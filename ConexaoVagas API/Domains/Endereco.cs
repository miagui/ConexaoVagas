using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Endereco
    {
        public Endereco()
        {
            Candidato = new HashSet<Candidato>();
            Empresa = new HashSet<Empresa>();
            Vaga = new HashSet<Vaga>();
        }

        public int IdEndereco { get; set; }
        public string Cep { get; set; }
        public string LocalCompleto { get; set; }
        public string Uf { get; set; }
        public double Lat { get; set; }
        public double Long { get; set; }

        public ICollection<Candidato> Candidato { get; set; }
        public ICollection<Empresa> Empresa { get; set; }
        public ICollection<Vaga> Vaga { get; set; }
    }
}
