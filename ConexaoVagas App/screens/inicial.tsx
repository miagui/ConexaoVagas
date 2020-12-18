import React, { Component, useEffect } from 'react'
import { Text, StyleSheet, View, Image, ImageBackground, Button, ActivityIndicator } from 'react-native'
import tailwind from 'tailwind-rn';
import { useNavigation } from '@react-navigation/native';
import { usuarioAutenticado } from '../services/auth';
import { Color } from '../styles/global';
import LoadingScreen from '../components/loadingscreen';


export default function Inicial() {
    const navigation = useNavigation();

    useEffect(() => {
        usuarioAutenticado().then(logado => {
            if (logado) {
                navigation.navigate("Master");
            }
        })
    }, [])

    usuarioAutenticado().then(logado => {
        if (logado) {
            return <LoadingScreen/>
        }
    })

    return (
        <View style={styles.body}>
            <ImageBackground source={require('../assets/imgs/imagem.jpg')} style={styles.background}>
                <Image source={require('../assets/imgs/logo-dark.png')} style={styles.Logo}></Image>
                <View style={tailwind("text-center text-xl mt-4 mb-6")}>
                    <Text style={styles.jumbotronText}>Sua conexão</Text>
                    <Text style={styles.jumbotronText}>com as empresas</Text>
                    <Text style={styles.jumbotronText}>começam agora</Text>
                    <View style={styles.Vbotao}>
                        <Button
                            title='Login'
                            onPress={() => navigation.navigate("Login")}
                            color='#CD322B'
                        />

                    </View>
                    {/* <Image source={require('../assets/imgs/logo-senai-principal.png')} style={styles.Senai}></Image> */}
                </View>
            </ImageBackground>
            {/* <ImageBackground source={ {uri:'../assets/imgs/imagem.jpg'}}style={styles.image}></ImageBackground> */}
        </View>
    )
}


let styles = StyleSheet.create({
    background: {
        flex: 1,
        resizeMode: "cover",
        justifyContent: "center"
    },
    // flex: 1 já cobre a tela inteira, não precisa de width ou height;
    body: {
        flex: 1,
        flexDirection: "column"
    },
    Logo: {
        height: '30%',
        maxHeight: 1000,
        width: '100%',
        marginHorizontal: 10,
        alignSelf: 'center'
    },
    jumbotronText: {
        color: "#fff",
        fontSize: 42,
        fontWeight: "bold",
        textAlign: "center"
    },
    Vbotao: {
        width: '30%',
        height: 30,
        alignSelf: 'center',
        marginTop: '25%'
    },
    botao: {
        color: '#000'
    },

    // Senai:{
    //     marginTop:20,
    //     marginLeft: '50%',
    //     width: '45%',
    //     height: 50
    // }
    //     Textoum: {
    //     position: 'absolute',
    //     color: 'white',
    //     fontSize: '2rem',
    //     top: '40%',
    //     left: '30%'
    // },
    //     Textodois: {
    //     position: 'absolute',
    //     color: 'white',
    //     fontSize: '2rem',
    //     top: '45%',
    //     left: '27%'
    // },
    //     Textotres: {
    //     position: 'absolute',
    //     color: 'white',
    //     fontSize: '2rem',
    //     top: '50%',
    //     left: '27%'
    // }
})
