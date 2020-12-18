using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class HabilidadeCandidatoRepository : IHabilidadeCandidatoRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista tods as habilidadeCandidatos
        /// </summary>
        /// <returns>Lista das habilidadeCandidatos</returns>
        public List<HabilidadeCandidato> Listar()
        {
            // Retorna uma lista com todas as informações das habilidadesCandidatos
            return ctx.HabilidadeCandidato.ToList();
        }

        /// <summary>
        /// Busca uma HabilidadeCandidato através do ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A HabilidadeCandidato buscada</returns>
        public HabilidadeCandidato BuscarPorId(int id)
        {
            // Retorna a primeira habilidade encontrada para o ID informado
            return ctx.HabilidadeCandidato.FirstOrDefault(h => h.IdHabilidadeCandidato == id);
        }

        /// <summary>
        /// Busca uma HabilidadeCandidato através do Id da candidato
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A HabilidadeCandidato buscada</returns>
        public HabilidadeCandidato BuscarPorIdCandidato(int id)
        {
            // Retorna a primeira habilidade encontrada para o Id do candidato informado
            return ctx.HabilidadeCandidato.FirstOrDefault(h => h.IdCandidato == id);
        }

        /// <summary>
        /// Cadastra uma nova HabilidadeCandidato
        /// </summary>
        /// <param name="novaHabilidadeCandidato"></param>
        public void Cadastrar(HabilidadeCandidato novaHabilidadeCandidato)
        {
            // Adiciona novaHabilidade
            ctx.HabilidadeCandidato.Add(novaHabilidadeCandidato);

            // Salva as informações para serem gravadas no banco de dados

            ctx.SaveChanges();
        }

        /// <summary>
        /// Deleta uma HabilidadeCandidato existente
        /// </summary>
        /// <param name="id">ID da HabilidadeCandidato que será deletada</param>
        public void Deletar(int id)
        {
            ctx.HabilidadeCandidato.Remove(BuscarPorId(id));
            ctx.SaveChanges();
        }
    }
}
