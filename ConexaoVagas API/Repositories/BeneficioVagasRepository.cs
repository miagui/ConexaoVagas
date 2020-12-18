using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class BeneficioVagasRepository : IBeneficioVagaRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        /// <summary>
        /// Lista todos os BeneficioVaga
        /// </summary>
        /// <returns>Lista dos BeneficioVagas</returns>
        public List<BeneficioVaga> Listar()
        {
            return ctx.BeneficioVaga.ToList();
        }

        /// <summary>
        /// Busca um BeneficioVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O BeneficioVaga buscado</returns>
        public BeneficioVaga BuscarPorId(int id)
        {
            return ctx.BeneficioVaga.FirstOrDefault(b => b.IdBeneficioVaga == id);
        }

        /// <summary>
        /// Cadastra um novo BeneficioVaga
        /// </summary>
        /// <param name="novoBeneficioVaga"></param>
        public void Cadastrar(BeneficioVaga novoBeneficioVaga)
        {
            ctx.BeneficioVaga.Add(novoBeneficioVaga);

            ctx.SaveChanges();
        }

        /// <summary>
        /// Deleta um BeneficioVaga
        /// </summary>
        /// <param name="id"></param>
        public void Deletar(int id)
        {
            ctx.BeneficioVaga.Remove(BuscarPorId(id));

            ctx.SaveChanges();
        }
    }
}
