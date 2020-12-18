using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using ConexaoVagasAPI.Viewmodels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [Produces("application/json")]
    [ApiController]

    public class UsuarioController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _usuarioRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IUsuarioRepository _usuarioRepository { get; set; }

        public UsuarioController()
        {
            _usuarioRepository = new UsuarioRepository();
        }

        /// <summary>
        /// Lista usuários
        /// </summary>
        /// <returns> Lista de usuários com dados públicos. </returns>
        /// <response code="200">OK</response>
        [HttpGet]
        [ProducesResponseType(200)]
        public IActionResult Get()
        {
            //Retorna um StatusCode 200 e a lista de Empresas.
            return Ok(_usuarioRepository.Listar());
        }

        /// <summary>
        /// Busca o usuário logado.
        /// </summary>
        /// <returns> Usuário guardado no JWT com seus dados completos. </returns>
        /// <response code="200">OK</response>
        /// <response code="400">Dados inválidos.</response>
        /// <response code="404">Não encontrado</response>
        [Authorize]
        [HttpGet("Token")]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult GetByJwt()
        {
            try
            {
                // Pega o ID que está guardado no token.
                int id = Convert.ToInt32(User.FindFirst("jti").Value);
                Usuario usuarioBuscado = _usuarioRepository.BuscarPorId(id);

                if (usuarioBuscado != null)
                    return Ok(usuarioBuscado);

                return NotFound("Nenhum Usuário encontrado para o ID informado");
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Busca um usuario através do email.
        /// </summary>
        /// <param name="email"></param>
        /// <returns>Usuario buscado com dados públicos. </returns>
        [Authorize]
        [HttpGet("Email/{email}")]
        public IActionResult GetByEmail(string email)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _usuarioRepository.BuscarPorEmail(email));
        }

        /// <summary>
        /// Deleta usuário
        /// </summary>
        /// <returns> Deleta o usuário logado. </returns>
        /// <response code="204">No Content</response>
        /// <response code="400">Bad Request</response>
        [Authorize]
        [HttpDelete]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult Delete()
        {
            try
            {
                // Pega o ID que está guardado no token.
                int id = Convert.ToInt32(User.FindFirst("jti").Value);
                _usuarioRepository.Deletar(id);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }
    }
}
