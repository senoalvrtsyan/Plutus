/**
 * React Starter Kit (https://www.reactstarterkit.com/)
 *
 * Copyright © 2014-2016 Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import {
  GraphQLObjectType as ObjectType,
  GraphQLID as ID,
  GraphQLString as StringType,
  GraphQLInt as IntType,
  GraphQLFloat as FloatType,
  GraphQLNonNull as NonNull,
  GraphQLBoolean as BooleanType
} from 'graphql';

const PaymentRecordType = new ObjectType({
  name: 'PaymentRecord',
  fields: {
    account: { type: StringType },
    type: { type: ID},
    name: { type: StringType },
    username: { type: StringType },
    amount: { type: FloatType },
    sent: { type: ID },
  },
});

export default PaymentRecordType;
