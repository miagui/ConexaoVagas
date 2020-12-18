/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Card from '../../components/card/index';
import Loader from '../../components/loader';
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';
import MatchesApi from '../../api/matching';
import CandidatosApi from '../../api/candidatos';
import CandidaturasApi from '../../api/candidatura';
import HabilidadeApi from '../../api/habilidades';

import ImgEmpresaDefault from '../../assets/imgs/default-empresa.png';
import { Candidatura } from '../../models/candidatura';
import ImgCandidatoDefault from '../../assets/imgs/default-candidato.png'

import { Vaga } from '../../models/vaga';
import { useLocation } from 'react-router-dom';
import { Matching } from '../../models/matching';
import { Candidato } from '../../models/candidato';
import { API_URL } from '../../api/apisettings';
import LoadingPage from '../loading';
import Dialog from '../../components/dialog';
import Button from '../../components/button';
import { toDate } from '../../services/date';
import { Habilidade } from '../../models/habilidade';
import { HabilidadeCandidato } from '../../models/habilidadeCandidato';

function EVisualizarVaga() {

    const location: any = useLocation();

    const [candidatos, setCandidatos] = useState<Candidato[]>([]);
    const [candidatoDialog, setCandidatoDialog] = useState<Candidato>(new Candidato());
    const [matches, setMatches] = useState<Matching[]>([]);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [vaga, setVagas] = useState<Vaga>(new Vaga());
    const [visualizarPerfil, setVisualizarPerfil] = useState(false);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        Promise.all([
            setVagas(location.state),
            HabilidadeApi.listar().then(data => setHabilidades(data)),
            MatchesApi.listar().then(data => setMatches(data)),
            CandidatosApi.listar().then(data => setCandidatos(data))
        ])
            .then(() => setIsLoading(false));

    }, []);

    function openPerfil(candidatura: Candidatura) {
        setCandidatoDialog(candidatos.find(c => c.idUsuario == candidatura.idCandidato)!)
        setVisualizarPerfil(true);
        if (!candidatura.visualizado) {
            console.log(candidatura.idCandidatura!)
            CandidaturasApi.visualizar(candidatura.idCandidatura!)
        }
    }

    function closePerfil() {
        setCandidatoDialog({});
        setVisualizarPerfil(false);
    }

    function renderCandidaturas() {

        return vaga.candidatura!.map((item: Candidatura) => {
            return (
                <Card key={item.idVaga} className="flex flex-row mb-5 justify-between">
                    {/* Lado esquerdo */}
                    <div className="flex items-center">
                        <div className="bg-white border-2 border-primary-color h-12 w-12 rounded-full ">
                            <p className="text-center pt-3 m-auto text-primary-color font-bold">{Math.round(matches
                                .find(match => (match.idVaga == item.idVaga) && (match.idCandidato == item.idCandidato))?.porcentagem as number || 0)}%</p>
                        </div>
                        <div className="pl-2">
                            {candidatos.find((c: Candidato) => c.idUsuario == item.idCandidato)?.nome +
                            " " +
                            (candidatos.find((c: Candidato) => c.idUsuario == item.idCandidato)?.sobrenome || "")
                            }
                            </div>
                    </div>
                    {/* Lado direito */}
                    <div className="flex md:flex-row flex-col">
                        <div className="hover-gray-200 md:p-5 p-2
                                        flex md:flex-col flex-row items-center"
                            onClick={() => openPerfil(item)}>
                            <i className="ri-file-text-line pr-1 md:text-2xl text-lg
                                          flex justify-center">                
                            </i>
                            <span> Ver perfil</span>
                        </div>
                        {/* Sem funcionalidade de ver PDF */}
                        {/* <div className="hover-gray-200 md:p-5 p-2
                                        flex md:flex-col flex-row items-center">
                            <i className="ri-attachment-2 pr-1 md:text-2xl text-lg
                                          flex justify-center items-center">
                            </i>
                            <span> Ver currículo</span>
                        </div> */}
                    </div>
                </Card>
            )
        })
    }

    if (isLoading) {
        return (
            <LoadingPage />
        )
    }

    return (
        <div className='body w-full'>
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden"></Sidebar>
            <main className="w-full flex flex-col">
                <Dialog isOpen={visualizarPerfil} onAfterClose={closePerfil}
                    title="Detalhes do candidato"
                >
                    <div className="flex justify-center w-50em gap-2 mt-6">
                        <div className="flex flex-col w-full">
                            <div className="flex flex-col gap-5 mb-10 self-center">
                                <img className="w-24 h-24 object-cover rounded-full self-center"
                                    src={`${API_URL}Candidato/Img/${candidatoDialog?.idUsuario}`}
                                    onError={e => e.currentTarget.src = ImgCandidatoDefault} alt="img candidato">
                                </img>
                                <div>
                                    <p className="text-lg">{`${candidatoDialog?.nome}  ${candidatoDialog?.sobrenome || ""}`}</p>
                                </div>
                            </div>
                            <div className="grid md:grid-cols-2 grid-cols-1">
                                {/* Coluna Esquerda */}
                                <div className="flex flex-col flex pr-10">
                                    <div>
                                        <div className="mb-8">
                                            <p className="font-bold">Email</p>
                                            <p>{candidatoDialog?.idUsuarioNavigation?.email}</p>
                                        </div>

                                        <div className="mb-8">
                                            <p className="font-bold">Endereço</p>
                                            <p>{candidatoDialog?.idEnderecoNavigation?.localCompleto}</p>
                                        </div>

                                        <div className="mb-8">
                                            <p className="font-bold"> Curso</p>
                                            <p>{candidatoDialog?.curso}</p>
                                        </div>
                                    </div>
                                </div>

                                {/* Coluna Direita */}
                                <div className="flex flex-col">
                                    <div>
                                        <div className="mb-8">
                                            <p className="font-bold">Data de Nascimento</p>
                                            <p>{toDate(new Date(candidatoDialog?.dataNascimento!))}</p>
                                        </div>

                                        <div className="mb-8">
                                            <p className="font-bold">Celular</p>
                                            <p>{candidatoDialog?.celularCandidato}</p>
                                        </div>
                                        <div className="mb-8">
                                            <p className="font-bold">Telefone</p>
                                            <p>{candidatoDialog?.telefoneCandidato}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {candidatoDialog?.habilidadeCandidato?.length! > 0 && (
                                <div>
                                <p className="font-bold">Habilidades</p>
                                <div className="flex flex-row flex-wrap gap-2">
                                    {candidatoDialog.habilidadeCandidato?.map((item: HabilidadeCandidato) => {
                                        return (
                                            <span className="bg-gray-400 p-2 rounded-full h-8 flex items-center cursor-pointer">
                                                {habilidades?.find(h => h.idHabilidade == item.idHabilidade)?.nomeHabilidade}
                                            </span>
                                        )
                                    })
                                    }
                                </div>
                            </div>
                            )}
                            <div className="flex flex-col items-center mt-5">
                                <Button onClick={closePerfil}>Fechar</Button>
                            </div>
                        </div>
                    </div>
                </Dialog>
                <div className="p-5 bg-cv-gray">
                    <div className="flex lg:w-2/3 w-full mx-auto">
                        <div className="pr-12">
                            <img className="w-56 h-56 object-contain"
                                src={`${API_URL}Empresa/Img/${vaga.idEmpresa}`}
                                onError={e => e.currentTarget.src = ImgEmpresaDefault}>
                            </img>
                        </div>
                        <div>
                            <h2 className="text-2xl">{vaga?.titulo}</h2>
                            <p className="pb-6">{vaga?.descricao}</p>
                            <div>
                                <i className="ri-map-pin-line">
                                    <span>{vaga?.idEnderecoNavigation?.localCompleto}</span>
                                </i>
                                <div className="flex">
                                    <div>
                                        <i className="ri-money-dollar-circle-line lg:text-lg"></i>
                                        <span>R$ {vaga?.salario}</span>
                                    </div>
                                    <div className="pl-10">
                                        <i className="ri-time-line lg:text-lg"></i>
                                        <span>{vaga?.cargaHoraria}h</span>
                                    </div>
                                </div>
                                <div>
                                    <i className="ri-draft-line lg:text-lg"></i>
                                    <span> {vaga.candidatura?.length || 0} candidaturas</span>
                                </div>
                                <div>
                                    <i className="ri-user-line lg:text-lg"></i>
                                    <span> {vaga.visualizacao || 0} visualizações</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {vaga.candidatura!.length > 0 ? (
                    <div>
                        <h1 className="p-10 md:text-2xl text-xl text-center">Candidaturas</h1>
                        <div className="lg:w-2/3 w-full m-auto md:text-base text-sm px-5">
                            <div className="justify-between">
                                <div className="flex flex-row font-medium m-2">
                                    <p className="flex">% de Match</p>
                                    <p className="flex pl-10">Candidato</p>
                                </div>
                            </div>
                            {renderCandidaturas()}
                        </div>
                    </div>
                ) : (
                        <div className="flex flex-1 justify-center items-center">
                            <p className="">Há nenhuma candidatura nessa vaga.</p>
                        </div>
                    )}
            </main>
        </div>
    );
}
export default EVisualizarVaga; 