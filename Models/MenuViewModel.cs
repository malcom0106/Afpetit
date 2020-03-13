using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Models
{
    public class MenuViewModel : Menu
    {
        public IEnumerable<Menu> ListeMenu { get; set; }
        public int ObjetParPage { get; set; }
        public int PageCourante { get; set; }

        public int PageCount()
        {
            return Convert.ToInt32(Math.Ceiling(ListeMenu.Count() / (double)ObjetParPage));
        }
        public IEnumerable<Menu> PaginatedProduits()
        {
            int start = (PageCourante - 1) * ObjetParPage;
            return ListeMenu.OrderBy(b => b.Nom).Skip(start).Take(ObjetParPage);
        }
    }
}