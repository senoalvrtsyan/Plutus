/**
 * React Starter Kit (https://www.reactstarterkit.com/)
 *
 * Copyright © 2014-2016 Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import {
  GraphQLSchema as Schema,
  GraphQLObjectType as ObjectType,
} from 'graphql';

// Queries
import content from './queries/content';
import authenticate from './queries/authenticate';
import accounts from './queries/accounts';
import finduser from './queries/finduser';
import paymentHistory from './queries/paymentHistory';
import getPaymentRequest from './queries/getPaymentRequest';
//import me from './queries/me';
//import echo from './queries/echo';

// Mutations
import makePayment from './queries/makePayment';
import signUp from './queries/signUp';

const schema = new Schema({
  query: new ObjectType({
    name: 'Query',
    fields: {
      content,
      authenticate,
      accounts,
      finduser,
      paymentHistory,
      getPaymentRequest,
//    me,
//    echo,
    },
  }),
  mutation: new ObjectType({
    name: 'Mutation',
    fields: {
      makePayment,
      signUp,
    },
  }),
});

export default schema;
