import { Candidato } from "./candidato";
import { Vaga } from "./vaga";

export class Endereco {
    idEndereco?: number;
    cep?: string;
    localCompleto?: string;
    uf?: string;
    lat?: number | null;
    long?: number | null;
    candidato?: Candidato[] = [];
    vaga?: Vaga[] = [];
}