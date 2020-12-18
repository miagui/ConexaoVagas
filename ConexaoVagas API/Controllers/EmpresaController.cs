using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using ConexaoVagasAPI.Utils;
using ConexaoVagasAPI.Viewmodels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpresaController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _empresaRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IEmpresaRepository _empresaRepository { get; set; }
        private readonly IHostingEnvironment _env;
        private const string SAVEPATH = "\\imgs\\empresas\\";

        public EmpresaController(IHostingEnvironment env)
        {
            _empresaRepository = new EmpresaRepository();
            _env = env;
        }

        /// <summary>
        /// Lista todos as empresas
        /// </summary>
        /// <returns>Uma lista de empresas e um status code 200 - Ok</returns>
        /// <response code="200">OK</response>
        [Authorize]
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Get()
        {
            //Retorna um StatusCode 200 e a lista de Empresas.
            return Ok(_empresaRepository.Listar());
        }

        /// <summary>
        /// Busca um Empresa pelo ID
        /// </summary>
        /// <param name="id"> ID do Empresa que será buscado </param>
        /// <returns> O Empresa buscado, com suas habilidades e candidaturas. </returns>
        /// <response code="200">OK</response>
        /// <response code="400">Dados inválidos</response>
        /// <response code="404">Não encontrado</response>
        [Authorize]
        [HttpGet("{id}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult GetById(int id)
        {
            try
            {
                Empresa empresa = _empresaRepository.BuscarPorId(id);

                if (empresa != null)
                    return Ok(empresa);

                return NotFound("Nenhum empresa encontrado para o ID informado.");
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Cadastra empresa
        /// </summary>
        /// <returns> Cadastra empresa </returns>
        /// <response code="201">Cadastrado</response>
        /// <response code="400">Dados inválidos</response>
        [HttpPost]
        [ProducesResponseType(201)]
        [ProducesResponseType(400)]
        public IActionResult Post(Empresa novoEmpresa)
        {
            try
            {
                novoEmpresa.IdUsuarioNavigation.Senha = StringUtils.Criptografar(novoEmpresa.IdUsuarioNavigation.Senha);
                _empresaRepository.Cadastrar(novoEmpresa);
                return StatusCode(201);
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Atualiza o Empresa por token.
        /// </summary>
        /// <response code="204">Atualizado</response>
        /// <response code="400">Dados inválidos</response>
        /// <returns></returns>
        [Authorize(Roles = "2")]
        [HttpPut]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult AtualizarPorToken(Empresa empresaAtualizado)
        {
            try
            {
                int id = Convert.ToInt32(User.FindFirst("jti").Value);
                _empresaRepository.Atualizar(id, empresaAtualizado);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Atualiza o Empresa por ID.
        /// </summary>
        /// <response code="204">Atualizado</response>
        /// <response code="400">Dados inválidos</response>
        /// <returns></returns>
        [Authorize(Roles = "2")]
        [HttpPut("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult Atualizar(int id, Empresa empresaAtualizado)
        {
            try
            {
                _empresaRepository.Atualizar(id, empresaAtualizado);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        [HttpPost("Img/upload/{id}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(400)]
        [ProducesResponseType(500)]
        public IActionResult EnviaArquivo([FromForm(Name = "file")] IFormFile file, int id)
        {
            if (file != null)
            {
                if (file.Length > 0)
                {
                    try
                    {
                        if (!Directory.Exists(_env.WebRootPath + SAVEPATH))
                        {
                            Directory.CreateDirectory(_env.WebRootPath + SAVEPATH);
                        }
                        using (FileStream filestream = System.IO.File.Create(_env.WebRootPath + SAVEPATH + id))
                        {
                            file.CopyTo(filestream);
                            filestream.Flush();
                            return Ok(SAVEPATH + id);
                        }
                    }
                    catch (Exception ex)
                    {
                        return StatusCode(500, ex);
                    }
                }
                else
                {
                    return BadRequest("Ocorreu uma falha no envio do arquivo...");
                }
            }
            else
            {
                return BadRequest("Ocorreu uma falha no envio do arquivo...");
            }
        }

        [Authorize]
        [HttpGet("Img/{id}")]
        [ProducesResponseType(200)]
        public IActionResult GetPhoto(int id)
        {
            try
            {
                var image = System.IO.File.OpenRead(_env.WebRootPath + SAVEPATH + id);
                return File(image, "image/jpeg");
            }
            catch
            {
                return BadRequest();
            }
        }

        /// <summary>
        /// Atualiza o estado de uma empresa por ID.
        /// </summary>
        /// <response code="204">Atualizado</response>
        /// <response code="400">Dados inválidos</response>
        /// <returns></returns>
        [Authorize]
        [HttpPut("Status")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult AtualizarStatus([FromQuery] int id, [FromQuery] int idStatus)
        {
            try
            {
                _empresaRepository.MudarStatus(id, idStatus);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }
    }
}
