using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IHabilidadeRepository
    {
        /// <summary>
        /// Lista todas as habilidades
        /// </summary>
        /// <returns>Uma lista das habilidades</returns>
        List<Habilidade> Listar();

        /// <summary>
        /// Lista todas as habilidades criadas de um usuário
        /// </summary>
        /// <returns>Uma lista das habilidades</returns>
        List<Habilidade> ListarPorCriador(int id);

        /// <summary>
        /// Busca uma habilidade pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma habilidade</returns>
        Habilidade BuscarPorId(int id);

        /// <summary>
        /// Busca uma habilidade por nome
        /// </summary>
        /// <param name="name"></param>
        /// <returns>A habilidade buscada com suas informações</returns>
        Habilidade BuscarPorNome(string name);

        /// <summary>
        /// Cadastra uma nova habilidade
        /// </summary>
        /// <param name="novaHabilidade">Objeto novaHabilidade que será cadastrada</param>
        void Cadastrar(Habilidade novaHabilidade);

        /// <summary>
        /// Atualiza uma habilidade existente
        /// </summary>
        /// <param name="id"></param>
        /// <param name="habilidadeAtualizada"></param>
        void Atualizar(int id, Habilidade habilidadeAtualizada);

        /// <summary>
        /// Deleta uma habilidade
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);
    }
}
