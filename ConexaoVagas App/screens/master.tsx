import AsyncStorage from '@react-native-async-storage/async-storage';
import { createDrawerNavigator, DrawerView, DrawerItemList, DrawerContentComponentProps, DrawerContentOptions } from '@react-navigation/drawer';
import { createStackNavigator } from '@react-navigation/stack';
import React, { useEffect, useState } from 'react'
import { StyleSheet, Switch, Text, View, Image, ActivityIndicator } from 'react-native'
import tailwind from 'tailwind-rn';
import { Jwt } from '../services/auth';
import { Color } from '../styles/global';
import { TipoUsuario } from '../utils/enums';
import { CHome } from './c-home';
import EHome from './e-home';
import Vagas from './c-vagas';
import { AppLoading } from 'expo';
import { color } from 'react-native-reanimated';
import EVagaCandidaturas from './e-vaga-candidaturas';
import { TouchableNativeFeedback } from 'react-native-gesture-handler';
import { TOKEN_KEY } from '../api/apisettings';
import { useNavigation } from '@react-navigation/native';
import LoadingScreen from '../components/loadingscreen';

const Drawer = createDrawerNavigator();
const Stack = createStackNavigator();

export default function Master() {
    const [token, setToken] = useState<any>();
    const [isLoading, setIsLoading] = useState<Boolean>(true)
    
    const hiddenScreens = ["Candidaturas"];
    const navigation = useNavigation();

    useEffect(() => {
        Jwt().then(token => {
            setToken(token);
            setIsLoading(false);
        })
    }, [])

    const filteredScreens = (props: DrawerContentComponentProps<DrawerContentOptions>) => {
        let filteredProps: DrawerContentComponentProps<DrawerContentOptions> = Object.assign({
            ...props,
            state: {
                ...props.state,
                routes: props.state.routes.filter(p => {
                    if (!hiddenScreens.includes(p.name))
                        return p;
                })
            }
        })
        return filteredProps;
    }

    function logoff() {
        AsyncStorage.removeItem(TOKEN_KEY).then(() => navigation.navigate("Inicial"))
    }

    if (isLoading) {
        return <LoadingScreen/>
    }

    return (
        <Drawer.Navigator
            drawerStyle={{ backgroundColor: Color.SECONDARY }}
            drawerContent={(props) => (
                <View style={tailwind("flex flex-1 justify-between")}>
                    {/* Parte de cima */}
                    <View>
                        <Image style={tailwind("w-full h-32")}
                                source={require('../assets/imgs/logo-dark.png')}></Image>
                        <DrawerItemList {...filteredScreens(props)} />
                        <TouchableNativeFeedback style={tailwind("flex-row justify-between mx-5")}
                                                onPress={() => logoff()}>
                            <Text style={{color: '#888888'}}>Logoff</Text>
                        </TouchableNativeFeedback>
                    </View>
                    {/* Footer */}
                    {/* É necessario encapsular dentro de uma View para manter o ratio. */}
                    <View style={tailwind("m-5")}>
                        <Image style={{
                            width: 200,
                            height: 50,
                            resizeMode: 'contain',
                            alignSelf: "center"
                        }}
                            source={require('../assets/imgs/logo-senai-principal.png')} />
                    </View>
                </View>
            )}
            drawerContentOptions={{
                inactiveTintColor: "#888888",
                activeTintColor: "#FFF",
                activeBackgroundColor: "",
            }}>
            {token?.Role == TipoUsuario.CANDIDATO && (
                <Drawer.Screen name="Home" component={CHome} />
            )}
            {token?.Role == TipoUsuario.EMPRESA && (
                <Drawer.Screen name="Home" component={EHome} />
            )}

        </Drawer.Navigator>
    )
}

const styles = StyleSheet.create({})
