import React, {Component} from 'react';
import {
    StyleSheet,
    Text,
    View
  } from 'react-native';
  import { Col, Row, Grid } from 'react-native-easy-grid';

export class GridComponent extends Component {

    constructor(props) {
        super(props)
    }

    render() {
        return(
            <View style={styles.gridContainer}>
                <Grid>
                    <Row size={25}>
                    </Row>
                    <Row size={25}>
                    </Row>
                </Grid>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    gridContainer: {
        flex:1
    }
})

export default GridComponent