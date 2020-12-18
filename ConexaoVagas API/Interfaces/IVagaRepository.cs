using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface IVagaRepository
    {
        /// <summary>
        /// Lista todas as vagas
        /// </summary>
        /// <returns>Uma lista das candidaturas</returns>
        List<Vaga> Listar();

        /// <summary>
        /// Lista todas as vagas de uma empresa
        /// </summary>
        /// <param name="id">ID da empresa</param>
        /// <returns>Lista das vagas</returns>
        List<Vaga> ListarPorEmpresa(int id);

        /// <summary>
        /// Busca uma vaga ppor filtro
        /// </summary>
        /// <param name="titulo">Titulo da vaga a ser filtrada</param>
        /// <param name="minSalario">Salário Mínimo</param>
        /// <param name="idHabilidade">ID da Habilidade a ser filtrada</param>
        /// <returns>Vaga</returns>
        List<Vaga> ListarPorFiltro(string titulo, decimal minSalario, int idHabilidade);

        /// <summary>
        /// Busca uma vaga pelo id
        /// </summary>
        /// <param name="id">ID da vaga</param>
        /// <returns>Uma candidatura</returns>
        Vaga BuscarPorId(int id);


        /// <summary>
        /// Atualiza uma vaga existente
        /// </summary>
        /// <param name="id"></param>
        /// <param name="vaga">Vaga atualizada</param>
        void Atualizar(int id, Vaga vaga);

        /// <summary>
        /// Cadastra uma nova vaga
        /// </summary>
        /// <param name="vaga">Nova vaga que será cadastrada</param>
        void Cadastrar(Vaga vaga);

        /// <summary>
        /// Deleta uma habilidade
        /// </summary>
        /// <param name="id">ID da vaga</param>
        void Deletar(int id);

    }
}
