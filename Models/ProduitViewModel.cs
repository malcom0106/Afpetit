using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Models
{
    public class ProduitViewModel : Produit
    {
        public IEnumerable<Produit> ListeProduits { get; set; }
        public int ProduitParPage { get; set; }
        public int PageCourante { get; set; }

        public int PageCount()
        {
            return Convert.ToInt32(Math.Ceiling(ListeProduits.Count() / (double)ProduitParPage));
        }
        public IEnumerable<Produit> PaginatedProduits()
        {
            int start = (PageCourante - 1) * ProduitParPage;
            return ListeProduits.OrderBy(b => b.Nom).Skip(start).Take(ProduitParPage);
        }
    }
}