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
    // Define que o tipo de resposta da API será no formato JSON
    [Produces("application/json")]

    // Define que a rota de uma requisição será no formato domínio/api/NomeController
    [Route("api/[controller]")]

    // Define que é um controlador de API
    [ApiController]

    public class VagaController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _vagaRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IVagaRepository _vagaRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public VagaController()
        {
            _vagaRepository = new VagaRepository();
        }

        /// <summary>
        /// Lista Todas as Vagas
        /// </summary>
        /// <returns>Uma lista de vagas e um status code 200 - Ok</returns>
        /// dominio/api/Vaga
        [Authorize(Roles = "1,2,3")]
        [HttpGet]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_vagaRepository.Listar());
        }

        /// <summary>
        /// Busca uma vaga através do seu Id
        /// </summary>
        /// <param name="id">Id da vaga que sera buscada</param>
        /// <returns>Uma vaga buscada</returns>
        /// dominio/api/Vaga/13
        [Authorize(Roles = "1,2,3")]
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _vagaRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Busca uma vaga através da empresa
        /// </summary>
        /// <param name="id">ID da empresa</param>
        /// <returns>Vaga</returns>
        [Authorize]
        [HttpGet("Empresa/{id}")]
        public IActionResult GetByEmpresa(int id)
        {
            return StatusCode(200, _vagaRepository.ListarPorEmpresa(id));
        }

        /// <summary>
        /// Busca uma vaga através de filtros
        /// </summary>
        /// <param name="titulo">Nome da vaga</param>
        /// <param name="id">ID da habilidade</param>
        /// <param name="minSalario">Salário mínimo a ser buscado</param>
        /// <returns>Vaga</returns>
        [Authorize]
        [HttpGet("Filtro")]
        public IActionResult GetByFiltro([FromQuery] string titulo,[FromQuery] decimal minSalario,[FromQuery] int id)
        {
            return StatusCode(200, _vagaRepository.ListarPorFiltro(titulo, minSalario, id));
        }

        /// <summary>
        /// Cadastra uma nova vaga
        /// </summary>
        /// <param name="novaVaga">Objeto novaVaga que será cadastrada</param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        /// dominio/api/Vaga
        [Authorize(Roles = "2")]
        [HttpPost]
        public IActionResult Post(Vaga novaVaga)
        {
            // Faz a chamada para o método .Cadastrar();
            _vagaRepository.Cadastrar(novaVaga);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Atualiza uma vaga cadastrada
        /// </summary>
        /// <param name="id">Id da vaga que será atualizada</param>
        /// <param name="vagaAtualizada"></param>
        /// <returns>Retorna um status code</returns>
        /// dominio/api/Vaga/1
        [Authorize(Roles = "2")]
        [HttpPut("{id}")]
        public IActionResult Atualizar(int id, Vaga vagaAtualizada)
        {
            Vaga vagaBuscada = _vagaRepository.BuscarPorId(id);

            //Verifica se vagaBuscada é diferente de nulo
            if (vagaBuscada != null)
            {
                //Haverá uma tentativa de atualizar a clinica
                try
                {
                    //Caso seja, a vaga será atualizada
                    _vagaRepository.Atualizar(id, vagaAtualizada);

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

        [Authorize(Roles = "2")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            Vaga vagaBuscada = _vagaRepository.BuscarPorId(id);

            //Verifica se vagaBuscada é igual a nulo
            if (vagaBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a vaga e retorna um StatusCode Accepted
            _vagaRepository.Deletar(id);

            return StatusCode(202);
        }
    }
}