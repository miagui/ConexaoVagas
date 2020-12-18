using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    interface ICandidatoRepository
    {
        /// <summary>
        /// //Lista todos os candidatos
        /// </summary>
        /// <returns>Uma lista de candidatos</returns>
        List<Candidato> Listar();

        /// <summary>
        /// Busca um Candidato pelo ID
        /// </summary>
        /// <param name="id"> ID do Candidato que será buscado</param>
        /// <returns> O Candidato buscado </returns>
        Candidato BuscarPorId(int id);

        /// <summary>
        /// Cadastra um novo Candidato no sistema
        /// </summary>
        /// <param name="novoCandidato"> Objeto com as informações de Cadastro </param>
        void Cadastrar(Candidato novoCandidato);

        /// <summary>
        /// Altera um Candidato existente
        /// </summary>
        /// <param name="id"> ID do Candidato que será atualizado </param>
        /// <param name="candidatoAtualizado"> Objeto com as novas informações </param>
        void Atualizar(int id, Candidato candidatoAtualizado);

        /// <summary>
        /// Muda o status de usuário do Candidato
        /// </summary>
        /// <param name="id"> ID do Candidato </param>
        /// <param name="status">ID do Status</param>
        void MudarStatus(int id, int status);
    }
}
