import { Empresa } from "../models/empresa";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

const CONTROLLER = "Empresa/";

/**
 * Lista os empresas.
 */
async function listar(): Promise<Empresa[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
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
async function listarPorStatus(id: number): Promise<Empresa[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
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
async function buscarPorId(id: number): Promise<Empresa> {
    // http://localhost:5000/api/Empresa/5
    return fetch(API_URL + CONTROLLER + id, {
        method: "GET",
        headers: {
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
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
async function salvar(empresa: Empresa, id: number): Promise<Empresa> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(empresa),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
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
async function uploadFoto(id: number, file: Blob) {

    var img = new FormData();
    img.append("file", file, id.toString());

    return fetch(API_URL + CONTROLLER + "Img/upload/" + id, {
        method: "POST",
        body: img,
        headers: {
            'Accept': '*/*',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => id)
        .catch(err => console.error(err));
}


async function mudarStatus(id: number, idStatus: number): Promise<void> {

    fetch(API_URL + CONTROLLER + `Status?id=${id}&idStatus=${idStatus}`, {
        method: "PUT",
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .catch(err => console.error(err));
}

export default { listar, listarPorStatus, buscarPorId, salvar, uploadFoto, mudarStatus }