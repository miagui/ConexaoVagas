import { Vaga } from "../models/vaga";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";
import MatchesApi from "../api/matching";

const CONTROLLER = "Vaga/";

/**
 * Lista os vagas.
 */
async function listar(): Promise<Vaga[]> {
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
 * @param id ID do vaga
 * @returns O vaga buscado.
 */
async function buscarPorId(id: number): Promise<Vaga> {
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
 * @param id ID da empresa.
 */
async function listarPorEmpresa(id: number): Promise<Vaga[]> {
    return fetch(API_URL + CONTROLLER + `Empresa/${id}`, {
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
 * @param titulo Nome da vaga
 * @param minSalario Salário mínimo
 * @param idHabilidade ID da habilidade relacionada
 */
async function listarPorFiltro(titulo: string, minSalario: number, idHabilidade: number): Promise<Vaga[]> {
    var filtro: string = `Filtro?titulo=${titulo}&minSalario=${minSalario}&id=${idHabilidade}`

    return fetch(API_URL + CONTROLLER + filtro, {
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
 * @param vaga Objeto vaga a ser adicionado/atualizado.
 * @param id ID do vaga a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto vaga se a operação for feita com sucesso, caso contrário retorno nada.
 */
async function salvar(vaga: Vaga, id: number): Promise<Vaga> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);
    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(vaga),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            MatchesApi.atualizar();
            return vaga as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma vaga.
 * @param id ID da vaga
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

export default {listar, listarPorEmpresa, listarPorFiltro, buscarPorId, salvar, deletar}