import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Image,
  Modal,
  Dimensions,
  Keyboard
} from 'react-native';
import Header from './Header'
import { Form, Item, Input, Button, Icon } from 'native-base'
import { Col, Row, Grid } from 'react-native-easy-grid';
import Analytics from 'appcenter-analytics';

const {height, width} = Dimensions.get('window');

export class MainDashboard extends Component {
    constructor(props) {
        super(props);

        const {width, height} = Dimensions.get('window')

        this.state = {
            errorTextOpacity: 0,
            watts:"",
            amperage:"",
            resitance:"",
            volts:"",
            modalVisible:false
        }
    }

    _preformCalculation = () => {

        Analytics.trackEvent("Calculation preformed.", {});

        Keyboard.dismiss()

        if(this.state.resitance === "" || this.state.volts === "") {
            this.setState({
                errorTextOpacity:100
            })
            return;
        }

        var resitance = Number.parseFloat(this.state.resitance)
        var volts = Number.parseFloat(this.state.volts)

        var amperageResult = volts / resitance;

        this.setState({
            amperage: volts / resitance,
            watts: amperageResult * volts,
            errorTextOpacity:0
        })
    }

    clear = () => {
        this.setState({
            watts:"",
            amperage:"",
            resitance:"",
            volts:""
        })
    }

    openModal = () => {
        Analytics.trackEvent("Disclaimer opened", {});
        this.setState({modalVisible:true});
      }
    
      closeModal = () => {
        Analytics.trackEvent("Disclaimer agreed to.", {});
        this.setState({modalVisible:false});
      }

    render() {

        if(this.state.modalVisible) {
            return(
                <View style={styles.modalView}>
                <Modal
                    visible={this.state.modalVisible}
                    animationType={'fade'}
                    onRequestClose={() => this.closeModal()}
                >
                <Text style={styles.disclaimerText}>
                This Application provides calculations using Ohm's Law.
                The creator takes no responsibility or liability for calculations this app provides.
                </Text>
                <Button onPress={() => this.closeModal()} small style={styles.submitBtn} rounded><Text style={styles.loginBtnText}>I Agree</Text></Button>
                </Modal>
             </View>
            )
        }

        else {
            return (
                <View style={styles.container}>
                    <Header />
                    <Image style={styles.logo} source={require("../assets/ohmlogo.png")} />
                    <Text style={styles.gettingstarted}>Get started, enter your resitance and wattage.</Text>
                    <Text onPress={this.openModal} style={styles.disclaimer}>Disclaimer</Text>

                    <Text style={styles.ohmsLawText}>Ohm's Law: stating that electric current is proportional to voltage and inversely proportional to resistance.</Text>
      
                    <Form style={styles.formLocation}>
                    <Text style={{opacity:this.state.errorTextOpacity, paddingLeft:10, color:"red"}}>Please ensure you enter a value for both fields.</Text>
                          <Item rounded>
                              <Icon name="pulse" />
                              <Input returnKeyType="next" keyboardType="numeric" onChangeText={(resitance) => this.setState({resitance})} value={this.state.resitance} placeholder="Resitance eg. 0.2" />
                          </Item>
                          <Item style={styles.inputStyle} rounded>
                              <Icon name="bulb" />
                              <Input returnKeyType="go" keyboardType="numeric" onChangeText={(volts) => this.setState({volts})} value={this.state.volts} placeholder="Volts eg. 4.2" />
                          </Item>
                          <Button small style={styles.submitBtn} onPress={this._preformCalculation}  rounded><Text style={styles.loginBtnText}>Calculate</Text></Button>
                          <Button small style={styles.submitBtn} onPress={this.clear}  rounded><Text style={styles.loginBtnText}>Reset</Text></Button>
                      </Form>

                    <View style={styles.gridStyle}>
                      <Grid>
                          <Row style={styles.rowStyle} size={1}>
                            <Col>
                                <Text style={styles.colTextStyle}>Wattage</Text>
                                <Text style={styles.resultsStyle}>{this.state.watts}</Text>
                            </Col>
                            <Col>
                                <Text style={styles.colTextStyle}>Amperage</Text>
                                <Text style={styles.resultsStyle}>{this.state.amperage}</Text>
                            </Col>
                          </Row>
                      </Grid>
                    </View>
                </View>
              );
            }
        }
}

const styles = StyleSheet.create({
    container: {
        height: height,
        width: width
    },
    ohmsLawText: {
        marginTop:"5%",
        alignItems:"center",
        fontStyle:"italic",
        textAlign:"center"
    },
    mainView: {
        backgroundColor: "#FFF"
    },
    disclaimerText: {
        fontWeight:"bold",
        fontSize:18,
        alignItems:"center",
        textAlign:"center",
        marginTop:"60%",
        marginBottom:"15%"
    },
    disclaimer: {
        alignSelf:"center",
        fontWeight:"bold",
        color:"blue",
        fontStyle:"italic"
    },
    colTextStyle: {
        alignSelf:"center",
        color:"#FFF",
        justifyContent: 'center',
        fontWeight:"bold",
        fontSize:15
    },
    resultsStyle:{
        alignSelf:"center",
        color:"#FFF",
        justifyContent: 'center',
        marginTop:30,
        fontWeight:"bold",
        fontSize:22
    },
    rowStyle: {
        backgroundColor:"#013243"
    },
    gridStyle: {
        flex: 1
    },
    formLocation: {
        flex:2
    },
    loginBtnText: {
      color:"#FFF"  
    },
    submitBtn: {
        alignSelf:"center",
        padding:100,
        marginTop:"2%",
        backgroundColor:"#013243"
    },
    inputStyle: {
       marginTop:5

    },
    logo: {
        alignSelf:"center",
        width:100,
        height:100
    },
    gettingstarted: {
        marginTop:10,
        alignSelf:"center",
        fontWeight:"bold"
    }
})

export default MainDashboard;