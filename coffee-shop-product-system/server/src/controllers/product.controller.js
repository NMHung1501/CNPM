import { buildProductFilterQuery } from '../db/queries.js';

export async function listProducts(req, res, next) {
  try {
    const { categoryId, search, status } = req.query;

    const { sql: querySql, params } = buildProductFilterQuery({
      categoryId,
      search,
      status
    });

    const request = req.app.locals.pool.request();
    for (const [k, v] of Object.entries(params)) {
      request.input(k, v);
    }

    const result = await request.query(querySql);
    res.json(result.recordset || []);
  } catch (err) {
    next(err);
  }
}

export async function getProductById(req, res, next) {
  try {
    const { id } = req.params;

    const request = req.app.locals.pool.request();
    request.input('id', Number(id));

    const result = await request.query(`
      SELECT 
        p.id, p.name, p.price, p.description, p.image_url, p.status, p.created_at,
        c.id AS category_id, c.name AS category_name
      FROM dbo.products p
      LEFT JOIN dbo.categories c ON c.id = p.category_id
      WHERE p.id = @id
    `);

    const rows = result.recordset || [];
    if (!rows.length) return res.status(404).json({ message: 'Product not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}


