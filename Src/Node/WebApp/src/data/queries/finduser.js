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
  GraphQLID as ID,
} from 'graphql';

import UserType from '../types/UserType';

var mysql      = require('mysql');

const finduser = {
  type: UserType,
  description: "Return user if found",
  args: {
        username: {type: StringType},
        userId: {type: ID},
      },
  resolve: function(root, { username, userId }) {

    return new Promise(function(resolve, reject) {

    var connection = mysql.globalConnection;

    var sql;
    var params = [];

    if(username != null)
    {
      sql = 'select idusers, name, username, email from plutus.users where binary username = ?';
      params = [username];
    }
    else if(userId != null)
    {
      sql = 'select idusers, name, username, email from plutus.users where idusers = ?';
      params = [userId];
    }

    // Make the query.
    connection.query(sql, params, function(err, rows, fields) {
        if(!err) {

          if(rows.length == 1) {  

            // Here is our single resoult.
            var row = rows[0];

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

export default finduser;
