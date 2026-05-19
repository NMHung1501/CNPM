import { createApp } from './app.js';
import { loadEnv } from './config/env.js';
import { startServer } from './config/db.js';

const env = loadEnv();
const app = createApp();

startServer(app, env).catch((err) => {
  console.error('Fatal error:', err);
  process.exit(1);
});




