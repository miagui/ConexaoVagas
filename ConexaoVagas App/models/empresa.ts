import { Endereco } from "./endereco";
import { StatusUsuario } from "./statusUsuario";
import { Usuario } from "./usuario";
import { Vaga } from "./vaga";

export class Empresa {
    idUsuario?: number;
    idStatusUsuario?: number;
    idEndereco?: number | null;
    foto?: string;
    cnae?: string;
    cnpj?: string;
    razaoSocial?: string;
    nomeFantasia?: string | null;
    emailPublico?: string;
    descricao?: string;
    telefoneEmpresa?: string;
    celularEmpresa?: string;
    visualizacao?: number;
    idEnderecoNavigation?: Endereco = undefined;
    idStatusUsuarioNavigation?: StatusUsuario = undefined;
    idUsuarioNavigation?: Usuario = undefined;
    vaga?: Vaga[] = [];
}