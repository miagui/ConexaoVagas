using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Usuario
    {
        public Usuario()
        {
            Beneficio = new HashSet<Beneficio>();
            Habilidade = new HashSet<Habilidade>();
        }

        public int IdUsuario { get; set; }
        public int IdTipoUsuario { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public DateTime? DataCadastrado { get; set; }

        public TipoUsuario IdTipoUsuarioNavigation { get; set; }
        public Administrador Administrador { get; set; }
        public Candidato Candidato { get; set; }
        public Empresa Empresa { get; set; }
        public ICollection<Beneficio> Beneficio { get; set; }
        public ICollection<Habilidade> Habilidade { get; set; }
    }
}
