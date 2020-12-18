import { createDrawerNavigator } from '@react-navigation/drawer';
import React from 'react'
import { StyleSheet, Text, View } from 'react-native'
import { Color } from '../styles/global';
import { Home } from './home';
import Inicial from './inicial';
import Login from './login';

const Drawer = createDrawerNavigator();

export default function Master() {
    return (
        <Drawer.Navigator
            drawerStyle={{
                backgroundColor: Color.SECONDARY
            }}>
            <Drawer.Screen name="Home" component={Home} />
            <Drawer.Screen name="Login" component={Login} />
            <Drawer.Screen name="Inicial" component={Inicial} />
            
        </Drawer.Navigator>
    )
}

const styles = StyleSheet.create({})
