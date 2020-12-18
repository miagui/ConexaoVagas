/* eslint-disable eqeqeq */
import React, { useState } from 'react';
import { Link, useHistory } from 'react-router-dom';
import ButtonForm from '../../components/buttonForm';
import Senai from '../../assets/imgs/logo-senai-principal.png';
import Logo from '../../assets/imgs/logo-dark.png';
import Button from '../../components/button';
import './index.css';
import Hamburguer from '../../components/hamburguer';
import Sidebar from '../../components/sidebar/Index';

function Cadastro() {

    const [pagina, setPagina] = useState('');

    let history = useHistory();

    function mudarPagina() {

        if (pagina == 'false') {
            history.push('/cadastro/empresa/passo-1')

        } else {
            history.push('/cadastro/candidato/passo-1')
        }
    }

    return (
        <div className="w-full flex body">
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
                        <h1 className="font-bold text-4xl">Crie sua conta</h1>
                        <p className="mt-4 font-bold text-2x1">Nesse perfil você procura...</p>

                        <div className="flex flex-col justify-between mt-8">
                            <div className="flex justify-center">

                                <input type="radio" name="tipo" id="empresa" className="escolha hidden"
                                    onChange={() => setPagina("false")} />
                                <label htmlFor="empresa" className="escolha w-40 flex justify-center items-center cursor-pointer" >Criar vagas</label>

                                <input type="radio" name="tipo" id="candidato" className="escolha hidden"
                                    onChange={() => setPagina("true")} />

                                <label htmlFor="candidato"
                                    className="escolha m-0 w-40 p-2 pl-8 leading-5 cursor-pointer ml-2">Arrumar um emprego</label>

                            </div>
                            <div className="flex justify-center gap-5 mt-8">

                                <ButtonForm name="Login" onClick={() => mudarPagina()} />
                                <Link to="/"><Button ghost>Voltar</Button></Link>
                            </div>


                            <img className="sm:hidden block w-32 right-0 bottom-0 absolute m-2" src={Senai} />


                        </div>

                    </div>

                </div>
            </main>
        </div>

    )
}

export default Cadastro