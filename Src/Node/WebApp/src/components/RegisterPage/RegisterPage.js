/**
 * React Starter Kit (https://www.reactstarterkit.com/)
 *
 * Copyright © 2014-2016 Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import React, { Component, PropTypes } from 'react';
import withStyles from 'isomorphic-style-loader/lib/withStyles';
import s from './RegisterPage.scss';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import {Dialog, RaisedButton, Avatar, TextField, Paper, Checkbox} from 'material-ui';
import {green500} from 'material-ui/styles/colors';

const title = 'New User Registration';


const style = {
  marginTop: 20,
  padding: '0 12px',
};

class RequestDialog extends Component {

  state = {
    open: false,
  };

  handleOpen = () => {
    this.setState({open: true});
  };

  handleClose = () => {
    this.setState({open: false});
  };

  render() {
    return (
        <div>
            <h3 style = {{textAlign : 'center', color : '#616161', fontWeight : 'bold'}}>Please sign up</h3>
            <Paper zDepth={2} style={style}>
                <TextField 
                    floatingLabelText="Company name"
                    type="text"
                    underlineShow={true}
                    fullWidth={true}
                />
                <TextField 
                    floatingLabelText="Email address"
                    type="text"
                    underlineShow={true}
                    fullWidth={true}
                />
                <TextField 
                    floatingLabelText="Password"
                    type="text"
                    underlineShow={true}
                    fullWidth={true}
                />
                <TextField 
                    floatingLabelText="Confirm password"
                    type="text"
                    underlineShow={true}
                    fullWidth={true}
                />
                <br />
                <br />
                <Checkbox label="I have read and agree to the terms and conditions." />
                <RaisedButton
                    label="Sign up"
                    primary={true}
                    fullWidth={true}
                />,
            </Paper>
       
       
        
        
        
        
        
            <Dialog
              title="Request payment"
              titleStyle={{textAlign : 'center', color : '#616161', fontWeight : 'bold'}}
              actions={[
                  <RaisedButton
                    label="Cancel"
                    onTouchTap={this.handleClose}
                  />,
                  <RaisedButton
                    label="Request"
                    primary={true}
                    labelColor = {'#FFFFFF'}
                    onTouchTap={this.handleClose}
                  />,
              ]}
              actionsContainerStyle = {{ alignItems: 'center',}}
              autoScrollBodyContent={false}
              modal={true}
              open={false}
              onRequestClose={this.handleClose}
              >

                <Paper zDepth={0} rounded = {false} style = {{marginLeft : 30, marginRight : 30,}}>
                      <Avatar
                          src='http://lylesmoviefiles.com/wp-content/uploads/2015/06/emily-ratajkowski-no-bra.jpg'
                          size={100}
                          style={{border: 0, marginLeft : '43%'}}
                        />
                        <br />

                        <h4 style = {{textAlign : 'center', color : green500,}}>Emily Ratajkowski</h4>
                        <h5 style = {{textAlign : 'center', color : green500,}}>@emulik</h5> 

                      <TextField
                          hintText="AMD"
                          floatingLabelText="Amount you want to request"
                          floatingLabelFixed={false}
                          style = {{marginLeft : 235,}} />
                      <br />
                      <TextField
                          hintText="Notes/Comments (Optional)"
                          style = {{marginLeft : 235,}}/>
                      <br />
                </Paper>
            </Dialog>
        
        
        
        
        </div>
    );
  }
}


class RegisterPage extends Component {

  static contextTypes = {
    onSetTitle: PropTypes.func.isRequired,
  };

  componentWillMount() {
    this.context.onSetTitle(title);
  }

  render() {
    return (
      <div className={s.root}>
        <div className={s.container}>
         <RequestDialog />
        </div>
      </div>
    );
  }

}

export default withStyles(RegisterPage, s);
