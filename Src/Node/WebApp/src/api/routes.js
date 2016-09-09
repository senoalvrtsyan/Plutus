/**
 * Created by Koriun on 9/9/2016.
 */

import users from './users';

var express = require('express');
var router = express.Router();

router.use('/users', users);

router.get('/', function(err, req, res) {
  // TODO : we need here nice json error!
  const template = require('../views/error.jade');
  const statusCode = err.status || 500;
  res.status(statusCode);
  res.send(template({
    message: err.message,
    stack: process.env.NODE_ENV === 'production' ? '' : err.stack,
  }));
});

export default router;
