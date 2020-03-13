using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoCommande : DaoAccess
    {
        public List<Commande> GetCommandesUtilisateur(Utilisateur utilisateur)
        {
            try
            {
                return db.Commandes.Where(c => c.IdUtilisateur == utilisateur.IdUtilisateur).ToList();
            }
            catch(Exception ex)
            {
                throw ex;
            }            
        }

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

        public Commande GetCommande(int IdCommande)
        {
            try
            {
                Commande commande = db.Commandes.Find(id);
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        
    }
}