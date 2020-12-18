import { DarkTheme, NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import React from 'react';
import { StatusBar, StyleSheet, Text, View } from 'react-native';
import { CHome } from './screens/c-home';
import {
  setCustomView,
  setCustomTextInput,
  setCustomText,
  setCustomImage,
  setCustomTouchableOpacity
} from 'react-native-global-props';
import { Color } from './styles/global';
import Master from './screens/master';
import Login from './screens/login';
import Inicial from './screens/inicial';
import { useFonts } from 'expo-font';
import { AppLoading } from 'expo';
import { MaterialCommunityIcons } from '@expo/vector-icons'
import VagaDetalhes from './screens/vaga-detalhes';
import EHome from './screens/e-home';
const Stack = createStackNavigator();

export default function App() {

  const fontLoaded = useFonts(MaterialCommunityIcons.font)

  if (!fontLoaded) {
    return (<AppLoading />)
  }

  return (
    <NavigationContainer theme={CvTheme}>
      <StatusBar barStyle="light-content" />
      <Stack.Navigator>
        <Stack.Screen
          name="Inicial"
          component={Inicial}
          options={{
            headerStyle: { backgroundColor: Color.SECONDARY },
            headerTintColor: Color.TINT,
            headerTitleStyle: { fontFamily: "Roboto" },
            headerShown: false
          }}
        />
        <Stack.Screen
          name="Login"
          component={Login}
          options={{
            headerStyle: { backgroundColor: Color.SECONDARY },
            headerTintColor: Color.TINT,
            headerTitleStyle: { fontFamily: "Roboto" },
            headerShown: false
          }} />
        <Stack.Screen
          name="Master"
          component={Master}
          options={{
            headerStyle: { backgroundColor: Color.SECONDARY },
            headerTintColor: Color.TINT,
            headerTitleStyle: { fontFamily: "Roboto" },
            headerShown: false,
          }}
        />

      </Stack.Navigator>
    </NavigationContainer>
  );
}

const CvTheme = {
  dark: true,
  colors: {
    primary: Color.PRIMARY,
    background: Color.BACKGROUND,
    card: "#FFFFFF",
    text: "#000000",
    border: "",
    notification: Color.SECONDARY
  }
}

setCustomText({
  style: {
    fontFamily: "Roboto"
  }
})
