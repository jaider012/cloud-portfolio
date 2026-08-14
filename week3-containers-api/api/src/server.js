const app = require('./app');
const { init } = require('./db');

const port = process.env.PORT || 3000;

init()
  .then(() => {
    app.listen(port, () => console.log(`url-shortener listening on :${port}`));
  })
  .catch((err) => {
    console.error('DB init failed:', err.message);
    process.exit(1);
  });

process.on('SIGTERM', () => process.exit(0));
