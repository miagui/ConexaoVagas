import { Habilidade } from "./habilidade";
import { Vaga } from "./vaga";

export class HabilidadeVaga {
    idHabilidadeVaga?: number;
    idHabilidade?: number;
    idVaga?: number;
    idHabilidadeNavigation?: Habilidade = undefined;
    idVagaNavigation?: Vaga = undefined;
}