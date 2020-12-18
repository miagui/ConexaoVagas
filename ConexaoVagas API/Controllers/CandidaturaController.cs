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
    // Define que o tipo de resposta da API será no formato JSON
    [Produces("application/json")]

    // Define que a rota de uma requisição será no formato domínio/api/NomeController
    [Route("api/[controller]")]

    // Define que é um controlador de API
    [ApiController]

    public class CandidaturaController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _candidaturaRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private ICandidaturaRepository _candidaturaRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public CandidaturaController()
        {
            _candidaturaRepository = new CandidaturaRepository();
        }

        /// <summary>
        /// Lista candidaturas
        /// </summary>
        /// <returns>Uma candidatura buscada</returns>
        /// dominio/api/Candidatura
        [Authorize]
        [HttpGet]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult Get(int id)
        {

            return Ok(_candidaturaRepository.Listar());
        }

        /// <summary>
        /// Busca candidaturas de um usuário
        /// </summary>
        /// <returns>Uma candidatura buscada</returns>
        /// dominio/api/Candidatura/1
        [Authorize]
        [HttpGet("{id}")]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        [ProducesResponseType(400)]
        public IActionResult GetByCandidato(int id)
        {

            List<Candidatura> candidaturasUsuario = _candidaturaRepository.ListarPorCandidato(id);

            return Ok(candidaturasUsuario);
        }


        /// <summary>
        /// Cadastra uma nova candidatura
        /// </summary>
        /// <param name="novaCandidatura">Objeto novaCandidatura que será cadastrada</param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        /// dominio/api/Candidatura
        [Authorize]
        [HttpPost]
        public IActionResult Post(Candidatura novaCandidatura)
        {
            // Faz a chamada para o método .Cadastrar();
            _candidaturaRepository.Cadastrar(novaCandidatura);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Atualiza uma candidatura cadastrada
        /// </summary>
        /// <param name="id">Id da candidatura que será atualizada</param>
        /// <param name="candidaturaAtualizada"></param>
        /// <returns>Retorna um status code</returns>
        /// dominio/api/Candidatura/1
        [Authorize]
        [HttpPut("{id}")]
        public IActionResult Atualizar(int id, Candidatura candidaturaAtualizada)
        {

            Candidatura candidaturaBuscada = _candidaturaRepository.BuscarPorId(id);

            //Verifica se vagaBuscada é diferente de nulo
            if (candidaturaBuscada != null)
            {
                //Haverá uma tentativa de atualizar a clinica
                try
                {
                    //Caso seja, a vaga será atualizada
                    _candidaturaRepository.Atualizar(id, candidaturaAtualizada);

                    //E retornará um statusCode Ok
                    return StatusCode(200);
                }
                //Ao tentar atualizar, se não for possível, retornará um StatusCode com erro
                catch (Exception erro)
                {
                    return BadRequest(erro);
                }
            }
            // Se clinica não for diferente de nulo, retornará um StatusCode NotFound
            return StatusCode(404);
        }

        [Authorize]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            Candidatura candidaturaBuscada = _candidaturaRepository.BuscarPorId(id);

            //Verifica se candidaturaBuscada é igual a nulo
            if (candidaturaBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a candidatura e retorna um StatusCode Accepted
            _candidaturaRepository.Deletar(id);

            return StatusCode(202);
        }
    }
}