using ConexaoVagasAPI.Domains;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Viewmodels
{
    public class EmpresaViewmodel
    {
        public int IdUsuario { get; set; }
        public string Foto { get; set; }
        public string RazaoSocial { get; set; }
        public string TelefoneEmpresa { get; set; }
        public string CelularEmpresa { get; set; }
        public string Email { get; set; }
        public string Cep { get; set; }
        public string Endereco { get; set; }
        public int Numero { get; set; }
        public int Visualizacao { get; set; }
        public List<Vaga> Vaga { get; set; }


        /// <summary>
        /// Construtor do Viewmodel que aceita um objeto Domain para
        /// transformar em um objeto sem informmaçoes sensíveis (EmpresaViewModel).
        /// </summary>
        /// <param name="e"></param>
        public EmpresaViewmodel(Empresa e)
        {
            this.IdUsuario = e.IdUsuario;
            this.CelularEmpresa = e.CelularEmpresa;
            this.Foto = e.Foto;
            this.TelefoneEmpresa = e.TelefoneEmpresa;
            this.Vaga = e.Vaga.ToList();
            this.Visualizacao = e.Visualizacao;
        }
    }
}
