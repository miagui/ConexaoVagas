import { Candidato } from "./candidato";
import { Empresa } from "./empresa";

export class StatusUsuario {
    idStatusUsuario?: number;
    nomeStatus?: string;
    candidato?: Candidato[] = undefined;
    empresa?: Empresa[] = undefined;
}