import React from 'react';
import { BrowserRouter, Redirect, Route, Switch } from 'react-router-dom';
import ADashboard from './pages/a-dashboard';
import AEmpresaGeral from './pages/empresa-resumo';
import AListaCandidato from './pages/a-gerenciamento-candidatos';
import VagasRecomendadas from './pages/vagas';
import ECadastrarVagas from './pages/e-cadastrar-vagas';
import ESuasVagas from './pages/e-suas-vagas';
import Home from './pages/home';
import Login from './pages/login';
import CHistoricoCandidaturas from './pages/c-historico-candidaturas';
import AGerenciarEmpresas from './pages/a-gerenciamento-empresas';
import EDashboard from './pages/e-dashboard';
import VerVaga from './pages/vaga';
import CadastroEmpresa from './pages/cadastro-empresa-passo1';
import CadastroCandidato from './pages/cadastro-candidato-passo1';
import CadastroDadosEmpresa from './pages/cadastro-empresa-passo2';
import CadastroDadosCandidato from './pages/cadastro-candidato-passo2';
import Cadastro from './pages/cadastro';
import EVisualizarVaga from './pages/e-vaga-candidaturas';
import EditarPerfilEmpresa from './pages/e-editar-perfil';
import EditarPerfilCandidato from './pages/c-editar-perfil';
import Erro from './pages/404';
import { Jwt } from './services/auth';
import { TipoUsuario } from './utils/enums';
import { AuthRoute } from './components/authRoute';

function Routers() {
    return (
        <BrowserRouter>
            {/* Switch é necessario para a página 404 não aparecer em todas páginas. */}
            <Switch>
                {/* Administrador */}
                <AuthRoute path="/Administrador/dashboard" exact
                    Component={ADashboard} requiredRole={TipoUsuario.ADMINISTRADOR} />
                <AuthRoute path="/Administrador/gerenciamento-candidatos" exact
                    Component={AListaCandidato} requiredRole={TipoUsuario.ADMINISTRADOR} />
                <AuthRoute path="/Administrador/gerenciamento-empresas" exact
                    Component={AGerenciarEmpresas} requiredRole={TipoUsuario.ADMINISTRADOR} />

                {/* Empresa */}
                <AuthRoute path="/Empresa/dashboard" exact
                    Component={EDashboard} requiredRole={TipoUsuario.EMPRESA} />
                <AuthRoute path="/Empresa/suas-vagas" exact
                    Component={ESuasVagas} requiredRole={TipoUsuario.EMPRESA} />
                <AuthRoute path="/Empresa/cadastrar-vagas" exact
                    Component={ECadastrarVagas} requiredRole={TipoUsuario.EMPRESA} />
                <AuthRoute path="/Empresa/editar-perfil" exact
                    Component={EditarPerfilEmpresa} requiredRole={TipoUsuario.EMPRESA} />
                <AuthRoute path="/Empresa/visualizar-vaga" exact
                    Component={EVisualizarVaga} requiredRole={TipoUsuario.EMPRESA} />

                {/* Candidato */}
                <AuthRoute path="/Candidato/editar-perfil" exact 
                    Component={EditarPerfilCandidato} requiredRole={TipoUsuario.CANDIDATO}/>
                <AuthRoute path="/Candidato/historico-candidaturas" exact 
                    Component={CHistoricoCandidaturas} requiredRole={TipoUsuario.CANDIDATO}/>

                {/* Páginas dinâmicas */}
                <Route path="/vaga/:id" exact component={VerVaga} />
                <Route path="/empresa/resumo/:id" exact component={AEmpresaGeral} />

                {/* Páginas genéricas */}
                <Route path="/" exact component={Home} />
                <Route path="/login" exact component={Login} />
                <Route path="/cadastro" exact component={Cadastro} />
                <Route path="/cadastro/empresa/passo-1" exact component={CadastroEmpresa} />
                <Route path="/cadastro/candidato/passo-1" exact component={CadastroCandidato} />
                <Route path="/cadastro/empresa/passo-2" exact component={CadastroDadosEmpresa} />
                <Route path="/cadastro/candidato/passo-2" exact component={CadastroDadosCandidato} />
                <Route path="/vagas" exact component={VagasRecomendadas} />
                <Route exact component={Erro} />
            </Switch>
        </BrowserRouter>
    )
}

export default Routers;