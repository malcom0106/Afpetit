using Afpetit.Models;
using Afpetit.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Helpers;

namespace Afpetit.Dao
{
    public class DaoRestaurant : DaoAccess
    {
        /// <summary>
        /// Retourner la liste de tous les restanrant 
        /// </summary>
        /// <returns>List < Restaurant > </returns>
        public List<Restaurant> GetRestaurants()
        {
            try
            {
                List<Restaurant> restaurants = db.Restaurants.ToList();
                return restaurants;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Permets de generer la liste des cuisine en IEnumerable pour faire les selectList
        /// </summary>
        /// <returns></returns>
        public IEnumerable GetCuisine()
        {
            try
            {
                IEnumerable typeCuisines = db.TypeCuisines;
                return typeCuisines;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Retourne le restaurant via l'Id
        /// </summary>
        /// <param name="IdRestaurant"></param>
        /// <returns> Restaurant/Id </returns>
        public Restaurant GetRestaurantById(int IdRestaurant)
        {
            try
            {
                Restaurant restaurant = db.Restaurants.Find(IdRestaurant);
                return restaurant;
            }
            catch (Exception ex)
            {
                throw ex;
            }            
        }

        /// <summary>
        /// Retourne la liste de tous les produits d'un restaurant
        /// </summary>
        /// <param name="restaurant"></param>
        /// <returns></returns>
        public List<Produit> GetProduitRestaurant(Restaurant restaurant)
        {
            try
            {
                List<Produit> produits = db.Produits.Where(m => m.IdRestaurant == restaurant.IdRestaurant && m.Statut == true).ToList();
                return produits;
            } 
            catch(Exception ex)
            {
                throw ex;
            }            
        }

        /// <summary>
        /// Creation d'un restaurant avec verification du fichier inseré.
        /// </summary>
        /// <param name="restaurant">Formulaire bindé</param>
        /// <param name="file">Photo uploadé</param>
        /// <returns>Boolean true en cas de success</returns>
        public bool CreateRestaurant(Restaurant restaurant, HttpPostedFileBase file)
        {
            try
            {
                restaurant.Password = Crypto.HashPassword(restaurant.Password);
                restaurant.Photos.Add(Functions.CreatePhoto(file));
                db.Restaurants.Add(restaurant);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Editer un restaurant via le backend AFPA
        /// </summary>
        /// <param name="restaurant">Objet restaurant bindé</param>
        /// <returns>Boolean true en cas de success</returns>
        public bool EditRestaurant(Restaurant restaurant)
        {
            try
            {
                db.Entry(restaurant).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Change le mot de passe d'un restauranteur en le hashant
        /// </summary>
        /// <param name="restaurant"></param>
        /// <param name="password1"></param>
        /// <param name="password2"></param>
        /// <returns>Boolean true en cas de success</returns>
        public bool ChangePassword(Restaurant restaurant, string password1, string password2)
        {
            try
            {
                Restaurant resto = this.GetRestaurantById(restaurant.IdRestaurant);
                if (resto != null)
                {
                    if (password1 == password2)
                    {
                        resto.Password = Crypto.HashPassword(password2);
                        db.SaveChanges();
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }

        public bool AddPhoto(Restaurant restaurant, HttpPostedFileBase file)
        {
            try
            {
                Restaurant resto = this.GetRestaurantById(restaurant.IdRestaurant);
                resto.Photos.Add(Functions.CreatePhoto(file));
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