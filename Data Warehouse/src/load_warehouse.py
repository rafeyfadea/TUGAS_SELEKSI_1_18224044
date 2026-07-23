import psycopg2
from psycopg2.extras import RealDictCursor

DB_CONFIG = {
    "dbname": "motherofpearl_db",
    "user": "danesha",
    "password": "",
    "host": "localhost",
    "port": 5432,
}


def main():
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor(cursor_factory=RealDictCursor)

    print("Load warehouse.availability...")
    cur.execute("SELECT DISTINCT availability FROM public.variants WHERE availability IS NOT NULL")
    statuses = [row["availability"] for row in cur.fetchall()]
    availability_id_map = {}
    for status in statuses:
        cur.execute(
            """
            INSERT INTO warehouse.availability (status)
            VALUES (%s)
            ON CONFLICT (status) DO NOTHING
            RETURNING availability_id
            """,
            (status,),
        )
        row = cur.fetchone()
        if row is None:
            cur.execute("SELECT availability_id FROM warehouse.availability WHERE status = %s", (status,))
            row = cur.fetchone()
        availability_id_map[status] = row["availability_id"]
    print(f"  {len(availability_id_map)} status ketersediaan.")

    print("Menentukan kategori utama tiap produk...")
    cur.execute("""
        SELECT DISTINCT ON (product_id)
            product_id, category_id
        FROM public.product_categories
        ORDER BY product_id, category_id ASC
    """)
    primary_category_map = {row["product_id"]: row["category_id"] for row in cur.fetchall()}
    print(f"  {len(primary_category_map)} produk punya kategori utama.")

    print("Load warehouse.sales...")
    cur.execute("""
        SELECT variant_id, product_id, price, compare_at_price, availability
        FROM public.variants
    """)
    variants = cur.fetchall()
    inserted, skipped = 0, 0
    for v in variants:
        category_id = primary_category_map.get(v["product_id"])
        availability_id = availability_id_map.get(v["availability"])
        if category_id is None or availability_id is None:
            skipped += 1
            continue

        price = float(v["price"])
        compare = float(v["compare_at_price"]) if v["compare_at_price"] else None
        discount_amount = (compare - price) if compare else 0
        discount_pct = round((discount_amount / compare * 100), 2) if compare and compare > 0 else 0

        cur.execute(
            """
            INSERT INTO warehouse.sales
                (product_id, variant_id, category_id, availability_id,
                 price, compare_at_price, discount_amount, discount_percentage)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (product_id, variant_id, category_id, availability_id) DO NOTHING
            """,
            (v["product_id"], v["variant_id"], category_id, availability_id,
             price, compare, discount_amount, discount_pct),
        )
        inserted += 1
    print(f"  {inserted} baris masuk, {skipped} dilewati (kategori/availability tidak ketemu).")

    conn.commit()
    cur.close()
    conn.close()
    print("\nETL warehouse selesai.")


if __name__ == "__main__":
    main()
