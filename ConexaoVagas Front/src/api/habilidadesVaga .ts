import { HabilidadeVaga } from "../models/habilidadeVaga";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "HabilidadeVaga/";

/**
 * Lista habilidadeVagas.
 */
function listar(): Promise<HabilidadeVaga[]> {
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
 * @param id ID da habilidadeVaga
 * @returns A habilidadeVaga buscada.
 */
function buscarPorId(id: number): Promise<HabilidadeVaga> {
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
 * @param habilidadeVaga Objeto habilidadeVaga a ser adicionado/atualizado.
 * @param id ID do habilidadeVaga a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto habilidadeVaga se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(habilidadeVaga: HabilidadeVaga, id: number): Promise<HabilidadeVaga> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(habilidadeVaga),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return habilidadeVaga as any;
        })
        .catch(err => console.error(err));
}

/**
 * Deleta uma habilidadeVaga.
 * @param id ID da habilidadeVaga
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