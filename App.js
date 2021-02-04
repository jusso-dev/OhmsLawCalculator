import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';
import Header from './components/Header'
import MainDashboard from './components/MainDashboard'
import Crashes from 'appcenter-crashes'
import codePush from "react-native-code-push";

export default class App extends Component<{}> {

  componentDidMount() {
    Crashes.setEnabled(true)
  }

  render() {
    return (
      <View style={styles.container}>
       <MainDashboard />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {

  }
});

App = codePush(App);