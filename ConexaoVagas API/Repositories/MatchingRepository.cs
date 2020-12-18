using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class MatchingRepository : IMatchingRepository


    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista das notificacoes
        /// </summary>
        /// <returns>Uma lista de notificacoes</returns>
        public List<Matching> Listar()
        {
            return ctx.Matching.ToList();
        }

        /// <summary>
        /// Cadastrar nova matching
        /// </summary>
        /// <param name="novoMatching"></param>
        public void Cadastrar(Matching novoMatching)
        {
            ctx.Matching.Add(novoMatching);
            ctx.SaveChanges();
        }

        /// <summary>
        /// Busca uma matching pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A matching buscado</returns>
        public Matching BuscarPorId(int id)
        {
            return ctx.Matching.FirstOrDefault(b => b.IdMatching == id);
        }

        /// <summary>
        /// Deletar uma matching por id
        /// </summary>
        /// <param name="id"></param>
        public void Deletar(int id)
        {
            ctx.Matching.Remove(BuscarPorId(id));
            ctx.SaveChanges();
        }

        /// <summary>
        /// Deletar todas as notificacoes
        /// </summary>
        public void DeletarAll()
        {
            ctx.Matching.RemoveRange(ctx.Matching.ToList());
            ctx.SaveChanges();
        }
    
    }
}
