import { Candidato } from "../models/candidato";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";
import MatchesApi from "../api/matching";

// Define o controller de comunicação da API.
// A URL ficaria assim:
// http://localhost:5000/api/Candidato/
const CONTROLLER = "Candidato/";

/**
 * Lista os candidatos.
 */
async function listar(): Promise<Candidato[]> {
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
 * 
 * @param id ID do candidato
 * @returns O candidato buscado.
 */
async function listarPorStatus(id: number): Promise<Candidato> {
    // http://localhost:5000/api/Candidato/5
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
 * @param candidato Objeto candidato a ser adicionado/atualizado.
 * @param id ID do candidato a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto candidato se a operação for feita com sucesso, caso contrário retorno nada.
 */
async function salvar(candidato: Candidato, id: number): Promise<Candidato> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(candidato),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            MatchesApi.atualizar();
            return candidato as any;
        })
        .catch(err => console.error(err));
}

/**
 * 
 * @param id ID da Candidato
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

async function mudarStatus(id: number, idStatus: number): Promise<Promise<void>> {

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

export default {listar, buscarPorId: listarPorStatus, salvar, mudarStatus}