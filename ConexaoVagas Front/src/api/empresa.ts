/* eslint-disable eqeqeq */
import { Empresa } from "../models/empresa";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Empresa/";

/**
 * Lista os empresas.
 */
function listar(): Promise<Empresa[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => {
            return response.json();
        })
        .catch(err => console.error(err));
}
/**
 * Lista por status de usuário.
 * @param id ID do status de usuário 
 *      PENDENTE = 1,
 *      ATIVO = 2,
 *      BLOQUEADO = 3,
 *      RECUSADO = 4
 */
function listarPorStatus(id: number): Promise<Empresa[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => {
            return response.json();
        })
        .then((data) => {
            return data.filter((empresa: Empresa) => {
                return empresa.idStatusUsuario == id
            });
        })

        .catch(err => console.error(err));
}

/**
 * 
 * @param id ID do empresa
 * @returns O empresa buscado.
 */
function buscarPorId(id: number): Promise<Empresa> {
    // http://localhost:5000/api/Empresa/5
    return fetch(API_URL + CONTROLLER + id, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => {
            return response.json();
        })
        .catch(err => console.error(err));
}

/**
 * 
 * @param empresa Objeto empresa a ser adicionado/atualizado.
 * @param id ID do empresa a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto empresa se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(empresa: Empresa, id: number): Promise<Empresa> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(empresa),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return empresa as any;
        })
        .catch(err => console.error(err));
}
/**
 * 
 * @param id ID da Empresa
 * @param file Foto
 */
function uploadFoto(id: number, file: Blob) {

    var img = new FormData();
    img.append("file", file, id.toString());

    return fetch(API_URL + CONTROLLER + "Img/upload/" + id, {
        method: "POST",
        body: img,
        headers: {
            'Accept': '*/*',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => id)
        .catch(err => console.error(err));
}


function mudarStatus(id: number, idStatus: number): void {

    fetch(API_URL + CONTROLLER + `Status?id=${id}&idStatus=${idStatus}`, {
        method: "PUT",
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .catch(err => console.error(err));
}

function somaVisualizacao(id: number) {
    
    var empresa = new Empresa();

    buscarPorId(id).then(data => {
        empresa.visualizacao = data.visualizacao! + 1;
        
        salvar(empresa, id) 
    });
}

export default { listar, listarPorStatus, buscarPorId, salvar, uploadFoto, mudarStatus , somaVisualizacao}