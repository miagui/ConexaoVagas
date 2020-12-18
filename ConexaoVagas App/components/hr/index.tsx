import React from 'react'
import { StyleSheet, Text, View } from 'react-native'

export default function Hr(props: any) {
    return (
        <View style={[styles.ruler, props.style]}>
        </View>
    )
}

const styles = StyleSheet.create({
    ruler: {
        borderBottomColor: '#CECECE',
        borderBottomWidth: 1
    }
})
