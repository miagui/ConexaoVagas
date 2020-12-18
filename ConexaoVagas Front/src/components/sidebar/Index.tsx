/* eslint-disable eqeqeq */
import React from 'react';
import Logo from '../../assets/imgs/logo-dark.png';
import LogoSenai from '../../assets/imgs/logo-senai-principal.png';
import { Link, useHistory } from 'react-router-dom';
import { TOKEN_KEY } from '../../api/apisettings';
import { Jwt } from '../../services/auth';
import { TipoUsuario } from '../../utils/enums';
import './index.css';
import '../../assets/styles/global.css';

function Sidebar(props: any) {
    let history = useHistory(); //Usando o método Histoy

    const logout = () => {
        localStorage.removeItem(TOKEN_KEY);
        history.push('/');
    }

    const menu = () => {
        const token = localStorage.getItem(TOKEN_KEY);

        if (token === undefined || token === null) {
            return (
                <div className="mt-12">
                    <Link to="/login"><div className="rela-block side-button login"></div></Link>
                    <Link to="/cadastro"><div className="rela-block side-button cadastro"></div></Link>
                </div>
            )
        } else {
            if (Jwt().Role == TipoUsuario.ADMINISTRADOR) {
                return (
                    <div className="mt-12">
                        <Link to="/Administrador/dashboard"><div className="rela-block side-button a-dashboard"></div></Link>
                        <Link to="/vagas"><div className="rela-block side-button vagas"></div></Link>
                        <Link to="/Administrador/gerenciamento-candidatos"><div className="rela-block side-button a-lista-candidato"></div></Link>
                        <Link to="/Administrador/gerenciamento-empresas"><div className="rela-block side-button a-gerenciamento-empresas"></div></Link>
                        <div className="rela-block side-button logout"
                            onClick={() => logout()}></div>
                    </div>
                )
            } else if (Jwt().Role == TipoUsuario.EMPRESA) {
                return (
                    <div className="mt-12">
                        <Link to="/Empresa/dashboard"><div className="rela-block side-button e-dashboard"></div></Link>
                        <Link to="/vagas"><div className="rela-block side-button vagas"></div></Link>
                        <Link to="/Empresa/suas-vagas"><div className="rela-block side-button e-suas-vagas"></div></Link>
                        <Link to="/Empresa/cadastrar-vagas"><div className="rela-block side-button e-cadastrar-vagas"></div></Link>
                        <Link to="/Empresa/editar-perfil"><div className="rela-block side-button e-editar-perfil"></div></Link>
                        <div className="rela-block side-button logout"
                            onClick={() => logout()}></div>
                    </div>
                );
            } else if (Jwt().Role == TipoUsuario.CANDIDATO) {
                return (
                    <div className="mt-12">
                        <Link to="/vagas"><div className="rela-block side-button vagas"></div></Link>
                        <Link to="/Candidato/historico-candidaturas"><div className="rela-block side-button c-historico-candidaturas"></div></Link>
                        <Link to="/Candidato/editar-perfil"><div className="rela-block side-button c-editar-perfil"></div></Link>
                        <div className="rela-block side-button logout"
                            onClick={() => logout()}></div>
                    </div>
                );
            }
        }
    }

    return (
        <div {...props} className={props.className}>

            <div style={{ width: "80px" }}></div>
            <div className="side-bar">
                <div className="side-container top">
                    <Link to="/"><img id="img" src={Logo} alt="Logo escrito (conexão Vagas)" /></Link>
                </div>
                <div className="side-container middle">
                    {menu()}
                    <div className="logoSenai">
                        <Link to="/"><img id="img" src={LogoSenai} alt="Logo vermelha do senai com escrito branco" /></Link>
                    </div>
                </div>
            </div>
        </div>
    );
}
export default Sidebar;
