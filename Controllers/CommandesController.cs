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
    public class CommandesController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: Commandes
        public ActionResult IndexRestaurant()
        {
            if(Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                var commandes = db.Commandes.Include(c => c.EtatCommande).Include(c => c.Restaurant).Include(c => c.Utilisateur).Where(c=>c.IdRestaurant == restaurant.IdRestaurant);
                return View(commandes.ToList());
            }
            return RedirectToAction("ConnexionRestaurant","Restaurants",null);
            
        }

        // GET: Commandes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Commande commande = db.Commandes.Find(id);
            if (commande == null)
            {
                return HttpNotFound();
            }
            return View(commande);
        }        

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
