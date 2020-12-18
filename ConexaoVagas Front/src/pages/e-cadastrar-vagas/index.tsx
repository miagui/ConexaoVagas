/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Button from '../../components/button';
import Input from '../../components/input';
import VagaApi from '../../api/vagas'
import EmpresaApi from '../../api/empresa';
import HabilidadeApi from '../../api/habilidades';
import BeneficioApi from '../../api/beneficios';
import NotificacaoApi from '../../api/notificacoes'
import ButtonForm from '../../components/buttonForm';
import Select from '../../components/select';
import Sidebar from '../../components/sidebar/Index';
import Hamburguer from '../../components/hamburguer';
import { BeneficioVaga } from '../../models/beneficioVaga';
import { HabilidadeVaga } from '../../models/habilidadeVaga';
import { Empresa } from '../../models/empresa';
import { Beneficio } from '../../models/beneficio';
import { Habilidade } from '../../models/habilidade';
import { Vaga } from '../../models/vaga';
import { Jwt } from '../../services/auth';
import { useAlert } from 'react-alert';
import { useHistory } from 'react-router-dom';
import { StatusUsuario } from '../../utils/enums';
import LoadingPage from '../loading';

function ECadastrarVagas() {

    const [empresa, setEmpresa] = useState<Empresa>();
    const [vagaForm, setVagaForm] = useState<Vaga>(new Vaga());
    const [beneficios, setBeneficios] = useState<Beneficio[]>([]);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [idBeneficio, setIdBeneficio] = useState<number>(0);
    const [idHabilidade, setIdHabilidade] = useState<number>(0);
    const [isLoading, setIsLoading] = useState(true);

    const alert = useAlert();
    const history = useHistory();

    useEffect(() => {
        Promise.all([
            EmpresaApi.buscarPorId(Jwt().jti).then(data => setEmpresa(data)),
            HabilidadeApi.listar().then(data => setHabilidades(data)),
            BeneficioApi.listar().then(data => setBeneficios(data))
        ])
        .then(() => setIsLoading(false))
        
    }, []);

    function salvar() {
        // Deixa indefinido para não enviar no body da requisição.
        var vagaJson = {
            ...vagaForm,
            idEmpresaNavigation: undefined,
            idEmpresa: empresa?.idUsuario,
            dataCriado: new Date().toDateString()
        }

        if (empresa!.idStatusUsuario == StatusUsuario.BLOQUEADO) {
            alert.error("Você não tem permissão para isso");
            return;
        }

        if (vagaJson != undefined) {
            VagaApi.salvar(vagaJson, 0).then(data => {
                if (data != null || data != undefined) {
                    NotificacaoApi.addNotificacao(`Empresa ${empresa?.nomeFantasia} cadastrou a vaga ${vagaForm.titulo}.`)
                    alert.success("Cadastrado com sucesso.", {
                        // Manda para página "Suas vagas" quando o alerta desaparecer.
                        onClose: () => history.push("/Empresa/suas-vagas")
                    });
                }
            });
        } else {
            alert.error('Campos não preenchidos.')
        }
    }

    function addBeneficio(id: number) {
        var beneficiosAdd: BeneficioVaga[] = vagaForm.beneficioVaga!;
        BeneficioApi.buscarPorId(id).then(data => {
            beneficiosAdd.push({ idBeneficio: id })
            setVagaForm({ ...vagaForm, beneficioVaga: beneficiosAdd })

        })
    }

    function removeBeneficio(id: number) {
        var beneficios: BeneficioVaga[] = vagaForm.beneficioVaga!;
        var beneficiosDel = beneficios.filter(b => b.idBeneficio !== id)
        setVagaForm({ ...vagaForm, beneficioVaga: beneficiosDel })
    }

    function addHabilidade(id: number) {
        var habilidadesAdd: HabilidadeVaga[] = vagaForm.habilidadeVaga!;
        HabilidadeApi.buscarPorId(id).then(data => {
            habilidadesAdd.push({ idHabilidade: id })
            setVagaForm({ ...vagaForm, habilidadeVaga: habilidadesAdd })
        })
    }

    function removeHabilidade(id: number) {
        var habilidades: HabilidadeVaga[] = vagaForm.habilidadeVaga!;
        var habilidadesDel = habilidades.filter(h => h.idHabilidade !== id)
        setVagaForm({ ...vagaForm, habilidadeVaga: habilidadesDel })
    }

    function renderHabilidades() {
        if (vagaForm.habilidadeVaga?.length == 0) return (
            <div></div>
        )

        return vagaForm.habilidadeVaga?.map((item: HabilidadeVaga) => {
            return (
                <span className="bg-gray-400 p-2 rounded-full m-1 h-8 flex items-center cursor-pointer"
                    onClick={() => removeHabilidade(item.idHabilidade!)}>
                    {habilidades?.find(h => h.idHabilidade == item.idHabilidade)?.nomeHabilidade}
                </span>
            )
        })
    }

    function renderBeneficios() {
        if (vagaForm.beneficioVaga?.length == 0) return (
            <div></div>
        )

        return vagaForm.beneficioVaga?.map((item: BeneficioVaga) => {
            return (
                <span className="bg-gray-400 p-2 rounded-full m-1 h-8 flex items-center cursor-pointer"
                    onClick={() => removeBeneficio(item.idBeneficio!)}>
                    {beneficios?.filter(b => b.idBeneficio == item.idBeneficio)[0].nomeBeneficio}
                </span>
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
            <main className="w-full m-5">
                <h1 className="p-10 md:text-2xl text-xl flex justify-center">Cadastrar Vaga</h1>

                <form className="w-1/2 rounded-md lg:w-1/2 m-auto w-full"
                    onSubmit={event => {
                        event.preventDefault();
                        salvar();
                    }}>

                    <p className="font-bold mb-3">Dados da vaga de emprego</p>
                    <div className="flex">
                        <Input mask="" className="flex-1" placeholder='Nome do Título' name="título" label="Titulo"
                            onChange={e => setVagaForm({ ...vagaForm, titulo: e.target.value })} required
                            value={vagaForm.titulo}></Input>
                        <Input mask="9999.99" className="w-32 ml-4" placeholder='1000,00' name="salário" label="Salário"
                            onChange={e => setVagaForm({ ...vagaForm, salario: parseInt(e.target.value) })} required
                            value={vagaForm.salario || ""}></Input>
                    </div>
                    <p className="font-bold mt-3">Descrição</p>

                    <div className="rounded-md border-2 border-gray-400 w-64 hover:border-gray-500 w-full">
                        <textarea className="bg-white focus:bg-gray-100 border-0 
                                            focus:outline-none w-full py-2 px-2 
                                            appearance-none"
                            onChange={e => setVagaForm({ ...vagaForm, descricao: e.target.value })} required
                            value={vagaForm.descricao}>
                        </textarea>
                    </div>
                    <div className="flex mt-1">
                        <Input mask="99999-999" className="flex-1 mt-3" placeholder='00001001' name="cep"
                            label="Cep"
                            onChange={e => setVagaForm({ ...vagaForm, idEnderecoNavigation: { cep: e.target.value } })} required
                            value={vagaForm.idEnderecoNavigation?.cep}></Input>
                        <Input mask="99/99/9999" className="flex-1 ml-4 mt-3" name="cep" label="Data de expiração"
                            type=""
                            onChange={e => setVagaForm({ ...vagaForm, dataExpiracao: e.target.value })} required
                            value={vagaForm.dataExpiracao}></Input>
                    </div>
                    <div className="flex mt-1 mb-1">
                        <Input mask="" className="flex-1 mt-3" placeholder='Programador Jr' name="Qualificação" label="Qualificação"
                            onChange={e => setVagaForm({ ...vagaForm, qualificacao: e.target.value })} required
                            value={vagaForm.qualificacao}></Input>
                        <Input mask="99" className="w-32 ml-4 mt-3" placeholder='6 Horas' name="Carga Horária" label="Carga Horária"
                            onChange={e => setVagaForm({ ...vagaForm, cargaHoraria: parseInt(e.target.value) })} required
                            value={vagaForm.cargaHoraria}></Input>
                    </div>

                    {/* Input Beneficio */}
                    <div className="flex items-end">
                        <Select className="w-full" label="Beneficios" name="beneficio"
                            onChange={e => setIdBeneficio(parseInt(e.target.value))}
                            value={idBeneficio} required>
                            <option value="0" selected>Selecione uma opção</option>
                            {beneficios?.map((h: Beneficio) => {
                                return (
                                    <option value={h.idBeneficio}>{h.nomeBeneficio}</option>
                                )
                            })}
                        </Select>
                        <Button className="ri-add-line ml-2" ghost={true}
                            disabled={idBeneficio == 0}
                            onClick={() => addBeneficio(idBeneficio)}></Button>
                    </div>
                    <div className="flex flex-row flex-wrap m-2">
                        {renderBeneficios()}
                    </div>

                    {/* Input Habilidade */}
                    <div className="flex items-end">
                        <Select className="w-full" label="Habilidades" name="habilidade"
                            onChange={e => setIdHabilidade(parseInt(e.target.value))}
                            value={idHabilidade} required>
                            <option value="0" selected>Selecione uma opção</option>
                            {habilidades?.map((h: Habilidade) => {
                                return (
                                    <option value={h.idHabilidade}>{h.nomeHabilidade}</option>
                                )
                            })}
                        </Select>
                        <Button className="ri-add-line ml-2" ghost={true}
                            disabled={idHabilidade == 0}
                            onClick={() => addHabilidade(idHabilidade)}></Button>
                    </div>
                    <div className="flex flex-row flex-wrap m-2">
                        {renderHabilidades()}
                    </div>

                    <div>
                        <div className="flex justify-center mt-4">
                            <ButtonForm className="" value="Concluir"></ButtonForm>
                        </div>
                    </div>
                </form>
            </main>
        </div>

    )
}

export default ECadastrarVagas