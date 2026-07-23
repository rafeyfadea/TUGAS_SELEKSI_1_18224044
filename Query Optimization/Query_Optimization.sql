
-- ============================================================
-- OPTIMASI 1: Index pada foreign key variants.product_id
--
-- Penjelasan: PostgreSQL tidak otomatis membuat index di
-- kolom foreign key. Jadi walaupun variants.product_id sudah punya
-- constraint ke products, kolom ini tetap bisa kena Seq Scan kalau
-- dipakai untuk JOIN atau filter.
-- ============================================================

EXPLAIN ANALYZE
SELECT variant_id, shade_name, price, availability
FROM variants
WHERE product_id = 'g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb';

CREATE INDEX idx_variants_product_id ON variants(product_id);

EXPLAIN ANALYZE
SELECT variant_id, shade_name, price, availability
FROM variants
WHERE product_id = 'g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb';


-- ============================================================
-- OPTIMASI 2: Index pada variants.availability
--
-- Penjelasan: query yang mencari varian berdasarkan status
-- stok, misalnya untuk laporan produk yang sedang habis, juga bisa
-- berakhir dengan Seq Scan kalau belum ada index.
-- ============================================================

EXPLAIN ANALYZE
SELECT v.variant_id, p.name, v.shade_name
FROM variants v
JOIN products p ON v.product_id = p.product_id
WHERE v.availability = 'OutOfStock';

CREATE INDEX idx_variants_availability ON variants(availability);

EXPLAIN ANALYZE
SELECT v.variant_id, p.name, v.shade_name
FROM variants v
JOIN products p ON v.product_id = p.product_id
WHERE v.availability = 'OutOfStock';


-- ============================================================
-- OPTIMASI 3: Menulis ulang correlated subquery jadi JOIN
--
-- Penjelasan: versi awal query di bawah menjalankan
-- EXISTS() untuk setiap baris di products. Artinya PostgreSQL
-- perlu mengecek variants berulang-ulang. Kalau diganti JOIN, kerja
-- databasenya jadi lebih ringkas dan biasanya lebih cepat, terlebih saat datanya sudah besar.
-- ============================================================

EXPLAIN ANALYZE
SELECT p.product_id, p.name
FROM products p
WHERE EXISTS (
    SELECT 1 FROM variants v
    WHERE v.product_id = p.product_id
    AND v.compare_at_price IS NOT NULL
)

ORDER BY p.name;

EXPLAIN ANALYZE
SELECT DISTINCT p.product_id, p.name
FROM products p
JOIN variants v ON p.product_id = v.product_id
WHERE v.compare_at_price IS NOT NULL
ORDER BY p.name;
