import { HabilidadeCandidato } from "../models/habilidadeCandidato";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "HabilidadeCandidato/";

/**
 * Lista habilidadeCandidatos.
 */
function listar(): Promise<HabilidadeCandidato[]> {
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
 * @param id ID da habilidadeCandidato
 * @returns A habilidadeCandidato buscada.
 */
function buscarPorId(id: number): Promise<HabilidadeCandidato> {
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
 * @param habilidadeCandidato Objeto habilidadeCandidato a ser adicionado/atualizado.
 * @param id ID do habilidadeCandidato a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto habilidadeCandidato se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(habilidadeCandidato: HabilidadeCandidato, id: number): Promise<HabilidadeCandidato> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(habilidadeCandidato),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return habilidadeCandidato as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma habilidadeCandidato.
 * @param id ID da habilidadeCandidato
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