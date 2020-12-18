using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Viewmodels
{
    public class LoginViewmodel
    {
        [Required(ErrorMessage = "Informe o e-mail ou o apelido")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Informe a senha")]
        [DataType(DataType.Password)]
        public string Senha { get; set; }
    }
}
