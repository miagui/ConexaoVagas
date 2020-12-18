/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Button from '../../components/button';
import VagaApi from '../../api/vagas'
import CandidaturaApi from '../../api/candidatura'
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';
import { Vaga } from '../../models/vaga';
import { HabilidadeVaga } from '../../models/habilidadeVaga';
import { BeneficioVaga } from '../../models/beneficioVaga';
import { Link, useHistory } from 'react-router-dom';
import { Candidatura } from '../../models/candidatura';
import { Jwt } from '../../services/auth';
import { TipoUsuario } from '../../utils/enums';
import { useAlert } from 'react-alert';
import { TOKEN_KEY } from '../../api/apisettings';
import LoadingPage from '../loading';
import candidatura from '../../api/candidatura';
import { collapseTextChangeRangesAcrossMultipleVersions } from 'typescript';
import Erro from '../404';

function VerVaga({ match }: any) {

    const {
        params: { id },
    } = match;

    const [vaga, setVaga] = useState<Vaga>(new Vaga());
    const [isLoading, setIsLoading] = useState(true);

    const alert = useAlert();
    const history = useHistory();

    useEffect(() => {
        Promise.all([
            VagaApi.buscarPorId(id).then(data => {
                setVaga(data)
                console.log(data)
                if (data != undefined) {
                    VagaApi.somaVisualizacao(data.idVaga!);
                }
            })
        ])
        .then(() => setIsLoading(false));

    }, []);

    function renderHabilidades() {
        if (vaga.habilidadeVaga?.length == 0) return (
            <div></div>
        )

        return vaga.habilidadeVaga?.map((item: HabilidadeVaga) => {
            return (
                <span className="bg-gray-400 p-2 rounded-full h-8 flex items-center cursor-pointer">
                    {item.idHabilidadeNavigation!.nomeHabilidade}</span>
            )
        })
    }

    function renderBeneficios() {
        if (vaga.beneficioVaga?.length == 0) return (
            <div></div>
        )

        return vaga.beneficioVaga?.map((item: BeneficioVaga) => {
            return (
                <span className="bg-gray-400 p-2 rounded-full h-8 flex items-center cursor-pointer">
                    {item.idBeneficioNavigation!.nomeBeneficio}</span>
            )
        })
    }

    function salvar() {

        var candidaturaManipulavel: Candidatura = {
            idVaga: id,
            idCandidato: Jwt().jti
        }

        if (candidaturaManipulavel != undefined) {
            CandidaturaApi.salvar(candidaturaManipulavel, 0).then(data => {
                if (data != null || data != undefined) {
                    alert.success("Cadastrado com sucesso.");
                    setVaga({...vaga, candidatura: [...vaga.candidatura!, data]});
                }
            });
        } else {
            alert.error('Campos não preenchidos.')
        }
    }

    if (!isLoading && vaga == undefined) {
        return (
            <Erro/>
        )
    }

    if (isLoading) {
        return (
            <LoadingPage />
        )
    }

    return (
        <div className="body w-full">
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden" />
            <main className="w-full">

                <div className="flex flex-col m-auto lg:w-1/2 w-full bg-white shadow shadow-md body">

                    <h1 className="p-10 md:text-2xl text-xl flex justify-center">Detalhes da vaga</h1>

                    <div className="flex flex-col pb-10 justify-center items-center">
                        <p className="text-xl">{vaga?.titulo}</p>
                        <Link to={`/empresa/resumo/${vaga.idEmpresa}`}>
                            <span className="text-link">
                                {vaga.idEmpresaNavigation?.nomeFantasia}
                            </span>
                        </Link>
                    </div>

                    <div className="flex flex-col items-center p-5">
                        <div>
                            <div className="mb-1 flex items-center">
                                <i className="pr-2 ri-time-fill text-xl" />
                                <p>Carga Horária de {vaga?.cargaHoraria}h</p>
                            </div>

                            <div className="mb-1 flex items-center">
                                <p className="pr-2 ri-money-dollar-circle-fill text-xl" />
                                <p>R$ {vaga?.salario}</p>
                            </div>

                            <div className="mb-3 flex items-center">
                                <p className="pr-2 fa fa-graduation-cap text-xl" />
                                <p>{vaga?.qualificacao}</p>
                            </div>

                            <div className="mb-4">
                                <p className="font-bold pr-2">Descrição</p>
                                <p>{vaga?.descricao}</p>
                            </div>

                            <div className="mb-4">
                                <p className="font-bold pr-2">Sobre a empresa</p>
                                <p className="pr-8">{vaga?.idEmpresaNavigation?.descricao}</p>
                            </div>

                            <div className="mb-4">
                                <p className="font-bold pr-2">Local</p>
                                <p className="pr-8">{vaga?.idEnderecoNavigation?.localCompleto}</p>
                            </div>

                            <div className="mb-4">
                                <p className="font-bold">Habilidades buscadas</p>
                                <div className="flex flex-row flex-wrap mb-2 gap-2">
                                    {renderHabilidades()}
                                </div>
                            </div>

                            <div className="mb-4">
                                <p className="font-bold">Benefícios</p>
                                <div className="flex flex-column flex-wrap mb-2 gap-2">
                                    {renderBeneficios()}
                                </div>
                            </div>
                        </div>
                    </div>
                        {Jwt().Role == TipoUsuario.CANDIDATO && (
                            <div className="mt-auto py-5 flex flex-col items-center justify-center gap-3">
                                <div>

                                    {!vaga.candidatura!.find(c => c.idCandidato == Jwt().jti) && (
                                        <Button name="Candidatar-se"
                                            onClick={() => salvar()}>Candidatar-se
                                        </Button>
                                    )}

                                    {vaga.candidatura!.find(c => c.idCandidato == Jwt().jti) && (
                                        <Button className="flex items-center"
                                                name="Candidatado"
                                                style={{backgroundColor: "green"}}>
                                            Candidatado
                                            <i className="ri-check-line text-white pl-2"></i>
                                        </Button>
                                    )}
                                </div>

                                <div>
                                </div>
                            </div>
                        )}


                </div>
            </main>
        </div>
    )
}

export default VerVaga;