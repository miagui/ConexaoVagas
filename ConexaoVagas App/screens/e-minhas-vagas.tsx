import React, { useEffect, useState } from 'react'
import tailwind from 'tailwind-rn'
import { FlatList, Image, StyleSheet, Text, TouchableNativeFeedback, View } from 'react-native'
import { Card } from '../components/card';
import { useNavigation } from '@react-navigation/native';
import Hr from '../components/hr';
import VagaApi from '../api/vagas';
import HabilidadeApi from '../api/habilidades';
import CandidatoApi from '../api/candidatos';
import { Matching } from '../models/matching';
import { Jwt } from '../services/auth';
import { Vaga } from '../models/vaga';
import { Habilidade } from '../models/habilidade';
import { API_URL } from '../api/apisettings';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import LoadingScreen from '../components/loadingscreen';
import { toDate } from '../services/date';
const ImgEmpresaDefault = require('../assets/imgs/default-empresa.png');


export default function EMinhasVagas() {

    const [vagas, setVagas] = useState<Vaga[]>([]);
    const [habilidades, setHabilidades] = useState<Habilidade[]>([]);
    const [token, setToken] = useState<any>();
    // const [matches, setMatches] = useState<Matching[]>([])
    const [isLoading, setIsLoading] = useState<Boolean>(true)
    const [filtro, setFiltro] = useState(
        {
            titulo: "",
            minSalario: 0,
            idHabilidade: 0
        }
    );
    const navigation = useNavigation();

    useEffect(() => {
        Jwt().then(token => {
            Promise.all([
                VagaApi.listarPorEmpresa(token.jti).then(data => setVagas(data)),
                HabilidadeApi.listar().then(data => setHabilidades(data))
            ])
            .then(() => setIsLoading(false))
        })
    }, [])

    function filtrarVagas() {
        VagaApi.listarPorFiltro(filtro.titulo, filtro.minSalario, filtro.idHabilidade)
            .then(data => setVagas(data))
    }

    if (isLoading) {
        return <LoadingScreen/>
    }

    return (
        <View style={tailwind("m-2")}>
            <FlatList
                data={vagas}
                keyExtractor={item => item.idVaga!.toString()}
                ListHeaderComponent={(<Text style={tailwind("text-center text-xl mt-4 mb-6")}>Minhas Vagas</Text>)}
                renderItem={({ item }) => (
                    <TouchableNativeFeedback onPress={() => {
                        navigation.navigate("Candidaturas", {
                            idVaga: item.idVaga
                        })
                    }} style={tailwind("flex w-full border-0")}>
                        <Card style={tailwind("mb-2")}>
                            {/* Conteudo de cima */}
                            <View style={tailwind("flex-row")}>
                                <Image source={{ uri: `${API_URL}Empresa/Img/${item.idEmpresa}` }}
                                    style={{ width: 30, height: 30 }} />
                                <Text style={tailwind("ml-5")}> {item.titulo}</Text>
                            </View>
                            <Hr style={tailwind("my-2")} />
                            {/* Conteudo debaixo */}
                            <View style={tailwind("flex-row")}>
                                <View style={tailwind("w-1/2 mr-3")}>
                                    <View style={tailwind("flex-row")}>
                                        <MaterialCommunityIcons name="currency-usd" size={18}></MaterialCommunityIcons>
                                        <Text> R$ {item.salario}</Text>
                                    </View>
                                    <View style={tailwind("flex-row")}>
                                        <MaterialCommunityIcons name="map-marker-outline" size={18}></MaterialCommunityIcons>
                                        <Text> {item.idEnderecoNavigation?.localCompleto}</Text>
                                    </View>
                                    <View style={tailwind("flex-row")}>
                                        <MaterialCommunityIcons name="clock-outline" size={18}></MaterialCommunityIcons>
                                        <Text> Expira em {toDate(new Date(item.dataExpiracao!))}</Text>
                                    </View>
                                </View>

                                <View style={tailwind("w-1/2 flex-row flex-wrap px-3 ")}>
                                    {item.habilidadeVaga?.map(hv => {
                                        return (
                                            <Text
                                                style={tailwind("bg-gray-400 p-2 rounded-full m-1 h-8")}
                                                ellipsizeMode='tail'
                                                numberOfLines={1}
                                                key={hv.idHabilidadeVaga?.toString()}>
                                                {habilidades.find((h: Habilidade) =>
                                                    h.idHabilidade == hv.idHabilidade)?.nomeHabilidade}
                                            </Text>
                                        )
                                    })}
                                </View>
                            </View>
                        </Card>
                    </TouchableNativeFeedback>
                )}
            >
            </FlatList>
        </View>
    )
}

const styles = StyleSheet.create({})
