import { BeneficioVaga } from "../models/beneficioVaga";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "BeneficioVaga/";

/**
 * Lista a beneficioVaga.
 */
function listar(): Promise<BeneficioVaga[]> {
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
 * @param id ID da beneficioVaga
 * @returns A beneficioVaga buscada.
 */
function buscarPorId(id: number): Promise<BeneficioVaga> {
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
 * @param beneficioVaga Objeto beneficioVaga a ser adicionado/atualizado.
 * @param id ID do beneficioVaga a ser atualizado.  O valor é 0 quando apenas quer adicionar.
 * @returns Objeto beneficioVaga se a operação for feita com sucesso, caso contrário retorno nada.
 */
function salvar(beneficioVaga: BeneficioVaga, id: number): Promise<BeneficioVaga> {

    const method = (id === 0 ? 'POST' : 'PUT');
    const urlRequest = (id === 0 ? API_URL + CONTROLLER : API_URL + CONTROLLER + id);

    return fetch(urlRequest, {
        method: method,
        body: JSON.stringify(beneficioVaga),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
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