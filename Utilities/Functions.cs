using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace Afpetit.Utilities
{
    public static class Functions 
    {
        public const int ImageMinimumBytes = 512;
        /// <summary>
        /// Verifier si le fichier transferé est bien une image
        /// </summary>
        /// <param name="postedFile">Fileposté</param>
        /// <returns>Boolean True en cas de success</returns>
        public static bool IsImage(this HttpPostedFileBase postedFile)
        {
            //-------------------------------------------
            //  Check les types images
            //-------------------------------------------
            if (!string.Equals(postedFile.ContentType, "image/jpg", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(postedFile.ContentType, "image/jpeg", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(postedFile.ContentType, "image/pjpeg", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(postedFile.ContentType, "image/gif", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(postedFile.ContentType, "image/x-png", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(postedFile.ContentType, "image/png", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            //-------------------------------------------
            //  Check les Extensions autorisées
            //-------------------------------------------
            var postedFileExtension = Path.GetExtension(postedFile.FileName);
            if (!string.Equals(postedFileExtension, ".jpg", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(postedFileExtension, ".png", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(postedFileExtension, ".gif", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(postedFileExtension, ".jpeg", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }

            //-------------------------------------------
            //  Essayez de lire le fichier et de vérifier les premiers octets
            //-------------------------------------------
            try
            {
                if (!postedFile.InputStream.CanRead)
                {
                    return false;
                }
                //------------------------------------------
                //   Vérifiez  la taille de l'image 
                //------------------------------------------ 
                if (postedFile.ContentLength < ImageMinimumBytes)
                {
                    return false;
                }

                byte[] buffer = new byte[ImageMinimumBytes];
                postedFile.InputStream.Read(buffer, 0, ImageMinimumBytes);
                string content = System.Text.Encoding.UTF8.GetString(buffer);
                if (Regex.IsMatch(content, @"<script|<html|<head|<title|<body|<pre|<table|<a\s+href|<img|<plaintext|<cross\-domain\-policy",
                    RegexOptions.IgnoreCase | RegexOptions.CultureInvariant | RegexOptions.Multiline))
                {
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }

            //-------------------------------------------
            //  Essayez d'instancier un nouveau Bitmap, si .NET lèvera une exception, nous pouvons supposer que ce n'est pas une image valide
            //-------------------------------------------

            try
            {
                using (var bitmap = new System.Drawing.Bitmap(postedFile.InputStream))
                {
                }
            }
            catch (Exception)
            {
                return false;
            }
            finally
            {
                postedFile.InputStream.Position = 0;
            }
            return true;
        }

        public static Photo CreatePhoto(HttpPostedFileBase file)
        {
            try
            {
                Photo photo = null;
                if (file.ContentLength > 0 && file.ContentLength < 2500000)
                {
                    if (Functions.IsImage(file))
                    {
                        var fileName = Path.GetFileName(file.FileName);
                        var pathBDD = "/Images/Upload/" + fileName;
                        var path = Path.Combine(HttpContext.Current.Server.MapPath("~/Images/Upload"), fileName);
                        file.SaveAs(path);
                        photo = new Photo
                        {
                            Nom = fileName,
                            Statut = true,
                            Url = pathBDD
                        };
                    }
                }
                return photo;
            } 
            catch(Exception ex)
            {
                throw ex;
            }            
        }

        public static string carouselImages(List<object> obj)
        {
            StringBuilder carousel = new StringBuilder();
            //Debut Carousel
            carousel.Append("<div id = 'multi-item-example' class='carousel slide carousel-multi-item carousel-multi-item-2' data-ride='carousel'>");
            carousel.Append("<div class='controls-top'>");
            //Controlleurs
            carousel.Append("<div class='controls-top'>");
            carousel.Append("<a class='black-text' href='#multi-item-example' data-slide='prev'><i class='fas fa-angle-left fa-3x pr-3'></i></a>");
            carousel.Append("<a class='black-text' href='#multi-item-example' data-slide='next'><i class='fas fa-angle-right fa-3x pl-3'></i></a>");
            carousel.Append("</div>");
            //Slides
            carousel.Append("<div class='carousel-inner' role='listbox'>");
            //Slides composé de 3 / 4 images
            
            if(obj.Count() > 0)
            {
                int i = 0;

                foreach (Afpetit.Models.Photo photo in obj)
                {
                    double calcul = i / 4;
                    if (unchecked(calcul == (int)calcul))
                    {
                        //premier Groupe de 4 images
                        carousel.Append("<div class='carousel-item active'>");
                    }
                    else if (unchecked(calcul == (int)calcul))
                    {
                        //Groupe suivant de 4 images 
                        carousel.Append("<div class='carousel-item'>");
                    }

                    //  4 Images à foreacher 
                    carousel.Append("<div class='col-md-3 mb-3'>");
                        carousel.Append("<div class='card'>");
                            carousel.Append("<img class='img-fluid' src='"+photo.Url+"'");
                            carousel.Append("alt ='" + photo.Nom + "'>");
                        carousel.Append("</div>");
                    carousel.Append("</div>");

                    if (unchecked(calcul == (int)calcul))
                    {
                        //premier Groupe de 4 images
                        carousel.Append("</div>");
                    }
                    else if (unchecked(calcul == (int)calcul))
                    {
                        //Groupe suivant de 4 images 
                        carousel.Append("</div>");
                    }
                }
            }
            carousel.Append("</div>");
            carousel.Append("</div>");
            return (carousel.ToString());
        }
    }
}