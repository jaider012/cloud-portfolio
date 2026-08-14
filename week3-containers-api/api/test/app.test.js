const { test } = require('node:test');
const assert = require('node:assert');

// Validation-only tests (no DB needed) — the POST handler rejects bad URLs
// before touching Postgres, so we stub the pool module.
require.cache[require.resolve('../src/db')] = {
  exports: { pool: { query: async () => ({ rows: [] }) }, init: async () => {} },
};

const app = require('../src/app');

function request(method, path, body) {
  return new Promise((resolve, reject) => {
    const server = app.listen(0, async () => {
      const port = server.address().port;
      try {
        const res = await fetch(`http://127.0.0.1:${port}${path}`, {
          method,
          headers: { 'content-type': 'application/json' },
          body: body ? JSON.stringify(body) : undefined,
          redirect: 'manual',
        });
        const json = await res.json().catch(() => null);
        resolve({ status: res.status, json });
      } catch (e) {
        reject(e);
      } finally {
        server.close();
      }
    });
  });
}

test('GET /health returns ok', async () => {
  const res = await request('GET', '/health');
  assert.strictEqual(res.status, 200);
  assert.deepStrictEqual(res.json, { status: 'ok' });
});

test('POST /links rejects missing url', async () => {
  const res = await request('POST', '/links', {});
  assert.strictEqual(res.status, 400);
});

test('POST /links rejects invalid url', async () => {
  const res = await request('POST', '/links', { url: 'not-a-url' });
  assert.strictEqual(res.status, 400);
});

test('POST /links accepts a valid url', async () => {
  const res = await request('POST', '/links', { url: 'https://example.com' });
  assert.strictEqual(res.status, 201);
  assert.ok(res.json.code);
});

test('GET /:code returns 404 for unknown code', async () => {
  const res = await request('GET', '/zzzzzzz');
  assert.strictEqual(res.status, 404);
});
