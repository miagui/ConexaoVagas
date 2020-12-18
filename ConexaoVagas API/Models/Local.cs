using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Models
{
    /// <summary>
    /// Objeto da API do viacep.
    /// https://viacep.com.br/
    /// </summary>
    public class Local
    {
        public string Cep { get; set; }
        public string Logradouro { get; set; }
        public string Complemento { get; set; }
        public string Bairro { get; set; }
        public string Localidade { get; set; }
        public string Uf { get; set; }
        public string Ibge { get; set; }
        public string Gia { get; set; }
        public string Ddd { get; set; }
        public string Siafi { get; set; }
        public string LocalCompleto { get
            {
                return $"{Logradouro}, {Bairro}, {Localidade} - {Uf}";
            }}
    }

}
