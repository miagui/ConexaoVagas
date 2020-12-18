export const API_URL: string = "http://conexaovagasapi.ddns.net:52525/api/"
export const TOKEN_KEY: string = "token-conexao-vagas"

export function handleErrors(response: Response) {
    if (!response.ok) {
        throw Error(response.statusText);
    }
    return response;
}