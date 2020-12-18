import React, { useEffect, useState } from 'react';
import Sidebar from '../../components/sidebar/Index';
import Card from '../../components/card/index';
import EmpresaApi from '../../api/empresa';
import Hamburguer from '../../components/hamburguer';
import { graphCandidaturaEmpresa } from '../../services/graph';
import { Line } from '@reactchartjs/react-chart.js';
import { Empresa } from '../../models/empresa';
import { Jwt } from '../../services/auth';
import LoadingPage from '../loading';

function EDashboard() {

    const [empresa, setEmpresa] = useState<Empresa>(new Empresa());
    const [qtdCandidaturas, setQtdCandidaturas] = useState<number>(0);
    const [chartCandidaturasMeses, setChartCandidaturasMeses] = useState<string[]>([]);
    const [chartCandidaturasCadastros, setChartCandidaturasCadastros] = useState<number[]>([]);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        Promise.all([
            EmpresaApi.buscarPorId(Jwt().jti).then(data => {
                setEmpresa(data);
    
                var qtde = 0;
                data.vaga?.forEach(item => qtde = qtde + item.candidatura!.length)
                setQtdCandidaturas(qtde)
    
                var graphCandidatura = graphCandidaturaEmpresa(12, data);
    
                var joinedMeses: string[] = [];
                var joinedCadastros: number[] = [];
    
                graphCandidatura.map(chart => {
                    joinedMeses.push(chart.mes);
                    joinedCadastros.push(chart.candidaturas);
                });
    
                setChartCandidaturasMeses(joinedMeses);
                setChartCandidaturasCadastros(joinedCadastros)
    
            })
        ])
        .then(() => setIsLoading(false))
        
    }, []);

    const dataCandidatura = {
        labels: chartCandidaturasMeses,
        datasets: [
            {
                label: 'Cadastros de Candidaturas',
                data: chartCandidaturasCadastros,
                fill: false,
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgba(255, 99, 132, 0.2)',
            },
        ],
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

    if (isLoading) {
        return (
            <LoadingPage/>
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
                        <div className="flex justify-center pb-2">Total de vagas</div>
                        <h2 className="text-orange-600 pl-2 font-bold flex justify-center text-4xl">{empresa.vaga?.length}</h2>
                    </Card>

                    <Card className="flex flex-col p-2 w-full">
                        <div className="flex justify-center pb-2">Total de visualizações</div>
                        <h2 className="text-blue-600 pl-2 font-bold flex justify-center text-4xl">{empresa.visualizacao}</h2>
                    </Card>

                    <Card className="flex flex-col p-2 w-full">
                        <div className="flex justify-center pb-2">Total de candidaturas</div>
                        <h2 className="text-purple-600 pl-2 font-bold flex justify-center text-4xl">{qtdCandidaturas}</h2>
                    </Card>
                </div>

                <div className="flex justify-center w-full py-8">
                    <div className="w-full">
                        <Card>
                            <Line type={Line} data={dataCandidatura}
                                options={optionsCandidaturas} />
                        </Card>
                    </div>
                </div>
            </main>
        </div>
    )
}

export default EDashboard;