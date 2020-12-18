using System;
using System.Collections.Generic;

namespace ConexaoVagasAPI.Domains
{
    public partial class Administrador
    {
        public int IdUsuario { get; set; }

        public Usuario IdUsuarioNavigation { get; set; }
    }
}
