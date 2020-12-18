/* eslint-disable eqeqeq */
import React, { useEffect, useState } from 'react';
import EmpresaApi from '../../api/empresa'
import Sidebar from '../../components/sidebar/Index';
import Input from '../../components/input';
import Hamburguer from '../../components/hamburguer';
import TextArea from '../../components/textArea';
import ButtonForm from '../../components/buttonForm';
import { Empresa } from '../../models/empresa';
import { Jwt } from '../../services/auth';
import { API_URL } from '../../api/apisettings';
import { useAlert } from 'react-alert';
import LoadingPage from '../loading';

function EditarPerfilEmpresa() {

    const [empresaForm, setEmpresaForm] = useState<Empresa>(new Empresa());
    const [empresa, setEmpresa] = useState<Empresa>(new Empresa());
    const [imgBuffer, setImgBuffer] = useState<Blob>();
    const [imgUrl, setImgUrl] = useState("")
    const [editando, setEditando] = useState(false);
    const [isLoading, setIsLoading] = useState(true);

    const alert = useAlert();

    useEffect(() => {
        Promise.all([
            EmpresaApi.salvar(empresaForm, Jwt().jti).then(data => setEmpresaForm(data)),
            EmpresaApi.buscarPorId(Jwt().jti).then(data => {
                setEmpresa(data)
                // A URL da foto da Empresa.
                setImgUrl(`${API_URL}Empresa/Img/${data.idUsuario}`)
            })
        ])
        .then(() => setIsLoading(false));

    }, []);

    useEffect(() => {
        // Verifica se o usuário já adicionou uma foto..
        if (imgBuffer != undefined || imgBuffer != null)
            setImgUrl(URL.createObjectURL(imgBuffer));
    }, [imgBuffer]);


    function salvar() {
        if (empresaForm != undefined) {
            EmpresaApi.salvar(empresaForm, Jwt().jti).then(data => {
                if (data != null || data != undefined) {
                    alert.success("Atualizado dados com sucesso.")
                    setEmpresaForm(new Empresa());
                    EmpresaApi.buscarPorId(Jwt().jti).then(e => setEmpresa(e))
                }
                else alert.error("Falha ao atualizar os dados.")
            });
            if (imgBuffer != null)
                EmpresaApi.uploadFoto(empresa.idUsuario!, imgBuffer).then(data => {
                    if (data != undefined) alert.success("Atualizado foto com sucesso.")
                    else alert.error("Não foi possível atualizar a foto.")
                })
        }
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
                <h1 className="p-10 md:text-2xl text-xl flex justify-center">Detalhes da empresa</h1>
                <form className="m-auto lg:w-1/2 w-full"
                    onSubmit={event => {
                        event.preventDefault();
                        salvar();
                        event.currentTarget.reset();
                    }}>
                    <div className="mb-5 text-center">
                        <img className="w-32 h-32 object-contain mx-auto border-2"
                            src={imgUrl} alt="" />
                        <input id="e-upload-photo" className="hidden" type="file"
                            onChange={e => setImgBuffer(e.target.files![0])}
                            accept="image/*"
                        />
                        <label className="button-ghost cursor-pointer 
                                          inline-block text-center m-2"
                            htmlFor="e-upload-photo"
                        >
                            Mudar foto
                        </label>

                    </div>


                    <div className="input-container mt-2 gap-1">
                        <b>Email: </b>
                        <input className="check-edit hidden" type="checkbox" id="showEmail" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Email:" name="email" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, idUsuarioNavigation: { email: e.target.value } })}
                            value={empresaForm?.idUsuarioNavigation?.email} placeholder={empresa.idUsuarioNavigation?.email}>
                        </Input>
                        <p>{empresa.idUsuarioNavigation?.email}</p>

                        {/* {!editando && (
                            <label className="input-editar ml-auto" htmlFor="showEmail">
                                <i className="ri-edit-2-line"></i>
                                <span className="cursor-pointer"> Editar</a>
                            </label>
                        )} */}

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
                            onChange={e => setEmpresaForm({ ...empresaForm, nomeFantasia: e.target.value })}
                            value={empresaForm?.nomeFantasia!} placeholder={empresa.nomeFantasia!}>
                        </Input>
                        <p>{empresa.nomeFantasia}</p>

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
                        <b>Telefone: </b>
                        <input className="check-edit hidden" type="checkbox" id="showTelefone" onClick={() => setEditando(true)}></input>
                        <Input mask="(99) 9999-9999" label="Telefone:" name="telefone" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, telefoneEmpresa: e.target.value })}
                            value={empresaForm?.telefoneEmpresa!} placeholder={empresa.telefoneEmpresa!}>
                        </Input>
                        <p>{empresa.telefoneEmpresa}</p>

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
                            onChange={e => setEmpresaForm({ ...empresaForm, celularEmpresa: e.target.value })}
                            value={empresaForm?.celularEmpresa!} placeholder={empresa.celularEmpresa!}>
                        </Input>
                        <p>{empresa.celularEmpresa}</p>

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
                        <b>CEP: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCEP" onClick={() => setEditando(true)}></input>
                        <Input mask="99999-999" label="Endereço:" name="endereço" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, idEnderecoNavigation: { cep: e.target.value } })}
                            value={empresaForm?.idEnderecoNavigation?.cep!} placeholder="Digite o cep...">
                        </Input>
                        <p>{empresa.idEnderecoNavigation?.cep}</p>

                        <label className="input-editar ml-auto" htmlFor="showCEP">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCEP">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCEP">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>Razão Social: </b>
                        <input className="check-edit hidden" type="checkbox" id="showRazaoSocial" onClick={() => setEditando(true)}></input>
                        <Input mask="" label="Razao Social:" name="razao" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, razaoSocial: e.target.value })}
                            value={empresaForm?.razaoSocial!} placeholder={empresa.razaoSocial!}>
                        </Input>
                        <p>{empresa.razaoSocial}</p>

                        <label className="input-editar ml-auto" htmlFor="showRazaoSocial">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showRazaoSocial">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showRazaoSocial">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>CNPJ: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCNPJ" onClick={() => setEditando(true)}></input>
                        <Input mask="99.999.999/9999-99" label="Razao Social:" name="razao" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, cnpj: e.target.value })}
                            value={empresaForm?.cnpj!} placeholder={empresa.cnpj!}>
                        </Input>
                        <p>{empresa.cnpj}</p>

                        <label className="input-editar ml-auto" htmlFor="showCNPJ">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCNPJ">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCNPJ">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b>CNAE: </b>
                        <input className="check-edit hidden" type="checkbox" id="showCNAE" onClick={() => setEditando(true)}></input>
                        <Input mask="9999-9" label="Razao Social:" name="razao" hideLabel={true}
                            onChange={e => setEmpresaForm({ ...empresaForm, cnae: e.target.value })}
                            value={empresaForm?.cnae!} placeholder={empresa.cnae!}>
                        </Input>
                        <p>{empresa.cnae}</p>

                        <label className="input-editar ml-auto" htmlFor="showCNAE">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto" htmlFor="showCNAE">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar" htmlFor="showCNAE">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <hr className="border-gray-500 mt-3 mb-3" />

                    <div className="input-container mt-2 gap-1">
                        <b className="self-start">Descrição: </b>
                        <input className="check-edit hidden" type="checkbox" id="showDescricao" onClick={() => setEditando(true)}></input>
                        <TextArea className="w-8/12" name="descricao" hideLabel
                            rows={5} cols={30}
                            onChange={e => setEmpresaForm({ ...empresaForm, descricao: e.target.value })}
                            value={empresaForm?.descricao!}
                            defaultValue={empresa.descricao!}
                            placeholder={empresa.descricao!}>
                        </TextArea>
                        <p className="p-5 mx-2 w-8/12 bg-white rounded-md">{empresa.descricao}</p>

                        <label className="input-editar ml-auto self-start" htmlFor="showDescricao">
                            <i className="ri-edit-2-line"></i>
                            <span className="cursor-pointer"> Editar</span>
                        </label>
                        <label className="input-salvar ml-auto self-start" htmlFor="showDescricao">
                            <i className="ri-check-fill"></i>
                            <input type="submit" value="Salvar"></input>
                        </label>
                        <label className="input-salvar self-start" htmlFor="showDescricao">
                            <i className="ri-close-line"></i>
                            <span className="cursor-pointer"> Cancelar</span>
                        </label>
                    </div>

                    <div className="flex justify-center mt-8">
                        <ButtonForm name="Concluir" value="Salvar Alterações"></ButtonForm>
                    </div>
                </form>

            </main>
        </div>
    );

}

export default EditarPerfilEmpresa;