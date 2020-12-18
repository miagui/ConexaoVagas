import React, { useEffect, useState } from 'react'
import { StyleSheet, Text, View } from 'react-native'
import { Vaga } from '../models/vaga'
import { MaterialCommunityIcons } from '@expo/vector-icons';
import CandidatoApi from '../api/candidatos';
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
import { Candidato } from '../models/candidato';

export default function CandidatoPublico({ route, navigate }: any) {
    const { id } = route.params;

    const [candidato, setCandidato] = useState<Candidato>(new Candidato());
    const [beneficios, setBeneficios] = useState<Beneficio[]>([]);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        Promise.all([
            CandidatoApi.buscarPorId(id).then(data => setCandidato(data)),
            BeneficioApi.listar().then(data => setBeneficios(data)),
            HabilidadeApi.listar().then(data => setHabilidades(data)),
        ])
            .then(() => setIsLoading(false))

    }, [])

    if (isLoading) {
        return <LoadingScreen />
    }

    return (
        <ScrollView style={tailwind("m-2")}>
            <View style={tailwind("mt-4 mb-6")}>
                <Text style={tailwind("text-center text-xl")}>{`${candidato.nome} ${candidato.sobrenome || ""}`}</Text>
            </View>
            <View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Curso</Text>
                    <Text>{candidato.curso}</Text>
                </View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Localização</Text>
                    <Text>{candidato.idEnderecoNavigation?.localCompleto}</Text>
                </View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Telefone</Text>
                    <Text>{candidato.telefoneCandidato}</Text>
                </View>
                <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Celular</Text>
                    <Text>{candidato.celularCandidato}</Text>
                </View>

                {candidato.habilidadeCandidato!.length > 0 && (
                    <View style={tailwind("mb-2")}>
                    <Text style={tailwind("font-bold")}>Habilidades</Text>
                    <View style={tailwind("flex-row flex-wrap")}>
                        {candidato.habilidadeCandidato?.map(hc => (
                            <Text
                                style={tailwind("bg-gray-400 p-2 rounded-full m-1 h-8")}
                                ellipsizeMode='tail'
                                numberOfLines={1}
                                key={hc.idHabilidade?.toString()}>
                                {habilidades.find((b: Habilidade) =>
                                    hc.idHabilidade == b.idHabilidade)?.nomeHabilidade}
                            </Text>
                        ))}
                    </View>
                </View>
                )}
                
            </View>
        </ScrollView >
    )
}

const styles = StyleSheet.create({})
