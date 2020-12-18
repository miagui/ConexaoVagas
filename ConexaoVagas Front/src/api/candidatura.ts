import { Candidatura } from "../models/candidatura";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Candidatura/";

/**
 * Lista as candidaturas.
 */
function listar(): Promise<Candidatura[]> {
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
 * @param id ID da candidatura
 * @returns A candidatura buscada
 */
function buscarPorId(id: number): Promise<Candidatura> {
    // http://localhost:5000/api/Candidatura/5
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
 * @param empresa Objeto candidatura a ser adicionada/atualizada.
 * @param id ID do candidatura a ser atualizada.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto candidatura se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(candidatura: Candidatura, id: number): Promise<Candidatura> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(candidatura),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return candidatura as any;
        })
        .catch(err => console.error(err));
}

function visualizar(id: number) {
    var form: Candidatura = {
        visualizado: true
    } 

    salvar(form, id)
}

export default { listar, buscarPorId, salvar, visualizar }