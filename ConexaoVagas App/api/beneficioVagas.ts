import { BeneficioVaga } from "../models/beneficioVaga";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

const CONTROLLER = "BeneficioVaga/";

/**
 * Lista a beneficioVaga.
 */
async function listar(): Promise<BeneficioVaga[]> {
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
 * @param id ID da beneficioVaga
 * @returns A beneficioVaga buscada.
 */
async function buscarPorId(id: number): Promise<BeneficioVaga> {
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
 * @param beneficioVaga Objeto beneficioVaga a ser adicionado/atualizado.
 * @param id ID do beneficioVaga a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto beneficioVaga se a operação for feita com sucesso, caso contrário retorno nada.
 */
async function salvar(beneficioVaga: BeneficioVaga, id: number): Promise<BeneficioVaga> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(beneficioVaga),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return beneficioVaga as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma beneficioVaga.
 * @param id ID da beneficioVaga
 */
async function deletar(id: number): Promise<Promise<void>> {
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