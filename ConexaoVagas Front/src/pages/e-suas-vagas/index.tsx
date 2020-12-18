/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import VagaApi from '../../api/vagas'
import Card from '../../components/card';
import Loader from '../../components/loader';
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';
import { Vaga } from '../../models/vaga';
import { Link } from 'react-router-dom';
import { Jwt } from '../../services/auth';
import { toDate } from '../../services/date';
import Pagination from '../../components/pagination';
import LoadingPage from '../loading';

function ESuasVagas() {

    const [vagas, setVagas] = useState<Vaga[]>([]);

    const [currentPage, setCurrentPage] = useState(1);
    const [vagasPorPagina] = useState(6);
    const [isLoading, setIsLoading] = useState(true);

    // Get current posts
    const indexOfLastPost = currentPage * vagasPorPagina;
    const indexOfFirstPost = indexOfLastPost - vagasPorPagina;
    const vagasAtuais = vagas.slice(indexOfFirstPost, indexOfLastPost);

    const paginate = (pageNumber: any) => setCurrentPage(pageNumber);

    useEffect(() => {
        Promise.all([
            VagaApi.listarPorEmpresa(Jwt().jti).then(data => setVagas(data))
        ])
        .then(() => setIsLoading(false));

    }, []);

    function renderVagas() {

        return vagasAtuais.map((item: Vaga) => {
            return (
                <Link className="cursor-pointer" to={{
                    pathname: "/Empresa/visualizar-vaga",
                    state: item
                }}>
                    <Card className="flex flex-col h-full hover-gray-100" key={item.idVaga}>
                        <div className="flex flex-row  items-center pb-2">
                            <div className="bg-transparent border-2 border-primary-color h-12 w-12 rounded-full ">
                                <p className="text-center pt-3 m-auto text-primary-color font-bold">{item.candidatura?.length}</p>
                            </div>
                            <h2 className="text-primary-color pl-2 font-bold">Candidatos</h2>
                        </div>
                        <hr></hr>
                        <div className="pt-2 pb-1">
                            <h2 className=''>{item.titulo}</h2>
                        </div>
                        <div className="text-sm">
                            <p><i className="ri-map-pin-line text-lg"></i>{item.idEnderecoNavigation?.localCompleto}</p>
                            <p><i className="ri-money-dollar-circle-line text-lg"></i> R${item.salario}</p>
                            <p><i className="ri-time-line text-lg"></i> Criado em: {`${toDate(new Date(item.dataCriado!))}`}</p>
                            <p><i className="ri-user-line text-lg"></i> {item.visualizacao} visualizações</p>
                        </div>
                    </Card>
                </Link>
            )
        })
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
            <main className='w-full m-5 flex flex-col'>
                <div className="lg:w-2/3 w-full mx-auto">
                    <h1 className="p-10 md:text-2xl text-xl flex justify-center">Suas Vagas</h1>
                    {vagas.length == 0 &&
                        <div className="text-center">
                            <h2 className="text-left inline-block">Parece que você ainda não anunciou nenhuma vaga.
                            <Link to="cadastrar-vagas"
                                    // &nbsp; serve para adicionar uma letra vazia.
                                    className="text-primary-color font-bold">&nbsp;Crie uma agora.
                            </Link></h2>
                        </div>}
                    <div className="grid lg:grid-cols-3 md:grid-cols-2 grid-cols-1 gap-4">
                        {renderVagas()}
                    </div>
                </div>
                <Pagination
                    className="mt-auto my-5 flex flex-col items-center"
                    objectsPerPage={vagasPorPagina}
                    totalObjects={vagas.length}
                    paginate={paginate}
                />
            </main>
        </div>
    )
}

export default ESuasVagas