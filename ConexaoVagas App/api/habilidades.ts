import { Habilidade } from "../models/habilidade";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

const CONTROLLER = "Habilidade/";

/**
 * Lista habilidades.
 */
async function listar(): Promise<Habilidade[]> {
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
 * @param id ID da habilidade
 * @returns A habilidade buscada.
 */
async function buscarPorId(id: number): Promise<Habilidade> {
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
 * @param habilidade Objeto habilidade a ser adicionado/atualizado.
 * @param id ID do habilidade a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto habilidade se a operação for feita com sucesso, caso contrário retorno nada.
 */
async function salvar(habilidade: Habilidade, id: number): Promise<Habilidade> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(habilidade),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return habilidade as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma habilidade.
 * @param id ID da habilidade
 */
async function deletar(id: number): Promise<void> {
    fetch(API_URL + CONTROLLER + id, {
        method: 'DELETE',
        headers: {
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => response.json())
        .catch(err => console.error(err));
}

export default {listar, buscarPorId, salvar, deletar}