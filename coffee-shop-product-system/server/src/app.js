import express from 'express';
import path from 'path';
import productRoutes from './routes/product.routes.js';
import adminRoutes from './routes/admin.routes.js';

export function createApp() {
  const app = express();

  app.use(express.json());

  // Serve static frontend
  const staticDir = path.resolve(process.cwd(), 'client');
  app.use(express.static(staticDir));

  app.get('/', (req, res) => res.sendFile(path.join(staticDir, 'index.html')));

  // API
  app.use('/api/products', productRoutes);
  app.use('/api/admin', adminRoutes);

  app.get('/health', (req, res) => {
    res.json({ ok: true });
  });

  // basic error handler
  app.use((err, req, res, next) => {
    console.error(err);
    res.status(500).json({ message: 'Internal Server Error' });
  });

  return app;
}



