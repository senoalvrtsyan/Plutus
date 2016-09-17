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
import Dialog from 'material-ui/Dialog';
import RaisedButton from 'material-ui/RaisedButton';
import Avatar from 'material-ui/Avatar';
import TextField from 'material-ui/TextField';
import Paper from 'material-ui/Paper';
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
              actions={[
                  <RaisedButton
                    label="Cancel"
                    secondary={true}
                    onTouchTap={this.handleClose}
                  />,
                  <RaisedButton
                    label="Request"
                    primary={true}
                    style={{}}
                    onTouchTap={this.handleClose}
                  />,
              ]}
              autoScrollBodyContent={false}
              modal={true}
              open={true}
              onRequestClose={this.handleClose}
          >

                <Paper zDepth={0} rounded = {false} style = {{marginLeft : 30, marginRight : 30,}}>
                      <br />

                      <Avatar
                          src='http://lylesmoviefiles.com/wp-content/uploads/2015/06/emily-ratajkowski-no-bra.jpg'
                          size={100}
                          backgroundColor='rgba(0,0,0,0)'
                          style={{border: 0, marginLeft : 300,}}
                        />
                        <br />

                        <h3 style = {{marginLeft : 250,}}>Emily Ratajkowski</h3>
                        <h4 style = {{marginLeft : 318,}}>@emulik</h4> <br />

                      <TextField
                          hintText="AMD"
                          floatingLabelText="Amount you want to request"
                          floatingLabelFixed={true}
                          style = {{marginLeft : 235,}} />
                      <br />
                      <TextField
                          hintText="Notes/Comments (Optional)"
                          style = {{marginLeft : 235,}} />
                      <br />
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
