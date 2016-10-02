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
} from 'graphql';

const echo = {
  type: StringType,
  description: "Echo what you enter",
  args: {
        message: {type: StringType}
      },
  resolve: function(root, {message}) {
        return `recieved ${message}`;
      },
};

export default echo;
