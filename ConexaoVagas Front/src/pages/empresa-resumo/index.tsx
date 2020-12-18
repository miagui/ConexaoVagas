/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Sidebar from '../../components/sidebar/Index';
import Card from '../../components/card/index';
import Button from '../../components/button/index';
import VagaApi from '../../api/vagas';
import EmpresaApi from '../../api/empresa';
import HabilidadeApi from '../../api/habilidades';
import Hamburguer from '../../components/hamburguer';
import ImgEmpresaDefault from '../../assets/imgs/default-empresa.png';
import Loader from '../../components/loader';
import Pagination from '../../components/pagination';
import { Vaga } from '../../models/vaga';
import { Empresa } from '../../models/empresa';
import { HabilidadeVaga } from '../../models/habilidadeVaga';
import { Link } from 'react-router-dom';
import { toDate, toHour } from '../../services/date';
import { Habilidade } from '../../models/habilidade';
import { API_URL } from '../../api/apisettings';
import LoadingPage from '../loading';
import Erro from '../404';

function AEmpresaGeral({ match }: any) {

    const {
        params: { id },
    } = match;

    const [vagas, setVagas] = useState<Vaga[]>([]);
    const [empresa, setEmpresa] = useState<Empresa>(new Empresa());
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [currentPage, setCurrentPage] = useState(1);
    const [vagasPorPagina] = useState(5);
    const [isLoading, setIsLoading] = useState(true);

    const indexOfLastPost = currentPage * vagasPorPagina;
    const indexOfFirstPost = indexOfLastPost - vagasPorPagina;
    const vagasAtuais = vagas.slice(indexOfFirstPost, indexOfLastPost);

    const paginate = (pageNumber: any) => setCurrentPage(pageNumber);


    useEffect(() => {
        Promise.all([
            VagaApi.listarPorEmpresa(id).then(data => setVagas(data)),
            HabilidadeApi.listar().then(data => setHabilidades(data)),
            EmpresaApi.buscarPorId(id).then(data => {
                setEmpresa(data)
                if (data) {
                    EmpresaApi.somaVisualizacao(data.idUsuario!);
                }
            })
        ])
            .then(() => setIsLoading(false));

    }, []);

    function renderVagas() {

        return vagasAtuais.map((item: Vaga) => {
            return (
                <Link to={`/vaga/${item.idVaga}`}>
                    <Card className="flex flex-col mb-5 hover-gray-100" key={item.idVaga}>
                        {/* Conteudo encima */}
                        <div className="flex flex-row p-2">
                            <p className="flex items-center">{item.titulo}</p>
                        </div>
                        <hr />
                        {/* Conteudo debaixo */}
                        <div className="flex flex-row pb-2 text-sm">
                            <div className="flex flex-col w-1/2 pr-2">
                                <div>
                                    <i className="ri-money-dollar-circle-line text-lg" />
                                    <span> R$ {item.salario}</span>
                                </div>
                                <div>
                                    <i className="ri-map-pin-line text-lg"></i>
                                    <span> {item.idEnderecoNavigation?.localCompleto}</span>
                                </div>
                                <div>
                                    <i className="ri-time-line text-lg"></i>
                                    <span> Expira em {`${toDate(new Date(item.dataExpiracao!))} ${toHour(new Date(item.dataExpiracao!))}`}</span>
                                </div>
                            </div>
                            <div className="w-1/2 flex flex-row flex-wrap">
                                {item.habilidadeVaga?.map((hv: HabilidadeVaga) => {
                                    return (
                                        <span className="bg-gray-400 p-2 rounded-full m-1 h-8 flex items-center">
                                            {habilidades.find((h: Habilidade) =>
                                                h.idHabilidade == hv.idHabilidade)?.nomeHabilidade}
                                        </span>
                                    )
                                })}
                            </div>
                        </div>
                    </Card>
                </Link>
            )
        })
    }

    if (!isLoading && empresa == undefined) {
        return (
            <Erro />
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
            <Sidebar className="md:flex hidden"></Sidebar>
            <main className="w-full flex flex-col">
                <div className="p-5 bg-cv-gray">
                    <div className="flex justify-center lg:w-2/3 w-full mx-auto">
                        <div className="pr-12">
                            <img className="w-56 h-56 object-contain"
                                src={`${API_URL}Empresa/Img/${empresa.idUsuario}`}
                                onError={e => e.currentTarget.src = ImgEmpresaDefault}>
                            </img>
                        </div>
                        <div>
                            <h2 className="text-4xl">{empresa?.nomeFantasia}</h2>
                            <p className="text-2xl">Cadastrada desde {`${toDate(new Date(empresa?.idUsuarioNavigation?.dataCadastrado!))}`}</p>
                            <p id="descricaoVaga" className="pb-6"></p>
                            <i className="ri-mail-line"><span>Email de contato</span></i>
                            <div className="pb-3">{empresa?.idUsuarioNavigation?.email}</div>
                            <div className="flex flex-row">
                                <div>
                                    <i className="ri-phone-fill"><span>Telefone</span></i>
                                    <div>{empresa?.telefoneEmpresa}</div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <h1 className="text-2xl text-center mt-10 mb-5">Vagas disponíveis</h1>
                <div className="lg:w-2/3 mx-auto p-5">
                    {renderVagas()}
                </div>
                <Pagination
                    className="mt-auto my-5 flex flex-col items-center"
                    objectsPerPage={vagasPorPagina}
                    totalObjects={vagas.length}
                    paginate={paginate}
                />
                {/* <div className="flex justify-center pb-10">
                    <Link to="/Administrador/gerenciamento-empresas">
                        <Button>
                            <p>Voltar</p>
                        </Button>
                    </Link>

                </div> */}
            </main>
        </div>
    )
}

export default AEmpresaGeral;