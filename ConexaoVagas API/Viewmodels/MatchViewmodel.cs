using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Viewmodels
{
    public class MatchViewmodel
    {
        public int IdCandidato { get; set; }
        public int IdVaga { get; set; }
        public double Porcentagem { get; set; }
        public double Distancia { get; set; }

    }
}
