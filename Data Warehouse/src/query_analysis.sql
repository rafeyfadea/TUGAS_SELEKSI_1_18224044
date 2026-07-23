
-- 1. Rata-rata persentase diskon per kategori
SELECT
    c.name AS category_name,
    ROUND(AVG(s.discount_percentage), 2) AS avg_discount_pct,
    COUNT(*) AS jumlah_varian
FROM warehouse.sales s
JOIN public.categories c ON s.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_discount_pct DESC;


-- 2. Lima varian dengan diskon terbesar
SELECT
    p.name AS product_name,
    v.shade_name,
    s.price,
    s.compare_at_price,
    s.discount_amount,
    s.discount_percentage
FROM warehouse.sales s
JOIN public.products p ON s.product_id = p.product_id
JOIN public.variants v ON s.variant_id = v.variant_id
WHERE s.discount_amount > 0
ORDER BY s.discount_amount DESC
LIMIT 5;


-- 3. Perbandingan rata-rata harga antara varian yang stoknya
--    tersedia vs habis
SELECT
    a.status,
    COUNT(*) AS jumlah_varian,
    ROUND(AVG(s.price), 2) AS rata_rata_harga
FROM warehouse.sales s
JOIN warehouse.availability a ON s.availability_id = a.availability_id
GROUP BY a.status
ORDER BY jumlah_varian DESC;
