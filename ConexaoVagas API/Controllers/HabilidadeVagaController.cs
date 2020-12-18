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

    public class HabilidadeVagaController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _habilidadeVagaRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IHabilidadeVagaRepository _habilidadeVagaRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public HabilidadeVagaController()
        {
            _habilidadeVagaRepository = new HabilidadeVagaRepository();
        }

        /// <summary>
        /// Lista todas as HabilidadesVagas
        /// </summary>
        /// <returns>Uma lista de habilidadeVagas e um status code 200 - Ok</returns>
        /// dominio/api/HabilidadeVaga
        [HttpGet]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_habilidadeVagaRepository.Listar());
        }

        /// <summary>
        /// Busca uma habilidadeVaga através do seu Id
        /// </summary>
        /// <param name="id">Id da habilidadeVaga que sera buscada</param>
        /// <returns>Uma habilidadeVaga buscada</returns>
        /// dominio/api/HabilidadeVaga/1
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeVagaRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Busca uma habilidadeVaga através do Id da vaga
        /// </summary>
        /// <param name="id">Id da habilidadeVaga que sera buscada</param>
        /// <returns>Uma habilidadeVaga buscada</returns>
        /// dominio/api/HabilidadeVaga/1
        [HttpGet("vaga/{id}")]
        public IActionResult GetByIdVaga(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeVagaRepository.BuscarPorIdVaga(id));
        }

        /// <summary>
        /// Cadastra uma nova habilidade
        /// </summary>
        /// <param name="novaHabilidadeVaga">Objeto novaHabilidadeVaga que será cadastrada</param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        /// dominio/api/HabilidadeVaga
        [Authorize(Roles = "2")]
        [HttpPost]
        public IActionResult Post(HabilidadeVaga novaHabilidadeVaga)
        {
            // Faz a chamada para o método .Cadastrar();
            _habilidadeVagaRepository.Cadastrar(novaHabilidadeVaga);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        [Authorize(Roles = "2")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            HabilidadeVaga habilidadeVagaBuscada = _habilidadeVagaRepository.BuscarPorId(id);

            //Verifica se habilidadeBuscada é igual a nulo
            if (habilidadeVagaBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a habilidade e retorna um StatusCode Accepted
            _habilidadeVagaRepository.Deletar(id);

            return StatusCode(202);
        }
    }
}