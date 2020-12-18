using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Viewmodels
{
    public class UsuarioViewmodel
    {
        public int IdUsuario { get; set; }
        public int IdTipoUsuario { get; set; }
        public CandidatoViewmodel Candidato { get; set; }
        public EmpresaViewmodel Empresa { get; set; }
        public ICollection<Beneficio> Beneficio { get; set; }
        public ICollection<Habilidade> Habilidade { get; set; }

        public UsuarioViewmodel(Usuario u)
        {
            this.IdUsuario = u.IdUsuario;
            this.IdTipoUsuario = u.IdTipoUsuario;

            if (u.IdTipoUsuario == (int)Enums.TipoUsuario.CANDIDATO)
                this.Candidato = new CandidatoViewmodel(u.Candidato);

            if (u.IdTipoUsuario == (int)Enums.TipoUsuario.EMPRESA)
                this.Empresa = new EmpresaViewmodel(u.Empresa);

            this.Beneficio = u.Beneficio.ToList();
            this.Habilidade = u.Habilidade.ToList();
        }
    }
}
