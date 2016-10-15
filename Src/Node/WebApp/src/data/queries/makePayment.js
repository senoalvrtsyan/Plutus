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

const makePayment = {
  type: BooleanType,
  description: "Return true if payment was a success",
  args: {
        account: {type: StringType},
        userId: {type: ID},
        amount: {type: FloatType},
      },
  resolve: function(root, { account, userId, amount }) {

    return new Promise(function(resolve, reject) {

    var connection = mysql.globalConnection;

    // 1. First of all, get the debit account of the reciving user so we can make a payment.
    var reciverAccount = "";
    var sql = 'SELECT idaccounts FROM plutus.accounts where iduser = ? and type = ?';
    var params = [userId, 1/*debit*/];
    connection.query(sql, params, function(err, rows, fields) {
      if(!err) {

        console.log('1 is good!!!');

        if(rows.length == 1) {  

          // Here is our single result.
          reciverAccount = rows[0].idaccounts;
          
          console.log('1 is still good!!!', reciverAccount);

          // TODO: check if there are availible founds first!

          // 2. Now when we have the account we can start deducing the amount from sender account.
          var sql = 'update plutus.accounts set balance = balance - ? where binary idaccounts = ?';
          var params = [amount, account];
          connection.query(sql, params, function(err, rows, fields) {
            if(!err) {

                console.log('2 is good!!!');

              // 3. Cool, now add amount to reciver account.
              var sql = 'update plutus.accounts set balance = balance + ? where binary idaccounts = ?';
              var params = [amount, reciverAccount];
              connection.query(sql, params, function(err, rows, fields) {
              if(!err) {
                
                // 3. Register the payment into DB.
                var sql =
                  'INSERT INTO plutus.payment (sender, receiver, amount, datetime) VALUES (?, ?, ?, \'2016-10-06 17:25:31\')';
                var params = [account, reciverAccount, amount];
                connection.query(sql, params, function(err, rows, fields) {
                  if(!err) {

                    resolve(true);

                  }
                  else {
                    console.log('MySQL error: ', err);
                    resolve(false);
                  } 
                });


              }
              else {
                console.log('MySQL error: ', err);
                resolve(false);
              } 
            });


            }
            else {
              console.log('MySQL error: ', err);
              resolve(false);
            }
          });


        }
        else {
          resolve(false);
        }
      }
      else {
        console.log('MySQL error: ', err);
        resolve(false);
      }
    });
  });
  },
};

export default makePayment;
