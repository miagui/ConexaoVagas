using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Candidato
    {
        public Candidato()
        {
            Candidatura = new HashSet<Candidatura>();
            HabilidadeCandidato = new HashSet<HabilidadeCandidato>();
            Matching = new HashSet<Matching>();
        }

        public int IdUsuario { get; set; }
        public int IdStatusUsuario { get; set; }
        public int? IdEndereco { get; set; }
        public string Nome { get; set; }
        public string Sobrenome { get; set; }
        public string Curso { get; set; }
        public string FormacaoAcademica { get; set; }
        public string Matricula { get; set; }
        public string Cpf { get; set; }
        public string Rg { get; set; }
        public string TelefoneCandidato { get; set; }
        public string CelularCandidato { get; set; }
        public DateTime DataNascimento { get; set; }
        public int Visualizacao { get; set; }

        public Endereco IdEnderecoNavigation { get; set; }
        public StatusUsuario IdStatusUsuarioNavigation { get; set; }
        public Usuario IdUsuarioNavigation { get; set; }
        public ICollection<Candidatura> Candidatura { get; set; }
        public ICollection<HabilidadeCandidato> HabilidadeCandidato { get; set; }
        public ICollection<Matching> Matching { get; set; }
    }
}
