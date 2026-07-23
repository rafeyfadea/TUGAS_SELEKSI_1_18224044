import psycopg2

DB_CONFIG = {
    "dbname": "motherofpearl_db",
    "user": "danesha",
    "password": "",
    "host": "localhost",
    "port": 5432,
}

LOG_FILE = "../etl_log.txt"


def main():
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    counts = {}
    for table in ["products", "variants", "categories", "product_categories"]:
        cur.execute(f"SELECT COUNT(*) FROM public.{table}")
        counts[table] = cur.fetchone()[0]

    cur.execute(
        """
        INSERT INTO public.scrape_log
            (products_count, variants_count, categories_count, product_categories_count)
        VALUES (%s, %s, %s, %s)
        RETURNING run_id, run_at
        """,
        (counts["products"], counts["variants"], counts["categories"], counts["product_categories"]),
    )
    run_id, run_at = cur.fetchone()
    conn.commit()
    cur.close()
    conn.close()

    log_line = (
        f"[{run_at}] Run #{run_id} - "
        f"products={counts['products']} variants={counts['variants']} "
        f"categories={counts['categories']} product_categories={counts['product_categories']}\n"
    )
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(log_line)

    print(log_line.strip())


if __name__ == "__main__":
    main()
