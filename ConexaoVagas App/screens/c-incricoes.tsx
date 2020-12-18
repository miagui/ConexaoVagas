import React, { useEffect, useState } from 'react'
import { FlatList, Image, StyleSheet, Text, View } from 'react-native'
import { Card } from '../components/card';
import tailwind from 'tailwind-rn'
import CandidatoApi from '../api/candidatos';
import { Candidato } from '../models/candidato';
import { Jwt } from '../services/auth';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import Hr from '../components/hr';
import { API_URL } from '../api/apisettings';
import LoadingScreen from '../components/loadingscreen';
import { toDate } from '../services/date';

export default function CInscricoes() {

    const [candidato, setCandidato] = useState<Candidato>();
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
            // Jwt retorna uma promessa, então é necessario usar .then.
            Jwt().then(token => {
                CandidatoApi.buscarPorId(token.jti).then(data => setCandidato(data))
            })
            .then(() => setIsLoading(false))
    }, []);

    if (isLoading) {
        return <LoadingScreen/>
    }

    return (
        <View style={tailwind("m-2")}>
            <FlatList
                data={candidato?.candidatura}
                keyExtractor={item => item.idCandidatura!.toString()}
                ListHeaderComponent={(<Text style={tailwind("text-center text-xl mt-4 mb-6")}>Inscrições</Text>)}
                renderItem={({ item }) => (
                    <Card style={tailwind("mb-3")}>
                        {/* Conteudo de cima */}
                        <View style={tailwind("flex-row justify-between")}>
                            <View style={tailwind("flex-row")}>
                                <Image source={{ uri: `${API_URL}Empresa/Img/${item.idVagaNavigation?.idEmpresa}` }}
                                        style={{ width: 30, height: 30 }}/>
                                <Text style={tailwind("ml-5")}
                                    numberOfLines={1}> {item.idVagaNavigation?.titulo}</Text>
                            </View>

                            {item.visualizado ? 
                            (
                                <View >
                                    <MaterialCommunityIcons name="account-check-outline" size={24}
                                                            style={tailwind("self-center text-green-600")}/>
                                    <Text style={tailwind("text-xs text-green-600")}>Visualizado</Text>
                                </View>
                            ) : (
                                <View>
                                    <MaterialCommunityIcons name="account-clock-outline" size={24}
                                                            style={tailwind("self-center")}/>
                                    <Text style={tailwind("text-xs text-gray-600")}>Pendente</Text>
                                </View>
                            )}
                            
                            
                        </View>
                        <Hr style={tailwind("my-2")} />
                        {/* Conteudo debaixo */}
                        <View style={tailwind("flex-row")}>
                            <View style={tailwind("w-1/2 mr-3")}>
                                <View style={tailwind("flex-row")}>
                                    <MaterialCommunityIcons name="currency-usd" size={18}></MaterialCommunityIcons>
                                    <Text> R$ {item.idVagaNavigation?.salario}</Text>
                                </View>
                                <View style={tailwind("flex-row")}>
                                    <MaterialCommunityIcons name="map-marker-outline" size={18}></MaterialCommunityIcons>
                                    <Text> {item.idVagaNavigation?.idEnderecoNavigation?.localCompleto}</Text>
                                </View>
                                <View style={tailwind("flex-row")}>
                                    <MaterialCommunityIcons name="clock-outline" size={18}></MaterialCommunityIcons>
                                    <Text> Inscrito em {toDate(new Date(item.dataCriado!))}</Text>
                                </View>
                            </View>
                        </View>
                    </Card>
                )}
            >
            </FlatList>
        </View>
    )
}

const styles = StyleSheet.create({})
