using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Afpetit.Dao;
using Afpetit.Models;
using Afpetit.Utilities;

namespace Afpetit.Controllers
{
    public class HomeController : Controller
    {
        DaoTypeCuisine daoTypeCuisine = new DaoTypeCuisine();
        DaoRestaurant daoRestaurant = new DaoRestaurant();
        private readonly AfpEatEntities db = new AfpEatEntities();
        // GET: Home
        public ActionResult Index(int? page)
        {
            List<TypeCuisine> typeCuisine = daoTypeCuisine.GetTypeCuisines();
            decimal cuisine = typeCuisine.Count();
            decimal NombrePageMax = Math.Ceiling(cuisine / Convert.ToDecimal(Constante.vignetteAccueil));
            if (page == null || page <= 1)
            {
                ViewBag.page = 1;
                ViewBag.typeCuisine = typeCuisine.Take(Constante.vignetteAccueil).OrderBy(t => t.Nom).ToList();
            }
            else if(page >= NombrePageMax)
            {
                ViewBag.page = (int)NombrePageMax;
                int saut = ((int)NombrePageMax - 1) * Constante.vignetteAccueil;
                ViewBag.typeCuisine = typeCuisine.Take(Constante.vignetteAccueil).OrderBy(t => t.Nom).Skip(saut).ToList();
            }
            else
            {
                ViewBag.page = (int)page;
                int saut = ((int)page-1) * Constante.vignetteAccueil;
                ViewBag.typeCuisine = typeCuisine.Take(Constante.vignetteAccueil).OrderBy(t => t.Nom).Skip(saut).ToList();
            }
            
            ViewBag.restaurants = daoRestaurant.GetRestaurants();
            
            return View();
        }
        public ActionResult Panier()
        {
            Panier panier = null;
            if (HttpContext.Application[Session.SessionID] != null)
            {
                panier = (Panier)HttpContext.Application[Session.SessionID];
            }
            return View(panier);
        }
    }
}