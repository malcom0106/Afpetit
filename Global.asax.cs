using Afpetit.Models;
using Afpetit.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace Afpetit
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            try
            {
                // Supprimer toutes les sessions au lancement de l'application
                AfpEatEntities db = new AfpEatEntities();
                List<SessionUtilisateur> sessions = db.SessionUtilisateurs.ToList();
                db.SessionUtilisateurs.RemoveRange(sessions);
                db.SaveChanges();
            } 
            catch(Exception ex)
            {
                throw ex;
            }

        }
        protected void Application_End()
        {

        }
        protected void Session_Start()
        {
            AfpEatEntities db = new AfpEatEntities();

            SessionUtilisateur sessionUtilisateur = new SessionUtilisateur
            {                
                IdSession = Session.SessionID,
                dateSession = DateTime.Now
            };

            db.SessionUtilisateurs.Add(sessionUtilisateur);
            db.SaveChanges();
            
        }
        protected void Session_End()
        {
            AfpEatEntities db = new AfpEatEntities();

            SessionUtilisateur sessionUtilisateur = db.SessionUtilisateurs.Find(Session.SessionID);
            db.SessionUtilisateurs.Remove(sessionUtilisateur);
            db.SaveChanges();
        }
        
    }
}
