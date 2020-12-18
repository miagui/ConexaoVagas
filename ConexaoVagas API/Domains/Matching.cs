using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Matching
    {
        public int IdMatching { get; set; }
        public int IdVaga { get; set; }
        public int IdCandidato { get; set; }
        public double Porcentagem { get; set; }
        public double Distancia { get; set; }

        public Candidato IdCandidatoNavigation { get; set; }
        public Vaga IdVagaNavigation { get; set; }
    }
}
