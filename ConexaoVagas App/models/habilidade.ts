import { HabilidadeCandidato } from "./habilidadeCandidato";
import { HabilidadeVaga } from "./habilidadeVaga";
import { Usuario } from "./usuario";

export class Habilidade {
    idHabilidade?: number;
    idCriadoPor?: number | null;
    nomeHabilidade?: string;
    idCriadoPorNavigation?: Usuario = undefined;
    habilidadeCandidato?: HabilidadeCandidato[] = [];
    habilidadeVaga?: HabilidadeVaga[] = [];
}