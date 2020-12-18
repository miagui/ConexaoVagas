using ConexaoVagasAPI.Domains;
using ConexaoVagasAPI.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Utils
{
    public class EnderecoUtils
    {
        private const string HERE_APIKEY = "hp_VUqBuxYRpVZ60Xi38OcB_HewzB05VKotA0FHFUQI";

        /// <summary>
        /// use um CEP para conseguir info. sobre um lugar.
        /// </summary>
        /// <param name="cep">CEP do lugar</param>
        /// <returns>Objeto Local com info. sobre o lugar (Viacep)</returns>
        public static Local BuscarLocal(string cep)
        {
            Local local = null;
            try
            {
                HttpClient client = new HttpClient();
                HttpResponseMessage response = client.GetAsync($"https://viacep.com.br/ws/{cep}/json/").Result;

                if (response.IsSuccessStatusCode)
                {
                    string json = response.Content.ReadAsStringAsync().Result;
                    local = JsonConvert.DeserializeObject<Local>(json);
                }
            } 

            catch(Exception e)
            {
                Console.WriteLine(e);
            }

            return local;
        }
        /// <summary>
        /// Retorna um EnderecoDomain usando de um CEP.
        /// </summary>
        /// <param name="cep"></param>
        /// <returns>Objeto Endereco com info. sobre o lugar (Domain)</returns>
        public static Endereco BuscarEndereco(string cep)
        {
            Local local = BuscarLocal(cep);

            string endereco = local.LocalCompleto;

            Geocode geocode = BuscarGeocode(endereco);

            double lat = geocode.items.First().position.lat;
            double lng = geocode.items.First().position.lng;

            return new Endereco
            {
                Cep = cep,
                LocalCompleto = local.LocalCompleto,
                Uf = local.Uf,
                Lat = lat,
                Long = lng

            };
        }

        public static Geocode BuscarGeocode(string lugar)
        {
            Geocode geocode = null;
            try
            {
                HttpClient client = new HttpClient();
                HttpResponseMessage response = client.GetAsync($"https://geocode.search.hereapi.com/v1/" +
                                                               $"geocode?q={lugar}" +
                                                               $"&apiKey={HERE_APIKEY}").Result;

                if (response.IsSuccessStatusCode)
                {
                    string json = response.Content.ReadAsStringAsync().Result;
                    geocode = JsonConvert.DeserializeObject<Geocode>(json);
                }
            }

            catch (Exception e)
            {
                Console.WriteLine(e);
            }

            return geocode;
        }

        /// <summary>
        /// Retorna um objeto route para calculo de rota entre dois pontos.
        /// </summary>
        /// <param name="geocodeOrigin"></param>
        /// <param name="geocodeDestination"></param>
        /// <returns>Route</returns>
        protected static HereRouting GeocodeParaRouting(Geocode geocodeOrigin, Geocode geocodeDestination)
        {
            HereRouting routing = null;
            double latOrigin = geocodeOrigin.items.First().position.lat;
            double longOrigin = geocodeOrigin.items.First().position.lng;
            double latDestination = geocodeDestination.items.First().position.lat;
            double longDestination = geocodeDestination.items.First().position.lng;

            try
            {
                HttpClient client = new HttpClient();
                HttpResponseMessage response = client.GetAsync($"https://router.hereapi.com/v8/" +
                                                               $"routes?transportMode=car" +
                                                               $"&origin={latOrigin},{longOrigin}" +
                                                               $"&destination={latDestination},{longDestination}" +
                                                               $"&return=summary" +
                                                               $"&apiKey={HERE_APIKEY}").Result;

                if (response.IsSuccessStatusCode)
                {
                    string json = response.Content.ReadAsStringAsync().Result;
                    routing = JsonConvert.DeserializeObject<HereRouting>(json);
                }
            }

            catch (Exception e)
            {
                Console.WriteLine(e);
            }

            return routing;
        }
        /// <summary>
        /// Calcula a distância entre dois CEPs.
        /// </summary>
        /// <param name="cep1">Origem</param>
        /// <param name="cep2">Destino</param>
        /// <returns>Distância (KMs)</returns>
        public static double DistanciaCep(string cep1, string cep2)
        {
            Local localOrigin = BuscarLocal(cep1);
            Local localDestination = BuscarLocal(cep2);

            string enderecoOrigin = localOrigin.LocalCompleto;
            string enderecoDestination = localDestination.LocalCompleto;

            Geocode geocodeOrigin = BuscarGeocode(enderecoOrigin);
            Geocode geocodeDestination = BuscarGeocode(enderecoDestination);

            double latOrigin = geocodeOrigin.items.First().position.lat;
            double longOrigin = geocodeOrigin.items.First().position.lng;
            double latDestination = geocodeDestination.items.First().position.lat;
            double longDestination = geocodeDestination.items.First().position.lng;

            return Distancia(latOrigin, longOrigin, latDestination, longDestination, 'K');
        }

        /// <summary>
        /// Calcula a distância usando de latlong.
        /// </summary>
        /// <param name="lat1"></param>
        /// <param name="lon1"></param>
        /// <param name="lat2"></param>
        /// <param name="lon2"></param>
        /// <param name="unit">Unidade de medição.
        ///                    K = Kilômetros
        ///                    M = Milhas
        ///                    N = Milhas Náuticas</param>
        /// <returns></returns>
        public static double Distancia(double lat1, double lon1, double lat2, double lon2, char unit)
        {
            if ((lat1 == lat2) && (lon1 == lon2))
            {
                return 0;
            }
            else
            {
                double theta = lon1 - lon2;
                double dist = Math.Sin(Deg2Rad(lat1)) * Math.Sin(Deg2Rad(lat2)) + Math.Cos(Deg2Rad(lat1)) * Math.Cos(Deg2Rad(lat2)) * Math.Cos(Deg2Rad(theta));
                dist = Math.Acos(dist);
                dist = Rad2Deg(dist);
                dist = dist * 60 * 1.1515;
                if (unit == 'K')
                {
                    dist = dist * 1.609344;
                }
                else if (unit == 'N')
                {
                    dist = dist * 0.8684;
                }
                return (dist);
            }
        }

        /// <summary>
        /// Converte graus para radianos.
        /// </summary>
        /// <param name="deg"></param>
        /// <returns>Radianos</returns>
        public static double Deg2Rad(double deg)
        {
            return (deg * Math.PI / 180.0);
        }

        /// <summary>
        /// Converte radianos para graus.
        /// </summary>
        /// <param name="rad"></param>
        /// <returns>Graus</returns>
        public static double Rad2Deg(double rad)
        {
            return (rad / Math.PI * 180.0);
        }

        //public static double CalcularKm(double latOrigin, double longOrigin, double latDestination, double longDestination)
        //{
        //    return 0.0;
        //}
    }
}