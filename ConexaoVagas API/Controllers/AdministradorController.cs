using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using ConexaoVagasAPI.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AdministradorController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _administradorRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IAdministradorRepository _administradorRepository { get; set; }

        public AdministradorController()
        {
            _administradorRepository = new AdministradorRepository();
        }

        /// <summary>
        /// Lista todos os administradores
        /// </summary>
        /// <returns>Uma lista de administradores e um status code 200 - Ok</returns>
        /// dominio/api/Administrador
        [Authorize(Roles = "1")]
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_administradorRepository.Listar());
        }

        /// <summary>
        /// Busca um Administrador pelo id
        /// </summary>
        /// <param name="id"> id do Administrador que será buscado </param>
        /// <returns> O Administrador buscado, com suas habilidades e candidaturas. </returns>
        /// <response code="200">OK</response>
        /// <response code="400">Dados inválidos.</response>
        /// <response code="404">Não encontrado</response>
        [Authorize(Roles = "1")]
        [HttpGet("{id}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult GetById(int id)
        {
            try
            {
                Administrador administradorBuscado = _administradorRepository.BuscarPorId(id);

                if (administradorBuscado != null)
                    return Ok(administradorBuscado);

                return NotFound("Nenhum administrador encontrado para o ID informado.");
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Cadastra administrador
        /// </summary>
        /// <remarks>
        /// Body Request:
        /// 
        ///            {
        ///             "IdUsuarioNavigation": 
        ///                 {
        ///                 "Email": "string",
        ///                 "Senha": "string",
        ///                 }
        ///             } 
        ///     
        /// </remarks>
        /// <returns> Cadastra administrador </returns>
        [Authorize(Roles = "1")]
        [HttpPost]
        [ProducesResponseType(201)]
        [ProducesResponseType(400)]
        public IActionResult Post(Administrador novoAdministrador)
        {
            try
            {
                novoAdministrador.IdUsuarioNavigation.Senha = StringUtils.Criptografar(novoAdministrador.IdUsuarioNavigation.Senha);
                _administradorRepository.Cadastrar(novoAdministrador);
                return StatusCode(201);
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Atualiza o Administrador pelo token.
        /// </summary>
        /// <remarks>
        /// Body Request
        /// 
        ///         {
        ///         "IdUsuarioNavigation": 
        ///             {
        ///             "Email": "string",
        ///             "Senha": "string",
        ///             }
        ///         } 
        /// 
        /// </remarks>
        /// <param name="id"> Id do Administrador </param>
        /// <param name="administradorAtualizado"> Id do Administrador </param>
        /// <returns></returns>
        [Authorize(Roles = "1")]
        [HttpPut("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult AtualizarPorId(int id, Administrador administradorAtualizado)
        {
            try
            {
                _administradorRepository.Atualizar(id, administradorAtualizado);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }
    }
}

