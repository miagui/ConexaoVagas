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
    class EmpresaRepository : IEmpresaRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Listar todas as empresas
        /// </summary>
        /// <returns></returns>
        public List<Empresa> Listar()
        {
            return ctx.Empresa.Include(e => e.Vaga).ThenInclude(v => v.BeneficioVaga)
                              .Include(e => e.Vaga).ThenInclude(v => v.HabilidadeVaga)
                              .Include(e => e.Vaga).ThenInclude(v => v.Candidatura)
                              .Include(e => e.IdEnderecoNavigation)
                              .Include(e => e.IdUsuarioNavigation)
                              .ToList();
        }

        /// <summary>
        /// Busca uma empresa pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A empresa buscada</returns>
        public Empresa BuscarPorId(int id)
        {
            return ctx.Empresa.Include(e => e.Vaga).ThenInclude(v => v.BeneficioVaga)
                              .Include(e => e.Vaga).ThenInclude(v => v.HabilidadeVaga)
                              .Include(e => e.Vaga).ThenInclude(v => v.Candidatura)
                              .Include(e => e.IdEnderecoNavigation)
                              .Include(e => e.IdUsuarioNavigation)
                              .FirstOrDefault(e => e.IdUsuario == id);
        }

        /// <summary>
        /// Cadastra uma nove empresa
        /// </summary>
        /// <param name="novaEmpresa"></param>
        public void Cadastrar(Empresa novaEmpresa)
        {
            novaEmpresa.IdUsuarioNavigation.IdTipoUsuario = (int)Enums.TipoUsuario.EMPRESA;
            novaEmpresa.IdStatusUsuario = (int)Enums.StatusUsuario.PENDENTE;
            novaEmpresa.IdUsuarioNavigation.DataCadastrado = DateTime.Now;
            novaEmpresa.IdEnderecoNavigation = EnderecoUtils.BuscarEndereco(novaEmpresa.IdEnderecoNavigation.Cep);

            ctx.Empresa.Add(novaEmpresa);

            ctx.SaveChanges();
        }

        /// <summary>
        /// Atualiza uma empresa pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <param name="empresaAtualizada"></param>
        public void Atualizar(int id, Empresa empresaAtualizada)
        {
            var e = ctx.Empresa.Include(empresa => empresa.IdUsuarioNavigation)
                                .FirstOrDefault(empresa => empresa.IdUsuario == id);
            if (e != null)
            {
                if (empresaAtualizada.CelularEmpresa != null)
                    e.CelularEmpresa = empresaAtualizada.CelularEmpresa;

                if (empresaAtualizada.Foto != null)
                    e.Foto = empresaAtualizada.Foto;
                if (empresaAtualizada.IdEnderecoNavigation != null)
                    if (empresaAtualizada.IdEnderecoNavigation.Cep != null)
                        e.IdEnderecoNavigation = EnderecoUtils.BuscarEndereco(empresaAtualizada.IdEnderecoNavigation.Cep);

                if (empresaAtualizada.Cnae != null)
                    e.Cnae = empresaAtualizada.Cnae;

                if (empresaAtualizada.Cnpj != null)
                    e.Cnpj = empresaAtualizada.Cnpj;

                if (empresaAtualizada.RazaoSocial != null)
                    e.RazaoSocial = empresaAtualizada.RazaoSocial;

                if (empresaAtualizada.NomeFantasia != null)
                    e.NomeFantasia = empresaAtualizada.NomeFantasia;

                if (empresaAtualizada.TelefoneEmpresa != null)
                    e.TelefoneEmpresa = empresaAtualizada.TelefoneEmpresa;

                if (empresaAtualizada.Descricao != null)
                    e.Descricao = empresaAtualizada.Descricao;

                if (empresaAtualizada.Visualizacao != 0)
                    e.Visualizacao = empresaAtualizada.Visualizacao;

                if(empresaAtualizada.IdUsuarioNavigation != null)
                {
                    if (empresaAtualizada.IdUsuarioNavigation.Email != null)
                        e.IdUsuarioNavigation.Email = empresaAtualizada.IdUsuarioNavigation.Email;

                    if (empresaAtualizada.IdUsuarioNavigation.Senha != null)
                        e.IdUsuarioNavigation.Senha = StringUtils.Criptografar(empresaAtualizada.IdUsuarioNavigation.Senha);
                }

            }
            ctx.SaveChanges();
        }

        /// <summary>
        /// Muda o status de uma empresa
        /// </summary>
        /// <param name="id"></param>
        /// <param name="status"></param>
        public void MudarStatus(int id, int status)
        {
            var empresa = ctx.Empresa.Find(id);
            empresa.IdStatusUsuario = status;
            ctx.SaveChanges();
        }
    }
}
