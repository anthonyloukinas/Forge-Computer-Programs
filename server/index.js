/**
 * index.js
 * 
 * @author Anthony Loukinas <anthony.loukinas@gmail.com>
 * @entrypoint
 */

/**
 * Requirements
 */
const express = require('express');
const app = express();
const { v4: uuidv4 } = require('uuid');

/**
 * Configuration
 */
const port = process.env.PORT || 50000;

/**
 * Express Options
 */
app.use(express.urlencoded({ extended: true }));

/**
 * LowDB Testing
 */
const JSONdb = require('simple-json-db');
const db = new JSONdb('./db.json');

db.set('test', 'test');



/**
 * Express routes
 */
app.get('/api/v1/ping', (req, res) => {
  res.send('pong');
});

app.post('/api/v1/configure', (req, res) => {

  console.log(req.body);

  let uuid = uuidv4();

  res.send({
    "msg": "Client has been configured as " + uuid,
    "status": "success",
  });
});

/**
 * Initialize server
 */
app.listen((port), () => {
  console.log('Server is running on port ' + port);
});