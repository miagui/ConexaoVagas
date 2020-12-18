/* eslint-disable eqeqeq */
import React, { useState } from 'react';
import { Link, useHistory } from 'react-router-dom';
import Logo from '../../assets/imgs/logo-dark.png';
import Input from '../../components/input'
import Senai from '../../assets/imgs/logo-senai-principal.png';
import { API_URL, TOKEN_KEY } from '../../api/apisettings';
import { parseJwt } from '../../services/auth';
import ButtonForm from '../../components/buttonForm';
import { StatusUsuario, TipoUsuario } from '../../utils/enums';
import { useAlert } from 'react-alert';
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';


function Login() {

    let history = useHistory();

    const [email, setEmail] = useState('');
    const [senha, setSenha] = useState('');

    const alert = useAlert();

    const login = () => {
        const login = {
            email: email,
            senha: senha
        }

        fetch(API_URL + 'Login', {
            method: 'POST',
            body: JSON.stringify(login),
            headers: {
                'content-type': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) alert.error("Senha ou Email incorretos")
                else return response.json()
            })
            .then(dados => {
                if (dados.token !== undefined) {
                    localStorage.setItem(TOKEN_KEY, dados.token)
                    let jwt = parseJwt(dados.token)
                    if (jwt.Role == TipoUsuario.ADMINISTRADOR) history.push('/Administrador/dashboard');
                    else if (jwt.StatusUsuario == StatusUsuario.BLOQUEADO) alert.error("Seu perfil foi bloqueado");
                    else if (jwt.Role == TipoUsuario.EMPRESA) history.push('/Empresa/dashboard');
                    else if (jwt.Role == TipoUsuario.CANDIDATO) history.push('/vagas');
                } else {
                    alert.error("Email existente")
                }
            })
            .catch(error => console.error(error))
    }

    return (
        <div className="w-full body">
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden" />
            <main className="flex">
                <div className="flex fundo flex-col justify-between items-center sm:flex hidden">
                    <img src={Senai} alt="" className="w-14 h-12 mt-4" />
                    <div className="">
                        <p className="escrito tracking-wider font-bold"><i> Sua conexão</i></p>
                        <p className="escrito tracking-wider font-bold"><i> com as empresas</i></p>
                        <p className="escrito tracking-wider font-bold"><i> começam agora.</i></p>
                    </div>
                    <img src={Logo} alt="" className="w-2/5" />
                </div>
                <div className="login flex w-full bg-white justify-center items-center">
                    <div className="login flex flex-col m-12">
                        <h1 className="font-bold text-4xl">Entre com sua conta</h1>
                        <form onSubmit={event => {
                            event.preventDefault()
                            login()
                        }}>
                            <div>
                                <Input mask="" type="text" name="Email" label="Insira seu email:" placeholder="email@email.com"
                                    className="input mt-8"
                                    onChange={e => setEmail(e.target.value)} value={email} />

                                <div className="flex justify-between">
                                    <Input mask="" type="password" name="Senha" label="Insira sua senha:" placeholder="*******"
                                        className="input flex-1 mt-5"
                                        onChange={e => setSenha(e.target.value)} value={senha} />
                                </div>
                            </div>

                            <div className="flex justify-between items-center md:justify-between items-center">
                                <div className="submit flex items-center">
                                    <ButtonForm className=" mt-6 mr-4" name="Login"></ButtonForm>
                                </div>

                                <p className="font-bold mt-8"> Não possui conta? <Link to="/cadastro" className="underline">Clique aqui</Link></p>
                            </div>
                        </form>
                        <img className="sm:hidden block w-32 right-0 bottom-0 absolute m-2" src={Senai} />
                    </div>

                </div>
            </main>
        </div>
    );
}

export default Login