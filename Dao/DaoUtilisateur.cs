using Afpetit.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Helpers;

namespace Afpetit.Dao
{
    public class DaoUtilisateur : DaoAccess
    {
        /// <summary>
        /// Renvoyer un utilisateur
        /// </summary>
        /// <param name="utilisateur"></param>
        /// <returns>Objet Utilisateur</returns>
        public Utilisateur GetUtilisateurById(int IdUtilisateur)
        {
            try
            {
                return db.Utilisateurs.Where(r => r.IdUtilisateur == IdUtilisateur).FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        public Utilisateur GetUtilisateurBySessionId(string SessionId)
        {
            try
            {
                return db.Utilisateurs.First(p => p.IdSession == SessionId);
            }
            catch(Exception ex)
            {
                throw ex;
            }
            
        }

        /// <summary>
        /// Retourner une liste des utilisateurs
        /// </summary>
        /// <returns>List<Utilisateur></Utilisateur></returns>
        public List<Utilisateur> GetUtilisateurs()
        {
            try
            {
                return db.Utilisateurs.ToList();
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Changer le password d'un utilisateur 
        /// </summary>
        /// <param name="utilisateur">Objet Utilisateur</param>
        /// <param name="password1">Premier password saisi</param>
        /// <param name="password2">Second password saisi</param>
        /// <returns>Returne un boolean</returns>
        public bool ChangePassword(Utilisateur utilisateur, string password1, string password2)
        {
            try
            {
                Utilisateur user = this.GetUtilisateurById(utilisateur.IdUtilisateur);
                if (user != null)
                {
                    if (password1 == password2)
                    {
                        user.Password = Crypto.HashPassword(password2);
                        db.SaveChanges();
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                return false;
            }
            catch(Exception ex)
            {
                throw ex;
            }
            
            
        }

        /// <summary>
        /// Ajout d'un utilisateur 
        /// </summary>
        /// <param name="utilisateur"></param>
        /// <returns>Retourner un boolean</returns>
        public bool AddUtilisateur(Utilisateur utilisateur)
        {
            try
            {
                db.Utilisateurs.Add(utilisateur);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        /// <summary>
        /// Editer un utilisateur 
        /// </summary>
        /// <param name="utilisateur"></param>
        /// <returns>Retourner un boolean</returns>
        public bool EditUtilisateur(Utilisateur utilisateur)
        {
            try
            {
                db.Entry(utilisateur).State = EntityState.Modified;
                db.SaveChanges();
                return true;
            }
            catch(Exception ex)
            {
                throw ex;
            }
            
        }

        /// <summary>
        /// Connexion et verification du password Hashé
        /// </summary>
        /// <param name="utilisateur"></param>
        /// <param name="sessionId"></param>
        /// <returns>Retourner un boolean</returns>
        public Utilisateur Connexion(Utilisateur utilisateur, string sessionId)
        {
            Utilisateur client = null;
            try
            {
                client = db.Utilisateurs.Where(u => u.Matricule == utilisateur.Matricule).FirstOrDefault();                
                if (client != null && Crypto.VerifyHashedPassword(client.Password, utilisateur.Password))
                {
                    client.IdSession = sessionId;
                    db.SaveChanges();                    
                }
                return null;
            }
            catch(Exception ex)
            {

                throw ex;
            }            
        }

        /// <summary>
        /// Retourne le sessionutilisateur stocké en bdd
        /// </summary>
        /// <param name="IdSession"></param>
        /// <returns></returns>
        public SessionUtilisateur GetSessionUtilisateur(string IdSession)
        {
            try
            {
                return db.SessionUtilisateurs.Find(IdSession);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}