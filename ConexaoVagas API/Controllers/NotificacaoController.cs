using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [Produces("application/json")]
    [ApiController]
    public class NotificacaoController : ControllerBase
    {
        private INotificacaoRepository _NotificacaoRepository { get; set; }

        public NotificacaoController()
        {
            _NotificacaoRepository = new NotificacaoRepository();
        }

        /// <summary>
        /// Busca lista de Notificação.
        /// </summary>
        /// <returns> Lista de notificações </returns>
        [Authorize(Roles = "1, 2")]
        [HttpGet]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        public IActionResult ListarTodos()

        {
            try
            {
                // Retora a resposta da requisição 200 - OK fazendo a chamada para o método e trazendo a notificacao buscada
                return Ok(_NotificacaoRepository.Listar());
            }
            catch (Exception error)
            {
                // Retorna a resposta da requisição 400 - Bad Request e o erro ocorrido
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Busca uma notificacao pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>A notificacao buscada</returns>
        [Authorize(Roles = "1, 2")]
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _NotificacaoRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Cadastra uma nova notificacao
        /// </summary>
        /// <param name="novoNotificacao"></param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        [Authorize(Roles = "1, 2")]
        [HttpPost]
        public IActionResult Post(Notificacao novoNotificacao)
        {
            // Faz a chamada para o método .Cadastrar();
            _NotificacaoRepository.Cadastrar(novoNotificacao);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Deleta uma notificacao pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Um status code</returns>
        [Authorize(Roles = "1, 2")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            Notificacao notificacaoBuscada = _NotificacaoRepository.BuscarPorId(id);

            //Verifica se notificacaoBuscada é igual a nulo
            if (notificacaoBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a notificacao e retorna um StatusCode Accepted
            _NotificacaoRepository.Deletar(id);

            return StatusCode(202);
        }

        /// <summary>
        /// Deleta todas as notificacoes
        /// </summary>
        /// <returns></returns>
        [Authorize(Roles = "1, 2")]
        [HttpDelete]
        public IActionResult DeletarAll()
        {
            _NotificacaoRepository.DeletarAll();
            return NoContent();
        }
    }
}
