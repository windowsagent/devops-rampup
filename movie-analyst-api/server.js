// Get our dependencies
const express = require('express');
const app = express();
const mysql = require('mysql2'); // Use mysql2 instead of mysql
const util = require('util');

// Create a connection pool using mysql2
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'applicationuser',
  password: process.env.DB_PASS || 'applicationuser',
  database: process.env.DB_NAME || 'movie_db',
});

// Promisify the query method for easier asynchronous handling
pool.query = util.promisify(pool.query);

// Implement the movies API endpoint
app.get('/movies', async (req, res) => {
  try {
    const rows = await pool.query(
      'SELECT m.title, m.release_year, m.score, r.name AS reviewer, p.name AS publication ' +
      'FROM movies m, reviewers r, publications p ' +
      'WHERE r.publication = p.name AND m.reviewer = r.name'
    );
    res.json(rows);
  } catch (err) {
    console.error('API Error:', err);
    res.status(500).send({ msg: 'Internal server error' });
  }
});

// Implement the reviewers API endpoint
app.get('/reviewers', async (req, res) => {
  try {
    const rows = await pool.query('SELECT r.name, r.publication, r.avatar FROM reviewers r');
    res.json(rows);
  } catch (err) {
    console.error('API Error:', err);
    res.status(500).send({ msg: 'Internal server error' });
  }
});

// Implement the publications API endpoint
app.get('/publications', async (req, res) => {
  try {
    const rows = await pool.query('SELECT r.name, r.publication, r.avatar FROM reviewers r');
    res.json(rows);
  } catch (err) {
    console.error('API Error:', err);
    res.status(500).send({ msg: 'Internal server error' });
  }
});

// Implement the pending movies API endpoint
app.get('/pending', async (req, res) => {
  try {
    const rows = await pool.query(
      'SELECT m.title, m.release, m.score, r.name AS reviewer, p.name AS publication ' +
      'FROM movie_db.movies m, movie_db.reviewers r, movie_db.publications p ' +
      'WHERE r.publication = p.name AND m.reviewer = r.name AND m.release >= 2017'
    );
    res.json(rows);
  } catch (err) {
    console.error('API Error:', err);
    res.status(500).send({ msg: 'Internal server error' });
  }
});

// Start the Express server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
