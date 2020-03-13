using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Afpetit.Dao;
using Afpetit.Models;
using Afpetit.Utilities;

namespace Afpetit.Controllers
{
    public class ProduitsController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();
        private DaoProduit daoProduit = new DaoProduit();
        // GET: Produits
        public ActionResult Index(int page = 1)
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];

                var produitsView = new ProduitViewModel
                {
                    ProduitParPage = Constante.produitsParPage,
                    ListeProduits = daoProduit.GetProduitsRestaurant(restaurant),
                    PageCourante = page
                };
                return View(produitsView);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Statut du produit
        public ActionResult Statut(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (Session["Restaurant"] != null)
            {                             
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                
                if (daoProduit.ChangeStatut((int)id))
                {
                    return RedirectToAction("Index", "Produits");                   
                }
                return HttpNotFound();
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Produits/Details/5
        public ActionResult Details(int? id)
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                Produit produit = daoProduit.GetProduitById((int)id);
                if (produit == null)
                {
                    return HttpNotFound();
                }
                return View(produit);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Produits/Create
        public ActionResult Create()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.IdRestaurant = restaurant.IdRestaurant;
                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");

                return View();
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // POST: Produits/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdProduit,IdRestaurant,IdCategorie,Nom,Prix,Description,Quantite")] Produit produit, HttpPostedFileBase[] files)
        {
            Restaurant monRestaurant = (Restaurant)Session["Restaurant"];
            ViewBag.IdRestaurant = monRestaurant.IdRestaurant;
            ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");

            if (ModelState.IsValid)
            {
                try
                {
                    produit.Statut = true;
                    if (daoProduit.CreateProduit(produit, files))
                    {
                        return RedirectToAction("Index");
                    }                    
                }
                catch (Exception ex)
                {                    
                    ViewBag.Erreur = ex.Message;
                    return View(produit);
                }
            }
            return View(produit);
        }

        // GET: Produits/Edit/5
        public ActionResult Edit(int? id)
        {
            if (Session["Restaurant"] != null)
            {
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }
                Produit produit = daoProduit.GetProduitById((int)id);
                if (produit == null)
                {
                    return HttpNotFound();
                }
                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom", produit.IdCategorie);
                ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Nom", produit.IdRestaurant);
                return View(produit);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // POST: Produits/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdProduit,IdRestaurant,IdCategorie,Nom,Prix,Description,Quantite,Statut")] Produit produit)
        {
            if (ModelState.IsValid)
            {
                if (daoProduit.EditProduit(produit))
                {
                    return RedirectToAction("Index");
                }                
            }
            ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom", produit.IdCategorie);
            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Nom", produit.IdRestaurant);
            return View(produit);
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
