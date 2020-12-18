using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Repositories
{
    public class BeneficioRepository : IBeneficioRepository
    {
        ConexaoVagasContext ctx = new ConexaoVagasContext();

        public List<Beneficio> Listar()
        {
            return ctx.Beneficio.ToList();
        }
        public List<Beneficio> ListarPorCriador(int id)
        {
            return ctx.Beneficio.Where(b => b.IdCriadoPor == id).ToList();
        }

        public Beneficio BuscarPorId(int id)
        {
            return ctx.Beneficio.FirstOrDefault(b => b.IdBeneficio == id);  
        }

        public Beneficio BuscarPorNome(string name)
        {
            return ctx.Beneficio.FirstOrDefault(h => h.NomeBeneficio == name);
        }

        public void Cadastrar(Beneficio novoBeneficio)
        {
            ctx.Beneficio.Add(novoBeneficio);

            ctx.SaveChanges();
        }

        public void Deletar(int id)
        {
            ctx.Beneficio.Remove(BuscarPorId(id));

            ctx.SaveChanges(); 
        }
    }
}
