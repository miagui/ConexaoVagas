/* eslint-disable eqeqeq */
import React, { useState } from 'react';
import Logo from '../../assets/imgs/logo-dark.png';
import Input from '../../components/input'
import Senai from '../../assets/imgs/logo-senai-principal.png';
import ButtonForm from '../../components/buttonForm';
import { Link, useHistory } from 'react-router-dom';
import { API_URL } from '../../api/apisettings';
import { useAlert } from 'react-alert';
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';

function CadastroEmpresa() {

    const alert = useAlert();

    var history = useHistory();

    const [email, setEmail] = useState('')
    const [senha, setSenha] = useState('')
    const [senhaConfirmacao, setSenhaConfirmacao] = useState('')

    const cadastro = () => {
        const cadastro = {
            email: email,
            senha: senha
        }

        fetch(API_URL + 'Cadastrar', {
            method: 'PUSH',
            body: JSON.stringify(cadastro),
            headers: {
                'content-type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(dados => {
                if (dados.email == API_URL) {
                    alert.success("Cadastrado com Sucesso.")
                } else {
                    alert.error("Email existente.")
                }
            })
            .catch(error => console.error(error))

    }

    const validarSenha = () => {
        if (senha == senhaConfirmacao && email != '') {
            return (
                history.push({
                    pathname: "/cadastro/empresa/passo-2",
                    state: { email: email, senha: senha }
                })
            )
        } else {
            return (
                alert.error("Senha ou Email inválido, por favor digite novamente.")
            )
        }
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
                    <img src={Logo} alt="" className="w-2/5 " />
                </div>
                <div className="login flex w-full bg-white justify-center items-center">

                    <div className="login flex flex-col m-12">
                        <h1 className="font-bold text-4xl">Crie seu perfil de empresa</h1>

                        <form onSubmit={event => {
                            event.preventDefault()
                            cadastro()
                            validarSenha()
                        }}>
                            <Input mask="" type="text" name="Email" label="Insira seu email:" placeholder="email@email.com" className="input mt-8"
                                onChange={e => setEmail(e.target.value)}
                                value={email} />

                            <div className="grid lg:grid-cols-2 grid-cols-1 mt-5 gap-5">
                                <Input mask="" type="password" name="Senha" label="Insira sua senha:" placeholder="*******"
                                    className="input col-span-1 w-full"
                                    onChange={e => setSenha(e.target.value)}
                                    value={senha} />
                                <Input mask="" type="password" name="Senha" label="Confirme sua senha:" placeholder="*******"
                                    className="input col-span-1 w-full"
                                    onChange={e => setSenhaConfirmacao(e.target.value)}
                                    value={senhaConfirmacao} />
                            </div>
                            <ButtonForm className="mt-6" name="cadastro" />

                        </form>
                        <img className="sm:hidden block w-32 right-0 bottom-0 absolute m-2" src={Senai} />
                    </div>
                </div>
            </main>
        </div>
    );
}

export default CadastroEmpresa