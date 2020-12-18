import { Beneficio } from "./beneficio";
import { Vaga } from "./vaga";

export class BeneficioVaga {
    idBeneficioVaga?: number;
    idBeneficio?: number;
    idVaga?: number;
    idBeneficioNavigation?: Beneficio = undefined;
    idVagaNavigation?: Vaga = undefined;
}