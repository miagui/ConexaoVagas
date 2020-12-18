/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import ButtonForm from '../../components/buttonForm';
import Input from '../../components/input';
import Senai from '../../assets/imgs/logo-senai-principal.png';
import Logo from '../../assets/imgs/logo-dark.png';
import Button from '../../components/button';
import EmpresaApi from '../../api/empresa';
import NotificacaoApi from '../../api/notificacoes';
import { Empresa } from '../../models/empresa';
import { Link, useHistory, useLocation } from 'react-router-dom';
import { useAlert } from 'react-alert';
import Hamburguer from '../../components/hamburguer';
import Sidebar from '../../components/sidebar/Index';

function CadastroDadosEmpresa() {

    const alert = useAlert();

    const [empresa, setEmpresa] = useState<Empresa>(new Empresa());

    const location = useLocation<any>();
    let history = useHistory();

    useEffect(() => {
        setEmpresa({ ...empresa, idUsuarioNavigation: { email: location.state.email, senha: location.state.senha } })
    }, []);

    function salvar() {
        if (empresa != undefined) {
            EmpresaApi.salvar(empresa, 0).then(data => {
                if (data != null || data != undefined) {
                    alert.success("Cadastrado com sucesso.")
                    history.push("/login")
                    NotificacaoApi.addNotificacao(`Empresa ${empresa.nomeFantasia} se cadastrou.`)
                }
            });
        } else {
            alert.error("Campos não preenchidos.")
        }
    }

    return (
        <div className="w-full body">
            <Hamburguer className="md:hidden flex fixed" />
            <Sidebar className="md:flex hidden" />
            <main className="flex">
                <div className="flex fundo flex-col justify-between items-center sm:flex hidden">
                    <img src={Senai} alt="" className="w-14 h-12 mt-4" />
                    <div>
                        <p className="escrito tracking-wider font-bold"><i> Sua conexão</i></p>
                        <p className="escrito tracking-wider font-bold"><i> com as empresas</i></p>
                        <p className="escrito tracking-wider font-bold"><i> começam agora.</i></p>
                    </div>
                    <img src={Logo} alt="" className="w-2/5 " />
                </div>
                <div className="login flex w-full bg-white justify-center items-center">
                    <div className="login flex flex-col m-12">
                        <h1 className="font-bold text-4xl">Preencha o formulário</h1>
    
                        <form onSubmit={event => {
                            event.preventDefault()
                            salvar()
                        }}>
                            <div className="flex flex-col justify-between mt-8">
                                <Input mask="" type="name" name="NomeFicticio" label="Nome ficticio:" placeholder="Olx"
                                    className="input" required
                                    onChange={e => setEmpresa({ ...empresa, nomeFantasia: e.target.value })}
                                    value={empresa?.nomeFantasia!}></Input>
    
                                <Input mask="" type="name" name="RazaoSocial" label="Razão social:" placeholder="bom negócio atividades de internet"
                                    className="input mt-2" required
                                    onChange={e => setEmpresa({ ...empresa, razaoSocial: e.target.value })}
                                    value={empresa.razaoSocial}></Input>
    
                                <div>
                                    <p className="font-bold mt-2">Descrição</p>
                                    <div className="rounded-md border-2 border-gray-400 w-64 hover:border-gray-500 w-full">
                                        <textarea className="bg-white focus:bg-gray-100 border-0 
                                                    focus:outline-none w-full py-2 px-2 
                                                    appearance-none"
                                            onChange={e => setEmpresa({ ...empresa, descricao: e.target.value })} required>
                                        </textarea>
                                    </div>
                                </div>
    
                                <div className="flex justify-between mt-2">
                                    <Input mask="99.999.999/9999-99" name="Cnpj" label="CNPJ:" placeholder="12.345.678/0009-12" className="input"
                                        onChange={e => setEmpresa({ ...empresa, cnpj: e.target.value })}
                                        value={empresa.cnpj}></Input>
    
                                    <Input mask="9999-9" name="CNAE" label="CNAE:" placeholder="2543-8" className="input ml-2"
                                        onChange={e => setEmpresa({ ...empresa, cnae: e.target.value })}
                                        value={empresa.cnae}></Input>
                                </div>
    
                                <div className="flex justify-between mt-2">
                                    <Input mask="99999-999" type="text" name="cep" label="CEP:" placeholder="Av. Paulista" 
                                        className="input flex-1" required
                                        onChange={e => setEmpresa({ ...empresa, idEnderecoNavigation: { cep: e.target.value } })}
                                        value={empresa.idEnderecoNavigation?.cep}></Input>
                                </div>
    
                                <div className="flex justify-between mt-2">
                                    <Input mask="(99) 99999-9999" type="tel" name="Telefone" label="Telefone:" placeholder="(11)22222-222" className="input" required
                                        onChange={e => setEmpresa({ ...empresa, telefoneEmpresa: e.target.value })}
                                        value={empresa.telefoneEmpresa}></Input>
    
                                    <Input mask="(99) 99999-9999" type="tel" name="Celular" label="Celular:" placeholder="(11)99999-9999" className="input ml-2" required
                                        onChange={e => setEmpresa({ ...empresa, celularEmpresa: e.target.value })}
                                        value={empresa.celularEmpresa}></Input>
                                </div>
    
                                <div className="flex mt-5 gap-5 justify-between">
                                    <ButtonForm name="Login"></ButtonForm>
                                    <Link to="/cadastro"><Button ghost>Voltar</Button></Link>
                                </div>
    
                            </div>
                        </form>
                        <img className="sm:hidden block w-32 right-0 bottom-0 absolute m-2" src={Senai}/>
                    </div>
                </div>
            </main>
        </div>
    )
}

export default CadastroDadosEmpresa