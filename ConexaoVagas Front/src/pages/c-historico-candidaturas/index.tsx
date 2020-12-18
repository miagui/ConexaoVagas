import React, { useEffect, useState } from 'react';
import Card from '../../components/card/index';
import CandidatoApi from '../../api/candidatos'
import Sidebar from '../../components/sidebar/Index';
import Loader from '../../components/loader';
import Hamburguer from '../../components/hamburguer';
import { Candidato } from '../../models/candidato';
import { Candidatura } from '../../models/candidatura';
import { Jwt } from '../../services/auth';
import { toDate, toHour } from '../../services/date';
import Pagination from '../../components/pagination';
import ImgEmpresaDefault from '../../assets/imgs/default-empresa.png'
import { API_URL } from '../../api/apisettings';
import LoadingPage from '../loading';

function CHistoricoCandidaturas() {
    const [candidato, setCandidato] = useState<Candidato>();
    const [currentPage, setCurrentPage] = useState(1);
    const [candidaturasPorPagina] = useState(10);
    const [candidaturasAtuais, setCandidaturasAtuais] = useState<Candidatura[]>([])
    const [isLoading, setIsLoading] = useState(true);

    const paginate = (pageNumber: any) => setCurrentPage(pageNumber);

    useEffect(() => {
        Promise.all([
            CandidatoApi.buscarPorId(Jwt().jti).then(data => {
                setCandidato(data)
                // Get current posts
                const indexOfLastPost = currentPage * candidaturasPorPagina;
                const indexOfFirstPost = indexOfLastPost - candidaturasPorPagina;
                setCandidaturasAtuais(data!.candidatura!.reverse().slice(indexOfFirstPost, indexOfLastPost));
            })
        ])
            .then(() => setIsLoading(false))
    }, []);

    function renderCandidaturas() {

        return candidaturasAtuais?.map((item: Candidatura) => {
            return (
                <Card className="flex flex-col mb-5" key={item.idCandidatura}>
                    {/* Conteudo encima */}
                    <div className="flex justify-between">
                        <div className="flex pb-2">
                            <div className="pr-2">
                                <img className="w-16 h-16 object-contain"
                                    src={`${API_URL}Empresa/Img/${item.idVagaNavigation?.idEmpresa}`}
                                    onError={e => e.currentTarget.src = ImgEmpresaDefault} alt="img empresa"></img>
                            </div>
                            <p className="flex items-center">{item.idVagaNavigation?.titulo}</p>
                        </div>
                        {item.visualizado && (
                            <div className="flex items-center self-start gap-1 text-green-1 text-sm"
                                 title="Empresa já visualizou sua candidatura.">
                                <span>Visualizado</span>
                                <i className="ri-checkbox-circle-line text-lg"></i>
                            </div>
                        )}
                        {!item.visualizado && (
                            <div className="flex items-center self-start gap-1 text-sm"
                                 title="Empresa ainda não visualizou sua candidatura.">
                                <span>Pendente</span>
                                <i className="ri-time-line text-lg"></i>
                            </div>
                        )}
                    </div>
                    <hr />
                    {/* Conteudo debaixo */}
                    <div className="flex flex-row p-2 text-sm justify-between items-center text">
                        <div className="flex flex-col w-1/2 pr-2">
                            <div>
                                <i className="ri-money-dollar-circle-line text-lg" />
                                <span> R$ {item.idVagaNavigation?.salario}</span>
                            </div>
                            <div>
                                <i className="ri-map-pin-line text-lg"></i>
                                <span> {item.idVagaNavigation?.idEnderecoNavigation?.localCompleto}</span>
                            </div>
                            <div>
                                <i className="ri-time-line text-lg"></i>
                                <span> Inscrito em {`${toDate(new Date(item.dataCriado!))} ${toHour(new Date(item.dataCriado!))}`}</span>
                            </div>
                        </div>
                        <div className="hover-gray-200 p-5">
                            <span className="ri-attachment-2 text-2xl flex justify-center"></span>
                            <span>Ver currículo</span>
                        </div>
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
        <div className="body w-full">
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden"></Sidebar>
            <main className="w-full flex flex-col">
                <h1 className="p-10 md:text-2xl text-xl flex justify-center">Histórico de Candidaturas</h1>
                <div className="lg:w-2/3 p-5 mx-auto md:text-base text-sm">
                    {renderCandidaturas()}
                </div>
                <Pagination
                    className="mt-auto my-5 flex flex-col items-center"
                    objectsPerPage={candidaturasPorPagina}
                    totalObjects={candidaturasAtuais.length}
                    paginate={paginate}
                />
            </main>
        </div>
    );
}

export default CHistoricoCandidaturas;