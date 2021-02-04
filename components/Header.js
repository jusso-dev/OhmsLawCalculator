import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  StatusBar
} from 'react-native';

export class Header extends Component {
    constructor(props) {
        super(props)
    }
    
    render() {
        return (
          <View style={styles.header}>
           <StatusBar barStyle="light-content" />
            <Text style={styles.text}>Ohm's Law</Text>
          </View>
        );
      }
}

const styles = StyleSheet.create({
    header: {
        paddingTop:25,
        backgroundColor:"#013243"
    },
    text: {
        color:"#FFF",
        alignSelf:"center",
        paddingBottom:20,
        fontWeight:"bold",
        fontSize:18
    }
})

export default Header