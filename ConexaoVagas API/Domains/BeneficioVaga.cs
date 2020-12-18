using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class BeneficioVaga
    {
        public int IdBeneficioVaga { get; set; }
        public int IdBeneficio { get; set; }
        public int IdVaga { get; set; }

        public Beneficio IdBeneficioNavigation { get; set; }
        public Vaga IdVagaNavigation { get; set; }
    }
}
