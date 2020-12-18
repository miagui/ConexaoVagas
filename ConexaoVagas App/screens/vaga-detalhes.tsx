import React, { useEffect, useState } from 'react'
import { StyleSheet, Text, View } from 'react-native'
import { Vaga } from '../models/vaga'
import { MaterialCommunityIcons } from '@expo/vector-icons';
import VagaApi from '../api/vagas';
import BeneficioApi from '../api/beneficios';
import HabilidadeApi from '../api/habilidades';
import tailwind from 'tailwind-rn';
import Hr from '../components/hr';
import { Color } from '../styles/global';
import { Beneficio } from '../models/beneficio';
import { Habilidade } from '../models/habilidade';
import LoadingScreen from '../components/loadingscreen';
import { ScrollView } from 'react-native-gesture-handler';
import { Jwt } from '../services/auth';

export default function VagaDetalhes({ route, navigate }: any) {
    const { id } = route.params;

    const [vaga, setVaga] = useState<Vaga>(new Vaga());
    const [beneficios, setBeneficios] = useState<Beneficio[]>([]);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [idUser, setIdUser] = useState(0);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        Promise.all([
            VagaApi.buscarPorId(id).then(data => setVaga(data)),
            BeneficioApi.listar().then(data => setBeneficios(data)),
            HabilidadeApi.listar().then(data => setHabilidades(data)),
            Jwt().then(token => setIdUser(token.jti))
        ])
            .then(() => setIsLoading(false))

    }, [])

    if (isLoading) {
        return <LoadingScreen />
    }

    return (
        <ScrollView style={tailwind("m-2")}>
            <View style={tailwind("mt-4 mb-6")}>
                <Text style={tailwind("text-center text-xl")}>{vaga.titulo}</Text>
                <Text style={tailwind("text-center text-xs")}>{vaga.idEmpresaNavigation?.nomeFantasia}</Text>
            </View>
            <View>
                    <View style={tailwind("flex-row items-center")}>
                        <MaterialCommunityIcons name="cash-usd" color="#000" size={18} />
                        <Text style={tailwind("text-base")}> R$ {vaga.salario}</Text>
                    </View>
                    <View style={tailwind("flex-row items-center")}>
                        <MaterialCommunityIcons name="school" color="#000" size={18} />
                        <Text style={tailwind("text-base")}> {vaga.qualificacao}</Text>
                    </View>
                    <View style={tailwind("flex-row items-center")}>
                        <MaterialCommunityIcons name="clock" color="#000" size={18} />
                        <Text style={tailwind("text-base")}> Carga horária de {vaga.cargaHoraria}h</Text>
                    </View>
                    <View style={tailwind("flex-row items-center mb-5")}>
                        <Text style={tailwind("text-black font-bold text-lg pr-1")}>
                            {Math.floor(vaga.matching?.find(match => match.idCandidato == idUser)?.porcentagem!)}%
                        </Text>
                        <Text style={tailwind("self-end")}>de match com a vaga</Text>
                    </View>
            </View>
            <View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Descrição</Text>
                    <Text>{vaga.descricao}</Text>
                </View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Sobre a Empresa</Text>
                    <Text>{vaga.idEmpresaNavigation?.descricao}</Text>
                </View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Local de Trabalho</Text>
                    <Text>{vaga.idEnderecoNavigation?.localCompleto}</Text>
                </View>


                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Benefícios</Text>
                    <View style={tailwind("flex-row flex-wrap")}>
                        {vaga.beneficioVaga?.map(bv => (
                            <Text
                                style={tailwind("bg-gray-400 p-2 rounded-full m-1 h-8")}
                                ellipsizeMode='tail'
                                numberOfLines={1}
                                key={bv.idBeneficio?.toString()}>
                                {beneficios.find((b: Beneficio) =>
                                    bv.idBeneficio == b.idBeneficio)?.nomeBeneficio}
                            </Text>
                        ))}
                    </View>
                </View>

                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Habilidades</Text>
                    <View style={tailwind("flex-row flex-wrap")}>
                        {vaga.habilidadeVaga?.map(hv => (
                            <Text
                                style={tailwind("bg-gray-400 p-2 rounded-full m-1 h-8")}
                                ellipsizeMode='tail'
                                numberOfLines={1}
                                key={hv.idHabilidade?.toString()}>
                                {habilidades.find((h: Habilidade) =>
                                    hv.idHabilidade == h.idHabilidade)?.nomeHabilidade}
                            </Text>
                        ))}
                    </View>
                </View>
            </View>
        </ScrollView >
    )
}

const styles = StyleSheet.create({})
