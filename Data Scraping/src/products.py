import re
from utils import get_all_product_urls, fetch_soup, get_product_ld_json, product_id_from_url, append_and_dedup_json

OUTPUT_PATH = "data/products.json"
NETTO_PATTERN = re.compile(r"Netto:\s*(.*?)Period After Oppening", re.IGNORECASE)
PAO_PATTERN = re.compile(r"Period After Oppening \(PAO\):\s*(.+)$", re.IGNORECASE)


def get_product_detail(url):
    soup = fetch_soup(url)
    if soup is None:
        return None

    data = get_product_ld_json(soup)
    if not data:
        return None

    description = data.get("description", "") or ""
    netto_match = NETTO_PATTERN.search(description)
    pao_match = PAO_PATTERN.search(description)

    return {
        "product_id": product_id_from_url(url),
        "name": data.get("name"),
        "category": data.get("category"),
        "description": description.strip(),
        "netto": netto_match.group(1).strip() if netto_match else None,
        "pao": pao_match.group(1).strip() if pao_match else None,
        "url": url,
    }


def main():
    collection_map = get_all_product_urls()
    all_urls = sorted({u for urls in collection_map.values() for u in urls})

    print("Tahap 2: Memproses setiap URL untuk mendapatkan detail produk")
    products_data = []
    for i, url in enumerate(all_urls, start=1):
        print(f"Memproses produk {i}/{len(all_urls)}...")
        detail = get_product_detail(url)
        if not detail:
            print(f"  -> Lewati, tidak ada blok Product/ProductGroup di: {url}")
            continue
        products_data.append(detail)
        print(f"  -> Berhasil scrape: {detail['name']}")

    print("\n----------------------------------------")
    print(f"Scraping complete. Total products found: {len(products_data)}")
    print("----------------------------------------\n")

    append_and_dedup_json(OUTPUT_PATH, products_data, key="product_id")
    print(f"Data disimpan di {OUTPUT_PATH}")


if __name__ == "__main__":
    main()