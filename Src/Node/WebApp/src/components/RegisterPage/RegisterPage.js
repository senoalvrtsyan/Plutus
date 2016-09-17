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
import {Dialog, RaisedButton, Avatar, TextField, Paper} from 'material-ui';
import {green500} from 'material-ui/styles/colors';

const title = 'New User Registration';

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
      <MuiThemeProvider>
          <div>
              <Dialog
              title="Request payment"
              titleStyle={{textAlign : 'center', color : '#616161', fontWeight : 'bold'}}
              actions={[
                  <RaisedButton
                    label="Cancel"
                    backgroundColor = {'EF5350'}
                    onTouchTap={this.handleClose}
                  />,
                  <RaisedButton
                    label="Request"
                    primary={false}
                    backgroundColor={'#2ecc71'}
                    labelColor = {'#FFFFFF'}
                    style={{backgroundColor : green500,}}
                    onTouchTap={this.handleClose}
                  />,
              ]}
              autoScrollBodyContent={false}
              modal={true}
              open={true}
              onRequestClose={this.handleClose}
          >

                <Paper zDepth={0} rounded = {false} style = {{marginLeft : 30, marginRight : 30,}}>
                      

                      <Avatar
                          src='http://lylesmoviefiles.com/wp-content/uploads/2015/06/emily-ratajkowski-no-bra.jpg'
                          size={100}
                          backgroundColor='rgba(0,0,0,0)'
                          style={{border: 0, marginLeft : '43%'}}
                        />
                        <br />

                        <h4 style = {{textAlign : 'center', color : green500,}}>Emily Ratajkowski</h4>
                        <h5 style = {{textAlign : 'center', color : green500,}}>@emulik</h5> 

                      <TextField
                          hintText="AMD"
                          floatingLabelText="Amount you want to request"
                          floatingLabelFocusStyle = {{color : green500,}}
                          underlineFocusStyle = {{borderColor : green500,}}
                          floatingLabelFixed={false}
                          style = {{marginLeft : 235,}} />
                      <br />
                      <TextField
                          hintText="Notes/Comments (Optional)"
                          style = {{marginLeft : 235,}}
                          underlineFocusStyle = {{borderColor : green500,}}/>
                      <br />
                </Paper>
            </Dialog>
        </div>
      </MuiThemeProvider>
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
