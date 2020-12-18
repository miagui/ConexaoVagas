import { TOKEN_KEY } from "../api/apisettings";

export const usuarioAutenticado = () => localStorage.getItem(TOKEN_KEY) !== null;

export const Jwt = () => {

    var token = localStorage.getItem(TOKEN_KEY);

    if (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        return JSON.parse(window.atob(base64));
    }
}

export const parseJwt = (token: any) => {

    if (token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        return JSON.parse(window.atob(base64));
    }
}
