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

    public class habilidadeCandidatoController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _habilidadeCandidatoRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IHabilidadeCandidatoRepository _habilidadeCandidatoRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public habilidadeCandidatoController()
        {
            _habilidadeCandidatoRepository = new HabilidadeCandidatoRepository();
        }

        /// <summary>
        /// Lista todas as HabilidadesCandidatos
        /// </summary>
        /// <returns>Uma lista de habilidadesCandidato e um status code 200 - Ok</returns>
        /// dominio/api/habilidadeCandidato
        [HttpGet]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_habilidadeCandidatoRepository.Listar());
        }

        /// <summary>
        /// Busca uma habilidadeCandidato através do seu Id
        /// </summary>
        /// <param name="id">Id da habilidadeCandidato que sera buscada</param>
        /// <returns>Uma habilidadeCandidato buscada</returns>
        /// dominio/api/habilidadeCandidato/1
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeCandidatoRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Busca uma habilidadeCandidato através do Id da vaga
        /// </summary>
        /// <param name="id">Id da habilidadeCandidato que sera buscada</param>
        /// <returns>Uma habilidadeCandidato buscada</returns>
        /// dominio/api/candidato/1
        [HttpGet("candidato/{id}")]
        public IActionResult GetByIdVaga(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeCandidatoRepository.BuscarPorIdCandidato(id));
        }

        /// <summary>
        /// Cadastra uma nova habilidade
        /// </summary>
        /// <param name="novaHabilidadeCandidato">Objeto novahabilidadeCandidato que será cadastrada</param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        /// dominio/api/habilidadeCandidato
        [Authorize(Roles = "3")]
        [HttpPost]
        public IActionResult Post(HabilidadeCandidato novaHabilidadeCandidato)
        {
            // Faz a chamada para o método .Cadastrar();
            _habilidadeCandidatoRepository.Cadastrar(novaHabilidadeCandidato);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        [Authorize(Roles = "3")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            HabilidadeCandidato habilidadeCandidatoBuscada = _habilidadeCandidatoRepository.BuscarPorId(id);

            //Verifica se habilidadeBuscada é igual a nulo
            if(habilidadeCandidatoBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a habilidade e retorna um StatusCode Accepted
            _habilidadeCandidatoRepository.Deletar(id);

            return StatusCode(202);
        }
    }
}