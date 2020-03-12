using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Afpetit.Models;

namespace Afpetit.Controllers
{
    public class UtilisateursController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: Restaurants/ChangePassword/
        public ActionResult ChangePassword()
        {
            if (Session["Utilisateur"] != null)
            {
                Utilisateur utilisateur = (Utilisateur)Session["Utilisateur"];
                return View(utilisateur);
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
            if (Session["Utilisateur"] != null)
            {
                string newPassword1 = formCollection["NewPassword1"];
                string newPassword2 = formCollection["NewPassword2"];

                Utilisateur utilisateur = (Utilisateur)Session["Utilisateur"];
                Utilisateur verificationPassword = db.Utilisateurs.Where(r => r.IdUtilisateur == utilisateur.IdUtilisateur).FirstOrDefault();
                if (verificationPassword != null)
                {
                    if (newPassword1 == newPassword2)
                    {
                        verificationPassword.Password = Crypto.HashPassword(newPassword2);
                        db.SaveChanges();
                        Session.Remove("utilisateur");
                        return RedirectToAction("Index", "Home");
                    }
                    else
                    {
                        ViewBag.Message = "Les deux nouveau mot de passe sont incorrrect";
                    }
                }
            }

            return RedirectToAction("Connexion", "Utilisateurs");

        }

        // GET: Utilisateurs
        public ActionResult ListeInscrits()
        {
            return View(db.Utilisateurs.ToList());
        }


        // GET: Utilisateurs/Create
        public ActionResult Inscription()
        {
            return View();
        }

        // POST: Utilisateurs/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Inscription([Bind(Include = "IdUtilisateur,Nom,Prenom,Matricule,Password,TypeCompte")] Utilisateur utilisateur)
        {
            if (ModelState.IsValid)
            {
                utilisateur.IdSession = Session.SessionID;
                db.Utilisateurs.Add(utilisateur);
                db.SaveChanges();
                return RedirectToAction("ListeInscrits");
            }

            return View(utilisateur);
        }

        // GET: Utilisateurs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Utilisateur utilisateur = db.Utilisateurs.Find(id);
            if (utilisateur == null)
            {
                return HttpNotFound();
            }
            return View(utilisateur);
        }

        // POST: Utilisateurs/Edit/5        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdUtilisateur,Nom,Prenom,Matricule,Password,TypeCompte,Statut")] Utilisateur utilisateur)
        {
            if (ModelState.IsValid)
            {
                db.Entry(utilisateur).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(utilisateur);
        }

        // GET: Utilisateurs/Connexion
        public ActionResult Connexion()
        {            
            return View();
        }

        // POST: Utilisateurs/Connexion
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Connexion([Bind(Include = "Matricule,Password")] Utilisateur utilisateur)
        {
            if (ModelState.IsValid)
            {
                Utilisateur client = db.Utilisateurs.Where(u => u.Matricule == utilisateur.Matricule).Where(u => u.Password == utilisateur.Password).FirstOrDefault();
                bool passwordValid = Crypto.VerifyHashedPassword(client.Password, utilisateur.Password);
                if (passwordValid)
                {
                    client.IdSession = Session.SessionID;
                    db.SaveChanges();
                    Session["Utilisateur"] = client;
                    return RedirectToAction("Index","Home");
                }
                else
                {
                    ViewBag.message = "L'identification a échoué";
                }                
            }
            return View();
        }
        public ActionResult Deconnexion() 
        {
            if (Session["Utilisateur"] != null)
            {
                Session.Abandon();
            }
            return RedirectToAction("Index", "Home");
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
