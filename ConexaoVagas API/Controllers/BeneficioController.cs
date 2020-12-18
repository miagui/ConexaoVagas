using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interface;
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

    public class BeneficioController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _beneficioRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IBeneficioRepository _beneficioRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public BeneficioController()
        {
            _beneficioRepository = new BeneficioRepository();
        }

        /// <summary>
        /// Lista Todas os beneficios
        /// </summary>
        /// <returns>Uma lista de habilidades e um status code 200 - Ok</returns>
        /// dominio/api/Habilidade
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_beneficioRepository.Listar());
        }

        /// <summary>
        /// Busca um beneficio pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O beneficio buscado</returns>
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _beneficioRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Busca um beneficio através do nome
        /// </summary>
        /// <param name="name"></param>
        /// <returns>O beneficio buscado com suas informações</returns>
        [HttpGet("pesquisarBeneficio/{name}")]
        public IActionResult GetByName(string name)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _beneficioRepository.BuscarPorNome(name));
        }

        /// <summary>
        /// Cadastra um novo beneficio
        /// </summary>
        /// <param name="novoBeneficio"></param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        [Authorize(Roles = "1")]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public IActionResult Post(Beneficio novoBeneficio)
        {
            // Faz a chamada para o método .Cadastrar();
            _beneficioRepository.Cadastrar(novoBeneficio);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Deleta um beneficio pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Um status code</returns>
        [Authorize(Roles = "1")]
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status202Accepted)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Delete(int id)
        {
            Beneficio beneficioBuscado = _beneficioRepository.BuscarPorId(id);

            //Verifica se benefucioBuscado é igual a nulo
            if (beneficioBuscado == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta o beneficio e retorna um StatusCode Accepted
            _beneficioRepository.Deletar(id);

            return StatusCode(202);
        }

    }
}