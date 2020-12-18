using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Threading.Tasks;
using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interfaces;
using ConexaoVagasAPI.Repositories;
using ConexaoVagasAPI.Utils;
using ConexaoVagasAPI.Viewmodels;
using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace ConexaoVagasAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        /// <summary>
        /// Cria um objeto _usuarioRepository que irá receber todos os métodos definidos na interface
        /// </summary>
        private IUsuarioRepository _usuarioRepository { get; set; }

        /// <summary>
        /// Instancia este objeto para que haja a referência aos métodos no repositório
        /// </summary>
        public LoginController()
        {
            _usuarioRepository = new UsuarioRepository();
        }

        /// <summary>
        /// Valida o Usuário
        /// </summary>
        /// <param name="login"> Objeto login que contém o e-mail e a senha do usuário </param>
        /// <returns> Retorna uma mensagem de Sucesso ou Inválido </returns>
        [HttpPost]
        [ProducesResponseType(200)]
        [ProducesResponseType(404)]
        public IActionResult Post(LoginViewmodel login)
        {
            try
            {
                var emailValidator = new EmailAddressAttribute();

                Usuario usuarioBuscado;

                login.Email = login.Email.ToUpper();

                // Se for um email.
                if (emailValidator.IsValid(login.Email))
                {
                    usuarioBuscado = _usuarioRepository.BuscarPorEmail(login.Email);

                    if (usuarioBuscado != null)
                    {
                        bool isValidUser = StringUtils.VerificarSenha(login.Senha, usuarioBuscado.Senha);
                        if (!isValidUser)
                            return Unauthorized();
                    }
                    else
                        return NotFound();
                }
                else
                {
                    return Unauthorized();
                }

                var claims = new List<Claim>
                {
                    new Claim(JwtRegisteredClaimNames.Email, usuarioBuscado.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, usuarioBuscado.IdUsuario.ToString()),
                    new Claim(ClaimTypes.Role, usuarioBuscado.IdTipoUsuario.ToString()),
                    new Claim("Role", usuarioBuscado.IdTipoUsuario.ToString()),
                };

                if (usuarioBuscado.IdTipoUsuario == (int)Enums.TipoUsuario.CANDIDATO)
                    claims.Add(new Claim("StatusUsuario", usuarioBuscado.Candidato.IdStatusUsuario.ToString()));

                if (usuarioBuscado.IdTipoUsuario == (int)Enums.TipoUsuario.EMPRESA)
                    claims.Add(new Claim("StatusUsuario", usuarioBuscado.Empresa.IdStatusUsuario.ToString()));

                // Define a chave de acesso ao token
                var key = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes("ConexaoVagas-chave-autenticacao"));

                // Define as credenciais do token - Header
                var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                // Gera o token
                var token = new JwtSecurityToken(
                    issuer: "ConexaoVagasAPI",                 // emissor do token
                    audience: "ConexaoVagasAPI",               // destinatário do token
                    claims: claims,                        // dados definidos acima
                    expires: DateTime.Now.AddMinutes(30),  // tempo de expiração
                    signingCredentials: creds              // credenciais do token
                );

                // Retorna Ok com o token
                return Ok(new
                {
                    token = new JwtSecurityTokenHandler().WriteToken(token)
                });
            }

            catch (Exception e)
            {
                // Retorna a resposta da requisição 400 - Bad Request e o erro ocorrido com uma mensagem personalizada
                return BadRequest(new
                {
                    mensagem = "Não foi possível gerar o token",
                    e
                });
            }
        }
    }
}
