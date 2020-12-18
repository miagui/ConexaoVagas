/* eslint-disable eqeqeq */
import React from 'react';
import Logo from '../../assets/imgs/logo-dark.png'
import Imagem from '../../assets/imgs/image-13@1x.jpg'
import LogoSenai from '../../assets/imgs/logo-senai-principal.png';
import Hamburguer from '../../components/hamburguer';
import { Link, useHistory } from 'react-router-dom';
import { Jwt } from '../../services/auth';
import { TipoUsuario } from '../../utils/enums';
import { TOKEN_KEY } from '../../api/apisettings';
import './index.css'

function Home() {

    let history = useHistory();

    const logout = () => {
        localStorage.removeItem(TOKEN_KEY);
        history.push('/');
    }

    function renderNav() {

        if (Jwt() === undefined || Jwt() === null) {
            return (
                // Não use fonte maior que font-base, pq fica muito grande.
                // Porém, caso queira manipular o tamanho, vá na linha 83.
                <div className="flex justify-end text-white text-lg m-5 nav pr-8">
                    <Link to="/login" className="hover:text-gray-300">Login</Link>
                    <Link to="/cadastro" className="ml-8 hover:text-gray-300">Cadastro</Link>
                </div>
            )
        }

        if (Jwt().Role == TipoUsuario.ADMINISTRADOR) {
            return (
                <div className="flex justify-end text-white m-5 nav">
                    <Link to="/Administrador/dashboard"
                        className="hover:text-gray-300">Dashboard</Link>
                    <Link to="/Administrador/gerenciamento-candidatos"
                        className="ml-4">Gerenciar Candidatos</Link>
                    <Link to="/Administrador/gerenciamento-empresas"
                        className="ml-4">Gerenciar Empresas</Link>
                    <span className="ml-4 hover:text-gray-300 cursor-pointer"
                        onClick={() => logout()}>Logoff</span>
                </div>
            )
        }
        else if (Jwt().Role == TipoUsuario.EMPRESA) {
            return (
                <div className="flex justify-end text-white m-5 nav">
                    <Link to="/Empresa/dashboard"
                        className="hover:text-gray-300">Dashboard</Link>
                    <Link to="/Empresa/suas-vagas"
                        className="ml-4">Suas Vagas</Link>
                    <Link to="/Empresa/cadastrar-vagas"
                        className="ml-4">Cadastrar Vagas</Link>
                    <Link to="/Empresa/editar-perfil"
                        className="ml-4">Editar Perfil</Link>
                    <span className="ml-4 hover:text-gray-300 cursor-pointer"
                        onClick={() => logout()}>Logoff</span>
                </div>
            )
        }
        else if (Jwt().Role == TipoUsuario.CANDIDATO) {
            return (
                <div className="flex justify-end text-white m-5 nav">
                    <Link to="/vagas"
                        className="ml-4 hover:text-gray-300">Vagas</Link>
                    <Link to="/Candidato/historico-candidaturas"
                        className="ml-4 hover:text-gray-300">Histórico de Candidaturas</Link>
                    <Link to={`/candidato/detalhes/${Jwt().Jti}`}
                        className="ml-4 hover:text-gray-300">Meu Perfil</Link>
                    <span className="ml-4 hover:text-gray-300 cursor-pointer"
                        onClick={() => logout()}>Logoff</span>
                </div>
            )
        }
    }

    return (
        <div className="min-h-screen">

            <div className="mx-10 md:block hidden
                            sm:text-base text-sm">
                {renderNav()}
            </div>
            <Hamburguer className="md:hidden flex fixed" />


            <div className="flex flex-wrap m-auto md:pt-16">
                <div className="md:w-1/2 w-full h-full m-auto">
                    <img className="lg:w-2/3 m-auto" id="img" src={Logo} alt="Logo escrito (Conexão Vagas)" />
                    <div className="conexao-frase text-white text-center m-auto">
                        <p>Conectamos as melhores</p>
                        <p>vagas com os melhores</p>
                        <p>candidatos</p>
                    </div>
                </div>

                <div className="m-auto p-5">
                    <img src={Imagem} alt="Imagem com duas pessoas, uma sentada com um notebook e uma em pé com um livro na mão" className="imagem" />
                </div>
            </div>
            <div className="bottom-0 right-0 lg:absolute pr-24"><img className="w-32 float-right m-5" src={LogoSenai} alt="Logo vermelha do SENAI" /></div>
        </div>
    )
}

export default Home
