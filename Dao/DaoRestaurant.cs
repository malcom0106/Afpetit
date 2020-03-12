using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoRestaurant : DaoAccess
    {
        public List<Restaurant> GetRestaurants()
        {
            List<Restaurant> restaurants = db.Restaurants.ToList();
            return restaurants;                
        }
    }
}