using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Afpetit.Models;
using Afpetit.Utilities;

namespace Afpetit.Controllers
{
    public class HomeController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();
        // GET: Home
        public ActionResult Index(int? page)
        {
            if(page == null || page == 1)
            {
                ViewBag.page = 1;
                ViewBag.typeCuisine = db.TypeCuisines.Where(t=>t.Statut).Take(Constante.vignetteAccueil).OrderBy(t => t.Nom).ToList();
            }
            else
            {
                ViewBag.page = (int)page;
                int saut = ((int)page-1) * Constante.vignetteAccueil;
                ViewBag.typeCuisine = db.TypeCuisines.Where(t => t.Statut).Take(Constante.vignetteAccueil).OrderBy(t => t.Nom).Skip(saut).ToList();
            }
            
            ViewBag.restaurants = db.Restaurants.ToList();
            
            return View();
        }
        public ActionResult Panier()
        {
            Afpetit.Models.Panier panier = null;
            if (HttpContext.Application[Session.SessionID] != null)
            {
                panier = (Afpetit.Models.Panier)HttpContext.Application[Session.SessionID];
            }
            return View(panier);
        }
    }
}