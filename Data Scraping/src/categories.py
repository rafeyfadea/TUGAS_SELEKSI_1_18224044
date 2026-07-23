from utils import get_all_product_urls, product_id_from_url, append_and_dedup_json

CATEGORIES_PATH = "data/categories.json"
RELATIONS_PATH = "data/product_categories.json"


def main():
    collection_map = get_all_product_urls()

    categories = [
        {"category_id": i + 1, "slug": slug, "name": slug.replace("-", " ").title()}
        for i, slug in enumerate(collection_map.keys())
    ]
    slug_to_id = {c["slug"]: c["category_id"] for c in categories}

    relations = []
    for slug, urls in collection_map.items():
        for url in urls:
            product_id = product_id_from_url(url)
            relations.append({
                "relation_id": f"{product_id}-{slug_to_id[slug]}",
                "product_id": product_id,
                "category_id": slug_to_id[slug],
            })

    append_and_dedup_json(CATEGORIES_PATH, categories, key="category_id")
    append_and_dedup_json(RELATIONS_PATH, relations, key="relation_id")

    print(f"{len(categories)} kategori disimpan di {CATEGORIES_PATH}")
    print(f"{len(relations)} relasi produk-kategori disimpan di {RELATIONS_PATH}")


if __name__ == "__main__":
    main()