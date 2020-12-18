using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class HabilidadeRepository : IHabilidadeRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        public List<Habilidade> Listar()
        {
            // Retorna uma lista com todas as informações das habilidades
            return ctx.Habilidade.ToList();
        }

        public List<Habilidade> ListarPorCriador(int id)
        {
            return ctx.Habilidade.Where(b => b.IdCriadoPor == id).ToList();
        }

        public Habilidade BuscarPorId(int id)
        {
            // Retorna a primeira habilidade encontrada para o ID informado
            return ctx.Habilidade.FirstOrDefault(h => h.IdHabilidade == id);
        }

        public Habilidade BuscarPorNome(string name)
        {
            return ctx.Habilidade.FirstOrDefault(h => h.NomeHabilidade == name);
        }

        public void Cadastrar(Habilidade novaHabilidade)
        {
            // Adiciona novaHabilidade
            ctx.Habilidade.Add(novaHabilidade);

            // Salva as informações para serem gravadas no banco de dados
            ctx.SaveChanges();
        }

        public void Atualizar(int id, Habilidade habilidadeAtualizada)
        {
            // Busca uma habilidade através do id
            Habilidade habilidadeBuscada = ctx.Habilidade.Find(id);

            // Atribui os novos valores ao campos existentes
            habilidadeBuscada.NomeHabilidade = habilidadeAtualizada.NomeHabilidade;
            habilidadeBuscada.IdCriadoPor = habilidadeAtualizada.IdCriadoPor;

            // Atualiza a habilidade que foi buscada
            ctx.Habilidade.Update(habilidadeBuscada);

            // Salva as informações para serem gravadas no banco
            ctx.SaveChanges();
        }

        public void Deletar(int id)
        {
            ctx.Habilidade.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }
    }
}
