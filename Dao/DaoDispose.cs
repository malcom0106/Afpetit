﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Afpetit.Dao
{
    public class DaoDispose :DaoAccess
    {
        public void DbDispose()
        {
            db.Dispose();
        }
    }
}