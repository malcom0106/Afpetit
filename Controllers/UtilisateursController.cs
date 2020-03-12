using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Afpetit.Dao;
using Afpetit.Models;

namespace Afpetit.Controllers
{
    public class UtilisateursController : Controller
    {
        private DaoUtilisateur daoUtilisateur = new DaoUtilisateur();

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
                if(daoUtilisateur.ChangePassword(utilisateur, newPassword1, newPassword2))
                {
                    Session.Remove("Utilisateur");
                    return RedirectToAction("Index", "Home");
                }
            }

            return RedirectToAction("Connexion", "Utilisateurs");

        }

        // GET: Utilisateurs
        public ActionResult ListeInscrits()
        {
            return View(daoUtilisateur.GetUtilisateurs());
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
                if (daoUtilisateur.AddUtilisateur(utilisateur))
                {
                    return RedirectToAction("ListeInscrits");
                }
                else
                {
                    return View(utilisateur);
                }
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
            else
            {
                Utilisateur utilisateur = daoUtilisateur.GetUtilisateurById((int)id);
                if (utilisateur == null)
                {
                    return HttpNotFound();
                }
                return View(utilisateur);
            }             
        }

        // POST: Utilisateurs/Edit/5        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdUtilisateur,Nom,Prenom,Matricule,Password,TypeCompte,Statut")] Utilisateur utilisateur)
        {
            if (ModelState.IsValid)
            {
                if (daoUtilisateur.EditUtilisateur(utilisateur))
                {
                    return RedirectToAction("Index");
                }
                else
                {
                    return View(utilisateur);
                }
                
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
                Utilisateur user = daoUtilisateur.Connexion(utilisateur, Session.SessionID);
                if (user != null )
                {
                    Session["Utilisateur"] = user;
                    return RedirectToAction("Index", "Home");
                }
                return View();
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
                DaoDispose daoDispose = new DaoDispose();
                daoDispose.DbDispose();
            }
            base.Dispose(disposing);
        }
    }
}
