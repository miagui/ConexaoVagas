import { Candidato } from "./candidato";
import { Vaga } from "./vaga";

export class Candidatura {
    idCandidatura?: number;
    idCandidato?: number;
    idVaga?: number;
    curriculo?: string;
    visualizado?: boolean;
    dataCriado?: string;
    idCandidatoNavigation?: Candidato = undefined;
    idVagaNavigation?: Vaga = undefined;
}