import { Candidato } from "./candidato";
import { Habilidade } from "./habilidade";

export class HabilidadeCandidato {
    idHabilidadeCandidato?: number;
    idHabilidade?: number;
    idCandidato?: number;
    idCandidatoNavigation?: Candidato = undefined;
    idHabilidadeNavigation?: Habilidade = undefined;
}