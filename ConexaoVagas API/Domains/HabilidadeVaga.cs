using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class HabilidadeVaga
    {
        public int IdHabilidadeVaga { get; set; }
        public int IdHabilidade { get; set; }
        public int IdVaga { get; set; }

        public Habilidade IdHabilidadeNavigation { get; set; }
        public Vaga IdVagaNavigation { get; set; }
    }
}
