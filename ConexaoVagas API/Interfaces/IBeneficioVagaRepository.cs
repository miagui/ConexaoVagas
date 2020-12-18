using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interface
{
    interface IBeneficioVagaRepository
    {
        /// <summary>
        /// //Lista todos os beneficiosVagas
        /// </summary>
        /// <returns>Uma lista de beneficiosVagas</returns>
        List<BeneficioVaga> Listar();

        /// <summary>
        /// Busca um beneficioVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O beneficioVaga buscado</returns>
        BeneficioVaga BuscarPorId(int id);

        /// <summary>
        /// Cadastra um novo beneficioVaga
        /// </summary>
        /// <param name="novoBeneficioVaga"></param>
        void Cadastrar(BeneficioVaga novoBeneficioVaga);

        /// <summary>
        /// Deleta um beneficioVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);
    }
}
