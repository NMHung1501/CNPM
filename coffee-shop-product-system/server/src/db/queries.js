export function buildProductFilterQuery({ categoryId, search, status }) {
  const where = [];
  const params = {};

  if (categoryId) {
    where.push('p.category_id = @categoryId');
    params.categoryId = Number(categoryId);
  }

  if (status === 'true' || status === 'false') {
    where.push('p.status = @status');
    params.status = status === 'true' ? 1 : 0;
  }

  if (search) {
    where.push('LOWER(p.name) LIKE LOWER(@search)');
    params.search = `%${search}%`;
  }

  const whereSql = where.length ? `WHERE ${where.join(' AND ')}` : '';

  const sql = `
    SELECT 
      p.id,
      p.name,
      p.price,
      p.description,
      p.image_url,
      p.status,
      p.created_at,
      c.id AS category_id,
      c.name AS category_name
    FROM dbo.products p
    LEFT JOIN dbo.categories c ON c.id = p.category_id
    ${whereSql}
    ORDER BY p.created_at DESC
  `;

  return { sql, params };
}


