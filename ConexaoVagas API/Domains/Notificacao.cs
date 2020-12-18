using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Notificacao
    {
        public int IdNotificacao { get; set; }
        public DateTime DataNotificacao { get; set; }
        public string Mensagem { get; set; }
    }
}
