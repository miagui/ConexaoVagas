import { Administrador } from "./administrador";
import { Beneficio } from "./beneficio";
import { Candidato } from "./candidato";
import { Empresa } from "./empresa";
import { Habilidade } from "./habilidade";
import { TipoUsuario } from "./tipoUsuario";

export class Usuario {
    idUsuario?: number;
    idTipoUsuario?: number;
    email?: string;
    senha?: string;
    dataCadastrado?: string | null;
    idTipoUsuarioNavigation?: TipoUsuario = undefined;
    administrador?: Administrador = undefined;
    candidato?: Candidato = undefined;
    empresa?: Empresa = undefined;
    beneficio?: Beneficio[] = [];
    habilidade?: Habilidade[] = [];
}