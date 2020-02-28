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
    public class TypeCuisinesController : Controller
    {
        private AfpEatEntities db = new AfpEatEntities();

        // GET: TypeCuisines
        public ActionResult Index()
        {
            return View(db.TypeCuisines.ToList());
        }

        // GET: TypeCuisines/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TypeCuisine typeCuisine = db.TypeCuisines.Find(id);
            if (typeCuisine == null)
            {
                return HttpNotFound();
            }
            return View(typeCuisine);
        }

        // GET: TypeCuisines/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TypeCuisines/Create
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "IdTypeCuisine,Nom,Statut")] TypeCuisine typeCuisine, HttpPostedFileBase file)
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
                            Afpetit.Models.Photo photo = new Photo();
                            photo.Nom = fileName;
                            photo.Statut = true;
                            photo.Url = pathBDD;

                            typeCuisine.Photos.Add(photo);
                            db.TypeCuisines.Add(typeCuisine);

                            db.SaveChanges();
                        }
                    }                    
                }
                return RedirectToAction("Index");
            }
            catch( Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View(typeCuisine);
            }
        }

        // GET: TypeCuisines/AddImage/5
        public ActionResult AddImage(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TypeCuisine typeCuisine = db.TypeCuisines.Find(id);
            if (typeCuisine == null)
            {
                return HttpNotFound();
            }

            return View(typeCuisine);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AddImage(HttpPostedFileBase file, FormCollection formCollection)
        {

            

            return RedirectToAction("Index");
        }

        // GET: TypeCuisines/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TypeCuisine typeCuisine = db.TypeCuisines.Find(id);
            if (typeCuisine == null)
            {
                return HttpNotFound();
            }
            return View(typeCuisine);
        }

        // POST: TypeCuisines/Edit/5
        // Afin de déjouer les attaques par sur-validation, activez les propriétés spécifiques que vous voulez lier. Pour 
        // plus de détails, voir  https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "IdTypeCuisine,Nom,Statut")] TypeCuisine typeCuisine)
        {
            if (ModelState.IsValid)
            {
                db.Entry(typeCuisine).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(typeCuisine);
        }

        // GET: TypeCuisines/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TypeCuisine typeCuisine = db.TypeCuisines.Find(id);
            if (typeCuisine == null)
            {
                return HttpNotFound();
            }
            return View(typeCuisine);
        }

        // POST: TypeCuisines/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TypeCuisine typeCuisine = db.TypeCuisines.Find(id);
            db.TypeCuisines.Remove(typeCuisine);
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
