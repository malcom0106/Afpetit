using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoTypeCuisine : DaoAccess
    {
        public List<TypeCuisine> GetTypeCuisines()
        {
            try
            {
                return db.TypeCuisines.Where(t => t.Statut == true).ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }