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
} from 'graphql';

const AccountType = new ObjectType({
  name: 'Account',
  fields: {
    id: { type: new NonNull(ID) },
    userid: { type: new NonNull(ID) },
    type: { type: IntType },
    balance: { type: FloatType },
    limit: { type: FloatType },
  },
});

export default AccountType;
