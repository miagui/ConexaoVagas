import AsyncStorage from '@react-native-async-storage/async-storage';
import { useNavigation } from '@react-navigation/native';
import React, { useEffect, useState } from 'react'
import { ImageBackground, Image, StyleSheet, Text, TextInput, View, Button, Alert } from 'react-native'
import tailwind from 'tailwind-rn'
import { API_URL, TOKEN_KEY } from '../api/apisettings';
import { parseJwt } from '../services/auth';
import { TipoUsuario } from '../utils/enums';
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view'



export default function Login() {


    let navigation = useNavigation();

    const [validEmail, setvalidEmail] = useState(false);
    const [email, setEmail] = useState('');
    const [senha, setSenha] = useState('');

    useEffect(() => {
        isEmailValid();
    }, [email])

    function isEmailValid() {
        let pattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        setvalidEmail(pattern.test(String(email).toLowerCase())
        )
    }

    const fazerLogin = () => {
        const form = {
            email: email,
            senha: senha
        }

        fetch(API_URL + 'Login', {
            method: 'POST',
            body: JSON.stringify(form),
            headers: {
                'content-type': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) {
                    Alert.alert(
                        "Login",
                        "Email ou senha inválidos.",
                        [
                            { text: "OK" }
                        ],
                        { cancelable: false }
                    )
                }
                else return response.json()
            })
            .then(dados => {
                if (dados !== undefined) {
                    AsyncStorage.setItem(TOKEN_KEY, dados.token);
                    let jwt = parseJwt(dados.token);
                    navigation.navigate("Master");
                }
            })
            .catch(error => console.error(error))
    }

    return (
        // KeyboardAwareScrollView permite scroll al clicar em um input.
        <ImageBackground source={require('../assets/imgs/imagem.jpg')} style={styles.background}>
            <KeyboardAwareScrollView style={styles.body}>
                <Image source={require('../assets/imgs/logo-dark.png')} style={styles.logo as any} />
                <View>
                    <View style={styles.form}>
                        <View style={styles.inputField}>
                            <Text style={styles.inputTitle}>Digite seu email</Text>
                            <TextInput
                                style={tailwind('h-10 text-sm px-1')}
                                textContentType="emailAddress"
                                onChangeText={e => setEmail(e)} value={email}
                                placeholder="Insira seu email" />
                        </View>
                        <View style={styles.inputField}>
                            <Text style={styles.inputTitle}>Digite sua senha</Text>
                            <TextInput
                                style={tailwind('h-10 text-sm px-1')}
                                secureTextEntry={true}
                                onChangeText={e => setSenha(e)} value={senha}
                                placeholder="Insira sua senha" />
                        </View>
                        <View style={styles.buttonLogin}>
                            <Button
                                disabled={!validEmail || senha.length == 0}
                                title='Login'
                                color='#CD322B'
                                onPress={fazerLogin}
                            />
                        </View>
                    </View>
                </View>
            </KeyboardAwareScrollView>
        </ImageBackground>
    )
}

const styles = StyleSheet.create({

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
    logo: {
        height: 200,
        width: '100%',
        maxWidth: 500,
        marginHorizontal: 10,
        alignSelf: 'center'
    },
    input: {
        width: '80%',
        height: 40
    },
    form: {
        backgroundColor: 'white',
        width: '80%',
        alignSelf: 'center',
        padding: 20,
        borderRadius: 5,
        marginTop: '5%',
        marginBottom: '30%'

    },
    inputField: {
        marginBottom: '8%',
        borderBottomColor: '#000',
        borderBottomWidth: 1
        // textDecorationLine: "underline",
        // textDecorationStyle: "solid",
        // textDecorationColor: "#000",
    },
    inputTitle: {
        fontSize: 25,
        fontWeight: "700",
    },
    buttonLogin: {
        width: 100,
        alignSelf: 'center',
        marginTop: 20

    }
})
