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


import UserType from '../types/UserType';

const authenticate = {
  type: UserType,
  description: "Return user if auth is successful",
  args: {
        username: {type: StringType},
        password: {type: StringType},
      },
  resolve: function(root, { username, password }) {
  		if(username == 'hov' && password == 'pwd')
  		{
  			return {
      			id: "101",
      			name: "Hovhannes Grigoryan",
      			username: "hov",
      			email: "hovgrig@gmail.com",
    			};
  		}
  		else if (username == 'kor' && password == 'pwd')
  		{
  			return {
      			id: "102",
      			name: "Koriun Aslanyan",
      			username: "kor",
      			email: "kor@gmail.com",
    			};
  		}
  		else if (username == 'seno' && password == 'pwd')
  		{
  			return {
      			id: "103",
      			name: "Senik Alvrtyan",
      			username: "seno",
      			email: "seno@gmail.com",
    			};
  		}
  		else
  		{
  			return null;
  		}
      },
};

export default authenticate;
