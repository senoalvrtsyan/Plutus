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
import { Form, FormControl, Checkbox, Button, FormGroup } from 'react-bootstrap';

const title = 'Log In';

class LoginForm extends Component {

  render() {
    return (
      <Form>
        <h2>Please log in</h2>
        <FormGroup bsSize="large">
          <FormControl type="email" placeholder="Email"/>
          <FormControl type="password" placeholder="Password" bsSize="large"/>
        </FormGroup>
        <Checkbox> Remember me </Checkbox>
        <Button type="submit"  bsSize="large" block> Log in </Button>
      </Form>
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
