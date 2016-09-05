var express = require('express');
var router = express.Router();
// var mysql = require('mysql');

// api/users
router.get('/', function(req, res) {

  res.json({ message: 'Grigoryan Hovhannes' });
  
  /*
  var connection = mysql.createConnection({
  	host: 'localhost',
  	user: 'root',
  	password: 'mysqlsql',
  	database: 'smartfield'
  });

  connection.connect();

  connection.query('select * from smartfield.user', function(err, rows, fields) {
  	if(err)
  		throw err;

  	res.send('Query resoult is: ' + rows[5].name);
  });

  connection.end();
*/
});

router.post('/', function(req, res) {
	console.log(req.body);

	res.json({ message: 'User created: ' + req.body.name });
});

// api/users/:user_id

router.get('/:user_id', function(req, res) {
	res.json({ message: 'user: ' + req.params.user_id});
});

module.exports = router;
