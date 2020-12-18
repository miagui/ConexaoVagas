using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Viewmodels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IUsuarioRepository
    {
        /// <summary>
        /// Lista todas as usuarios
        /// </summary>
        /// <returns>Lista de usuários</returns>
        List<Usuario> Listar();

        /// <summary>
        /// Busca um usuario pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Um usuário</returns>
        Usuario BuscarPorId(int id);

        /// <summary>
        /// Deleta um usuario
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);

        /// <summary>
        /// Busca um usuario pelo email
        /// </summary>
        /// <param name="email"></param>
        /// <returns>Um usuário</returns>
        Usuario BuscarPorEmail(string email);
    }
}
