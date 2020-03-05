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
    public class RestaurantsController : Controller
    {
        //Page Precedente
        //Request.UrlReferrer.ToString()

        private AfpEatEntities db = new AfpEatEntities();
        private Commande commande;

        // GET: Add Produit dans commande
        public ActionResult AddProduit(int? IdProduit, int? IdRestaurant)
        {
            int idProduit = Convert.ToInt32(IdProduit);
            int idRestaurant = Convert.ToInt32(IdRestaurant);
            bool ProduitExiste = false;
            if (Session["Commande"] != null)
            {
                commande = (Commande)Session["Commande"];   
                if(commande.CommandeProduits.Count() > 0)
                {
                    foreach(CommandeProduit item in commande.CommandeProduits)
                    {
                        if(item.IdProduit == idProduit)
                        {
                            ProduitExiste = true;
                            item.Quantite++;
                        }
                    }
                    if (!ProduitExiste)
                    {
                        CommandeProduit commandeProduit = new CommandeProduit();
                        Produit produit = db.Produits.Where(p => p.IdProduit == idProduit).FirstOrDefault();
                        commandeProduit.Produit = produit;
                        commandeProduit.IdProduit = produit.IdProduit;
                        commandeProduit.Prix = produit.Prix;
                        commandeProduit.Quantite = 1;
                        commande.CommandeProduits.Add(commandeProduit);
                    }
                }
            }
            else
            {
                commande = new Commande();
                CommandeProduit commandeProduit = new CommandeProduit();
                Produit produit = db.Produits.Where(p => p.IdProduit == idProduit).FirstOrDefault();
                commandeProduit.Produit = produit;
                commandeProduit.IdProduit = produit.IdProduit;
                commandeProduit.Prix = produit.Prix;
                commandeProduit.Quantite = 1;
                commande.CommandeProduits.Add(commandeProduit);
            }
            Session["Commande"] = commande;


            return RedirectToAction("Details/"+ idRestaurant.ToString());
        }

        // GET: Restaurants
        public ActionResult Index(int? IdTypeCuisine, int? IdRestaurant)
        {
            string urls = Request.UrlReferrer.ToString();
            List<Restaurant> restaurants = db.Restaurants.Include(r => r.TypeCuisine).ToList();

            if (IdTypeCuisine != null)
            {
                restaurants = restaurants.Where(r => r.IdTypeCuisine == IdTypeCuisine).ToList();
            }
            if (IdRestaurant != null)
            {
                restaurants = restaurants.Where(r => r.IdRestaurant == IdRestaurant).ToList();
            }
            return View(restaurants);
        }

        // GET: Restaurants/Details/5
        public ActionResult Details(int? id)
        {
            
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Restaurant restaurant = db.Restaurants.Find(id);

            var produits = db.Produits.Where(m => m.IdRestaurant == id).ToList();

            foreach(Menu menu in restaurant.Menus)
            {
                if (menu != null)
                {
                    Dictionary<string, List<SelectListItem>> menucategorieDLL = new Dictionary<string, List<SelectListItem>>();
                    foreach (var categorie in menu.Categories)
                    {
                        List<Produit> produits1 = produits.Where(p => p.IdCategorie == categorie.IdCategorie).ToList();

                        // On crée les items d'un select (dropdownlist)
                        List<SelectListItem> items = new List<SelectListItem>();

                        foreach (Produit produit in produits1)
                        {
                            items.Add(new SelectListItem { Text = produit.Nom, Value = produit.IdProduit.ToString() });
                        }
                        menucategorieDLL.Add("cat"+categorie.IdCategorie, items);

                        ViewData["menu" + menu.IdMenu] = menucategorieDLL;
                    }
                }
                
            }
            
            if (restaurant == null)
            {
                return HttpNotFound();
            }
            return View(restaurant);
        }

        // GET: Restaurants/Create
        public ActionResult Create()
        {
            ViewBag.IdTypeCuisine = new SelectList(db.TypeCuisines, "IdTypeCuisine", "Nom");
            return View();
        }

        // POST: Restaurants/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdRestaurant,Nom,Description,Responsable,IdTypeCuisine,Adresse,CodePostal,Ville,Mobile,Telephone,Login,Password,Tag,Budget,Email")] Restaurant restaurant, HttpPostedFileBase file)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (file.ContentLength > 0 && file.ContentLength < 2500000)
                    {
                        if (Functions.IsImage(file))
                        {
                            var fileName = Path.GetFileName(file.FileName);
                            var pathBDD = "Images/Upload/" + fileName;
                            var path = Path.Combine(Server.MapPath("~/Images/Upload"), fileName);
                            file.SaveAs(path);
                            Photo photo = new Photo
                            {
                                Nom = fileName,
                                Statut = true,
                                Url = pathBDD
                            };
                            restaurant.Photos.Add(photo);
                            db.Restaurants.Add(restaurant);                            
                            db.SaveChanges();                            
                        }
                    }                    
                }
                return RedirectToAction("Index");
            } 
            catch (Exception ex)
            {
                ViewBag.IdTypeCuisine = new SelectList(db.TypeCuisines, "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
                ViewBag.Error = ex.Message;
                return View(restaurant);
            }
        }

        // GET: Restaurants/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Restaurant restaurant = db.Restaurants.Find(id);
            if (restaurant == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdTypeCuisine = new SelectList(db.TypeCuisines, "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
            return View(restaurant);
        }

        // POST: Restaurants/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdRestaurant,Nom,Responsable,IdTypeCuisine,Adresse,CodePostal,Ville,Mobile,Telephone,Login,Password,Tag,Budget,Email")] Restaurant restaurant)
        {
            if (ModelState.IsValid)
            {
                db.Entry(restaurant).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdTypeCuisine = new SelectList(db.TypeCuisines, "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
            return View(restaurant);
        }

        // GET: Restaurants/Connexion/
        public ActionResult Connexion()
        {                  
            return View();
        }

        // POST: Restaurants/Connexion/
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Connexion([Bind(Include = "Login,Password")] Restaurant restaurant)
        {
            if (ModelState.IsValid)
            {
                Restaurant monRestaurant = db.Restaurants.Where(r => r.Login == restaurant.Login && r.Password == restaurant.Password).SingleOrDefault();
                if (monRestaurant != null)
                {
                    Session["Restaurant"] = monRestaurant;
                    return RedirectToAction("Index", "Restaurants");
                }
                else
                {
                    ViewBag.message = "L'identification a échoué";
                    return View();
                }
            }            
            return View();
        }

        // GET: Restaurants/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Restaurant restaurant = db.Restaurants.Find(id);
            if (restaurant == null)
            {
                return HttpNotFound();
            }
            return View(restaurant);
        }

        // POST: Restaurants/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Restaurant restaurant = db.Restaurants.Find(id);
            db.Restaurants.Remove(restaurant);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: Produits
        public ActionResult IndexProduit()
        {
            if(Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                var produits = db.Produits.Include(p => p.Categorie).Include(p => p.Restaurant).Where(p => p.IdRestaurant == restaurant.IdRestaurant);
                return View(produits.ToList());
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }            
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
