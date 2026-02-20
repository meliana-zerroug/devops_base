// app.test.js
const request = require('supertest');
const app = require('./app');

describe('Test the root path', () => {
  test('It should respond to the GET method', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('Hello, World!');
  });
});

describe('Test the /name/:name path', () => {
  test('It should respond with a personalized greeting', async () => {
    const name = 'Alice';
    const response = await request(app).get(`/name/${name}`);
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe(`Hello, ${name}!`);
  });
});

// Exercise 9: Tests pour /add/:a/:b endpoint
describe('Test the /add/:a/:b path', () => {
  test('It should return the sum of two positive numbers', async () => {
    const response = await request(app).get('/add/5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('8');
  });

  test('It should return the sum of negative numbers', async () => {
    const response = await request(app).get('/add/-5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('-2');
  });

  test('It should handle decimal numbers', async () => {
    const response = await request(app).get('/add/2.5/3.7');
    expect(response.statusCode).toBe(200);
    expect(parseFloat(response.text)).toBeCloseTo(6.2, 1);
  });

  test('It should return 400 for invalid first parameter', async () => {
    const response = await request(app).get('/add/abc/5');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Invalid input: both parameters must be numbers');
  });

  test('It should return 400 for invalid second parameter', async () => {
    const response = await request(app).get('/add/5/xyz');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Invalid input: both parameters must be numbers');
  });

  test('It should return 400 for both invalid parameters', async () => {
    const response = await request(app).get('/add/foo/bar');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Invalid input: both parameters must be numbers');
  });
});

// Exercise 13
describe('Test the /multiply/:a/:b path (TDD)', () => {
  test('It should return the product of two positive numbers', async () => {
    const response = await request(app).get('/multiply/5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('15');
  });

  test('It should handle negative numbers', async () => {
    const response = await request(app).get('/multiply/-5/3');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('-15');
  });

  test('It should handle multiplication by zero', async () => {
    const response = await request(app).get('/multiply/5/0');
    expect(response.statusCode).toBe(200);
    expect(response.text).toBe('0');
  });

  test('It should return 400 for invalid inputs', async () => {
    const response = await request(app).get('/multiply/abc/5');
    expect(response.statusCode).toBe(400);
    expect(response.text).toBe('Invalid input: both parameters must be numbers');
  });
});
