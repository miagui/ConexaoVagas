import { Beneficio } from "../models/beneficio";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Beneficio/";

/**
 * Lista beneficios.
 */
function listar(): Promise<Beneficio[]> {
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
 * 
 * @param id ID da beneficio
 * @returns A beneficio buscada.
 */
function buscarPorId(id: number): Promise<Beneficio> {
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
 * @param beneficio Objeto beneficio a ser adicionado/atualizado.
 * @param id ID do beneficio a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto beneficio se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(beneficio: Beneficio, id: number): Promise<Beneficio> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(beneficio),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return beneficio as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma beneficio.
 * @param id ID da beneficio
 */
function deletar(id: number): void {
    fetch(API_URL + CONTROLLER + id, {
        method: 'DELETE',
        headers: {
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => response.json())
        .catch(err => console.error(err));
}

export default { listar, buscarPorId, salvar, deletar }