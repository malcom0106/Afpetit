using Afpetit.Models;
using Afpetit.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Afpetit.Controllers
{
    public class SwController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: AddProduit
        public JsonResult AddProduit(int p, string s)
        {
            string session = Cryptage.Decrypt(s);
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(session);
            List<ProduitPanier> produitPaniers = null;
            bool ProduitExiste = false;
            if (sessionUtilisateur != null)
            {
                if (HttpContext.Application[session] != null)
                {
                    produitPaniers = (List<ProduitPanier>)HttpContext.Application[session];
                }
                else
                {
                    produitPaniers = new List<ProduitPanier>();
                }

                foreach (ProduitPanier produitPanier1 in produitPaniers)
                {
                    if (produitPanier1.IdProduit == p)
                    {
                        produitPanier1.Quantite++;
                        ProduitExiste = true;
                    }
                }
                if (!ProduitExiste)
                {
                    ProduitPanier produitPanier = new ProduitPanier();
                    Produit produit = db.Produits.Find(p);

                    produitPanier.IdProduit = p;
                    produitPanier.Nom = produit.Nom;
                    produitPanier.IdRestaurant = produit.IdRestaurant;
                    produitPanier.Description = produit.Description;
                    produitPanier.Quantite = 1;
                    produitPanier.Prix = produit.Prix;
                    produitPanier.Photo = produit.Photos.First().Url;

                    produitPaniers.Add(produitPanier);
                }
                HttpContext.Application[session] = produitPaniers;
            }
            return Json(produitPaniers.Count, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRestaurants(string search)
        {
            var restaurants = (from r in db.Restaurants.Where(r => r.Nom.Contains(search) || r.TypeCuisine.Nom.Contains(search))                              
                              select new { Id = r.IdRestaurant, Nom = r.Nom}).ToList();
            return Json(restaurants, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetProduits(string s)
        {
            string session = Cryptage.Decrypt(s);
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(session);
            List<ProduitPanier> panier = null;

            if (sessionUtilisateur != null)
            {
                if (HttpContext.Application[session] != null)
                {
                    panier = (List<ProduitPanier>)HttpContext.Application[session];
                }
            }
            return Json(panier, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveCommande(string s)
        {
            string session = Cryptage.Decrypt(s);
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(session);
            List<ProduitPanier> produitPaniers = null;
            string message = "";
            if (sessionUtilisateur != null)
            {
                if (HttpContext.Application[session] != null)
                {
                    produitPaniers = (List<ProduitPanier>)HttpContext.Application[session];
                }
                else
                {
                    produitPaniers = new List<ProduitPanier>();
                }
                Utilisateur utilisateur = db.Utilisateurs.First(u => u.IdSession == session);
                decimal prixTotal = 0;
                if (utilisateur != null && utilisateur.Solde >0 && produitPaniers != null && produitPaniers.Count > 0)
                {
                    int IdRestaurant = 0;
                    foreach (ProduitPanier produit in produitPaniers)
                    {
                        prixTotal += produit.Quantite * produit.Prix;
                        IdRestaurant = produit.IdRestaurant;
                    }
                    if(prixTotal <= utilisateur.Solde)
                    {
                        utilisateur.Solde -= prixTotal;
                        Commande commande = new Commande();
                        commande.IdUtilisateur = utilisateur.IdUtilisateur;
                        commande.IdRestaurant = IdRestaurant;
                        commande.DateCommande = DateTime.Now;
                        commande.Prix = prixTotal;
                        commande.IdEtatCommande = 1;

                        foreach (ProduitPanier produitPanier in produitPaniers)
                        {
                            CommandeProduit commandeProduit = new CommandeProduit();
                            commandeProduit.IdProduit = produitPanier.IdProduit;
                            commandeProduit.Prix = produitPanier.Prix;
                            commandeProduit.Quantite = produitPanier.Quantite;
                            commande.CommandeProduits.Add(commandeProduit);
                        }
                        try
                        {
                            db.Commandes.Add(commande);
                            db.SaveChanges();
                            HttpContext.Application[session] = null;
                        }
                        catch
                        {
                            message = "Erreur lors de l'import en BDD";
                        }
                        
                    }
                    else
                    {
                        message = "Solde Insuffisant";
                    }
                }
                else
                {
                    message = "Utilisateur non connecté / Solde Insuffisant / Panier null ";
                }
            }

        return Json(message, JsonRequestBehavior.AllowGet);
        }

        public JsonResult ConnexionUtilisateur(string l, string p, string s) 
        {
            string message ="";
            string session = Cryptage.Decrypt(s);
            Utilisateur utilisateur = db.Utilisateurs.First(u => u.Matricule == l && u.Password == p);
            if(utilisateur != null)
            {
                utilisateur.IdSession = session;
                db.SaveChanges();
                message = "Connecté avec Success";
            } else
            {
                message = "Erreur de Login/Mot de Passe";
            }
            return Json(message, JsonRequestBehavior.AllowGet);            
        }
    }
}