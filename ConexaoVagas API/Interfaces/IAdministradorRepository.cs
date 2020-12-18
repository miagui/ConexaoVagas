using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IAdministradorRepository
    {
        /// <summary>
        /// //Lista todos os administradores
        /// </summary>
        /// <returns>Uma lista de administradores</returns>
        List<Administrador> Listar();

        /// <summary>
        /// Busca um Admin pelo ID
        /// </summary>
        /// <param name="id"> ID do Admin que será buscado</param>
        /// <returns> O Admin buscado </returns>
        Administrador BuscarPorId(int id);

        /// <summary>
        /// Cadastra um novo Admin no sistema
        /// </summary>
        /// <param name="novoAdmin"> Objeto com as informações de Cadastro </param>
        void Cadastrar(Administrador novoAdmin);

        /// <summary>
        /// Altera um Admin existente
        /// </summary>
        /// <param name="id"> ID do Admin que será atualizado </param>
        /// <param name="adminAtualizado"> Objeto com as novas informações </param>
        void Atualizar(int id, Administrador adminAtualizado);
    }
}
