import { BeneficioVaga } from "./beneficioVaga";
import { Usuario } from "./usuario";

export class Beneficio {
    idBeneficio?: number;
    idCriadoPor?: number | null;
    nomeBeneficio?: string;
    idCriadoPorNavigation?: Usuario = undefined;
    beneficioVaga?: BeneficioVaga[] = [];
}