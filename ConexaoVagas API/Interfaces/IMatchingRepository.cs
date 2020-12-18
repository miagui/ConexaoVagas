using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IMatchingRepository
    {
        /// <summary>
        /// Lista as notificacoes
        /// </summary>
        /// <returns>Uma lista das notificacoes</returns>
        List<Matching> Listar();

        /// <summary>
        /// Busca uma matching pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A matching buscada</returns>
        Matching BuscarPorId(int id);

        /// <summary>
        /// Cadastra uma nova matching
        /// </summary>
        /// <param name="novoMatching"></param>
        void Cadastrar(Matching novoMatching);

        /// <summary>
        /// Deleta uma matching por id
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);

        /// <summary>
        /// Deleta todas as matchings
        /// </summary>
        void DeletarAll();
    }
}
