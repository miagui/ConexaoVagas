import { Notificacao } from "../models/notificacao";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";

const CONTROLLER = "Notificacao/";

/**
 * Lista a notificacoes.
 */
function listar(): Promise<Notificacao[]> {
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
 * @param id ID da notificacao
 * @returns A notificacao buscada.
 */
function buscarPorId(id: number): Promise<Notificacao> {
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
 * @param mensagem Mensagem de notificação.
 */
function addNotificacao(mensagem: string): Promise<Notificacao> {

    var notificacao: Notificacao = new Notificacao();
    notificacao.mensagem = mensagem;

    return fetch(API_URL + CONTROLLER, {
        method: "POST",
        body: JSON.stringify(notificacao),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(() => {
            return notificacao as any;
        })
        .catch(err => console.error(err));
}



/**
 * Deleta uma notificacao.
 * @param id ID da notificacao
 */
function deletar(id: number): void {
    fetch(API_URL + CONTROLLER, {
        method: 'DELETE',
        headers: {
            authorization: 'Bearer ' + localStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => response.json())
        .catch(err => console.error(err));
}

export default { listar, buscarPorId, addNotificacao, deletar }