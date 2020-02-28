using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Afpetit.Models;

namespace Afpetit.Controllers
{
    public class HomeController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();
        // GET: Home
        public ActionResult Index()
        {
            ViewBag.restaurants = db.Restaurants.ToList();
            ViewBag.typeCuisine = db.TypeCuisines.ToList();
            return View();
        }
        public ActionResult MaView()
        {
            return View();
        }
    }
}