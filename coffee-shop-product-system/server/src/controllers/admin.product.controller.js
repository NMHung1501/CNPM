function validateProductInput(body) {
  const errors = [];

  const name = typeof body.name === 'string' ? body.name.trim() : '';
  const price = body.price;
  const description = typeof body.description === 'string' ? body.description.trim() : '';
  const image_url = typeof body.image_url === 'string' ? body.image_url.trim() : '';
  const category_id = body.category_id === null || body.category_id === undefined ? null : Number(body.category_id);

  const status = body.status;
  const statusBool = status === true || status === 'true' ? true : status === false || status === 'false' ? false : null;

  if (!name) errors.push('Name không được để trống');
  if (price === undefined || price === null || Number(price) <= 0) errors.push('Price phải lớn hơn 0');
  if (!description) errors.push('Description không được để trống');
  if (!image_url) errors.push('Image_URL không được để trống');
  if (statusBool === null) errors.push('Status không hợp lệ');
  if (category_id !== null && Number.isNaN(category_id)) errors.push('Category_Id không hợp lệ');

  return {
    errors,
    normalized: {
      name,
      price: Number(price),
      description,
      image_url,
      category_id,
      status: statusBool
    }
  };
}

export async function adminListProducts(req, res, next) {
  try {
    const result = await req.app.locals.pool
      .request()
      .query(`
        SELECT 
          p.id, p.name, p.price, p.description, p.image_url, p.category_id,
          p.status, p.created_at,
          c.name AS category_name
        FROM dbo.products p
        LEFT JOIN dbo.categories c ON c.id = p.category_id
        ORDER BY p.created_at DESC
      `);

    res.json(result.recordset || []);
  } catch (err) {
    next(err);
  }
}

export async function createProduct(req, res, next) {
  try {
    const { errors, normalized } = validateProductInput(req.body);
    if (errors.length) return res.status(400).json({ errors });

    const request = req.app.locals.pool.request();
    request.input('name', normalized.name);
    request.input('price', normalized.price);
    request.input('description', normalized.description);
    request.input('image_url', normalized.image_url);
    request.input('category_id', normalized.category_id);
    request.input('status', normalized.status ? 1 : 0);

    const result = await request.query(`
      INSERT INTO dbo.products (name, price, description, image_url, category_id, status)
      OUTPUT INSERTED.*
      VALUES (@name, @price, @description, @image_url, @category_id, @status)
    `);

    res.status(201).json((result.recordset || [])[0]);
  } catch (err) {
    next(err);
  }
}

export async function updateProduct(req, res, next) {
  try {
    const { id } = req.params;
    const { errors, normalized } = validateProductInput(req.body);
    if (errors.length) return res.status(400).json({ errors });

    const request = req.app.locals.pool.request();
    request.input('id', Number(id));
    request.input('name', normalized.name);
    request.input('price', normalized.price);
    request.input('description', normalized.description);
    request.input('image_url', normalized.image_url);
    request.input('category_id', normalized.category_id);
    request.input('status', normalized.status ? 1 : 0);

    const result = await request.query(`
      UPDATE dbo.products
      SET name=@name, price=@price, description=@description, image_url=@image_url,
          category_id=@category_id, status=@status
      OUTPUT INSERTED.*
      WHERE id=@id
    `);

    const rows = result.recordset || [];
    if (!rows.length) return res.status(404).json({ message: 'Product not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

export async function deleteProduct(req, res, next) {
  try {
    const { id } = req.params;

    const request = req.app.locals.pool.request();
    request.input('id', Number(id));

    const result = await request.query(`
      DELETE FROM dbo.products
      OUTPUT DELETED.*
      WHERE id=@id
    `);

    const rows = result.recordset || [];
    if (!rows.length) return res.status(404).json({ message: 'Product not found' });
    res.json({ ok: true });
  } catch (err) {
    next(err);
  }
}


