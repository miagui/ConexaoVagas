using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Vaga
    {
        public Vaga()
        {
            BeneficioVaga = new HashSet<BeneficioVaga>();
            Candidatura = new HashSet<Candidatura>();
            HabilidadeVaga = new HashSet<HabilidadeVaga>();
            Matching = new HashSet<Matching>();
        }

        public int IdVaga { get; set; }
        public int IdEmpresa { get; set; }
        public int? IdEndereco { get; set; }
        public string Titulo { get; set; }
        public decimal Salario { get; set; }
        public string Qualificacao { get; set; }
        public DateTime DataCriado { get; set; }
        public DateTime DataExpiracao { get; set; }
        public int CargaHoraria { get; set; }
        public string Descricao { get; set; }
        public int Visualizacao { get; set; }

        public Empresa IdEmpresaNavigation { get; set; }
        public Endereco IdEnderecoNavigation { get; set; }
        public ICollection<BeneficioVaga> BeneficioVaga { get; set; }
        public ICollection<Candidatura> Candidatura { get; set; }
        public ICollection<HabilidadeVaga> HabilidadeVaga { get; set; }
        public ICollection<Matching> Matching { get; set; }
    }
}
