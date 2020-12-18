using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IEmpresaRepository
    {
        /// <summary>
        /// //Lista todos as empresas
        /// </summary>
        /// <returns>Uma lista de empresas</returns>
        List<Empresa> Listar();

        /// <summary>
        /// Busca um Empresa pelo ID
        /// </summary>
        /// <param name="id"> ID do Empresa que será buscado</param>
        /// <returns> O Empresa buscado </returns>
        Empresa BuscarPorId(int id);

        /// <summary>
        /// Cadastra um novo Empresa no sistema
        /// </summary>
        /// <param name="novoEmpresa"> Objeto com as informações de Cadastro </param>
        void Cadastrar(Empresa novoEmpresa);

        /// <summary>
        /// Altera um Empresa existente
        /// </summary>
        /// <param name="id"> ID do Empresa que será atualizado </param>
        /// <param name="empresaAtualizado"> Objeto com as novas informações </param>
        void Atualizar(int id, Empresa empresaAtualizado);

        /// <summary>
        /// Muda o status de usuário da Empresa
        /// </summary>
        /// <param name="id"> ID da Empresa </param>
        /// <param name="status">ID do Status</param>
        void MudarStatus(int id, int status);
    }
}
