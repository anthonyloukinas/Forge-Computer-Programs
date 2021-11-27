const express = require('express');
const app = express();
const { v4: uuidv4 } = require('uuid');

const port = process.env.PORT || 50000;

app.use(express.urlencoded({ extended: true }));

app.get('/api/v1/configure', (req, res) => {

  console.log("new request!")
  console.log(req.body);

  let uuid = uuidv4();

  res.send({
    "msg": "Client has been configured as " + uuid,
    "status": "success",
  });
});

app.listen((port), () => {
  console.log('Server is running on port ' + port);
});