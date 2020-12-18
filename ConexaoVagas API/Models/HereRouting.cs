using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ConexaoVagasAPI.Models
{
    public class HereRouting
    {
        public class Location
        {
            public double lat { get; set; }
            public double lng { get; set; }
        }

        public class Place
        {
            public Location location { get; set; }
            public string type { get; set; }
        }

        public class Arrival
        {
            public Place place { get; set; }
            public DateTime time { get; set; }
        }

        public class Location2
        {
            public double lat { get; set; }
            public double lng { get; set; }
        }

        public class Place2
        {
            public Location2 location { get; set; }
            public string type { get; set; }
        }

        public class Departure
        {
            public Place2 place { get; set; }
            public DateTime time { get; set; }
        }

        public class Summary
        {
            public int duration { get; set; }
            public int length { get; set; }
        }

        public class Transport
        {
            public string mode { get; set; }
        }

        public class Section
        {
            public Arrival arrival { get; set; }
            public Departure departure { get; set; }
            public string id { get; set; }
            public Summary summary { get; set; }
            public Transport transport { get; set; }
            public string type { get; set; }
        }

        public class Route
        {
            public string id { get; set; }
            public List<Section> sections { get; set; }
        }

        /// <summary>
        /// Objeto da HERE Routing API.
        /// API para calcular a distância entre dois pontos, usando latlong.
        /// https://developer.here.com/documentation/routing-api/8.8.0/dev_guide/index.html
        /// </summary>
        public class Routes
        {
            public List<Route> routes { get; set; }
        }
    }
}
