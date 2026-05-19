-- Coffee Shop Product System - SQL Server seed data (T-SQL)

SET NOCOUNT ON;

-- Categories
IF NOT EXISTS (SELECT 1 FROM dbo.categories WHERE name = N'Cà phê pha máy')
  INSERT INTO dbo.categories(name) VALUES (N'Cà phê pha máy');

IF NOT EXISTS (SELECT 1 FROM dbo.categories WHERE name = N'Cà phê truyền thống')
  INSERT INTO dbo.categories(name) VALUES (N'Cà phê truyền thống');

IF NOT EXISTS (SELECT 1 FROM dbo.categories WHERE name = N'Trà trái cây')
  INSERT INTO dbo.categories(name) VALUES (N'Trà trái cây');

-- Helper: resolve category ids
DECLARE @cat_machine INT = (SELECT id FROM dbo.categories WHERE name = N'Cà phê pha máy');
DECLARE @cat_trad INT = (SELECT id FROM dbo.categories WHERE name = N'Cà phê truyền thống');
DECLARE @cat_fruit INT = (SELECT id FROM dbo.categories WHERE name = N'Trà trái cây');

-- Products
IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Ethiopian Yirgacheffe Pour Over')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Ethiopian Yirgacheffe Pour Over', 55000, N'Pour over thủ công, hương hoa nhài và cam bergamot, hậu vị sạch và kéo dài.', 'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Caramel Macchiato')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Caramel Macchiato', 50000, N'Veo caramel ấm cùng lớp espresso béo mịn, vị ngọt thanh cân bằng.', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Matcha Cream Frappuccino')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Matcha Cream Frappuccino', 62000, N'Kem matcha mịn, hương trà xanh tươi, uống lạnh kiểu “cực đã” như quán chuyên.', 'https://images.unsplash.com/photo-1502741338009-cac2772e18bc?auto=format&fit=crop&w=1200&q=80', @cat_fruit, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Vietnamese Traditional Phin Coffee')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Vietnamese Traditional Phin Coffee', 45000, N'Cà phê phin truyền thống, đậm đà – thơm nồng, uống nóng hoặc đá đều cuốn.', 'https://images.unsplash.com/photo-1461023058943-9f1b1f9a2f8b?auto=format&fit=crop&w=1200&q=80', @cat_trad, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Pistachio Latte')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Pistachio Latte', 55000, N'Sữa béo hòa quyện espresso, béo hạt dẻ – hương thơm tinh tế.', 'https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=1200&q=80', @cat_machine, 0);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Black Sesame Latte')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Black Sesame Latte', 52000, N'Latte mè đen rang, vị béo bùi, thơm đặc trưng, hậu vị mượt.', 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=1200&q=80', @cat_trad, 1);

-- Legacy seeds removed/overridden by premium set

/*
IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Espresso')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Espresso', 45000, N'Shot espresso đậm đà, vị cân bằng.', 'https://via.placeholder.com/600x400?text=Espresso', @cat_machine, 1);
*/


IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Latte')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Latte', 65000, N'Sữa tươi béo ngậy, espresso thơm lừng.', 'https://via.placeholder.com/600x400?text=Latte', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Bạc xỉu')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Bạc xỉu', 55000, N'Sữa và cà phê hòa quyện, thơm nhẹ.', 'https://via.placeholder.com/600x400?text=Bac+xiu', @cat_trad, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Phin sữa đá')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Phin sữa đá', 48000, N'Phin cà phê truyền thống, uống mát lạnh.', 'https://via.placeholder.com/600x400?text=Phin+sua+da', @cat_trad, 0);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Trà đào cam sả')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Trà đào cam sả', 59000, N'Trà trái cây thanh mát, thơm hương đào.', 'https://via.placeholder.com/600x400?text=Tra+dao+cam+sa', @cat_fruit, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Trà chanh dây')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Trà chanh dây', 62000, N'Vị chanh dây chua nhẹ, thơm và giải khát.', 'https://via.placeholder.com/600x400?text=Tra+chanh+day', @cat_fruit, 1);

-- Extra items for modern UX (target ~15+ products)
IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Coconut Iced Latte')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Coconut Iced Latte', 58000, N'Latte lạnh hương dừa béo thơm, uống mát lịm.', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Berry Cloud Frappe')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Berry Cloud Frappe', 65000, N'Frappe trái cây berry sánh mịn, chua ngọt cân bằng.', 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=1200&q=80', @cat_fruit, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Hazelnut Espresso')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Hazelnut Espresso', 52000, N'Ướp hạt phỉ thơm nồng, espresso đậm đà.', 'https://images.unsplash.com/photo-1442512595331-e89e73853f31?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Green Tea Matcha')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Green Tea Matcha', 56000, N'Matcha chuẩn vị Nhật, béo mịn, hậu vị sạch.', 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?auto=format&fit=crop&w=1200&q=80', @cat_trad, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Mango Lassi')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Mango Lassi', 60000, N'Lassi xoài thơm ngậy, uống mát giải nhiệt.', 'https://images.unsplash.com/photo-1497534446932-c925b458314e?auto=format&fit=crop&w=1200&q=80', @cat_fruit, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Irish Cream Coffee')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Irish Cream Coffee', 59000, N'Cà phê kem Irish Cream vị ngọt béo dễ uống.', 'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Salted Caramel Macchiato')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Salted Caramel Macchiato', 54000, N'Caramel muối thơm, cân bằng ngọt mặn tinh tế.', 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?auto=format&fit=crop&w=1200&q=80', @cat_machine, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Stirred Iced Milk Tea')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Stirred Iced Milk Tea', 42000, N'Trà sữa đánh khuấy đậm vị, thơm béo vừa miệng.', 'https://images.unsplash.com/photo-1542444459-db47c7c6f9d8?auto=format&fit=crop&w=1200&q=80', @cat_fruit, 1);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Triple Chocolate')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Triple Chocolate', 69000, N'Tổ hợp cacao đậm, thơm và mượt như dessert.', 'https://images.unsplash.com/photo-1541167760496-1628856ab772?auto=format&fit=crop&w=1200&q=80', @cat_machine, 0);

IF NOT EXISTS (SELECT 1 FROM dbo.products WHERE name = N'Orange Blossom Tea')
INSERT INTO dbo.products(name, price, description, image_url, category_id, status)
VALUES (N'Orange Blossom Tea', 45000, N'Trà hoa cam thanh mát, hương thơm nhẹ nhàng.', 'https://images.unsplash.com/photo-1497534446932-c925b458314e?auto=format&fit=crop&w=1200&q=80', @cat_fruit, 1);

PRINT 'Seed done.';



