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
import s from './LoginPage.scss';

import RaisedButton from 'material-ui/RaisedButton';
import Paper from 'material-ui/Paper';
import TextField from 'material-ui/TextField';
import Checkbox from 'material-ui/Checkbox';

const title = 'Log In';

const style = {
  marginTop: 20,
  padding: '0 12px',
};

class LoginForm extends Component {
  render() {
    return (
    <div>    
    <h3 style = {{textAlign : 'center', color : '#616161', fontWeight : 'bold'}}>Please sign up</h3> 
    <Paper zDepth={2} style={style}>
          <TextField 
            floatingLabelText="Email address" 
            type="text"
            underlineShow={true}
            fullWidth={true}
          />
          <TextField 
            floatingLabelText="Password" 
            type="password"
            underlineShow={true}
            fullWidth={true}
          />
          <Checkbox
            label="Remember me"
            style={{
              marginTop: 2,
              marginBottom: 10,
            }}
          />
          <RaisedButton 
            label="Log in" 
            fullWidth={true}
            primary={true}
            style={{marginBottom: 12,}}
          />
    </Paper>
    </div>    
    );
  }
}

class LoginPage extends Component {

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
          <LoginForm/>
        </div>
      </div>
    );
  }

}

export default withStyles(LoginPage, s);
