import { Usuario } from "../models/usuario";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

// Define o controller de comunicação da API.
// A URL ficaria assim:
// http://localhost:5000/api/Usuario/
const CONTROLLER = "Usuario/";

/**
 * Lista usuários.
 */
async function listar(): Promise<Usuario[]> {
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
 * @param email Email de um usuário.
 * @returns Usuário.
 */
async function buscarPorEmail(email: string): Promise<Usuario> {
    // http://localhost:5000/api/Usuario/Email/nome@email.com
    return fetch(API_URL + CONTROLLER + "Email/" + email, {
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
 * Busca o usuário autorizado (logado) no momento.
 * @returns Usuário.
 */
async function buscarAutorizado(): Promise<Usuario> {
    return fetch(API_URL + CONTROLLER, {
        method: 'GET',
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
 * Deleta o usuario autenticado (logado) no momento.
 */
async function deletar(): Promise<void> {
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

export default {listar, buscarAutorizado, buscarPorEmail, deletar}