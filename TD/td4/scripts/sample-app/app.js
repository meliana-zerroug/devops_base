// app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Exercise 7: 
app.get('/name/:name', (req, res) => {
  res.send(`Hello, ${req.params.name}!`);
});

// Exercise 9:
app.get('/add/:a/:b', (req, res) => {
  const a = parseFloat(req.params.a);
  const b = parseFloat(req.params.b);
  
 
  if (isNaN(a) || isNaN(b)) {
    return res.status(400).send('Invalid input: both parameters must be numbers');
  }
  
  const sum = a + b;
  res.send(`${sum}`);
});

// Exercise 13: 

app.get('/multiply/:a/:b', (req, res) => {
  const a = parseFloat(req.params.a);
  const b = parseFloat(req.params.b);
  
 
  if (isNaN(a) || isNaN(b)) {
    return res.status(400).send('Invalid input: both parameters must be numbers');
  }
  
  const product = a * b;
  res.send(`${product}`);
});

module.exports = app;
