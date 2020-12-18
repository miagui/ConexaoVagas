using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interface
{
    interface IBeneficioRepository
    {
        /// <summary>
        /// //Lista todos os beneficios
        /// </summary>
        /// <returns>Uma lista de beneficios</returns>
        List<Beneficio> Listar();

        /// <summary>
        /// //Lista todos os beneficios criados de um usuário
        /// </summary>
        /// <returns>Uma lista de beneficios</returns>
        List<Beneficio> ListarPorCriador(int id);

        /// <summary>
        /// Busca um beneficio pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O beneficio buscado</returns>
        Beneficio BuscarPorId(int id);

        /// <summary>
        /// Busca um beneficio por nome
        /// </summary>
        /// <param name="name"></param>
        /// <returns>O beneficio buscada com suas informações</returns>
        Beneficio BuscarPorNome(string name);

        /// <summary>
        /// Cadastra um novo beneficio
        /// </summary>
        /// <param name="novoBeneficio"></param>
        void Cadastrar(Beneficio novoBeneficio);

        /// <summary>
        /// Deleta um beneficio pelo id
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);
    }
}
