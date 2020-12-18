using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class StatusUsuario
    {
        public StatusUsuario()
        {
            Candidato = new HashSet<Candidato>();
            Empresa = new HashSet<Empresa>();
        }

        public int IdStatusUsuario { get; set; }
        public string NomeStatus { get; set; }

        public ICollection<Candidato> Candidato { get; set; }
        public ICollection<Empresa> Empresa { get; set; }
    }
}
