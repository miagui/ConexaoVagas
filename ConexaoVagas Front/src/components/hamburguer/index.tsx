/* eslint-disable eqeqeq */
import React from 'react';
import Logo from '../../assets/imgs/logo-dark.png';
import LogoSenai from '../../assets/imgs/logo-senai-principal.png';
import { Link, useHistory } from 'react-router-dom';
import { TOKEN_KEY } from '../../api/apisettings';
import { Jwt } from '../../services/auth';
import { TipoUsuario } from '../../utils/enums';
import './style.css';

function Hamburguer(props: any) {

    let history = useHistory();

    const logout = () => {
        localStorage.removeItem(TOKEN_KEY);
        history.push('/');
    }

    const menu = () => {

        if (Jwt() === undefined || Jwt() === null) {
            return (
                <div className="flex flex-col text-white m-5 nav-mobile">
                    <Link to="/login"
                        className="hover:text-gray-300">Login
                            <i className="ri-login-circle-line" />
                    </Link>
                    <Link to="/cadastro"
                        className="hover:text-gray-300">Cadastro
                            <i className="ri-user-add-line" />
                    </Link>
                </div>
            )
        } else {
            if (Jwt().Role == TipoUsuario.ADMINISTRADOR) {
                return (
                    <div className="flex flex-col text-white m-5 nav-mobile">
                        <Link to="/Administrador/dashboard"
                            className="hover:text-gray-300">Dashboard
                            <i className="ri-dashboard-fill" />
                        </Link>
                        <Link to="/Administrador/gerenciamento-candidatos"
                            className="hover:text-gray-300">Gerenciar Candidatos
                            <i className="ri-article-line" />
                        </Link>
                        <Link to="/Administrador/gerenciamento-empresas"
                            className="hover:text-gray-300">Gerenciar Empresas
                            <i className="ri-building-4-line" />
                        </Link>
                        <span className=" hover:text-gray-300 cursor-pointer"
                            onClick={() => logout()}>Logoff
                            <i className="ri-logout-circle-line" />
                        </span>
                    </div>
                )
            }
            else if (Jwt().Role == TipoUsuario.EMPRESA) {
                return (
                    <div className="flex flex-col text-white m-5 nav-mobile">
                        <Link to="/Empresa/dashboard"
                            className="hover:text-gray-300">Dashboard
                            <i className="ri-dashboard-fill" />
                        </Link>
                        <Link to="/Empresa/suas-vagas"
                            className="hover:text-gray-300">Suas Vagas
                            <i className=" ri-profile-line" />
                        </Link>
                        <Link to="/Empresa/cadastrar-vagas"
                            className="hover:text-gray-300">Cadastrar Vagas
                            <i className="ri-add-circle-line" />
                        </Link>
                        <Link to="/Empresa/editar-perfil"
                            className="">Editar Perfil
                            <i className="ri-building-4-line" />
                        </Link>
                        <span className="hover:text-gray-300 cursor-pointer"
                            onClick={() => logout()}>Logoff
                            <i className="ri-logout-circle-line" />
                        </span>
                    </div>
                )
            }
            else if (Jwt().Role == TipoUsuario.CANDIDATO) {
                return (
                    <div className="flex flex-col text-white m-5 nav-mobile">
                        <Link to="/vagas"
                            className="hover:text-gray-300">Vagas
                            <i className=" ri-profile-line" />
                        </Link>
                        <Link to="/Candidato/historico-candidaturas"
                            className="hover:text-gray-300">Histórico de Candidaturas
                            <i className="ri-history-line" />
                        </Link>
                        <Link to={"/Candidato/editar-perfil"} 
                              className="hover:text-gray-300">Meu Perfil
                              <i className="ri-user-line"/>
                        </Link>
                        <span className="hover:text-gray-300 cursor-pointer"
                            onClick={() => logout()}>Logoff
                            <i className="ri-logout-circle-line" />
                        </span>
                    </div>
                )
            }
        }
    }

    return (
        <div className={props.className}>
            <input type="checkbox" id="toggle" className="hidden"></input>

            <label htmlFor="toggle"
                className="bg-secondary-color rounded-full w-12 h-12 m-3 
                        shadow shadow-lg flex justify-center items-center cursor-pointer ">
                <div>
                    <i className="barra fa fa-bars text-white text-2xl"></i>
                </div>
            </label>

            <div className="h-screen w-screen fixed z-50 
                            bg-secondary-color hamburguer-menu p-3">
                <div className="flex items-center">
                    <label className="ri-close-line text-white text-3xl relative cursor-pointer" htmlFor="toggle"></label>
                    <Link to="/">
                        <img className="h-16 force-center" src={Logo} alt="logo"></img>
                    </Link>
                </div>
                {menu()}
                <div>
                    <img className="w-32 absolute bottom-0 inset-x-0 m-auto pb-16" src={LogoSenai} alt="logo senai"></img>
                </div>

            </div>

        </div>
    )
}

export default Hamburguer;