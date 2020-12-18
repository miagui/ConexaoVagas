using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interface;
using ConexaoVagasAPI.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Controllers
{
    // Define que o tipo de resposta da API será no formato JSON
    [Produces("application/json")]

    // Define que a rota de uma requisição será no formato domínio/api/NomeController
    [Route("api/[controller]")]

    // Define que é um controlador de API
    [ApiController]

    public class BeneficiosVagasController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _beneficioVagaVagaRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IBeneficioVagaRepository _beneficioVagaRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public BeneficiosVagasController()
        {
            _beneficioVagaRepository = new BeneficioVagasRepository();
        }

        /// <summary>
        /// Lista Todas os beneficioVagas
        /// </summary>
        /// <returns>Uma lista de beneficioVagas e um status code 200 - Ok</returns>
        /// dominio/api/Habilidade
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_beneficioVagaRepository.Listar());
        }

        /// <summary>
        /// Busca um beneficioVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>O beneficioVaga buscado</returns>
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _beneficioVagaRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Cadastra um novo beneficioVaga
        /// </summary>
        /// <param name="novoBeneficioVaga"></param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        [Authorize(Roles = "2")]
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public IActionResult Post(BeneficioVaga novoBeneficioVaga)
        {
            // Faz a chamada para o método .Cadastrar();
            _beneficioVagaRepository.Cadastrar(novoBeneficioVaga);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Deleta um beneficioVaga pelo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Um status code</returns>
        [Authorize(Roles = "2")]
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status202Accepted)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Delete(int id)
        {
            BeneficioVaga beneficioVagaBuscado = _beneficioVagaRepository.BuscarPorId(id);

            //Verifica se beneficioVagaBuscado é igual a nulo
            if (beneficioVagaBuscado == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a bebeficioVaga e retorna um StatusCode Accepted
            _beneficioVagaRepository.Deletar(id);

            return StatusCode(202);
        }

    }
}
