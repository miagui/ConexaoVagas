using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class HabilidadeVagaRepository : IHabilidadeVagaRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista tods as habilidadesVagas
        /// </summary>
        /// <returns>Lista das habilidadesVagas</returns>
        public List<HabilidadeVaga> Listar()
        {
            // Retorna uma lista com todas as informações das habilidadesVags
            return ctx.HabilidadeVaga.ToList();
        }

        /// <summary>
        /// Busca uma habilidadeVaga através do ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A habilidadeVaga buscada</returns>
        public HabilidadeVaga BuscarPorId(int id)
        {
            // Retorna a primeira habilidade encontrada para o ID informado
            return ctx.HabilidadeVaga.FirstOrDefault(h => h.IdHabilidadeVaga == id);
        }

        /// <summary>
        /// Busca uma habilidadeVaga através do Id da vaga
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A habilidadeVaga buscada</returns>
        public HabilidadeVaga BuscarPorIdVaga(int id)
        {
            // Retorna a primeira habilidade encontrada para o Id da vaga informada
            return ctx.HabilidadeVaga.FirstOrDefault(h => h.IdVaga == id);
        }

        /// <summary>
        /// Cadastra uma nova habilidadeVaga
        /// </summary>
        /// <param name="novaHabilidadeVaga"></param>
        public void Cadastrar(HabilidadeVaga novaHabilidadeVaga)
        {
            // Adiciona novaHabilidade
            ctx.HabilidadeVaga.Add(novaHabilidadeVaga);

            // Salva as informações para serem gravadas no banco de dados

            ctx.SaveChanges();
        }

        /// <summary>
        /// Deleta uma habilidadeVaga existente
        /// </summary>
        /// <param name="id">ID da habilidadeVaga que será deletada</param>
        public void Deletar(int id)
        {
            ctx.HabilidadeVaga.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }
    }
}
