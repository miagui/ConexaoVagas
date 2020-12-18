/* eslint-disable eqeqeq */
import { Candidatura } from "../models/candidatura";
import { ChartCandidaturas } from "../interfaces/chartCandidaturas";
import { Empresa } from "../models/empresa";
import { ChartEmpresas } from "../interfaces/chartEmpresas";
import { Vaga } from "../models/vaga";
import EmpresaApi from '../api/empresa';
import CandidaturaApi from '../api/candidatura';

// Define uma lista de meses para ser exportado depois em qualquer parte da aplicação.
export const MESES = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"];

/**
 * 
 * @param qtdeMeses Qtde de meses a ser retornado na lista.
 */
export function graphCandidatura(qtdeMeses: number): Promise<ChartCandidaturas[]> {
    // Inicializa a data (de hoje)
    var date: Date = new Date();

    // Pega o mês e o ano
    var mesAtual: number = date.getMonth();
    var anoAtual: number = date.getFullYear();

    // Inicializa a lista de candidaturas cadastradas no mês para ter conteudo adicionado depois (push).
    var chartCandidatura: ChartCandidaturas[] = [];

    // LIsta candidaturas e manipula os dados.
    return CandidaturaApi.listar().then((candidaturas: Candidatura[]) => {

        // Laço de repetição de acordo com a qtde de meses a buscar no grafico (qtdeMeses).
        for (let i = 0; i < qtdeMeses; i++) {
            // Candidaturas filtradas pelo mês e ano.
            var candidaturasFiltradas = candidaturas?.filter((candidatura: Candidatura) => {
                var date = new Date(candidatura.dataCriado!)
                var mes = date.getMonth();
                var ano = date.getFullYear();
                // Condição de filtro
                return mes == mesAtual && ano == anoAtual;
            });

            chartCandidatura?.push({
                candidaturas: candidaturasFiltradas?.length,
                mes: `${MESES[mesAtual]}/${anoAtual}`,
                ano: anoAtual
            })

            // Se o mês for Outubro, então volte um mês para Setembro, por exemplo.
            // Esse if evita que subtraia -1 quando o mês for 0 (Janeiro) e manda para Dezembro do ano passado.
            if (mesAtual == 0) {
                mesAtual = 11;
                anoAtual--;
            }
            else
                mesAtual--;
        }
        return chartCandidatura.reverse();
    })
}

/**
 * 
 * @param qtdeMeses Qtde de meses a ser retornado na lista.
 */
export function graphEmpresa(qtdeMeses: number): Promise<ChartEmpresas[]> {
    // Inicializa a data (de hoje)
    var date: Date = new Date();

    // Pega o mês e o ano
    var mesAtual: number = date.getMonth();
    var anoAtual: number = date.getFullYear();

    // Inicializa a lista de empresas cadastradas no mês para ter conteudo adicionado depois (push).
    var chartEmpresas: ChartEmpresas[] = [];

    // LIsta empresas e manipula os dados.
    return EmpresaApi.listar().then((empresas: Empresa[]) => {

        // Laço de repetição de acordo com a qtde de meses a buscar no grafico (qtdeMeses).
        for (let i = 0; i < qtdeMeses; i++) {
            // Empresas filtradas pelo mês e ano.
            var empresasFiltradas = empresas?.filter((empresa: Empresa) => {
                var date = new Date(empresa.idUsuarioNavigation!.dataCadastrado!)
                var mes = date.getMonth();
                var ano = date.getFullYear();
                // Condição de filtro
                return mes == mesAtual && ano == anoAtual;
            });

            chartEmpresas?.push({
                empresas: empresasFiltradas?.length,
                mes: `${MESES[mesAtual]}/${anoAtual}`,
                ano: anoAtual
            })

            // Se o mês for Outubro, então volte um mês para Setembro, por exemplo.
            // Esse if evita que subtraia -1 quando o mês for 0 (Janeiro) e manda para Dezembro do ano passado.
            if (mesAtual == 0) {
                mesAtual = 11;
                anoAtual--;
            }
            else
                mesAtual--;
        }
        return chartEmpresas.reverse();
    })
}

/**
 * 
 * @param qtdeMeses Qtde de meses a ser retornado na lista.
 */
export function graphCandidaturaEmpresa(qtdeMeses: number, empresa: Empresa): ChartCandidaturas[] {
    // Inicializa a data (de hoje)
    var date: Date = new Date();

    // Pega o mês e o ano
    var mesAtual: number = date.getMonth();
    var anoAtual: number = date.getFullYear();

    // Inicializa a lista de candidaturas cadastradas no mês para ter conteudo adicionado depois (push).
    var chartCandidatura: ChartCandidaturas[] = [];


    for (let i = 0; i < qtdeMeses; i++) {

        var candidaturasFiltradas: Candidatura[] = [];

        empresa.vaga?.forEach((vaga: Vaga) => {
            // Soma todas candidaturas filtradas em um array.
            candidaturasFiltradas = candidaturasFiltradas.concat(vaga.candidatura!.filter((candidatura: Candidatura) => {
                var date = new Date(candidatura.dataCriado!)
                var mes = date.getMonth();
                var ano = date.getFullYear();
                // Condição de filtro
                return mes == mesAtual && ano == anoAtual;
            }))

        })

        chartCandidatura?.push({
            candidaturas: candidaturasFiltradas?.length,
            mes: `${MESES[mesAtual]}/${anoAtual}`,
            ano: anoAtual
        })

        // Se o mês for Outubro, então volte um mês para Setembro, por exemplo.
        // Esse if evita que subtraia -1 quando o mês for 0 (Janeiro) e manda para Dezembro do ano passado.
        if (mesAtual == 0) {
            mesAtual = 11;
            anoAtual--;
        }
        else
            mesAtual--;
    }
    return chartCandidatura.reverse();
}
