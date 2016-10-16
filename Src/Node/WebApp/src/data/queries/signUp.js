/**
 * React Starter Kit (https://www.reactstarterkit.com/)
 *
 * Copyright © 2014-2016 Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import {
  GraphQLString as StringType,
  GraphQLBoolean as BooleanType,
  GraphQLID as ID,
  GraphQLFloat as FloatType,
} from 'graphql';

import UserType from '../types/UserType';

var mysql      = require('mysql');

const signUp = {
  type: UserType,
  description: "Returns newely signed up user if successful",
  args: {
        name: {type: StringType},
        username: {type: StringType},
        email: {type: StringType},
        password: {type: StringType},
      },
  resolve: function(root, { name, username, email, password }) {

    return new Promise(function(resolve, reject) {

    var connection = mysql.globalConnection;

    // Call db procedure to create the new user. 
    var sql = 'CALL plutus.CreateUser(?, ?, ?, ?)';
    var params = [name, username, email, password];
    connection.query(sql, params, function(err, rows) {
      if(!err) {
        if(rows[0].length == 1) {
          var row = rows[0][0];
          resolve({
                  id: row.idusers,
                  name: row.name,
                  username: row.username,
                  email: row.email
                });
        }
        else {
          resolve(null);
        }
      }
      else {
        console.log('MySQL error: ', err);
        resolve(null);
      }
    });
  });
  },
};

export default signUp;
