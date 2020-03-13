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
    public class MenusController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();
        private DaoMenu daomenu = new DaoMenu();

        // GET: Menus
        public ActionResult Index()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];                
                return View(daomenu.GetMenu());
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
            
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
                if (daomenu.ChangeStatut((int)id))
                {
                    return RedirectToAction("Index", "Menus");
                }
                return HttpNotFound();                
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
                daomenu.CreateMenu(menu);
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
                Menu menu = daomenu.GetMenuById((int)idmenu);

                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");

                return View(menu);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }

        }
        // POST: Menus/AddCategorie/5
        
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
                ViewBag.Restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.IdCategorie = new SelectList(db.Categories, "IdCategorie", "Nom");

                daomenu.AddCategorieInMenu((int)idmenu, (int)idcategorie);                  
                return View(daomenu.GetMenuById((int)idmenu));
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