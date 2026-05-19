-- Coffee Shop Product System - SQL Server (T-SQL)

IF OBJECT_ID('dbo.products','U') IS NULL
BEGIN
  CREATE TABLE dbo.products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    image_url NVARCHAR(1000) NOT NULL,
    category_id INT NULL,
    status BIT NOT NULL CONSTRAINT DF_products_status DEFAULT (1), -- 1: còn hàng, 0: hết hàng
    created_at DATETIME NOT NULL CONSTRAINT DF_products_created_at DEFAULT GETDATE(),
    CONSTRAINT CK_products_price CHECK (price > 0)
  );
END

IF OBJECT_ID('dbo.categories','U') IS NULL
BEGIN
  CREATE TABLE dbo.categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL CONSTRAINT DF_categories_created_at DEFAULT GETDATE()
  );
END

-- FK products -> categories
IF NOT EXISTS (
  SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_products_categories'
)
BEGIN
  ALTER TABLE dbo.products
  ADD CONSTRAINT FK_products_categories
  FOREIGN KEY (category_id) REFERENCES dbo.categories(id);
END

INSERT INTO dbo.categories (name)
VALUES 
(N'Cà phê pha máy'),      -- ID sẽ tự động là 1
(N'Cà phê truyền thống'), -- ID sẽ tự động là 2
(N'Trà & Trà Trái Cây'),  -- ID sẽ tự động là 3
(N'Đồ uống đá xay');      -- ID sẽ tự động là 4

-- Chèn 15 dữ liệu mẫu vào bảng products
INSERT INTO dbo.products (name, price, description, image_url, category_id, status)
VALUES
-- Danh mục 1: Cà phê pha máy (Machine Coffee)
(N'Espresso Nguyên Bản', 35000, N'Cà phê Espresso chiết xuất nguyên chất từ hạt Arabica rang mộc, mang lại hương vị đậm đà, nguyên bản.', N'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=500', 1, 1),
(N'Americano Đá', 40000, N'Espresso pha loãng với nước tinh khiết và đá lạnh, giải khát tức thì cho ngày dài năng động.', N'https://images.unsplash.com/photo-1551030173-122aabc4489c?w=500', 1, 1),
(N'Cappuccino Nóng', 50000, N'Sự kết hợp hoàn hảo giữa Espresso, sữa nóng và lớp bọt sữa bồng bềnh nghệ thuật.', N'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500', 1, 1),
(N'Latte Macchiato', 55000, N'Hương vị nhẹ nhàng, ngọt ngào với tỷ lệ sữa tươi nhiều hơn cà phê, phù hợp cho buổi sáng nhẹ nhàng.', N'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?w=500', 1, 1),
(N'Caramel Macchiato Đá', 60000, N'Cà phê phủ xốt Caramel ngọt ngào hòa quyện cùng sữa tươi và đá lạnh.', N'https://images.unsplash.com/photo-1485808191679-5f86510681a2?w=500', 1, 0), -- 0: Hết hàng

-- Danh mục 2: Cà phê truyền thống (Traditional Coffee)
(N'Cà Phê Đen Đá', 29000, N'Cà phê Robusta pha phin truyền thống Việt Nam, đậm vị, đắng thanh và mạnh mẽ.', N'https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=500', 2, 1),
(N'Cà Phê Sữa Đá', 35000, N'Sự hòa quyện kinh điển giữa cà phê phin đậm đặc và sữa đặc có đường béo ngậy.', N'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?w=500', 2, 1),
(N'Bạc Xỉu', 39000, N'Thức uống quen thuộc với phần sữa đặc và sữa tươi lấn át chút vị đắng của cà phê.', N'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500', 2, 1),
(N'Cà Phê Cốt Dừa', 45000, N'Biến tấu độc đáo kết hợp cà phê đen truyền thống cùng kem cốt dừa xay mịn, béo ngậy.', N'https://images.unsplash.com/photo-1582294451000-0df1dfa5f566?w=500', 2, 1),
(N'Cà Phê Trứng', 50000, N'Đặc sản Hà Nội: lớp kem trứng đánh bông mềm mịn phủ lên lớp cà phê nóng hổi.', N'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500', 2, 1),

-- Danh mục 3: Trà & Trà Trái Cây (Teas)
(N'Trà Đào Cam Sả', 45000, N'Trà đen ủ lạnh kết hợp vị ngọt của đào, chua thanh của cam và thơm nồng của sả tươi.', N'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500', 3, 1),
(N'Trà Vải Nhiệt Đới', 45000, N'Hương vị thanh mát của trà olong quyện với mứt vải và trái vải tươi giòn rụm.', N'https://images.unsplash.com/photo-1499638673689-79a0b5115d87?w=500', 3, 1),
(N'Matcha Latte Nóng', 55000, N'Bột trà xanh Matcha Nhật Bản nguyên chất hòa quyện cùng sữa nóng mềm mịn.', N'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500', 3, 1),

-- Danh mục 4: Đồ uống đá xay (Ice Blended)
(N'Cookies Ice Blended', 59000, N'Bánh Oreo xay nhuyễn cùng sữa, đá viên và lớp kem whipping béo ngậy phía trên.', N'https://images.unsplash.com/photo-1572490122747-3968b75bb811?w=500', 4, 1),
(N'Chocolate Đá Xay', 59000, N'Hương vị Chocolate Bỉ đậm đặc xay cùng đá, thỏa mãn tín đồ yêu thích sự ngọt ngào.', N'https://images.unsplash.com/photo-1553177595-4de2bb0842b9?w=500', 4, 0); -- 0: Hết hàng