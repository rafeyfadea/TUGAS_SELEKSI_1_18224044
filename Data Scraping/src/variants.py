import re
from utils import get_all_product_urls, fetch_soup, get_product_ld_json, get_compare_at_price_map, product_id_from_url, append_and_dedup_json

OUTPUT_PATH = "data/variants.json"

SHADE_BPOM_PATTERN = re.compile(r"\d+\.\s*([A-Za-z0-9 &\-']+?)\s*\(BPOM\s*-\s*([A-Z0-9]+)\)")
SINGLE_BPOM_PATTERN = re.compile(r"BPOM\s*[-:]\s*([A-Z0-9]+)")
VARIANT_ID_PATTERN = re.compile(r"variant=(\d+)")


def get_bpom_map(description):
    return {m.group(1).strip(): m.group(2).strip() for m in SHADE_BPOM_PATTERN.finditer(description)}


def get_shade_name(variant_name, product_name):
    if not variant_name or " - " not in variant_name:
        return None
    return variant_name.rsplit(" - ", 1)[-1].strip()


def build_variant_entry(offer, product_id, sku, shade_name, bpom_number, compare_map):
    variant_url = offer.get("url", "")
    id_match = VARIANT_ID_PATTERN.search(variant_url)
    if not id_match:
        return None
    variant_id = id_match.group(1)
    return {
        "variant_id": variant_id,
        "product_id": product_id,
        "sku": sku,
        "shade_name": shade_name,
        "price": float(offer.get("price", 0)),
        "compare_at_price": compare_map.get(variant_id),
        "availability": offer.get("availability", "").split("/")[-1],
        "bpom_number": bpom_number,
    }


def get_variants_detail(url):
    soup = fetch_soup(url)
    if soup is None:
        return []

    data = get_product_ld_json(soup)
    if not data:
        return []

    product_id = product_id_from_url(url)
    description = data.get("description", "") or ""
    bpom_map = get_bpom_map(description)
    compare_map = get_compare_at_price_map(soup)

    variants_list = []

    if data.get("@type") == "ProductGroup":
        product_name = data.get("name", "")
        for variant in data.get("hasVariant", []):
            shade_name = get_shade_name(variant.get("name", ""), product_name)
            entry = build_variant_entry(
                variant.get("offers", {}),
                product_id,
                variant.get("sku"),
                shade_name,
                bpom_map.get(shade_name) if shade_name else None,
                compare_map,
            )
            if entry:
                variants_list.append(entry)
    else:
        single_bpom_match = SINGLE_BPOM_PATTERN.search(description)
        entry = build_variant_entry(
            data.get("offers", {}),
            product_id,
            data.get("sku"),
            None,
            single_bpom_match.group(1) if single_bpom_match else None,
            compare_map,
        )
        if entry:
            variants_list.append(entry)

    return variants_list


def main():
    collection_map = get_all_product_urls()
    all_urls = sorted({u for urls in collection_map.values() for u in urls})

    print("Tahap 2: Memproses setiap URL untuk mendapatkan data varian")
    variant_data = []
    for i, url in enumerate(all_urls, start=1):
        print(f"Memproses produk {i}/{len(all_urls)}...")
        variants_list = get_variants_detail(url)
        if variants_list:
            print(f"  -> Ditemukan {len(variants_list)} varian")
            variant_data.extend(variants_list)
        else:
            print(f"  -> Lewati, tidak ada data varian di: {url}")

    print("\n----------------------------------------")
    print(f"Scraping complete. Total variants: {len(variant_data)}")
    print("----------------------------------------\n")

    append_and_dedup_json(OUTPUT_PATH, variant_data, key="variant_id")
    print(f"Data disimpan di {OUTPUT_PATH}")


if __name__ == "__main__":
    main()