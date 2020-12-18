import AsyncStorage from "@react-native-async-storage/async-storage";
import { TOKEN_KEY } from "../api/apisettings";
import {decode as atob} from 'base-64'

export function usuarioAutenticado() {
    return AsyncStorage.getItem(TOKEN_KEY).then(token => token != null)
} 

export const Jwt = async () => {
    var token = await AsyncStorage.getItem(TOKEN_KEY)
    return parseJwt(token);
}

export const parseJwt = (token: any) => {
    
    if(token) {
        var base64Url = token.split('.')[1];
        var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        return JSON.parse(atob(base64));
    }
}
