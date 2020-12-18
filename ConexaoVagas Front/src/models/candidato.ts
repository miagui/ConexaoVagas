import { Candidatura } from "./candidatura";
import { Endereco } from "./endereco";
import { HabilidadeCandidato } from "./habilidadeCandidato";
import { Matching } from "./matching";
import { StatusUsuario } from "./statusUsuario";
import { Usuario } from "./usuario";

export class Candidato {
    idUsuario?: number;
    idStatusUsuario?: number;
    idEndereco?: number | null;
    nome?: string;
    sobrenome?: string;
    curso?: string;
    formacaoAcademica?: string;
    matricula?: string;
    cpf?: string;
    rg?: string;
    telefoneCandidato?: string;
    celularCandidato?: string;
    dataNascimento?: string;
    visualizacao?: number;
    idEnderecoNavigation?: Endereco = undefined;
    idStatusUsuarioNavigation?: StatusUsuario = undefined;
    idUsuarioNavigation?: Usuario = undefined;
    candidatura?: Candidatura[] = [];
    habilidadeCandidato?: HabilidadeCandidato[] = [];
    matching?: Matching[] = [];
}