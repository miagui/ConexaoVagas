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
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CandidatoController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _candidatoRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private ICandidatoRepository _candidatoRepository { get; set; }
        private readonly IHostingEnvironment _env;
        private const string SAVEPATH = "\\imgs\\candidatos\\";

        public CandidatoController(IHostingEnvironment env)
        {
            _candidatoRepository = new CandidatoRepository();
            _env = env;
        }

        /// <summary>
        /// Lista todos os candidatos
        /// </summary>
        /// <returns>Uma lista de candidatos com dados públicos. </returns>
        /// <response code="200">OK</response>
        [Authorize]
        [HttpGet]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        public IActionResult Get()
        {
            //Retorna um StatusCode 200 e a lista de candidatos.
            return Ok(_candidatoRepository.Listar());
        }

        /// <summary>
        /// Busca um Candidato pelo ID
        /// </summary>
        /// <param name="id"> ID do Candidato que será buscado </param>
        /// <returns> O Candidato buscado, com suas habilidades e candidaturas. </returns>
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
                Candidato candidato = _candidatoRepository.BuscarPorId(id);

                // Retorna o candidato com dados protegidos pelo Viewmodel.
                if (candidato != null)
                    return Ok(candidato); 

                return NotFound("Nenhum candidato encontrado para o ID informado.");
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Cadastra candidato
        /// </summary>
        /// <returns> Cadastra candidato </returns>
        /// <response code="201">Cadastrado</response>
        /// <response code="400">Dados inválidos.</response>
        [HttpPost]
        [ProducesResponseType(201)]
        [ProducesResponseType(400)]
        public IActionResult Post(Candidato novoCandidato)
        {
            try
            {
                novoCandidato.IdUsuarioNavigation.Senha = StringUtils.Criptografar(novoCandidato.IdUsuarioNavigation.Senha);
                _candidatoRepository.Cadastrar(novoCandidato);
                return StatusCode(201);
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Atualiza o Candidato por id [DEV].
        /// </summary>
        /// <param name="candidatoAtualizado"> Candidato atualizado </param>
        /// <param name="id">ID do candidato</param>
        /// <response code="201">Atualizado</response>
        /// <response code="400">Dados inválidos</response>
        [Authorize(Roles = "3")]
        [HttpPut("{id}")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult AtualizarPorId(Candidato candidatoAtualizado, int id)
        {
            try
            {
                _candidatoRepository.Atualizar(id, candidatoAtualizado);
                return Ok();
            }
            catch (Exception error)
            {
                return BadRequest(error);
            }
        }

        /// <summary>
        /// Atualiza o estado de um candidato por ID.
        /// </summary>
        /// <response code="204">Atualizado</response>
        /// <response code="400">Dados inválidos</response>
        /// <returns></returns>
        [Authorize(Roles = "3")]
        [HttpPut("Status")]
        [ProducesResponseType(204)]
        [ProducesResponseType(400)]
        public IActionResult AtualizarStatus([FromQuery] int id, [FromQuery] int idStatus)
        {
            try
            {
                _candidatoRepository.MudarStatus(id, idStatus);
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
    }
}
