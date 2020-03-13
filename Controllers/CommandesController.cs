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

namespace Afpetit.Controllers
{
    public class CommandesController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();
        DaoCommande daoCommande = new DaoCommande(); 

        // GET: Commandes/HistoriqueUtilisateur
        public ActionResult HistoriqueUtilisateur()
        {
            if (Session["Utilisateur"] != null)
            {
                Utilisateur utilisateur = (Utilisateur)Session["Utilisateur"];                
                return View(daoCommande.GetCommandesUtilisateur(utilisateur));
            }
            return RedirectToAction("Index", "Home", null);
        }

        // GET: Commandes/IndexRestaurant
        public ActionResult IndexRestaurant()
        {
            if(Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                return View(daoCommande.GetCommandesRestaurant(restaurant));
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
            Commande commande = daoCommande.GetCommande((int)id);
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
