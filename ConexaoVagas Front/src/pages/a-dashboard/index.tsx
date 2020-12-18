import React, { useEffect, useState } from 'react';
import Sidebar from '../../components/sidebar/Index';
import Card from '../../components/card/index';
import EmpresaApi from '../../api/empresa';
import VagaApi from '../../api/vagas';
import CandidaturaApi from '../../api/candidatura';
import NotificacaoApi from '../../api/notificacoes';
import Loader from '../../components/loader';
import Hamburguer from '../../components/hamburguer';
import { graphEmpresa } from '../../services/graph';
import { graphCandidatura } from '../../services/graph';
import { Line } from '@reactchartjs/react-chart.js';
import { Notificacao } from '../../models/notificacao';
import { toDate, toHour } from '../../services/date';
import LoadingPage from '../loading';
import notificacoes from '../../api/notificacoes';

function ADashboard() {

  const [qtdVagas, setQtdVagas] = useState<Number>(0);

  const [qtdEmpresas, setQtdEmpresas] = useState<Number>(0);
  const [chartEmpresasMeses, setChartEmpresasMeses] = useState<string[]>([]);
  const [chartEmpresasCadastros, setChartEmpresasCadastros] = useState<number[]>([]);

  const [qtdCandidaturas, setQtdCandidaturas] = useState<Number>(0);
  const [chartCandidaturasMeses, setChartCandidaturasMeses] = useState<string[]>([]);
  const [chartCandidaturasCadastros, setChartCandidaturasCadastros] = useState<number[]>([]);

  const [Notificacoes, setNotificacoes] = useState<Notificacao[]>();
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      EmpresaApi.listar().then(data => setQtdEmpresas(data?.length)),
      VagaApi.listar().then(data => setQtdVagas(data?.length)),
      graphEmpresa(12).then(data => {
        var joinedMeses: string[] = [];
        var joinedCadastros: number[] = []
        data.map(chart => {
          // Se você especificou como 3 no valor de qtdeMeses e você 
          // estiver no mês de Novembro, vai retornar um array ["Setembro", "Outubro", "Novembro"]
          joinedMeses.push(chart.mes);
          joinedCadastros.push(chart.empresas);
        });

        setChartEmpresasMeses(joinedMeses);
        setChartEmpresasCadastros(joinedCadastros)
      })
      ,
      CandidaturaApi.listar().then(data => setQtdCandidaturas(data?.length)),
      graphCandidatura(12).then(data => {
        var joinedMeses: string[] = [];
        var joinedCadastros: number[] = [];
        data.map(chart => {
          // Se você especificou como 3 no valor de qtdeMeses e você 
          // estiver no mês de Novembro, vai retornar um array ["Setembro", "Outubro", "Novembro"]
          joinedMeses.push(chart.mes);
          joinedCadastros.push(chart.candidaturas);
        });
        setChartCandidaturasMeses(joinedMeses);
        setChartCandidaturasCadastros(joinedCadastros)
      }),

      NotificacaoApi.listar().then(data => setNotificacoes(data.reverse()))
    ])
      .then(() => setIsLoading(false));

  }, []);

  const dataEmpresa = {
    labels: chartEmpresasMeses,
    datasets: [
      {
        label: 'Cadastros de Empresas',
        data: chartEmpresasCadastros,
        fill: false,
        backgroundColor: 'rgb(255, 99, 132)',
        borderColor: 'rgba(255, 99, 132, 0.2)',
      },
    ],
  }

  const dataCandidatura = {
    labels: chartCandidaturasMeses,
    datasets: [
      {
        label: 'Inscrições em vagas',
        data: chartCandidaturasCadastros,
        fill: false,
        backgroundColor: 'rgb(255, 99, 132)',
        borderColor: 'rgba(255, 99, 132, 0.2)',
      },
    ],
  }

  const optionsEmpresa = {
    scales: {
      yAxes: [
        {
          ticks: {
            suggestedMin: 1,
            suggestedMax: 10
          },
        },
      ],
    },
  }

  const optionsCandidaturas = {
    scales: {
      yAxes: [
        {
          ticks: {
            suggestedMin: 1,
            suggestedMax: 10
          },
        },
      ],
    },
  }

  function renderNotificacoes() {

    return Notificacoes!.map((item: Notificacao) => {
      return (
        <div className="pb-4"  >
          <div key={item.idNotificacao}>
            <p className="text-sm">{item.mensagem}</p>
            <p className="text-xs text-gray-700">{`${toDate(new Date(item.dataNotificacao!))} ${toHour(new Date(item.dataNotificacao!))}`}</p>
            <hr className="mt-4" />
          </div>
        </div>
      )
    })
  }

  if (isLoading) {
    return (
      <LoadingPage />
    )
  }

  return (
    <div className="body w-full">
      <Hamburguer className="md:hidden flex fixed" />
      <Sidebar className="md:flex hidden"></Sidebar>
      <main className="md:w-2/3 w-full mx-auto p-5">
        <h1 className="p-10 md:text-2xl text-xl flex justify-center">Dashboard</h1>
        <div className="flex md:flex-no-wrap flex-wrap gap-5 mb-2 justify-center">
          <Card className="flex flex-col p-2 w-full">
            <div className="flex justify-center pb-2">Total de empresas</div>
            <h2 className="text-orange-600 pl-2 font-bold flex justify-center text-4xl">{qtdEmpresas}</h2>
          </Card>

          <Card className="flex flex-col p-2 w-full">
            <div className="flex justify-center pb-2">Total de vagas</div>
            <h2 className="text-blue-600 pl-2 font-bold flex justify-center text-4xl">{qtdVagas}</h2>
          </Card>

          <Card className="flex flex-col p-2 w-full">
            <div className="flex justify-center pb-2">Total de candidaturas</div>
            <h2 className="text-purple-600 pl-2 font-bold flex justify-center text-4xl">{qtdCandidaturas}</h2>
          </Card>
        </div>

        <div className="flex justify-center gap-5 pt-5 w-full lg:flex-no-wrap flex-wrap">

          <div className="flex-auto">
            <Card>
              <Line type={Line} data={dataEmpresa}
                options={optionsEmpresa} />
            </Card>
            <br />
            <Card>
              <Line type={Line} data={dataCandidatura}
                options={optionsCandidaturas} />
            </Card>
          </div>

          <Card className="lg:w-64 w-full overflow-y-scroll h-screen">
            <div>
              <h2 className="flex justify-center pb-2">Notificações</h2>
              <hr className="mb-4" />
            </div>
            <div>
              {renderNotificacoes()}
            </div>
          </Card>
        </div>
      </main>
    </div>
  )
}

export default ADashboard;