import React from 'react'
import { ActivityIndicator, StyleSheet, Text, View } from 'react-native'
import tailwind from 'tailwind-rn'
import { Color } from '../../styles/global'

export default function LoadingScreen() {
    return (
        <View style={tailwind("flex-1 justify-center items-center")}>
            <ActivityIndicator size="large" color={Color.PRIMARY} />
        </View>
    )
}

