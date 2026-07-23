import json
import psycopg2

DB_CONFIG = {
    "dbname": "motherofpearl_db",
    "user": "danesha",  
    "password": "",
    "host": "localhost",
    "port": 5432,
}

DATA_DIR = "../../Data Scraping/data"


def load_json(filename):
    with open(f"{DATA_DIR}/{filename}", "r", encoding="utf-8") as f:
        return json.load(f)


def main():
    products = load_json("products.json")
    variants = load_json("variants.json")
    categories = load_json("categories.json")
    product_categories = load_json("product_categories.json")

    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    print("Memasukkan products...")
    for p in products:
        cur.execute(
            """
            INSERT INTO products (product_id, name, category, description, netto, pao, url)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (product_id) DO NOTHING
            """,
            (p.get("product_id"), p.get("name"), p.get("category"), p.get("description"),
             p.get("netto"), p.get("pao"), p.get("url")),
        )
    print(f"  {len(products)} baris diproses.")

    print("Memasukkan categories...")
    for c in categories:
        cur.execute(
            """
            INSERT INTO categories (category_id, slug, name)
            VALUES (%s, %s, %s)
            ON CONFLICT (category_id) DO NOTHING
            """,
            (c.get("category_id"), c.get("slug"), c.get("name")),
        )
    print(f"  {len(categories)} baris diproses.")

    cur.execute("SELECT setval('categories_category_id_seq', (SELECT MAX(category_id) FROM categories))")

    print("Memasukkan variants...")
    for v in variants:
        cur.execute(
            """
            INSERT INTO variants (variant_id, product_id, sku, shade_name, price,
                                   compare_at_price, availability, bpom_number)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (variant_id) DO NOTHING
            """,
            (v.get("variant_id"), v.get("product_id"), v.get("sku"), v.get("shade_name"),
             v.get("price"), v.get("compare_at_price"), v.get("availability"), v.get("bpom_number")),
        )
    print(f"  {len(variants)} baris diproses.")

    print("Memasukkan product_categories...")
    for pc in product_categories:
        cur.execute(
            """
            INSERT INTO product_categories (product_id, category_id)
            VALUES (%s, %s)
            ON CONFLICT (product_id, category_id) DO NOTHING
            """,
            (pc.get("product_id"), pc.get("category_id")),
        )
    print(f"  {len(product_categories)} baris diproses.")

    conn.commit()
    cur.close()
    conn.close()
    print("\nSelesai. Semua data hasil scraping sudah masuk ke database.")


if __name__ == "__main__":
    main()