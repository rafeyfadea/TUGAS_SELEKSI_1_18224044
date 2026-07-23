CREATE TABLE IF NOT EXISTS public.scrape_log (
    run_id                    SERIAL PRIMARY KEY,
    run_at                    TIMESTAMP NOT NULL DEFAULT NOW(),
    products_count            INT,
    variants_count            INT,
    categories_count          INT,
    product_categories_count  INT
);
