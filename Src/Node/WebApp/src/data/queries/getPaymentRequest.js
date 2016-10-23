/**
 * React Starter Kit (https://www.reactstarterkit.com/)
 *
 * Copyright © 2014-2016 Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import {
  GraphQLID as ID,
  GraphQLString as StringType,
  GraphQLList as ListType,
  GrapgQLBoolean as BooleanType,
} from 'graphql';

import PaymentRequestType from '../types/PaymentRequestType';

var mysql      = require('mysql');

const getPaymentRequest = {
  type: PaymentRequestType,
  description: "Returns pending payment request",
  args: {
        userid: {type: ID},
      },
  resolve: function(root, { userid }) {

    return new Promise(function(resolve, reject) {
    
      var connection = mysql.globalConnection;

      // Make the query.
      var sql = 'SELECT * FROM plutus.payment_requests where sender = ? LIMIT 1';
      var params = [userid];

      console.log(userid);

      connection.query(sql, params, function(err, rows, fields) {

        if(!err) {

          console.log(rows);

          if(rows.length == 1) {  

            // Here is our single resoult.
            var row = rows[0];

            resolve({
                requestId: row.id,
                receiver: row.receiver,
                sender: row.sender,
                amount: row.amount,
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
  }
};

export default getPaymentRequest;
