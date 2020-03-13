using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoCommande : DaoAccess
    {
        /// <summary>
        /// Retourne une lister de commande correspondant a un utilisateur
        /// </summary>
        /// <param name="utilisateur"></param>
        /// <returns></returns>
        public List<Commande> GetCommandesUtilisateur(Utilisateur utilisateur)
        {
            try
            {
                return db.Commandes.Where(c => c.IdUtilisateur == utilisateur.IdUtilisateur).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Retourne une liste de commande correspondant à celle reçu par le restaurant
        /// </summary>
        /// <param name="restaurant"></param>
        /// <returns></returns>
        public List<Commande> GetCommandesRestaurant(Restaurant restaurant)
        {
            try
            {
                return db.Commandes.Where(c => c.IdRestaurant == restaurant.IdRestaurant).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Retourne une commande par son Id
        /// </summary>
        /// <param name="IdCommande"></param>
        /// <returns></returns>
        public Commande GetCommande(int IdCommande)
        {
            try
            {
                return db.Commandes.Find(IdCommande);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool SaveCommande(Panier panier, Utilisateur utilisateur)
        {
            try
            {
                decimal prixTotal = 0;

                // panier.GetTotal(); -> On fait appel à CalculPanier() à l'ajout ou à la suppression d'un item
                prixTotal = panier.Total;

                if (prixTotal <= utilisateur.Solde)
                {
                    Commande commande = new Commande();
                    commande.IdUtilisateur = utilisateur.IdUtilisateur;
                    commande.IdRestaurant = panier.IdRestaurant;
                    commande.DateCommande = DateTime.Now;
                    commande.Prix = prixTotal;
                    commande.IdEtatCommande = 1;

                    utilisateur.Solde -= prixTotal;

                    foreach (ItemPanier item in panier)
                    {
                        if (item is ProduitPanier)
                        {
                            CommandeProduit commandeProduit = new CommandeProduit();
                            commandeProduit.IdProduit = item.GetIdProduit();
                            commandeProduit.Prix = item.Prix;
                            commandeProduit.Quantite = item.Quantite;

                            commande.CommandeProduits.Add(commandeProduit);
                        }

                        else if (item is MenuPanier menuPanier)
                        {
                            List<ProduitPanier> produitPaniers = menuPanier.produits;
                            Menu menu = db.Menus.Find(item.GetIdMenu());

                            foreach (ProduitPanier produitPanier in produitPaniers)
                            {
                                CommandeProduit commandeProduit = new CommandeProduit();
                                commandeProduit.IdProduit = produitPanier.IdProduit;
                                commandeProduit.Prix = 0;
                                commandeProduit.Quantite = 1;
                                commandeProduit.Menus.Add(menu);
                                //commandeProduit.Menus.FirstOrDefault().IdMenu = item.GetIdMenu();

                                commande.CommandeProduits.Add(commandeProduit);
                            }
                        }

                        else if (item is ProduitComposePanier produitComposePanier)
                        {
                            List<ProduitPanier> produitPaniers = produitComposePanier.produits;
                            foreach (ProduitPanier produitPanier in produitPaniers)
                            {
                                CommandeProduit commandeProduit = new CommandeProduit();
                                commandeProduit.IdProduit = item.GetIdProduit();
                                commandeProduit.Prix = item.Prix;
                                commandeProduit.Quantite = item.Quantite;

                                commande.CommandeProduits.Add(commandeProduit);
                            }
                        }
                    }

                    db.Commandes.Add(commande);
                    db.SaveChanges();
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        }
    }
}