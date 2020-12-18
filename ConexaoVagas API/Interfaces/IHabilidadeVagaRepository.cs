using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IHabilidadeVagaRepository
    {
        /// <summary>
        /// Lista todas as habilidadeVagas
        /// </summary>
        /// <returns>Uma lista das habilidadeVagas</returns>
        List<HabilidadeVaga> Listar();

        /// <summary>
        /// Busca uma habilidadeVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma habilidadeVaga</returns>
        HabilidadeVaga BuscarPorId(int id);

        /// <summary>
        /// Busca uma habilidadeVaga pelo id da vaga
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma habilidadeVaga</returns>
        HabilidadeVaga BuscarPorIdVaga(int id);

        /// <summary>
        /// Cadastra uma nova habilidadeVaga
        /// </summary>
        /// <param name="novaHabilidadeVaga">Objeto novaHabilidadeVaga que será cadastrada</param>
        void Cadastrar(HabilidadeVaga novaHabilidadeVaga);

        /// <summary>
        /// Deleta uma habilidadeVaga
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);
    }
}
