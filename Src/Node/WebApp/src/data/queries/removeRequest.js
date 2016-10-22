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

const removeRequest = {
  type: BooleanType,
  description: "Remove request with id",
  args: {
        requestId: {type: ID},
      },
  resolve: function(root, { requestId }) {

    return new Promise(function(resolve, reject) {

    var connection = mysql.globalConnection;
    // Call db procedure . 
    var sql = 'delete from plutus.payment_requests where id = ?';
    var params = [requestId];
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

export default removeRequest;
