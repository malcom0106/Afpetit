using Afpetit.Models;
using Afpetit.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoProduit : DaoAccess
    {
        /// <summary>
        /// Afficher le produit par ID
        /// </summary>
        /// <param name="IdProduit"></param>
        /// <returns>Retourne un produit</returns>
        public Produit GetProduitById(int IdProduit)
        {
            try
            {
                Produit produit = db.Produits.Find((int)IdProduit);
                return produit;
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        }

        /// <summary>
        /// Retourne les produits d'un resto
        /// </summary>
        /// <param name="restaurant"></param>
        /// <returns> List < Produit > </returns>
        public List<Produit> GetProduitsRestaurant(Restaurant restaurant)
        {
            try
            {
                var produits = db.Produits.Where(p => p.IdRestaurant == restaurant.IdRestaurant);
                return produits.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        }

        /// <summary>
        /// Change le staut du produit
        /// </summary>
        /// <param name="IdProduit"></param>
        /// <returns>Boolean true si success</returns>
        public bool ChangeStatut(int IdProduit)
        {
            try
            {
                Produit produit1 = this.GetProduitById(IdProduit);
                produit1.Statut = !produit1.Statut;
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;    
            }
            
        }

        /// <summary>
        /// Creation d'un produit en ajouter x images. 
        /// </summary>
        /// <param name="produit"></param>
        /// <param name="files"></param>
        /// <returns>Boolean true si success</returns>
        public bool CreateProduit(Produit produit, HttpPostedFileBase[] files)
        {
            try
            {
                foreach (HttpPostedFileBase file in files)
                {                 
                    produit.Photos.Add(Functions.CreatePhoto(file));
                }
                produit.Statut = true;
                db.Produits.Add(produit);
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Editer un produit
        /// </summary>
        /// <param name="produit"></param>
        /// <returns>Boolean true si success</returns>
        public bool EditProduit(Produit produit)
        {
            try
            {
                db.Entry(produit).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }            
        }




    }
}