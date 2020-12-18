using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class CandidaturaRepository : ICandidaturaRepository
    {

        ConexaoVagasContext ctx = new ConexaoVagasContext();

        public List<Candidatura> Listar()
        {
            // Retorna uma lista com todas as informações das candidaturas
            return ctx.Candidatura.Include(c => c.IdCandidatoNavigation)
                                  .ThenInclude(candidato => candidato.IdEnderecoNavigation)
                                  .ToList();
                                  
        }

        public List<Candidatura> ListarPorCandidato(int id)
        {
            return ctx.Candidatura.Where(c => c.IdCandidato == id)
                                  .ToList();
        }

        public Candidatura BuscarPorId(int id)
        {
            // Retorna a primeira candidatura encontrada para o ID informado
            return ctx.Candidatura.Include(c => c.IdCandidatoNavigation)
                                  .FirstOrDefault(h => h.IdCandidatura == id);
        }

        public void Cadastrar(Candidatura novaCandidatura)
        {
            novaCandidatura.DataCriado = DateTime.Now;

            // Adiciona novacandidatura
            ctx.Candidatura.Add(novaCandidatura);

            // Salva as informações para serem gravadas no banco de dados
            ctx.SaveChanges();
        }

        public void Atualizar(int id, Candidatura c)
        {
            // Busca uma vaga através do id
            Candidatura candidaturaBuscada = ctx.Candidatura.Find(id);

            // Atribui os novos valores ao campos existentes
            if (c.Visualizado != null)
                candidaturaBuscada.Visualizado = c.Visualizado;

            // Salva as informações para serem gravadas no banco de dados
            ctx.SaveChanges();
        }

        public void Deletar(int id)
        {
            ctx.Candidatura.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }
    }
}
