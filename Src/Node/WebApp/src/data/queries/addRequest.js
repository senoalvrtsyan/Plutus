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

const addRequest = {
  type: BooleanType,
  description: "Add a new payment request",
  args: {
        receiver: {type: ID},
        sender: {type: ID},
        amount: {type: FloatType},
      },
  resolve: function(root, { receiver, sender, amount }) {

    return new Promise(function(resolve, reject) {

    var connection = mysql.globalConnection;
    // Call db procedure . 
    var sql = 'INSERT INTO plutus.payment_requests (receiver, sender, amount, `datetime`) VALUES (?, ?, ?, NOW())';
    var params = [receiver, sender, amount];
    connection.query(sql, params, function(err, rows) {
      if(!err) {
          resolve(true);
      }
      else {
        console.log('MySQL error: ', err);
        resolve(false);
      }
    });
   });
  },
};

export default addRequest;
