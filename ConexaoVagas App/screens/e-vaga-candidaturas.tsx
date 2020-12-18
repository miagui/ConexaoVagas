import React, { useEffect, useState } from 'react'
import { FlatList, StyleSheet, Text, View, Image, ActivityIndicator } from 'react-native'
import tailwind from 'tailwind-rn'
import VagaApi from '../api/vagas';
import CandidaturaApi from '../api/candidatura';
import { Vaga } from '../models/vaga';
import { Candidatura } from '../models/candidatura';
import { Card } from '../components/card';
import { API_URL } from '../api/apisettings';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import Hr from '../components/hr';
import { Color } from '../styles/global';
import { TouchableNativeFeedback } from 'react-native-gesture-handler';
import { useNavigation } from '@react-navigation/native';

export default function EVagaCandidaturas({ route, navigate }: any) {
    const { idVaga } = route.params;

    const [vaga, setVaga] = useState<Vaga>(new Vaga());
    const [candidaturas, setCandidaturas] = useState<Candidatura[]>([]);
    const [isLoading, setIsLoading] = useState<Boolean>(true)

    const navigation = useNavigation();

    useEffect(() => {
        Promise.all([
            VagaApi.buscarPorId(idVaga).then(data => setVaga(data)),
            CandidaturaApi.listarPorVaga(idVaga).then(data => setCandidaturas(data))
        ])
            .then(() => setIsLoading(false))
    }, [])

    if (isLoading) {
        return (
            <View style={tailwind("flex-1 justify-center items-center")}>
                <ActivityIndicator size="large" color={Color.PRIMARY} />
            </View>
        )
    }

    return (
        <View style={tailwind("m-2")}>
            <FlatList
                data={candidaturas}
                contentContainerStyle={{ flexGrow: 1 }}
                keyExtractor={item => item.idCandidatura!.toString()}
                ListHeaderComponent={
                    <View style={tailwind("mt-4 mb-6")}>
                        <Text style={tailwind("text-center text-xl")}>{vaga.titulo}</Text>
                        <Text style={tailwind("text-center text-xs")}>{vaga.idEmpresaNavigation?.nomeFantasia}</Text>
                    </View>
                }
                ListEmptyComponent={
                    <Text style={{ marginTop: '50%', alignSelf: 'center' }}>Nenhuma candidatura nessa vaga.</Text>
                }
                renderItem={({ item }) => (
                    <TouchableNativeFeedback onPress={() => {
                        console.log(`${API_URL}Candidato/Img/${item.idCandidato}`)
                        navigation.navigate("Detalhes do Candidato", {
                            id: item.idCandidato
                        })
                    }} style={tailwind("flex w-full border-0")}>
                        <Card style={tailwind("mb-2")}>
                            {/* Conteudo de cima */}
                            <View style={tailwind("flex-row")}>
                                <Image source={{ uri: `${API_URL}Candidato/Img/${item.idCandidato}` }}
                                    style={{ width: 30, height: 30 }} 
                                />
                                <Text style={tailwind("ml-5")}> {`${item.idCandidatoNavigation?.nome} ${item.idCandidatoNavigation?.sobrenome || ''}`}</Text>
                            </View>
                            <Hr style={tailwind("my-2")} />
                            {/* Conteudo debaixo */}
                            <View style={tailwind("flex-row")}>
                                <View style={tailwind("mr-3")}>
                                    <View style={tailwind("flex-row")}>
                                        <MaterialCommunityIcons name="school" size={18}></MaterialCommunityIcons>
                                        <Text> {item.idCandidatoNavigation?.curso}</Text>
                                    </View>
                                    <View style={tailwind("flex-row")}>
                                        <MaterialCommunityIcons name="map-marker-outline" size={18}></MaterialCommunityIcons>
                                        <Text> {item.idCandidatoNavigation?.idEnderecoNavigation?.localCompleto}</Text>
                                    </View>
                                </View>
                            </View>
                        </Card>
                    </TouchableNativeFeedback>

                )} />
        </View>
    )
}

const styles = StyleSheet.create({})
