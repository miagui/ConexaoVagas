using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class AdministradorRepository : IAdministradorRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista todos os administradores
        /// </summary>
        /// <returns>Lista dos administradores</returns>
        public List<Administrador> Listar()
        {
            return ctx.Administrador.Include(a => a.IdUsuarioNavigation)
                                    .ToList();
        }

        /// <summary>
        /// Busca um administrador pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O administrador buscado</returns>
        public Administrador BuscarPorId(int id)
        {
            return ctx.Administrador.Include(a => a.IdUsuarioNavigation)
                                    .FirstOrDefault(a => a.IdUsuario == id);
        }

        /// <summary>
        /// Cadstra um novo administrador
        /// </summary>
        /// <param name="novoAdmin"></param>
        public void Cadastrar(Administrador novoAdmin)
        {
            novoAdmin.IdUsuarioNavigation.DataCadastrado = DateTime.Now;
            novoAdmin.IdUsuarioNavigation.IdTipoUsuario = (int)Enums.TipoUsuario.ADMINISTRADOR;
            ctx.Administrador.Add(novoAdmin);
            ctx.SaveChanges();
        }

        public void Atualizar(int id, Administrador adminAtualizado)
        {
            var admin = ctx.Administrador.Find(id);

            admin.IdUsuarioNavigation.Email = admin.IdUsuarioNavigation.Email;
            admin.IdUsuarioNavigation.Senha = admin.IdUsuarioNavigation.Senha;

            ctx.SaveChanges();
        }
    }
}
