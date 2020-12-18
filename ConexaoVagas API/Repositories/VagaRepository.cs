using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Utils;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class VagaRepository : IVagaRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        public List<Vaga> Listar()
        {
            // Retorna uma lista com todas as informações das vagas
            return ctx.Vaga.Include(v => v.BeneficioVaga)
                           .Include(v => v.HabilidadeVaga)
                           .Include(v => v.Candidatura)
                           .Include(v => v.IdEmpresaNavigation)
                           .Include(v => v.IdEnderecoNavigation)
                           .ToList();
        }

        public List<Vaga> ListarPorEmpresa(int id)
        {
            return ctx.Vaga.Where(v => v.IdEmpresa == id).Include(v => v.BeneficioVaga)
                                                           .Include(v => v.HabilidadeVaga)
                                                           .Include(v => v.Candidatura)
                                                           .Include(v => v.IdEmpresaNavigation)
                                                           .Include(v => v.IdEnderecoNavigation)
                                                           .ToList();
        }

        public List<Vaga> ListarPorFiltro(string titulo, decimal minSalario, int idHabilidade)
        {
            IQueryable<Vaga> vagas = ctx.Vaga;

            if (!string.IsNullOrEmpty(titulo) || !string.IsNullOrWhiteSpace(titulo))
                vagas = vagas.Where(v => v.Titulo.ToUpper().Contains(titulo.ToUpper()));

            if (minSalario != 0)
                vagas = vagas.Where(v => v.Salario >= minSalario);

            if (idHabilidade != 0)
                vagas = vagas.Where(v => v.HabilidadeVaga.Any(hv => hv.IdHabilidade == idHabilidade));

            return vagas.Include(v => v.BeneficioVaga)
                           .Include(v => v.HabilidadeVaga)
                           .Include(v => v.Candidatura)
                           .Include(v => v.IdEmpresaNavigation)
                           .Include(v => v.IdEnderecoNavigation)
                           .ToList();
        }

        public Vaga BuscarPorId(int id)
        {
            // Retorna a primeira vaga encontrada para o ID informado
            return ctx.Vaga.Include(v => v.BeneficioVaga)
                           .ThenInclude(bv => bv.IdBeneficioNavigation)
                           .Include(v => v.HabilidadeVaga)
                           .ThenInclude(hv => hv.IdHabilidadeNavigation)
                           .Include(v => v.Candidatura).ThenInclude(c => c.IdCandidatoNavigation)
                           .Include(v => v.IdEmpresaNavigation)
                           .Include(v => v.IdEnderecoNavigation)
                           .Include(v => v.Matching)
                           .FirstOrDefault(h => h.IdVaga == id);
        }

        public void Cadastrar(Vaga novaVaga)
        {
            novaVaga.IdEnderecoNavigation = EnderecoUtils.BuscarEndereco(novaVaga.IdEnderecoNavigation.Cep);

            // Adiciona novaVaga
            ctx.Vaga.Add(novaVaga);

            // Salva as informações para serem gravadas no banco de dados
            ctx.SaveChanges();
        }

        public void Atualizar(int id, Vaga v)
        {
            // Busca uma vaga através do id
            Vaga vagaBuscada = ctx.Vaga.Find(id);

            // Atribui os novos valores ao campos existentes
            if (v.Titulo != null)
                vagaBuscada.Titulo = v.Titulo;

            if (v.Salario != 0)
                vagaBuscada.Salario = v.Salario;


            if (v.IdEnderecoNavigation != null)
                if (v.IdEnderecoNavigation.Cep != null)
                vagaBuscada.IdEnderecoNavigation = EnderecoUtils.BuscarEndereco(v.IdEnderecoNavigation.Cep);

            if (v.Qualificacao != null)
                vagaBuscada.Qualificacao = v.Qualificacao;

            if (v.DataCriado != DateTime.MinValue)
                vagaBuscada.DataCriado = v.DataCriado;

            if (v.DataExpiracao != DateTime.MinValue)
                vagaBuscada.DataExpiracao = v.DataExpiracao;

            if (v.CargaHoraria != 0)
                vagaBuscada.CargaHoraria = v.CargaHoraria;

            if (v.Descricao != null)
                vagaBuscada.Descricao = v.Descricao;

            if (v.Visualizacao != 0)
                vagaBuscada.Visualizacao = v.Visualizacao;

            if (v.IdEmpresaNavigation != null)
                vagaBuscada.IdEmpresaNavigation = v.IdEmpresaNavigation;

            if (v.BeneficioVaga.Count > 0)
                vagaBuscada.BeneficioVaga = v.BeneficioVaga;

            if (v.Candidatura.Count > 0)
                vagaBuscada.Candidatura = v.Candidatura;

            if (v.HabilidadeVaga.Count > 0)
                vagaBuscada.HabilidadeVaga = v.HabilidadeVaga;

            // Atualiza a vaga que foi buscada
            ctx.Vaga.Update(vagaBuscada);

            // Salva as informações para serem gravadas no banco
            ctx.SaveChanges();
        }

        public void Deletar(int id)
        {
            ctx.Vaga.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }
    }
}

