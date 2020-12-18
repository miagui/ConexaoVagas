using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Viewmodels;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class UsuarioRepository : IUsuarioRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista todos os usuarios
        /// </summary>
        /// <returns></returns>
        public List<Usuario> Listar()
        {
            var usuarios = ctx.Usuario.Include(u => u.Candidato)
                                      .Include(u => u.Empresa)
                                      .Include(u => u.Administrador)
                                      .ToList();
            return usuarios;
        }

        /// <summary>
        /// Busca um usuario por id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Usuario BuscarPorId(int id)
        {
            var usuario = ctx.Usuario.Include(c => c.Candidato)
                                     .Include(e => e.Empresa)
                                     .Include(a => a.Administrador)
                                     .FirstOrDefault(u => u.IdUsuario == id);

            if (usuario != null)
                return usuario; 

            else return null;
        }

        /// <summary>
        /// Busca um usuario através do email. Usado como helper para fazer login.
        /// </summary>
        /// <param name="email"></param>
        /// <returns>O usuario buscado com suas informações</returns>
        public Usuario BuscarPorEmail(string email)
        {
            return ctx.Usuario.Include(u => u.Candidato)
                              .Include(u => u.Empresa)
                              .Include(u => u.Administrador)
                              .FirstOrDefault(h => h.Email.ToUpper() == email.ToUpper());
        }

        /// <summary>
        /// Deleta um usuario por id
        /// </summary>
        /// <param name="id"></param>
        public void Deletar(int id)
        {
            // Esses includes serão utéis para remover todos os traços desse usuário no sistema.
            //var usuario = ctx.Usuario.Include(u => u.Administrador)
            //                         .Include(u => u.Empresa)
            //                         .ThenInclude(e => e.Vaga)
            //                         .ThenInclude(v => v.Candidatura)
            //                         .Include(e => e.Empresa.Vaga)
            //                         .ThenInclude(v => v.HabilidadeVaga)
            //                         .Include(e => e.Empresa.Vaga)
            //                         .ThenInclude(v => v.BeneficioVaga)
            //                         .Include(u => u.Candidato)
            //                         .ThenInclude(c => c.HabilidadeCandidato)
            //                         .Include(u => u.Candidato.Candidatura)
            //                         .FirstOrDefault(c => c.IdUsuario == id);
            var usuario = ctx.Usuario.Include(u => u.Administrador)
                                     .Include(u => u.Empresa)
                                     .Include(u => u.Candidato)
                                     .FirstOrDefault(c => c.IdUsuario == id);
            if (usuario != null)
            {
                ctx.Usuario.Remove(usuario);
                ctx.SaveChanges();
            }
        }
    }
}
