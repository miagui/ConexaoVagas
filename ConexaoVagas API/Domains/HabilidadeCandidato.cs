using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class HabilidadeCandidato
    {
        public int IdHabilidadeCandidato { get; set; }
        public int IdHabilidade { get; set; }
        public int IdCandidato { get; set; }

        public Candidato IdCandidatoNavigation { get; set; }
        public Habilidade IdHabilidadeNavigation { get; set; }
    }
}
