/**
 * Created by Koriun on 9/9/2016.
 */

var express = require('express');
var router = express.Router();

router.get('/', function(req, res) {
  res.send(
    [
      {
        id : 1,
        name : 'Koriun',
        surname : 'Aslanyan',
        mail : 'aslanyankor@gmail.com'
      },
      {
        id : 2,
        name : 'Hovhannes',
        surname : 'Grigoryan',
        mail : 'hovgrig@gmail.com'
      }
    ]
  );
});

export default router;
