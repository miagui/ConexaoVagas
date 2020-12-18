/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import Button from '../../components/button/index';
import CandidatoApi from '../../api/candidatos'
import Sidebar from '../../components/sidebar/Index';
import Input from '../../components/input';
import Hamburguer from '../../components/hamburguer';
import ButtonForm from '../../components/buttonForm';
import Select from '../../components/select';
import HabilidadeApi from '../../api/habilidades';
import ImgCandidatoDefault from '../../assets/imgs/default-candidato.png';
import { Candidato } from '../../models/candidato';
import { Jwt } from '../../services/auth';
import { API_URL } from '../../api/apisettings';
import { useAlert } from 'react-alert';
import { HabilidadeCandidato } from '../../models/habilidadeCandidato';
import { Habilidade } from '../../models/habilidade';
import { toDate } from '../../services/date';
import '../e-editar-perfil/index';
import LoadingPage from '../loading';

function EditarPerfilCandidato() {

    const [candidatoForm, setCandidatoForm] = useState<Candidato>(new Candidato());
    const [candidato, setCandidato] = useState<Candidato>(new Candidato());
    const [imgBuffer, setImgBuffer] = useState<Blob>();
    const [imgUrl, setImgUrl] = useState("")
    const [editando, setEditando] = useState(false);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [idHabilidade, setIdHabilidade] = useState<number>(0);
    const [isLoading, setIsLoading] = useState(true);
    var perfilEditado = false;

    const alert = useAlert();

    useEffect(() => {
        Promise.all([
            HabilidadeApi.listar().then(data => setHabilidades(data)),
            CandidatoApi.buscarPorId(Jwt().jti).then(data => {
                setCandidatoForm({
                    ...candidatoForm, habilidadeCandidato: data.habilidadeCandidato?.map(hc => {
                        return Object.assign({}, hc, {
                            idHabilidadeCandidato: undefined
                        })
                    })
                });
                setCandidato(data)
                // A URL da foto da Candidato.
                setImgUrl(`${API_URL}Candidato/Img/${data.idUsuario}`);
            })
        ])
        .then(() => setIsLoading(false))

    }, []);

    useEffect(() => {
        // Verifica se o usuário já adicionou uma foto..
        if (imgBuffer != undefined || imgBuffer != null)
            setImgUrl(URL.createObjectURL(imgBuffer));
    }, [imgBuffer]);


    useEffect(() => {
        perfilEditado = true;
    }, [candidatoForm]);

    function salvar() {
        if (candidatoForm != undefined && perfilEditado == true) {
            CandidatoApi.salvar(candidatoForm, Jwt().jti).then(data => {
                if (data != null || data != undefined) {
                    alert.success("Dados atualizados com sucesso.")
                    setCandidatoForm(new Candidato());
                    CandidatoApi.buscarPorId(Jwt().jti).then(e => setCandidato(e))
                }
                else alert.error("Não foi possível atualizar suas informações.")
            });
        }
        if (imgBuffer != null)
            CandidatoApi.uploadFoto(candidato.idUsuario!, imgBuffer).then(data => {
                if (data != undefined) alert.success("Atualizado foto com sucesso.")
                else alert.error("Não foi possível atualizar a foto.")
            })
    }

    function addHabilidade(id: number) {
        var habilidadesAdd: HabilidadeCandidato[] = candidatoForm.habilidadeCandidato!;
        HabilidadeApi.buscarPorId(id).then(data => {
            habilidadesAdd.push({ idHabilidade: id })
            setCandidatoForm({ ...candidatoForm, habilidadeCandidato: habilidadesAdd })
        })
    }

    function removeHabilidade(id: number) {
        var habilidades: HabilidadeCandidato[] = candidatoForm.habilidadeCandidato!;
        var habilidadesDel = habilidades.filter(h => h.idHabilidade !== id)
        setCandidatoForm({ ...candidatoForm, habilidadeCandidato: habilidadesDel })
    }

    function renderHabilidades() {
        if (candidatoForm.habilidadeCandidato?.length == 0) return (
            <div></div>
        )

        return candidatoForm.habilidadeCandidato?.map((item: HabilidadeCandidato) => {
            return (
                <span className="bg-gray-400 p-2 rounded-full m-1 h-8 flex items-center cursor-pointer"
                    onClick={() => removeHabilidade(item.idHabilidade!)}>
                    {habilidades?.find(h => h.idHabilidade == item.idHabilidade)?.nomeHabilidade}
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
            <Sidebar className="md:flex hidden" />
            <main className="w-full p-5">
                <h1 className="p-10 md:text-2xl text-xl flex justify-center">Detalhes do candidato</h1>
                <form className="m-auto lg:w-1/2 w-full"
                    onSubmit={event => {
                        event.preventDefault();
                        salvar();
                        event.currentTarget.reset();
                    }}>
                    <div className="mb-5 text-center">
                        <img className="w-32 h-32 object-contain mx-auto rounded-full"
                            onError={e => e.currentTarget.src = ImgCandidatoDefault}
                            src={imgUrl} alt="img candidato" 
                        />
                        <input id="c-upload-photo" className="hidden" type="file"
                            onChange={e => setImgBuffer(e.target.files![0])}
                            accept="image/*" />
                        <label className="button-ghost cursor-pointer
                                          inline-block text-center m-2"
                            htmlFor="c-upload-photo"
                        >
                            Mudar foto
                        </label>

                    </div>


                    <div className="input-container mt-2 gap-1">
                        <b>Email: </b>
                        <input className="check-edit hidden" type="checkbox" id="showEmail" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Email:" name="email" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, idUsuarioNavigation: { email: e.target.value } })}
                            value={candidatoForm?.idUsuarioNavigation?.email} placeholder={candidato.idUsuarioNavigation?.email}>
                        </Input>
                        <p>{candidato.idUsuarioNavigation?.email}</p>

                        <label className="input-editar ml-auto" htmlFor="showEmail">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showEmail">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showEmail">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Nome: </b>
                        <input className="check-edit hidden" type="checkbox" id="showNome" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Nome:" name="nome" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, nome: e.target.value })}
                            value={candidatoForm?.nome!} placeholder={candidato.nome!}>
                        </Input>
                        <p>{candidato.nome}</p>

                        <label className="input-editar ml-auto" htmlFor="showNome">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showNome">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showNome">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Sobrenome: </b>
                        <input className="check-edit hidden" type="checkbox" id="showSobrenome" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Sobrenome:" name="sobrenome" hideLabel
                            onChange={e => setCandidatoForm({ ...candidatoForm, sobrenome: e.target.value })}
                            value={candidatoForm?.sobrenome!} placeholder={candidato.sobrenome!}>
                        </Input>
                        <p>{candidato.sobrenome}</p>

                        <label className="input-editar ml-auto" htmlFor="showSobrenome">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showSobrenome">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showSobrenome">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Data de Nascimento: </b>
                        <input className="check-edit hidden" type="checkbox" id="showDataNascimento" onClick={() => setEditando(true)}></input>
                        <Input type="date" mask="" label="Data de nascimento:" name="data nascimento" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, dataNascimento: e.target.value })}
                            value={candidatoForm?.dataNascimento!} placeholder={toDate(new Date(candidato.dataNascimento!))}>
                        </Input>
                        <p>{toDate(new Date(candidato.dataNascimento!))}</p>

                        <label className="input-editar ml-auto" htmlFor="showDataNascimento">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showDataNascimento">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showDataNascimento">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>CPF: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCPF" onClick={() => setEditando(true)}></input>
                        <Input mask="999.999.999-99" label="Cpf:" name="cpf" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, cpf: e.target.value })}
                            value={candidatoForm?.cpf!} placeholder={candidato.cpf!}>
                        </Input>
                        <p>{candidato.cpf}</p>

                        <label className="input-editar ml-auto" htmlFor="showCPF">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCPF">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCPF">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>RG: </b>
                        <input className="check-edit hidden" type="checkbox" id="showRG" onClick={() => setEditando(true)}></input>
                        <Input mask="99.999.999-9" label="Rg:" name="rg" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, rg: e.target.value })}
                            value={candidatoForm?.cpf!} placeholder={candidato.rg!}>
                        </Input>
                        <p>{candidato.rg}</p>

                        <label className="input-editar ml-auto" htmlFor="showRG">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showRG">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showRG">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Matrícula do SENAI: </b>
                        <input className="check-edit hidden" type="checkbox" id="showNumMatricula" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Matrícula:" name="matrícula" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, matricula: e.target.value })}
                            value={candidatoForm?.matricula!} placeholder={candidato.matricula!}>
                        </Input>
                        <p>{candidato.matricula}</p>

                        <label className="input-editar ml-auto" htmlFor="showNumMatricula">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showNumMatricula">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showNumMatricula">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Endereço: </b>
                        <input className="check-edit hidden" type="checkbox" id="showEndereco" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Endereço:" name="endereço" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, idEnderecoNavigation: { cep: e.target.value } })}
                            value={candidatoForm?.idEnderecoNavigation?.cep!} placeholder="Digite o cep...">
                        </Input>
                        <p className="truncate break-all" style={{ width: "60%" }}>{candidato.idEnderecoNavigation?.localCompleto}</p>

                        <label className="input-editar ml-auto" htmlFor="showEndereco">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showEndereco">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showEndereco">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Telefone: </b>
                        <input className="check-edit hidden" type="checkbox" id="showTelefone" onClick={() => setEditando(true)}></input>
                        <Input mask="(99) 9999-9999" label="Telefone:" name="telefone" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, telefoneCandidato: e.target.value })}
                            value={candidatoForm?.telefoneCandidato!} placeholder={candidato.telefoneCandidato!}>
                        </Input>
                        <p>{candidato.telefoneCandidato}</p>

                        <label className="input-editar ml-auto" htmlFor="showTelefone">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showTelefone">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showTelefone">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Celular: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCelular" onClick={() => setEditando(true)}></input>
                        <Input mask="(99) 99999-9999" label="Celular:" name="celular" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, celularCandidato: e.target.value })}
                            value={candidatoForm?.celularCandidato!} placeholder={candidato.celularCandidato!}>
                        </Input>
                        <p>{candidato.celularCandidato}</p>

                        <label className="input-editar ml-auto" htmlFor="showCelular">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCelular">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCelular">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Formação acadêmica: </b>
                        <input className="check-edit hidden" type="checkbox" id="showFormacao" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Formação acadêmica:" name="formação acadêmica" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, formacaoAcademica: e.target.value })}
                            value={candidatoForm?.formacaoAcademica!} placeholder={candidato.formacaoAcademica!}>
                        </Input>
                        <p>{candidato.formacaoAcademica}</p>

                        <label className="input-editar ml-auto" htmlFor="showFormacao">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showFormacao">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showFormacao">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Curso: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCurso" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Curso:" name="curso" hideLabel={true}
                            onChange={e => setCandidatoForm({ ...candidatoForm, curso: e.target.value })}
                            value={candidatoForm?.curso!} placeholder={candidato.curso!}>
                        </Input>
                        <p>{candidato.curso}</p>

                        <label className="input-editar ml-auto" htmlFor="showCurso">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCurso">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCurso">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="flex items-end">
                        <Select className="w-full" label="Adicionar abilidades:" name="habilidade"
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
                            onClick={() => addHabilidade(idHabilidade)}>
                        </Button>
                    </div>

                    <div className="border-gray-500 mt-3 mb-3" />

                    <div className="flex flex-row flex-wrap">
                        {renderHabilidades()}
                    </div>

                    <div className="flex justify-center mt-8">
                        <ButtonForm name="Concluir" value="Salvar Alterações"></ButtonForm>
                    </div>
                </form>

            </main>
        </div>
    );

}

export default EditarPerfilCandidato;