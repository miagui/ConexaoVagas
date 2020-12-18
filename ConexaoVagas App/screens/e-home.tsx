import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { MaterialIcons } from '@expo/vector-icons';
import { Color } from '../styles/global';
import tailwind from 'tailwind-rn';
import EMinhasVagas from './e-minhas-vagas';
import EVagaCandidaturas from './e-vaga-candidaturas';
import CandidatoPublico from './candidato-publico';

const Tab = createMaterialTopTabNavigator();
const Stack = createStackNavigator();

// Inutilizado
function TabbedScreen() {
    return (
        <Tab.Navigator
            tabBarOptions={{
                style: { backgroundColor: Color.SECONDARY },
                activeTintColor: "#FFFFFF",
                inactiveTintColor: "#888888",
            }}>
            <Tab.Screen name="Minhas Vagas" component={EMinhasVagas} />
        </Tab.Navigator>
    )
}

export default function EHome({ navigation }: any) {
    return (
        <Stack.Navigator>
            <Stack.Screen
                name="Home"
                component={EMinhasVagas}
                options={{
                    headerStyle: { backgroundColor: Color.SECONDARY },
                    headerTintColor: Color.TINT,
                    headerTitleStyle: { fontFamily: "Roboto" },
                    headerLeft: () => (
                        <MaterialIcons name="menu" color="#FFF" size={32}
                            style={tailwind("ml-2")}
                            onPress={() => navigation.openDrawer()} />
                    )
                }}
            />
            <Stack.Screen
                name="Candidaturas"
                component={EVagaCandidaturas}
                options={{
                    headerStyle: { backgroundColor: Color.SECONDARY },
                    headerTintColor: Color.TINT,
                    headerTitleStyle: { fontFamily: "Roboto" },
                }}
            />
            <Stack.Screen
                name="Detalhes do Candidato"
                component={CandidatoPublico}
                options={{
                    headerStyle: { backgroundColor: Color.SECONDARY },
                    headerTintColor: Color.TINT,
                    headerTitleStyle: { fontFamily: "Roboto" },
                }}
            />

        </Stack.Navigator>
    )
}

