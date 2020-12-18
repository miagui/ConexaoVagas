using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Interfaces
{
    /// <summary>
    /// Interface responsável pelo NotificacaoRepository
    /// </summary>
    interface INotificacaoRepository
    {
        /// <summary>
        /// Lista as notificacoes
        /// </summary>
        /// <returns>Uma lista das notificacoes</returns>
        List<Notificacao> Listar();

        /// <summary>
        /// Busca uma notificacao pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A notificacao buscada</returns>
        Notificacao BuscarPorId(int id);

        /// <summary>
        /// Cadastrar uma nova notificacao
        /// </summary>
        /// <param name="novoNotificacao"></param>
        void Cadastrar(Notificacao novoNotificacao);

        /// <summary>
        /// Deleta uma notificacao por id
        /// </summary>
        /// <param name="id"></param>
        void Deletar(int id);

        /// <summary>
        /// Deleta todas as notificacoes
        /// </summary>
        void DeletarAll();
    }
}
