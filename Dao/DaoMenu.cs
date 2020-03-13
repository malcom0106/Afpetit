using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoMenu : DaoAccess
    {
        /// <summary>
        /// Retourne tous les menus
        /// </summary>
        /// <returns></returns>
        public List<Menu> GetMenu()
        {
            try
            {
                return db.Menus.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        /// <summary>
        /// Retourne tous les menus d'un restaurant
        /// </summary>
        /// <param name="IdMenu"></param>
        /// <returns></returns>
        public Menu GetMenuById(int IdMenu)
        {
            try
            {
                return db.Menus.Find(IdMenu);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        /// <summary>
        /// Permet de changer le statut d'un menu plutot que de le supprimer
        /// </summary>
        /// <param name="IdMenu"></param>
        /// <returns></returns>
        public bool ChangeStatut(int IdMenu)
        {
            try
            {
                Menu menu = this.GetMenuById(IdMenu);
                if(menu != null)
                {
                    menu.Statut = !menu.Statut;
                    db.SaveChanges();
                    return true;
                }
                return false;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Creer un menu
        /// </summary>
        /// <param name="menu"></param>
        /// <returns></returns>
        public bool CreateMenu(Menu menu)
        {
            try
            {
                db.Menus.Add(menu);
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Ajouter une categorie dans un menu
        /// </summary>
        /// <param name="IdMenu"></param>
        /// <param name="IdCategorie"></param>
        /// <returns></returns>
        public bool AddCategorieInMenu(int IdMenu, int IdCategorie)
        {
            try
            {
                Menu menu = this.GetMenuById(IdMenu);
                Categorie categorie = db.Categories.Find(IdCategorie);
                menu.Categories.Add(categorie);
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