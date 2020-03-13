using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoMenu : DaoAccess
    {
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