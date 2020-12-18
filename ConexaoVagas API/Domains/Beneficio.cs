using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Beneficio
    {
        public Beneficio()
        {
            BeneficioVaga = new HashSet<BeneficioVaga>();
        }

        public int IdBeneficio { get; set; }
        public int? IdCriadoPor { get; set; }
        public string NomeBeneficio { get; set; }

        public Usuario IdCriadoPorNavigation { get; set; }
        public ICollection<BeneficioVaga> BeneficioVaga { get; set; }
    }
}
