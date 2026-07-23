CREATE SCHEMA IF NOT EXISTS warehouse;

CREATE TABLE warehouse.availability (
    availability_id  SERIAL PRIMARY KEY,
    status           VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE warehouse.sales (
    product_id           VARCHAR(255) NOT NULL,
    variant_id           VARCHAR(50) NOT NULL,
    category_id          INT NOT NULL,
    availability_id      INT NOT NULL,
    price                NUMERIC(12,2) NOT NULL,
    compare_at_price     NUMERIC(12,2),
    discount_amount      NUMERIC(12,2) NOT NULL DEFAULT 0,
    discount_percentage  NUMERIC(5,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (product_id, variant_id, category_id, availability_id),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id) REFERENCES public.products(product_id),
    CONSTRAINT fk_sales_variant
        FOREIGN KEY (variant_id) REFERENCES public.variants(variant_id),
    CONSTRAINT fk_sales_category
        FOREIGN KEY (category_id) REFERENCES public.categories(category_id),
    CONSTRAINT fk_sales_availability
        FOREIGN KEY (availability_id) REFERENCES warehouse.availability(availability_id)
);
