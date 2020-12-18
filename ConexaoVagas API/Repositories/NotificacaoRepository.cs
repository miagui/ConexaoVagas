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
    public class NotificacaoRepository : INotificacaoRepository


    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista das notificacoes
        /// </summary>
        /// <returns>Uma lista de notificacoes</returns>
        public List<Notificacao> Listar()
        {
            return ctx.Notificacao.ToList();
        }

        /// <summary>
        /// Cadastrar nova notificacao
        /// </summary>
        /// <param name="novoNotificacao"></param>
        public void Cadastrar(Notificacao novoNotificacao)
        {
            novoNotificacao.DataNotificacao = DateTime.Now;
            ctx.Notificacao.Add(novoNotificacao);
            ctx.SaveChanges();
        }

        /// <summary>
        /// Busca uma notificacao pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A notificacao buscado</returns>
        public Notificacao BuscarPorId(int id)
        {
            return ctx.Notificacao.FirstOrDefault(b => b.IdNotificacao == id);
        }

        /// <summary>
        /// Deletar uma notificacao por id
        /// </summary>
        /// <param name="id"></param>
        public void Deletar(int id)
        {
            ctx.Notificacao.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }

        /// <summary>
        /// Deletar todas as notificacoes
        /// </summary>
        public void DeletarAll()
        {
            ctx.Notificacao.RemoveRange(ctx.Notificacao.ToList());
            ctx.SaveChanges();
        }
    
    }
}
