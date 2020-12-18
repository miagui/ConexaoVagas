using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using ConexaoVagasAPI.Utils;
using ConexaoVagasAPI.Viewmodels;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MatchController : ControllerBase
    {
        private IVagaRepository _vagaRepository { get; set; }
        private ICandidatoRepository _candidatoRepository { get; set; }
        private IMatchingRepository _matchingRepository { get; set; }

        public MatchController()
        {
            _vagaRepository = new VagaRepository();
            _candidatoRepository = new CandidatoRepository();
            _matchingRepository = new MatchingRepository();
        }

        /// <summary>
        /// Deleta e atualiza o matching entre candidatos e vagas.
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpPut]
        public IActionResult Refresh()
        {
            var vagas = _vagaRepository.Listar();
            var candidatos = _candidatoRepository.Listar();
            // Deleta tudo para se preparar para a operação.
            _matchingRepository.DeletarAll();

            foreach (Vaga v in vagas)
            {
                foreach (Candidato c in candidatos)
                {
                    double qtdeHc = c.HabilidadeCandidato.Count;
                    double qtdeHv = v.HabilidadeVaga.Count;
                    double qtdeRelacionadas = 0;
                    double percentage = 0;
                    double distancia = Math.Round(EnderecoUtils
                                       .Distancia(c.IdEnderecoNavigation.Lat, c.IdEnderecoNavigation.Long, v.IdEnderecoNavigation.Lat, v.IdEnderecoNavigation.Long, 'K'), 2);

                    foreach (var hc in c.HabilidadeCandidato)
                    {
                        var hvMatch = v.HabilidadeVaga.FirstOrDefault(hv => hv.IdHabilidade == hc.IdHabilidade);
                        if (hvMatch != null)
                            qtdeRelacionadas++;
                    }

                    // Evitar dividir por 0.
                    if (qtdeRelacionadas > 0)
                        percentage = (qtdeRelacionadas / qtdeHv) * 100;

                    var match = new Matching
                    {
                        IdCandidato = c.IdUsuario,
                        IdVaga = v.IdVaga,
                        Porcentagem = Math.Round((percentage / 1.5) + (33 - distancia), 2),
                        Distancia = distancia
                    };

                    _matchingRepository.Cadastrar(match);
                }
            }
            return StatusCode(204);
        }

        /// <summary>
        /// lista Matching.
        /// </summary>
        /// <returns> Lista de Matchings </returns>
        [Authorize]
        [HttpGet]
        public IActionResult Get()
        {
            return StatusCode(200, _matchingRepository.Listar());
        }
    }
}
