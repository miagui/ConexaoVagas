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

    public class HabilidadeController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _habilidadeRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IHabilidadeRepository _habilidadeRepository;

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public HabilidadeController()
        {
            _habilidadeRepository = new HabilidadeRepository();
        }

        /// <summary>
        /// Lista Todas as Habilidades
        /// </summary>
        /// <returns>Uma lista de habilidades e um status code 200 - Ok</returns>
        /// dominio/api/Habilidade
        [HttpGet]
        public IActionResult Get()
        {
            //Retorna um StatusCode e faz uma chamada para o método .Listar()
            return Ok(_habilidadeRepository.Listar());
        }

        /// <summary>
        /// Busca uma habilidade através do seu Id
        /// </summary>
        /// <param name="id">Id da habilidade que sera buscada</param>
        /// <returns>Uma habilidade buscada</returns>
        /// dominio/api/Habilidade/1
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeRepository.BuscarPorId(id));
        }

        /// <summary>
        /// Busca uma habilidade através do nome
        /// </summary>
        /// <param name="name"></param>
        /// <returns>A habilidade buscada com suas informações</returns>
        [HttpGet("pesquisarNome/{name}")]
        public IActionResult GetByName(string name)
        {
            //Retorna os dados buscados e um status code 200 - Ok
            return StatusCode(200, _habilidadeRepository.BuscarPorNome(name));
        }

        /// <summary>
        /// Cadastra uma nova habilidade
        /// </summary>
        /// <param name="novaHabilidade">Objeto novaHabilidade que será cadastrada</param>
        /// <returns>Os dados que foram enviados para cadastro e um status code 201 - Created</returns>
        /// dominio/api/Habilidade
        [Authorize(Roles = "1, 2")]
        [HttpPost]
        public IActionResult Post(Habilidade novaHabilidade)
        {
            // Faz a chamada para o método .Cadastrar();
            _habilidadeRepository.Cadastrar(novaHabilidade);

            // Retorna o status code 201 - Created com a URL e o objeto cadastrado
            return StatusCode(201);
        }

        /// <summary>
        /// Atualiza uma habilidade cadastrada
        /// </summary>
        /// <param name="id">Id da habilidade que será atualizada</param>
        /// <param name="habilidadeAtualizada"></param>
        /// <returns>Retorna um status code</returns>
        /// dominio/api/Habilidade/1
        [Authorize(Roles = "1")]
        [HttpPut("{id}")]
        public IActionResult Put(int id, Habilidade habilidadeAtualizada)
        {
            Habilidade habilidadeBuscada = _habilidadeRepository.BuscarPorId(id);

            //Verifica se habilidadeBuscada é diferente de nulo
            if (habilidadeBuscada != null)
            {
                //Haverá uma tentativa de atualizar a clinica
                try
                {
                    //Caso seja, a habilidade será atualizada
                    _habilidadeRepository.Atualizar(id, habilidadeAtualizada);

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

        [Authorize(Roles = "1")]
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            Habilidade habilidadeBuscada = _habilidadeRepository.BuscarPorId(id);

            //Verifica se habilidadeBuscada é igual a nulo
            if(habilidadeBuscada == null)
            {
                //Se for igual a nulo, retorna um NotFound
                return NotFound();
            }

            //Se não for,deleta a habilidade e retorna um StatusCode Accepted
            _habilidadeRepository.Deletar(id);

            return StatusCode(202);
        }
    }
}