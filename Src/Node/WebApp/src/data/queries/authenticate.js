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

const authenticate = {
  type: StringType,
  description: "Return true if successful",
  args: {
        username: {type: StringType},
        password: {type: StringType}
      },
  resolve: function(root, {username, password}) {
  		if((username == 'hov' || username == 'kor' || username == 'seno') && password == 'pwd')
  		{
  			return 'true';
  		}
  		else
  		{
  			return 'false';
  		}
      },
};

export default authenticate;
