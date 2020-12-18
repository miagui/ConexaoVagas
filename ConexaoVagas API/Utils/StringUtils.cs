using Microsoft.AspNetCore.Cryptography.KeyDerivation;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Utils
{
    public class StringUtils
    {
        /// <summary>
        /// Criptografa a senha usando de PBKDF2.
        /// https://en.wikipedia.org/wiki/PBKDF2
        /// </summary>
        /// <param name="senha"></param>
        /// <returns></returns>
        public static string Criptografar(string senha)
        {
            // Cria o tempero com um PRNG criptografado.
            byte[] salt;
            new RNGCryptoServiceProvider().GetBytes(salt = new byte[16]);

            // Cria o hash.
            var pbkdf2 = new Rfc2898DeriveBytes(senha, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);

            // Combina o tempero e a hash para usar depois.
            byte[] hashBytes = new byte[36];
            Array.Copy(salt, 0, hashBytes, 0, 16);
            Array.Copy(hash, 0, hashBytes, 16, 20);


            return Convert.ToBase64String(hashBytes);
        }
        /// <summary>
        /// Compara duas senhas, uma sendo o input do usuário, e a segunda a senha criptografada no banco
        /// </summary>
        /// <param name="senhaInput">Senha digitada pelo usuário.</param>
        /// <param name="senhaSalvada">Senha salva no banco de dados.</param>
        /// <returns></returns>
        public static bool VerificarSenha(string senhaInput, string senhaSalvada)
        {
            // Converte para bytes
            byte[] hashBytes = Convert.FromBase64String(senhaSalvada);

            // Pega o tempero nos 16 bytes.
            byte[] salt = new byte[16];
            Array.Copy(hashBytes, 0, salt, 0, 16);

            // Computa o hash com a senha do usuário
            var pbkdf2 = new Rfc2898DeriveBytes(senhaInput, salt, 100000);
            byte[] hash = pbkdf2.GetBytes(20);

            // Compara o resultado do hash
            for (int i = 0; i < 20; i++)
                if (hashBytes[i + 16] != hash[i])
                    return false;
            return true;
        }
    }
}
