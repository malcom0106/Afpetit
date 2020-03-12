using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Afpetit.Dao;
using Afpetit.Models;
using Afpetit.Utilities;

namespace Afpetit.Controllers
{
    public class RestaurantsController : Controller
    {
        //Page Precedente
        //Request.UrlReferrer.ToString()

        private AfpEatEntities db = new AfpEatEntities();
        private DaoRestaurant daoRestaurant = new DaoRestaurant();

        // GET: Add Produit dans commande
        //public ActionResult AddProduit(int? IdProduit, int? IdRestaurant)
        //{
        //    int idProduit = Convert.ToInt32(IdProduit);
        //    int idRestaurant = Convert.ToInt32(IdRestaurant);
        //    bool ProduitExiste = false;
        //    if (Session["Commande"] != null)
        //    {
        //        commande = (Commande)Session["Commande"];   
        //        if(commande.CommandeProduits.Count() > 0)
        //        {
        //            foreach(CommandeProduit item in commande.CommandeProduits)
        //            {
        //                if(item.IdProduit == idProduit)
        //                {
        //                    ProduitExiste = true;
        //                    item.Quantite++;
        //                }
        //            }
        //            if (!ProduitExiste)
        //            {
        //                CommandeProduit commandeProduit = new CommandeProduit();
        //                Produit produit = db.Produits.Where(p => p.IdProduit == idProduit).FirstOrDefault();
        //                commandeProduit.Produit = produit;
        //                commandeProduit.IdProduit = produit.IdProduit;
        //                commandeProduit.Prix = produit.Prix;
        //                commandeProduit.Quantite = 1;
        //                commande.CommandeProduits.Add(commandeProduit);
        //            }
        //        }
        //    }
        //    else
        //    {
        //        commande = new Commande();
        //        CommandeProduit commandeProduit = new CommandeProduit();
        //        Produit produit = db.Produits.Where(p => p.IdProduit == idProduit).FirstOrDefault();
        //        commandeProduit.Produit = produit;
        //        commandeProduit.IdProduit = produit.IdProduit;
        //        commandeProduit.Prix = produit.Prix;
        //        commandeProduit.Quantite = 1;
        //        commande.CommandeProduits.Add(commandeProduit);
        //    }
        //    Session["Commande"] = commande;

        //    return RedirectToAction("Details/"+ idRestaurant.ToString());
        //}

        // GET: Restaurants
        public ActionResult Index(int? IdTypeCuisine, int? IdRestaurant)
        {
            //string urls = Request.UrlReferrer.ToString();
            List<Restaurant> restaurants = daoRestaurant.GetRestaurants();

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
            
            Restaurant restaurant = daoRestaurant.GetRestaurantById((int)id);
            if(restaurant != null)
            {
                var produits = daoRestaurant.GetProduitRestaurant(restaurant);
                foreach (Menu menu in restaurant.Menus)
                {
                    if (menu != null && menu.Statut)
                    {
                        Dictionary<string, List<SelectListItem>> menucategorieDLL = new Dictionary<string, List<SelectListItem>>();
                        foreach (var categorie in menu.Categories)
                        {
                            List<Produit> produits1 = produits.Where(p => p.IdCategorie == categorie.IdCategorie).ToList();

                            // On crée les items d'un select (dropdownlist)
                            List<SelectListItem> items = new List<SelectListItem>();

                            foreach (Produit produit in produits1)
                            {
                                if (produit.Statut)
                                {
                                    items.Add(new SelectListItem { Text = produit.Nom, Value = produit.IdProduit.ToString() });
                                }
                            }
                            menucategorieDLL.Add("cat" + categorie.IdCategorie, items);
                            ViewData["menu" + menu.IdMenu] = menucategorieDLL;
                        }
                    }
                }
            }
            else
            {
                return HttpNotFound();
            } 
            return View(restaurant);
        }

        // GET: Restaurants/Create
        public ActionResult Create()
        {
            ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom");
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
                    if(daoRestaurant.CreateRestaurant(restaurant, file))
                    {
                        return RedirectToAction("Index");
                    }
                    return View(restaurant);
                }
                return View(restaurant);
            } 
            catch (Exception ex)
            {
                ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
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

            Restaurant restaurant = daoRestaurant.GetRestaurantById((int)id);
            if (restaurant == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
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
                if (daoRestaurant.EditRestaurant(restaurant))
                {
                    return RedirectToAction("Index");
                }
                ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
                return View(restaurant);
            }
            ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
            return View(restaurant);
        }


        // GET: Produits
        public ActionResult IndexProduit()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                return View(daoRestaurant.GetProduitRestaurant(daoRestaurant.GetRestaurantById(restaurant.IdRestaurant)));
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        // GET: Restaurants/DeconnexionRestaurant/
        public ActionResult DeconnexionRestaurant()
        {
            Session.Remove("Restaurant");
            return RedirectToAction("ConnexionRestaurant", "Restaurants");
        }

        // GET: Restaurants/ConnexionRestaurant/
        public ActionResult ConnexionRestaurant()
        {
            if (Session["Restaurant"] != null)
            {
                return RedirectToAction("IndexRestaurant", "Restaurants");
            }
            else
            {
                return View();
            }
        }
        
        // POST: Restaurants/ConnexionRestaurant/
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConnexionRestaurant([Bind(Include = "Login,Password")] Restaurant restaurant)
        {
            if (ModelState.IsValid)
            {
                Restaurant resto = daoRestaurant.Connexion(restaurant);
                if (resto != null)
                {
                    Session["Restaurant"] = resto;
                    return RedirectToAction("IndexRestaurant", "Restaurants");
                }
                ViewBag.message = "L'identification a échoué";
                return View();

            }            
            return View();
        }

        // GET: IndexRestaurant
        public ActionResult IndexRestaurant()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                Restaurant resto = daoRestaurant.GetRestaurantById(restaurant.IdRestaurant);
                return View(resto);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Restaurants/DetailsRestaurant/5
        public ActionResult DetailsRestaurant()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                return View(restaurant);
            }
            else
            {
                return RedirectToAction("ConnexionRestaurant", "Restaurants");
            }
        }

        // GET: Restaurants/EditRestaurant/
        public ActionResult EditRestaurant()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
                return View(restaurant);
            }
            else
            {
                return RedirectToAction("Connexion", "Restaurants");
            }
        }

        // POST: Restaurants/EditRestaurant/
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditRestaurant([Bind(Include = "IdRestaurant,Nom,Responsable,IdTypeCuisine,Adresse,CodePostal,Ville,Mobile,Telephone,Tag,Budget,Email,Description")] Restaurant restaurant)
        {
            if (ModelState.IsValid)
            {
                if (daoRestaurant.EditRestaurant(restaurant))
                {
                    return RedirectToAction("Index");
                }                
            }
            ViewBag.IdTypeCuisine = new SelectList(daoRestaurant.GetCuisine(), "IdTypeCuisine", "Nom", restaurant.IdTypeCuisine);
            return View(restaurant);
        }

        //POST: Restaurant/DelPhoto/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DelPhoto(int? IdPhoto)
        {
            if(IdPhoto != null)
            {
                if (Session["Restaurant"] != null)
                {
                    Restaurant resto = (Restaurant)Session["Restaurant"];
                    if(daoRestaurant.DelPhoto(resto, (int)IdPhoto))
                    {
                        return RedirectToAction("ChangePhoto", "Restaurants");
                    }                    
                }                
            }
            return RedirectToAction("ChangePhoto", "Restaurants");
        }

        //GET: Restaurants/AddPhoto
        public ActionResult AddPhoto()
        {
            if (Session["Restaurant"] != null)
            {
                return View();
            }
            return RedirectToAction("ConnexionRestaurant", "Restaurants");
        }

        //POST: Restaurants/AddPhoto
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddPhoto(HttpPostedFileBase file)
        {
            if(Session["Restaurant"] != null && file != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                daoRestaurant.AddPhoto(restaurant, file);
                return RedirectToAction("ChangePhoto", "Restaurants");
            }            
            return RedirectToAction("ChangePhoto", "Restaurants");
        }

        // GET: Restaurants/ChangePhoto/
        public ActionResult ChangePhoto()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                Restaurant monRestaurant = daoRestaurant.GetRestaurantById(restaurant.IdRestaurant);
                return View(monRestaurant);
            }
            else
            {
                return RedirectToAction("Connexion", "Restaurants");
            }
            // A TERMINER
        }


        // GET: Restaurants/ChangePassword/
        public ActionResult ChangePassword()
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                return View(restaurant);
            }
            else
            {
                return RedirectToAction("Connexion", "Restaurants");
            }
        }


        //POST: Restaurant/ChangePassword/
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(FormCollection formCollection)
        {
            if (Session["Restaurant"] != null)
            {
                Restaurant restaurant = (Restaurant)Session["Restaurant"];
                string newPassword1 = formCollection["NewPassword1"];
                string newPassword2 = formCollection["NewPassword2"];
                if (daoRestaurant.ChangePassword(restaurant, newPassword1, newPassword2))
                {
                    Session.Remove("Restaurant");                    
                }               
            } 
            return RedirectToAction("ConnexionRestaurant", "Restaurants");
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
