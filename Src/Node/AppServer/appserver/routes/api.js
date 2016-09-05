var express = require('express');
var router = express.Router();

var users = require('./api/users');

router.use('/users', users);

/* GET home page. */
router.get('/', function(req, res, next) {
	console.log('API route');
	next();
});

module.exports = router;
