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

import PaymentRecordType from '../types/PaymentRecordType';

var mysql      = require('mysql');

const paymentHistory = {
  type: new ListType(PaymentRecordType),
  description: "Return the  payment history for the user",
  args: {
        userid: {type: ID},
        sent: {type: ID},
      },
  resolve: function(root, { userid, sent }) {

    return new Promise(function(resolve, reject) {
    
      var connection = mysql.globalConnection;

      // Make the query.
      var sql = 'call plutus.GetPaymentHistory(?, ?)';
      var params = [userid, sent];
      connection.query(sql, params, function(err, rows, fields) {

        if(!err) {

          // List we will return.
          var res = [];
          for (var i = 0; i < rows[0].length; ++i) {
            // Here is our single resoult.
            var row = rows[0][i];

            res.push({
                account: row.account,
                type: row.mainType,
                name: row.name,
                username: row.username,
                amount: row.amount,
                sent: sent
            });
          }

          resolve(res);
        }
        else {
          console.log('MySQL error: ', err);
          resolve(null);
        }
      });
    });
  }
};

export default paymentHistory;
