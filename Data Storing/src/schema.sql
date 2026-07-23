CREATE TABLE products (
    product_id   VARCHAR(255) PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    category     VARCHAR(100),
    description  TEXT,
    netto        VARCHAR(50),
    pao          VARCHAR(50),
    url          VARCHAR(500)
);

CREATE TABLE variants (
    variant_id        VARCHAR(50) PRIMARY KEY,
    product_id        VARCHAR(255) NOT NULL,
    sku               VARCHAR(50),
    shade_name        VARCHAR(100),
    price             NUMERIC(12,2) NOT NULL,
    compare_at_price  NUMERIC(12,2),
    availability      VARCHAR(30),
    bpom_number       VARCHAR(50),
    CONSTRAINT fk_variants_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE
);

CREATE TABLE categories (
    category_id  SERIAL PRIMARY KEY,
    slug         VARCHAR(100) NOT NULL UNIQUE,
    name         VARCHAR(100) NOT NULL
);

CREATE TABLE product_categories (
    product_id   VARCHAR(255) NOT NULL,
    category_id  INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    CONSTRAINT fk_pc_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_pc_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE CASCADE
);

CREATE TABLE customers (
    customer_id  SERIAL PRIMARY KEY,
    name         VARCHAR(150) NOT NULL,
    email        VARCHAR(150) NOT NULL UNIQUE,
    phone        VARCHAR(30)
);

CREATE TABLE customer_addresses (
    address_id   SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL,
    street       VARCHAR(255) NOT NULL,
    city         VARCHAR(100) NOT NULL,
    province     VARCHAR(100) NOT NULL,
    zip_code     VARCHAR(10),
    CONSTRAINT fk_address_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
);

CREATE TABLE carts (
    cart_id      SERIAL PRIMARY KEY,
    customer_id  INT NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_cart_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
);

CREATE TABLE cart_items (
    cart_item_id  SERIAL PRIMARY KEY,
    cart_id       INT NOT NULL,
    variant_id    VARCHAR(50) NOT NULL,
    quantity      INT NOT NULL CHECK (quantity > 0),
    CONSTRAINT fk_cartitem_cart
        FOREIGN KEY (cart_id) REFERENCES carts(cart_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_cartitem_variant
        FOREIGN KEY (variant_id) REFERENCES variants(variant_id)
        ON DELETE RESTRICT
);

CREATE TABLE orders (
    order_id             SERIAL PRIMARY KEY,
    customer_id          INT NOT NULL,
    shipping_address_id  INT NOT NULL,
    order_date           DATE NOT NULL DEFAULT CURRENT_DATE,
    status               VARCHAR(30) NOT NULL DEFAULT 'pending',
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_order_address
        FOREIGN KEY (shipping_address_id) REFERENCES customer_addresses(address_id)
        ON DELETE RESTRICT
);

CREATE TABLE order_items (
    order_item_id      SERIAL PRIMARY KEY,
    order_id           INT NOT NULL,
    variant_id         VARCHAR(50) NOT NULL,
    quantity           INT NOT NULL CHECK (quantity > 0),
    price_at_purchase  NUMERIC(12,2) NOT NULL,
    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_orderitem_variant
        FOREIGN KEY (variant_id) REFERENCES variants(variant_id)
        ON DELETE RESTRICT
);

CREATE TABLE payments (
    payment_id    SERIAL PRIMARY KEY,
    order_id      INT NOT NULL,
    payment_date  DATE NOT NULL DEFAULT CURRENT_DATE,
    payment_type  VARCHAR(20) NOT NULL CHECK (payment_type IN ('bank_transfer', 'ewallet')),
    amount        NUMERIC(12,2) NOT NULL,
    CONSTRAINT fk_payment_order
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
);


CREATE TABLE bank_transfer_payments (
    payment_id      INT PRIMARY KEY,
    bank_name       VARCHAR(100) NOT NULL,
    account_number  VARCHAR(50) NOT NULL,
    CONSTRAINT fk_banktransfer_payment
        FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
        ON DELETE CASCADE
);

CREATE TABLE ewallet_payments (
    payment_id       INT PRIMARY KEY,
    wallet_provider  VARCHAR(50) NOT NULL,
    CONSTRAINT fk_ewallet_payment
        FOREIGN KEY (payment_id) REFERENCES payments(payment_id)
        ON DELETE CASCADE
);