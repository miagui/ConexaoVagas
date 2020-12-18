import { Matching } from "../models/matching";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Match/";

/**
 * Lista matching entre vagas e candidatos.
 */
function listar(): Promise<Matching[]> {
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
 * Atualiza a relação de matching entre candidato e vaga.
 */
function atualizar(): Promise<Matching[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "PUT",
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


export default { listar, atualizar }