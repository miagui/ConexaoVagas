import React, { FunctionComponent, ReactElement } from 'react'
import { StyleSheet, Text, View, ViewProps } from 'react-native'

export const Card: FunctionComponent<ViewProps> = (props) =>  {
    return (
        <View {...props} style={[styles.card, props.style]}>
            {props.children}
        </View>
    )
}

const styles = StyleSheet.create({
    card: {
        borderRadius: 5,
        backgroundColor: '#FFFFFF',
        padding: 10,
        shadowColor: "rgba(0,0,0,0.1)",
        shadowOffset: {
            width: 0,
            height: 2,
        },
        shadowOpacity: 0.25,
        shadowRadius: 5,
        fontFamily: 'Robot'

    }
})
