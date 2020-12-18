/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Card from '../../components/card';
import EmpresaApi from '../../api/empresa'
import NotificacaoApi from '../../api/notificacoes'
import Sidebar from '../../components/sidebar/Index';
import Loader from '../../components/loader';
import Hamburguer from '../../components/hamburguer';
import Dialog from '../../components/dialog';
import Button from '../../components/button';
import ImgEmpresaDefault from '../../assets/imgs/default-empresa.png'
import Pagination from '../../components/pagination';
import { Empresa } from '../../models/empresa';
import { StatusUsuario } from '../../utils/enums';
import { Link } from 'react-router-dom';
import { useAlert } from 'react-alert';
import { toDate, toHour } from '../../services/date';
import { Jwt } from '../../services/auth';
import { API_URL } from '../../api/apisettings';
import LoadingPage from '../loading';

function AGerenciarEmpresas({ match }: any) {
    const {
        params: { id },
    } = match;

    const [empresasPendentes, setEmpresasPendentes] = useState<Empresa[]>([]);
    const [empresas, setEmpresas] = useState<Empresa[]>([]);
    const [empresa, setEmpresa] = useState<Empresa>(new Empresa());
    const [visualizarPerfil, setVisualizarPerfil] = useState(false);
    const [empresaConfirmacao, setEmpresaConfirmacao] = useState<Empresa>();
    const [aceitarIsOpen, setAceitarIsOpen] = useState(false);
    const [recusarIsOpen, setRecusarIsOpen] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [empresasPorPagina] = useState(10);
    const [isLoading, setIsLoading] = useState(true);

    const indexOfLastPost = currentPage * empresasPorPagina;
    const indexOfFirstPost = indexOfLastPost - empresasPorPagina;
    const empresasAtuais = empresas.slice(indexOfFirstPost, indexOfLastPost);

    const paginate = (pageNumber: any) => setCurrentPage(pageNumber);

    const alert = useAlert();

    useEffect(() => {
        Promise.all([
            EmpresaApi.buscarPorId(id).then(data => setEmpresa(data)),
            EmpresaApi.listarPorStatus(1).then(data => setEmpresasPendentes(data)),
            EmpresaApi.listarPorStatus(2).then(data => setEmpresas(data))
        ])
        .then(() => setIsLoading(false))
    }, []);

    function openPerfil(empresaP: Empresa) {
        setEmpresa(empresaP);
        setVisualizarPerfil(true);
    }

    function closePerfil() {
        setEmpresa({});
        setVisualizarPerfil(false);
    }

    function openAceitar(empresa: Empresa) {
        setEmpresaConfirmacao(empresa);
        setAceitarIsOpen(true);
    }

    function closeAceitar() {
        setEmpresaConfirmacao({});
        setAceitarIsOpen(false);
    }

    function openRecusar(empresa: Empresa) {
        setEmpresaConfirmacao(empresa);
        setRecusarIsOpen(true);
    }

    function closeRecusar() {
        setEmpresaConfirmacao({});
        setRecusarIsOpen(false);
    }

    function aceitarEmpresa() {
        alert.success(`Empresa ${empresaConfirmacao?.nomeFantasia} aceita com sucesso.`)
        EmpresaApi.mudarStatus(empresaConfirmacao?.idUsuario!, StatusUsuario.ATIVO);
        NotificacaoApi.addNotificacao(`Empresa ${empresaConfirmacao?.nomeFantasia} foi aceita.`);
        closeAceitar();
        EmpresaApi.listarPorStatus(StatusUsuario.PENDENTE).then(data => setEmpresasPendentes(data));
        EmpresaApi.listarPorStatus(StatusUsuario.ATIVO).then(data => setEmpresas(data));
    }

    function recusarEmpresa() {
        alert.success(`Empresa ${empresaConfirmacao?.nomeFantasia} recusada com sucesso.`)
        EmpresaApi.mudarStatus(empresaConfirmacao?.idUsuario!, StatusUsuario.BLOQUEADO);
        closeRecusar();
        NotificacaoApi.addNotificacao(`Empresa ${empresaConfirmacao?.nomeFantasia} foi recusada.`);
        EmpresaApi.listarPorStatus(StatusUsuario.PENDENTE).then(data => setEmpresasPendentes(data));
        EmpresaApi.listarPorStatus(StatusUsuario.ATIVO).then(data => setEmpresas(data));

    }


    function renderPendentes() {
        if (empresasPendentes.length === 0) return (
            <p className="text-center p-5">Há nenhuma empresa pendente.</p>
        )

        return empresasPendentes.map((item: Empresa) => {
            return (

                <Card className="flex flex-row justify-between items-center mb-5">
                    <div className="flex items-center">
                        <img className="w-16 h-16 object-contain"
                            src={`${API_URL}Empresa/Img/${item.idUsuario}`}
                            onError={e => e.currentTarget.src = ImgEmpresaDefault} alt="img empresa"></img>
                        <p className="pl-2">{item.nomeFantasia}</p>
                    </div>
                    <div>
                        <span className="fa fa-check text-green-600 text-2xl p-2 cursor-pointer"
                            onClick={() => openAceitar(item)}></span>
                        <span className="fa fa-times text-red-600 text-2xl p-2 cursor-pointer"
                            onClick={() => openRecusar(item)}></span>
                    </div>
                </Card>
            )
        })
    }

    function renderEmpresas() {

        return empresasAtuais.map((item: Empresa) => {
            return (
                <Card className="flex flex-col mb-5" key={item.idUsuario}>
                    {/* Conteudo encima */}
                    <div className="flex items-center">
                        <img className="w-16 h-16 object-contain"
                            src={`${API_URL}Empresa/Img/${item.idUsuario}`}
                            onError={e => e.currentTarget.src = ImgEmpresaDefault} alt="img empresa"></img>
                        <p className="pl-2">{item.nomeFantasia}</p>
                    </div>
                    <hr className="m-2" />
                    {/* Conteudo debaixo */}
                    <div className="flex flex-row p-2 text-sm justify-between items-center">
                        <div className="flex flex-col w-1/2 pr-2">
                            <div>
                                <i className="ri-building-2-line text-lg" />
                                <span> {item.razaoSocial}</span>
                            </div>
                            <div>
                                <i className="ri-map-pin-line text-lg"></i>
                                <span> {item.idEnderecoNavigation?.localCompleto}</span>
                            </div>
                            <div>
                                <i className="ri-time-line text-lg"></i>
                                <span> Cadastrado desde {`${toDate(new Date(item.idUsuarioNavigation?.dataCadastrado!))} ${toHour(new Date(item.idUsuarioNavigation?.dataCadastrado!))}`}</span>
                            </div>
                        </div>
                        {/* Icones */}
                        <div className="flex">
                            <Link to={`/empresa/resumo/${item.idUsuario}`}>
                                <div className="hover-gray-200 p-5">
                                    <span className="ri-contacts-book-line text-2xl flex justify-center cursor-pointer"></span>
                                    <span className="cursor-pointer">Vagas</span>
                                </div>
                            </Link>
                            <div className="hover-gray-200 p-5" onClick={() => openPerfil(item)}>
                                <span className="ri-file-text-line text-2xl flex justify-center cursor-pointer"></span>
                                <span className="cursor-pointer">Perfil</span>
                            </div>
                        </div>
                    </div>
                </Card>
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
            <Sidebar className="md:flex hidden" />
            <main className="w-full m-5 flex flex-col">
                <Dialog
                    isOpen={visualizarPerfil} onAfterClose={closePerfil}
                    title="Detalhes da empresa"
                >
                    <div className="flex flex-col w-full mt-6">
                        <div className="w-full flex flex-col w-50em w-full">
                            <div className="grid md:grid-cols-2 grid-cols-1">

                                {/* Coluna Esquerda */}
                                <div className="flex flex-col">
                                    <div className="mb-8">
                                        <p className="font-bold">Email</p>
                                        <p>{empresa?.idUsuarioNavigation?.email}</p>
                                    </div>

                                    <div className="mb-8">
                                        <p className="font-bold">Nome</p>
                                        <p>{empresa?.razaoSocial}</p>
                                    </div>

                                    <div className="mb-8">
                                        <p className="font-bold">Telefone</p>
                                        <p>{empresa?.telefoneEmpresa}</p>
                                    </div>

                                    <div className="mb-8">
                                        <p className="font-bold">Endereço</p>
                                        <p className="pr-8">{empresa?.idEnderecoNavigation?.localCompleto}</p>
                                    </div>
                                </div>

                                {/* Coluna Direita */}
                                <div className="flex flex-col">
                                    <div className="mb-8">
                                        <p className="font-bold">Razão Social</p>
                                        <p>{empresa?.razaoSocial}</p>
                                    </div>

                                    <div className="mb-8">
                                        <p className="font-bold">CNPJ</p>
                                        <p>{empresa?.cnpj}</p>
                                    </div>

                                    <div className="mb-8">
                                        <p className="font-bold">CNAE</p>
                                        <p>{empresa?.cnae}</p>
                                    </div>
                                </div>
                            </div>
                            {/* Conteudo debaixo */}
                            <div className="mb-8">
                                <p className="font-bold">Descrição</p>
                                <p style={{ width: '30em' }}>{empresa?.descricao}</p>
                            </div>
                        </div>

                        <div className="flex flex-col items-center justify-center pt-6">
                            <div className="pb-5 flex gap-2">
                                {empresa?.idStatusUsuario == StatusUsuario.ATIVO && (
                                    <Button onClick={() => {
                                        EmpresaApi.mudarStatus(empresa.idUsuario!, StatusUsuario.BLOQUEADO)
                                        alert.success("Usuário bloqueado.")

                                    }} name="Bloquear Perfil">Bloquear Perfil</Button>
                                )}

                                {empresa?.idStatusUsuario == StatusUsuario.BLOQUEADO && (
                                    <Button onClick={() => {
                                        EmpresaApi.mudarStatus(empresa.idUsuario!, StatusUsuario.ATIVO)
                                        alert.success("Usuário foi desbloqueado.")

                                    }} name="Bloquear Perfil">Desbloquear</Button>
                                )}
                            </div>
                            <Button onClick={closePerfil} ghost>Fechar</Button>
                        </div>
                    </div>
                </Dialog>

                <Dialog isOpen={aceitarIsOpen} onAfterClose={closeAceitar}
                    title="Confirmar ação">
                    <div>
                        <p>Você deseja <b>aceitar</b> a empresa <b>{empresaConfirmacao?.nomeFantasia}</b>?</p>
                        <div className="flex justify-center gap-2 mt-5">
                            <Button onClick={aceitarEmpresa}>Sim</Button>
                            <Button onClick={closeAceitar} ghost={true}>Cancelar</Button>
                        </div>
                    </div>
                </Dialog>

                <Dialog isOpen={recusarIsOpen} onAfterClose={closeRecusar}
                    title="Confirmar ação">
                    <div>
                        <p>Você deseja <b>recusar</b> a empresa <b>{empresaConfirmacao?.nomeFantasia}</b>?</p>
                        <div className="flex justify-center gap-2 mt-5">
                            <Button onClick={recusarEmpresa}>Sim</Button>
                            <Button onClick={closeRecusar} ghost={true}>Cancelar</Button>
                        </div>
                    </div>
                </Dialog>

                <h1 className="p-10 md:text-2xl text-xl flex justify-center">Gerenciamento de empresas</h1>
                <div className="flex flex-col m-auto lg:w-2/3 w-full">
                    {empresasPendentes.length > 0 &&
                        <form>
                            <h2 className="flex flex-row justify-center m-5 text-lg">Empresas Pendentes</h2>
                            <div className="flex flex-row justify-between text-base">
                                <p>Solicitação</p>
                                <div className="flex">
                                    <p className="pr-2">Aceitar</p>
                                    <p>Recusar</p>
                                </div>
                            </div>
                            {renderPendentes()}
                        </form>
                    }
                    <h2 className="flex flex-row justify-center p-10 text-lg">Empresas Cadastradas</h2>
                    {renderEmpresas()}
                    <Pagination
                        className="mt-auto my-5 flex flex-col items-center"
                        objectsPerPage={empresasPorPagina}
                        totalObjects={empresas.length}
                        paginate={paginate}
                    />
                </div>
            </main>
        </div>
    )
}

export default AGerenciarEmpresas;