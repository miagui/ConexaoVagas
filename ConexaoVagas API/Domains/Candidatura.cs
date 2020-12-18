using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Candidatura
    {
        public int IdCandidatura { get; set; }
        public int IdCandidato { get; set; }
        public int IdVaga { get; set; }
        public string Curriculo { get; set; }
        public bool Visualizado { get; set; }
        public DateTime DataCriado { get; set; }

        public Candidato IdCandidatoNavigation { get; set; }
        public Vaga IdVagaNavigation { get; set; }
    }
}
