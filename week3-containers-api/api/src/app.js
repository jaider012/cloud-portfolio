const express = require('express');
const { nanoid } = require('nanoid');
const { pool } = require('./db');

const app = express();
app.use(express.json());

app.get('/health', (_req, res) => res.json({ status: 'ok' }));

app.post('/links', async (req, res) => {
  const { url } = req.body || {};
  try {
    new URL(url);
  } catch {
    return res.status(400).json({ error: 'A valid "url" field is required' });
  }

  const code = nanoid(7);
  await pool.query('INSERT INTO links (code, url) VALUES ($1, $2)', [code, url]);
  res.status(201).json({ code, short: `${req.protocol}://${req.get('host')}/${code}`, url });
});

app.get('/links/:code/stats', async (req, res) => {
  const { rows } = await pool.query(
    'SELECT code, url, hits, created_at FROM links WHERE code = $1',
    [req.params.code]
  );
  if (!rows.length) return res.status(404).json({ error: 'Not found' });
  res.json(rows[0]);
});

app.get('/:code', async (req, res) => {
  const { rows } = await pool.query(
    'UPDATE links SET hits = hits + 1 WHERE code = $1 RETURNING url',
    [req.params.code]
  );
  if (!rows.length) return res.status(404).json({ error: 'Not found' });
  res.redirect(302, rows[0].url);
});

module.exports = app;
