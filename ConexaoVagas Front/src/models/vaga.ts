import { BeneficioVaga } from "./beneficioVaga";
import { Candidatura } from "./candidatura";
import { Empresa } from "./empresa";
import { Endereco } from "./endereco";
import { HabilidadeVaga } from "./habilidadeVaga";
import { Matching } from "./matching";

export class Vaga {
    idVaga?: number;
    idEmpresa?: number;
    idEndereco?: number | null;
    titulo?: string;
    salario?: number;
    qualificacao?: string;
    dataCriado?: string;
    dataExpiracao?: string;
    cargaHoraria?: number;
    descricao?: string;
    visualizacao?: number;
    idEmpresaNavigation?: Empresa = undefined;
    idEnderecoNavigation?: Endereco = undefined;
    beneficioVaga?: BeneficioVaga[] = [];
    candidatura?: Candidatura[] = [];
    habilidadeVaga?: HabilidadeVaga[] = [];
    matching?: Matching[] = [];
}