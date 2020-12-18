using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Http;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

namespace ConexaoVagasAPI
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            // Public Release
            // services.AddMvc();
            
            // Desenvolvimento
            services.AddMvc(opts => opts.Filters.Add(new AllowAnonymousFilter()))
                // Impede loop de auto-referência no JSON.
                .AddJsonOptions(options => options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore)
                .SetCompatibilityVersion(Microsoft.AspNetCore.Mvc.CompatibilityVersion.Version_2_1);



            services.AddCors();

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "ConexaoVagasAPI", Version = "v1" });

                var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
                var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
                c.IncludeXmlComments(xmlPath);
            });

            services
                // Define a forma de autenticação
                .AddAuthentication(options =>
                {
                    options.DefaultAuthenticateScheme = "JwtBearer";
                    options.DefaultChallengeScheme = "JwtBearer";
                })

                // Define os parâmetros de validação do token
                .AddJwtBearer("JwtBearer", options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        // Quem está solicitando
                        ValidateIssuer = true,

                        // Quem está validando
                        ValidateAudience = true,

                        // Definindo o tempo de expiração
                        ValidateLifetime = true,

                        // Forma de criptografia
                        IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8.GetBytes("ConexaoVagas-chave-autenticacao")),

                        // Tempo de expiração do token
                        ClockSkew = TimeSpan.FromMinutes(30),

                        // Nome da issuer, de onde está vindo
                        ValidIssuer = "ConexaoVagasAPI",

                        // Nome da audience, de onde está vindo
                        ValidAudience = "ConexaoVagasAPI"
                    };
                });

            //GlobalConfiguration.Configuration.Formatters.JsonFormatter.SerializerSettings.Converters.Add(
            //new IsoDateTimeConverter() { DateTimeFormat = "dd/MM/yyyy"});

        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseCors(options => options.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod());
            app.UseSwagger();

            // Especifica o endpoint json usado pelo Swagger
            app.UseSwaggerUI(c =>
            {
                c.SwaggerEndpoint("/swagger/v1/swagger.json", "ConexaoVagasAPI");
                c.RoutePrefix = string.Empty;
            });
            app.UseAuthentication();

            app.UseMvc();
        }
    }
}
