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
} from 'graphql';

import AccountType from '../types/AccountType';

var mysql      = require('mysql');

const accounts = {
  type: new ListType(AccountType),
  description: "Return the list of user's account",
  args: {
        userid: {type: ID},
      },
  resolve: function(root, { userid }) {

    return new Promise(function(resolve, reject) {
    
      var connection = mysql.globalConnection;

      // Make the query.
      var sql = 'select idaccounts, iduser, type, balance, `limit` from plutus.accounts where iduser = ?';
      var params = [userid];
      connection.query(sql, params, function(err, rows, fields) {

        if(!err) {

          // Account list we will return.
          var res = [];
          for (var i = 0; i < rows.length; ++i) {
            // Here is our single resoult.
            var row = rows[i];

            res.push({
                id: row.idaccounts,
                userid: row.iduser,
                type: row.type,
                balance: row.balance,
                limit: row.limit
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

export default accounts;
