import { Administrador } from "../models/administrador";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Administrador/";

/**
 * Lista os administradors.
 */
function listar(): Promise<Administrador[]> {
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
 * @param id ID do administrador
 * @returns O administrador buscado.
 */
function buscarPorId(id: number): Promise<Administrador> {
    // http://localhost:5000/api/Administrador/5
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
 * @param administrador Objeto administrador a ser adicionado/atualizado.
 * @param id ID do administrador a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto administrador se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(administrador: Administrador, id: number): Promise<Administrador> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(administrador),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return administrador as any;
        })
        .catch(err => console.error(err));
}

export default { listar, buscarPorId, salvar }