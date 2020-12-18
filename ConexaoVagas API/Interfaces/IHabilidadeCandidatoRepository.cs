using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IHabilidadeCandidatoRepository
    {
        /// <summary>
        /// Lista todas as habilidadeCandidatos
        /// </summary>
        /// <returns>Uma lista das habilidadeCandidatos</returns>
        List<HabilidadeCandidato> Listar();

        /// <summary>
        /// Busca uma HabilidadeCandidato pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma HabilidadeCandidato</returns>
        HabilidadeCandidato BuscarPorId(int id);

        /// <summary>
        /// Busca uma HabilidadeCandidato pelo id da vaga
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma HabilidadeCandidato</returns>
        HabilidadeCandidato BuscarPorIdCandidato(int id);

        /// <summary>
        /// Cadastra uma nova HabilidadeCandidato
        /// </summary>
        /// <param name="novaHabilidadeCandidato">Objeto novaHabilidadeCandidato que será cadastrada</param>
        void Cadastrar(HabilidadeCandidato novaHabilidadeCandidato);

        /// <summary>
        /// Deleta uma HabilidadeCandidato
        /// </summary>
        /// <param name="id"></param>
        void Deletar (int id);
    }
}
