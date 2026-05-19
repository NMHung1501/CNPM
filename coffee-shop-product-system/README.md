# Coffee Shop Product System (CNPM)

## Chức năng
- Khách hàng: hiển thị danh sách sản phẩm, có lọc theo danh mục & tìm kiếm theo tên.
- Admin: CRUD sản phẩm (Create/Read/Update/Delete), form có validation, xóa có confirm.

## CSDL
- `categories` (nếu có)
- `products` với các trường: `id, name, price, description, image_url, category_id, status (còn/hết hàng), created_at`.

### SQL Server
- Schema: `database\schema_mssql.sql`
- Seed dữ liệu mẫu: `database\seed_mssql.sql`
- Hướng dẫn import: `database\SEED_INSTRUCTIONS.txt`


## Cấu trúc dự án
Xem thêm trong `docs/` và thư mục gốc.

