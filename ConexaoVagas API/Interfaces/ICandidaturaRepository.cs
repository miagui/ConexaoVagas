using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface ICandidaturaRepository
    {
        /// <summary>
        /// Lista todas as Candidaturas
        /// </summary>
        /// <returns>Lista das candidaturas</returns>
        List<Candidatura> Listar();

        /// <summary>
        /// Lista todas candidaturas de um usuário.
        /// </summary>
        /// <param name="idUsuario">ID do Usuário</param>
        /// <returns>Lista de candidaturas</returns>
        List<Candidatura> ListarPorCandidato(int idUsuario);

        /// <summary>
        /// Busca uma candidatura pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Uma candidatura</returns>
        Candidatura BuscarPorId(int id);

        /// <summary>
        /// Altera um Candidato existente
        /// </summary>
        /// <param name="id"> ID do Candidato que será atualizado </param>
        /// <param name="candidatoAtualizado"> Objeto com as novas informações </param>
        void Atualizar(int id, Candidatura c);

        /// <summary>
        /// Cadastra uma nova candidatura
        /// </summary>
        /// <param name="novaCandidatura">Objeto novaCandidatura que será cadastrada</param>
        void Cadastrar(Candidatura novaCandidatura);

        /// <summary>
        /// Deleta uma candidatura
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);



    }
}
