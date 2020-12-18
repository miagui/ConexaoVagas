import { Matching } from "../models/matching";
import { API_URL, handleErrors, TOKEN_KEY } from "./apisettings";
import AsyncStorage from "@react-native-async-storage/async-storage";

const CONTROLLER = "Match/";

/**
 * Lista matching entre vagas e candidatos.
 */
async function listar(): Promise<Matching[]> {
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
 * Atualiza a relação de matching entre candidato e vaga.
 */
async function atualizar(): Promise<Matching[]> {
    return fetch(API_URL + CONTROLLER, {
        method: "PUT",
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


export default {listar, atualizar}