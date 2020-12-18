import { createMaterialTopTabNavigator } from '@react-navigation/material-top-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import React from 'react';
import { Color } from '../styles/global';
import { MaterialIcons } from '@expo/vector-icons';
import CInscricoes from './c-incricoes';
import CVagas from './c-vagas';
import { View, Text } from 'react-native';
import tailwind from 'tailwind-rn';
import VagaDetalhes from './vaga-detalhes';

const Tab = createMaterialTopTabNavigator();
const Stack = createStackNavigator();

function TabbedScreen() {
    return (
        <Tab.Navigator
            tabBarOptions={{
                style: { backgroundColor: Color.SECONDARY },
                activeTintColor: "#FFFFFF",
                inactiveTintColor: "#888888",
            }}>
            <Tab.Screen name="Vagas" component={CVagas} />
            <Tab.Screen name="Inscrições" component={CInscricoes} />
        </Tab.Navigator>
    )
}

export function CHome({navigation}: any) {
    return (
        <Stack.Navigator>
            <Stack.Screen
                name="Home"
                component={TabbedScreen}
                options={{
                    headerStyle: { backgroundColor: Color.SECONDARY },
                    headerTintColor: Color.TINT,
                    headerTitleStyle: { fontFamily: "Roboto" },
                    headerLeft: () => (
                        <MaterialIcons name="menu" color="#FFF" size={32} 
                                       style={tailwind("ml-2")}
                                       onPress={() => navigation.openDrawer()}/>
                    )
                }}
            />
            <Stack.Screen
                name="Detalhes"
                component={VagaDetalhes}
                options={{
                    headerStyle: { backgroundColor: Color.SECONDARY },
                    headerTintColor: Color.TINT,
                    headerTitleStyle: { fontFamily: "Roboto" },
            }} />
        </Stack.Navigator>
    )
}
