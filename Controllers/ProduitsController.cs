using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Afpetit.Models;
using Afpetit.Utilities;

namespace Afpetit.Controllers
{
    public class ProduitsController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: Produits
        public ActionResult Index()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                var produits = db.Produits.Include(p => p.Categorie).Include(p => p.Restaurant).Where(p => p.IdRestaurant == restaurant.IdRestaurant);
                return View(produits.ToList());
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Statut du produit
        public ActionResult Statut(int? id)
        {
            if (Session["Restaurant"] != null)
            {                
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                Produit produit = db.Produits.Find(id);
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                if (produit == null)
                {
                    return HttpNotFound();
                }
                else
                {
                    produit.Statut = !produit.Statut;
                    db.SaveChanges();
                    return RedirectToAction("Index", "Produits");
                }                
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
                Produit produit = db.Produits.Find(id);
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
        public ActionResult Create([Bind(Include = "IdProduit,IdRestaurant,IdCategorie,Nom,Prix,Description,Quantite,Statut")] Produit produit, HttpPostedFileBase[] files)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    foreach (HttpPostedFileBase file in files)
                    {
                        if (file.ContentLength > 0 && file.ContentLength < 2500000)
                        {
                            if (Functions.IsImage(file))
                            {
                                var fileName = Path.GetFileName(file.FileName);
                                var pathBDD = "/Images/Upload/" + fileName;
                                var path = Path.Combine(Server.MapPath("~/Images/Upload"), fileName);
                                file.SaveAs(path);
                                Photo photo = new Photo
                                {
                                    Nom = fileName,
                                    Statut = true,
                                    Url = pathBDD
                                };
                                produit.Statut = true;
                                produit.Photos.Add(photo);
                            }
                        }
                    }
                    db.Produits.Add(produit);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    Restaurant monRestaurant = (Restaurant)Session["Restaurant"];

                    ViewBag.IdRestaurant = monRestaurant.IdRestaurant;
                    ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");
                    ViewBag.Erreur = ex.Message;
                    return View(produit);
                }
            }
            Restaurant restaurant = (Restaurant)Session["Restaurant"];

            ViewBag.IdRestaurant = restaurant.IdRestaurant;
            ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");
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
                Produit produit = db.Produits.Find(id);
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
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdProduit,IdRestaurant,IdCategorie,Nom,Prix,Description,Quantite,Statut")] Produit produit)
        {
            if (ModelState.IsValid)
            {
                db.Entry(produit).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
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
