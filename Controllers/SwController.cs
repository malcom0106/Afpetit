using Afpetit.Dao;
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
        private readonly AfpEatEntities db = new AfpEatEntities();
        private DaoUtilisateur daoUtilisateur = new DaoUtilisateur();
        private DaoMenu daoMenu = new DaoMenu();
        private DaoProduit daoProduit = new DaoProduit();
        private DaoCommande daoCommande = new DaoCommande();
        // GET: Sw

        public JsonResult AddMenu(int IdMenu, List<int> IdProduits, string s)
        {
            string IdSession = Cryptage.Decrypt(s);
            SessionUtilisateur sessionUtilisateur = daoUtilisateur.GetSessionUtilisateur(IdSession);
            Panier panier = GetPanier(sessionUtilisateur.IdSession);
            bool isReturnOk = false;

            if (sessionUtilisateur != null && panier != null && IdMenu > 0 && IdProduits.Count > 0)
            {
                Menu menu = daoMenu.GetMenuById(IdMenu);

                if (menu != null)
                {
                    MenuPanier menuPanier = new MenuPanier();
                    menuPanier.IdMenu = IdMenu;
                    menuPanier.Prix = menu.Prix;
                    menuPanier.Nom = menu.Nom;
                    menuPanier.Quantite = 1;

                    foreach (int IdProduit in IdProduits)
                    {
                        ProduitPanier produitPanier = FindProduit(IdProduit);

                        if (produitPanier != null)
                        {
                            panier.IdRestaurant = produitPanier.IdRestaurant;
                            menuPanier.produits.Add(produitPanier);
                        }
                    }

                    panier.AddItem(menuPanier);
                    isReturnOk = true;
                }

                HttpContext.Application[sessionUtilisateur.IdSession] = panier;
            }
            string jsonPanier = Newtonsoft.Json.JsonConvert.SerializeObject(panier);
            return Json(new { isReturnOk, qte = panier.Quantite, total = panier.Total, monpanier = jsonPanier }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddProduit(int p, string s)
        {
            string IdSession = Cryptage.Decrypt(s);
            SessionUtilisateur sessionUtilisateur = daoUtilisateur.GetSessionUtilisateur(IdSession);
            Panier panier = GetPanier(sessionUtilisateur.IdSession);
            bool isReturnOk = false;

            if (sessionUtilisateur != null && panier != null && p > 0)
            {
                ProduitPanier produitPanier = FindProduit(p);

                if (produitPanier != null)
                {
                    if (panier.IdRestaurant == 0)
                    {
                        panier.IdRestaurant = produitPanier.IdRestaurant;
                        panier.AddItem(produitPanier);
                        isReturnOk = true;
                    }

                    else if (panier.IdRestaurant == produitPanier.IdRestaurant)
                    {
                        panier.AddItem(produitPanier);
                        isReturnOk = true;
                    }
                }
                HttpContext.Application[sessionUtilisateur.IdSession] = panier;
            }

            string jsonPanier = Newtonsoft.Json.JsonConvert.SerializeObject(panier);

            return Json(new { isReturnOk, qte = panier.Quantite, total = panier.Total, monpanier = jsonPanier }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult RemoveProduit(int IdProduit, string idsession)
        {
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(Session.SessionID);

            Panier panier = (Panier)HttpContext.Application[idsession];

            ProduitPanier produitPanier = new ProduitPanier();

            int quantite = 0;

            var prod = panier.Find(p => p.GetIdProduit() == IdProduit);
            if (prod != null && panier.Count > 1)
            {
                prod.Quantite--;
                quantite -= prod.Quantite;
            }
            else if (prod != null && panier.Count > 0)
            {
                panier.Remove(produitPanier);
                quantite -= produitPanier.Quantite;
            }

            HttpContext.Application[idsession] = panier;

            return Json(quantite, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetProduits(string idsession)
        {
            SessionUtilisateur sessionUtilisateur = daoUtilisateur.GetSessionUtilisateur(idsession);
            Panier panier = null;

            if (sessionUtilisateur != null && HttpContext.Application[sessionUtilisateur.IdSession] != null)
            {
                panier = (Panier)HttpContext.Application[sessionUtilisateur.IdSession];
            }

            return Json(panier, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SaveCommande(string s)
        {
            try
            {
                //decrypage de la SessionID et recherche dans la bdd
                string IdSession = Cryptage.Decrypt(s);
                SessionUtilisateur sessionUtilisateur = daoUtilisateur.GetSessionUtilisateur(IdSession);
                Panier panier = null;

                if (sessionUtilisateur != null && HttpContext.Application[sessionUtilisateur.IdSession] != null)
                {
                    panier = (Panier)HttpContext.Application[sessionUtilisateur.IdSession];
                }

                Utilisateur utilisateur = daoUtilisateur.GetUtilisateurBySessionId(sessionUtilisateur.IdSession);

                if (utilisateur != null && utilisateur.Solde > 0 && panier != null && panier.Count > 0)
                {
                    if(daoCommande.SaveCommande(panier, utilisateur))
                    {
                        HttpContext.Application.Remove(utilisateur.IdSession);
                    }
                }
                return Json(new { idutilisateur = utilisateur.IdUtilisateur }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                string er = ex.Message;
            }
            return Json(JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult Hasard(int idfood, int idboisson, string idsession)
        {
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(Session.SessionID);
            List<ProduitPanier> produitPaniers = null;
            int quantite = 0;
            if (sessionUtilisateur != null)
            {
                if (HttpContext.Application[idsession] != null)
                {
                    produitPaniers = (List<ProduitPanier>)HttpContext.Application[idsession];
                }
                else
                {
                    produitPaniers = new List<ProduitPanier>();
                }

                var prod = produitPaniers.Find(p => p.IdProduit == idfood || p.IdProduit == idboisson);
                if (prod != null)
                {
                    prod.Quantite++;
                    quantite += prod.Quantite;
                    HttpContext.Application[idsession] = produitPaniers;
                    return Json(quantite, JsonRequestBehavior.AllowGet);
                }

                Produit produit = db.Produits.Find(idfood, idboisson);
                foreach (ProduitPanier item in produitPaniers)
                {
                    //item.IdProduit = idfood || item.IdProduit = idboisson;
                }
                ProduitPanier produitPanier = new ProduitPanier();
                produitPanier.IdProduit = idfood;
                produitPanier.Nom = produit.Nom;
                produitPanier.Description = produit.Description;
                produitPanier.Quantite = 1;
                produitPanier.Prix = produit.Prix;
                produitPanier.Photo = produit.Photos.First().Nom;
                produitPanier.IdRestaurant = produit.IdRestaurant;
                produitPaniers.Add(produitPanier);

                quantite++;

                HttpContext.Application[idsession] = produitPaniers;
            }
            var rnd = new Random();

            var first = db.Produits.Where(p => p.Categorie.IdCategorie == 3 || p.Categorie.IdCategorie == 5 || p.Categorie.IdCategorie == 7 || p.Categorie.IdCategorie == 8 || p.Categorie.IdCategorie == 9).OrderBy(p => rnd.Next());
            var second = db.Produits.Where(p => p.IdCategorie == 2).OrderBy(p => rnd.Next());

            return Json(quantite, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetRestos(int? IdTypeCuisine, string idsession)
        {
            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(Session.SessionID);

            if (sessionUtilisateur != null)
            {
                var resto = db.Restaurants.Where(r => r.IdTypeCuisine == IdTypeCuisine).Select(r => new
                {
                    IdRestaurant = r.IdRestaurant

                }).ToList();

                return Json(resto, JsonRequestBehavior.AllowGet);
            }

            return Json("", JsonRequestBehavior.AllowGet);
        }

        private ProduitPanier FindProduit(int IdProduit)
        {
            Produit produit = daoProduit.GetProduitById(IdProduit);
            ProduitPanier produitPanier = null;

            if (produit != null)
            {
                produitPanier = new ProduitPanier();
                produitPanier.IdProduit = IdProduit;
                produitPanier.Nom = produit.Nom;
                produitPanier.Description = produit.Description;
                produitPanier.Quantite = 1;
                produitPanier.Prix = produit.Prix;
                produitPanier.Photo = produit.Photos.First()?.Nom;
                produitPanier.IdRestaurant = produit.IdRestaurant;
            }

            return produitPanier;
        }

        private Panier GetPanier(string idsession)
        {
            Panier panier = null;

            if (HttpContext.Application[idsession] != null)
            {
                panier = (Panier)HttpContext.Application[idsession];
            }
            else
            {
                panier = new Panier();
                panier.IdRestaurant = 0;
            }

            return panier;
        }
    }
}