import { Notificacao } from "../models/notificacao";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

const CONTROLLER = "Notificacao/";

/**
 * Lista a notificacoes.
 */
async function listar(): Promise<Notificacao[]> {
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
 * @param id ID da notificacao
 * @returns A notificacao buscada.
 */
async function buscarPorId(id: number): Promise<Notificacao> {
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
 * @param mensagem Mensagem de notificação.
 */
async function addNotificacao(mensagem: string): Promise<Notificacao> {

    var notificacao: Notificacao = new Notificacao();
    notificacao.mensagem = mensagem;

    return fetch(API_URL + CONTROLLER, {
        method: "POST",
        body: JSON.stringify(notificacao),
        headers: {
            'content-type': 'application/json',
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
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
async function deletar(id: number): Promise<void> {
    fetch(API_URL + CONTROLLER, {
        method: 'DELETE',
        headers: {
            authorization: 'Bearer ' + await AsyncStorage.getItem(TOKEN_KEY)
        }
    })
        .then(handleErrors)
        .then(response => response.json())
        .catch(err => console.error(err));
}

export default {listar, buscarPorId, addNotificacao, deletar}