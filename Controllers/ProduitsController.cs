﻿using System;
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
            var produits = db.Produits.Include(p => p.Categorie).Include(p => p.Restaurant);
            return View(produits.ToList());
        }


        // GET: Produits/Details/5
        public ActionResult Details(int? id)
        {
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

        // GET: Produits/Create
        public ActionResult Create()
        {
            ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");
            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Nom");
            return View();
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
                    foreach(HttpPostedFileBase file in files)
                    {
                        if (file.ContentLength > 0 && file.ContentLength < 2500000)
                        {
                            if (Functions.IsImage(file))
                            {
                                var fileName = Path.GetFileName(file.FileName);
                                var pathBDD = "/Images/Upload/" + fileName;
                                var path = Path.Combine(Server.MapPath("~/Images/Upload"), fileName);
                                file.SaveAs(path);
                                Afpetit.Models.Photo photo = new Photo
                                {
                                    Nom = fileName,
                                    Statut = true,
                                    Url = pathBDD
                                };
                                produit.Photos.Add(photo);
                            }
                        }
                    }
                    db.Produits.Add(produit);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                catch(Exception ex)
                {
                    ViewBag.Erreur = ex.Message;
                    return View(produit);
                }                
            }

            ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom", produit.IdCategorie);
            ViewBag.IdRestaurant = new SelectList(db.Restaurants, "IdRestaurant", "Nom", produit.IdRestaurant);
            return View(produit);
        }

        // GET: Produits/Edit/5
        public ActionResult Edit(int? id)
        {
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

        // GET: Produits/Delete/5
        public ActionResult Delete(int? id)
        {
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

        // POST: Produits/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Produit produit = db.Produits.Find(id);
            db.Produits.Remove(produit);
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