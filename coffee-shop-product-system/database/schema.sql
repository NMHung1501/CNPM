-- Coffee Shop Product System - Database Schema

-- Categories (optional)
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Products (as required by the task)
-- Fields: Id, Name, Price, Description, Image_URL, Category_Id, Status, Created_At
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(12,2) NOT NULL CHECK (price > 0),
  description TEXT NOT NULL,
  image_url TEXT NOT NULL,
  category_id INT REFERENCES categories(id),
  status BOOLEAN NOT NULL DEFAULT TRUE, -- TRUE: còn hàng, FALSE: hết hàng
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

