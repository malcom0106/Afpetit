﻿using System;
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
    public class MenusController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: Menus
        public ActionResult Index()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                var menus = db.Menus.Include(m => m.Restaurant);
                return View(menus.ToList());
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
            
        }

        // GET: Menus/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Menu menu = db.Menus.Find(id);
            if (menu == null)
            {
                return HttpNotFound();
            }

            var produits = db.Produits.Where(m => m.IdRestaurant == menu.IdRestaurant).ToList();

            foreach (var categorie in menu.Categories)
            {
                List<Produit> produits1 = produits.Where(p => p.IdCategorie == categorie.IdCategorie).ToList();

                // On crée les items d'un select (dropdownlist)
                List<SelectListItem> items = new List<SelectListItem>();

                foreach (Produit produit in produits1)
                {
                    items.Add(new SelectListItem { Text = produit.Nom, Value = produit.IdProduit.ToString() });
                }

                ViewData["cat" + categorie.IdCategorie] = items;
            }

            return View(menu);
        }

        // GET: Statut du Menu
        public ActionResult Statut(int? id)
        {
            if (Session["Restaurant"] != null)
            {
                if (id == null)
                {
                    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
                }

                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                Menu menu = db.Menus.Find(id);
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                if (menu == null)
                {
                    return HttpNotFound();
                }
                else
                {
                    menu.Statut = !menu.Statut;
                    db.SaveChanges();
                    return RedirectToAction("Index", "Menus");
                }
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Menus/Create
        public ActionResult Create()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                return View();
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // POST: Menus/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdMenu,IdRestaurant,Nom,Statut,Prix")] Menu menu)
        {
            if (ModelState.IsValid)
            {
                db.Menus.Add(menu);
                db.SaveChanges();
                return RedirectToAction("AddCategorie", new { @idmenu = menu.IdMenu });
            }

            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Description", menu.IdRestaurant);
            return View(menu);
        }

        // GET: Menus/Edit/5
        public ActionResult AddCategorie(int? idmenu)
        {
            if (idmenu == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if (Session["Restaurant"] != null)
            {
                Menu menu = db.Menus.Find(idmenu);
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];

                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");
                return View(menu);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }

        }
        // POST: Menus/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddCategorie(int? idmenu, int? idcategorie)
        {
            if (idmenu == null || idcategorie ==null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if (Session["Restaurant"] != null)
            {
                Menu menu = db.Menus.Find(idmenu);
                Categorie categorie = db.Categories.Find(idcategorie);
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                menu.Categories.Add(categorie);
                db.SaveChanges();
                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");
                return View(menu);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }

        }

        // GET: Menus/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Menu menu = db.Menus.Find(id);
            if (menu == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Description", menu.IdRestaurant);
            return View(menu);
        }

        // POST: Menus/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdMenu,IdRestaurant,Nom,Statut,Prix")] Menu menu)
        {
            if (ModelState.IsValid)
            {
                db.Entry(menu).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Description", menu.IdRestaurant);
            return View(menu);
        }

        // GET: Menus/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Menu menu = db.Menus.Find(id);
            if (menu == null)
            {
                return HttpNotFound();
            }
            return View(menu);
        }

        // POST: Menus/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Menu menu = db.Menus.Find(id);
            db.Menus.Remove(menu);
            db.SaveChanges();
            return RedirectToAction("Index");
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