using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Habilidade
    {
        public Habilidade()
        {
            HabilidadeCandidato = new HashSet<HabilidadeCandidato>();
            HabilidadeVaga = new HashSet<HabilidadeVaga>();
        }

        public int IdHabilidade { get; set; }
        public int? IdCriadoPor { get; set; }
        public string NomeHabilidade { get; set; }

        public Usuario IdCriadoPorNavigation { get; set; }
        public ICollection<HabilidadeCandidato> HabilidadeCandidato { get; set; }
        public ICollection<HabilidadeVaga> HabilidadeVaga { get; set; }
    }
}
