import { Candidato } from "./candidato";
import { Vaga } from "./vaga";

export class Matching {
    idCandidato?: number;
    idVaga?: number;
    porcentagem?: number;
    distancia?: number;
    idCandidatoNavigation?: Candidato;
    idVagaNavigation?: Vaga;
}