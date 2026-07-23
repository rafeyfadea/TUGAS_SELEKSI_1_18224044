import json
import os
import time
import requests
from bs4 import BeautifulSoup

BASE_URL = "https://motherofpearl.id"
COLLECTIONS = [
    "face-all",
    "eyes",
    "lips-all",
    "cheeks",
    "skincare",
    "headband",
]

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; ITB-Basdat-Seleksi-Scraper/1.0)"
}
REQUEST_DELAY_SECONDS = 1.5


def fetch_soup(url, retries=3):
    for attempt in range(1, retries + 1):
        try:
            resp = requests.get(url, headers=HEADERS, timeout=15)
            resp.raise_for_status()
            return BeautifulSoup(resp.text, "html.parser")
        except requests.RequestException as e:
            print(f"  -> gagal ambil {url} (percobaan {attempt}/{retries}): {e}")
            if attempt < retries:
                time.sleep(3)
    print(f"  -> Skip produk setelah {retries} percobaan gagal.")
    return None


def get_all_product_urls():
    print("Tahap 1: Mengumpulkan semua URL produk")
    collection_map = {}
    for slug in COLLECTIONS:
        urls = set()
        page = 1
        while True:
            soup = fetch_soup(f"{BASE_URL}/collections/{slug}?page={page}")
            if soup is None:
                break
            links = set()
            for a in soup.select('a[href*="/products/"]'):
                href = a.get("href", "").split("?")[0]
                if href.startswith("/products/"):
                    links.add(BASE_URL + href)
                elif href.startswith(BASE_URL + "/products/"):
                    links.add(href)
            if not links:
                break
            urls.update(links)
            print(f"  {slug} halaman {page}: {len(links)} produk")
            pagination = soup.select_one('[class*="pagination"], nav[role="navigation"]')
            has_next = pagination and pagination.find(
                "a", string=lambda s: s and s.strip().lower() in ("next", ">", "»")
            )
            if not has_next:
                break
            page += 1
            time.sleep(REQUEST_DELAY_SECONDS)
        collection_map[slug] = sorted(urls)
        time.sleep(REQUEST_DELAY_SECONDS)

    total = len({u for urls in collection_map.values() for u in urls})
    print(f"Selesai. Total {total} URL produk unik ditemukan.\n")
    return collection_map


def get_product_ld_json(soup):
    for script in soup.find_all("script", type="application/ld+json"):
        try:
            data = json.loads(script.string)
        except (json.JSONDecodeError, TypeError):
            continue
        if data.get("@type") in ("ProductGroup", "Product"):
            return data
    return None


def product_id_from_url(url):
    return url.rstrip("/").split("/products/")[-1].split("?")[0]


def get_compare_at_price_map(soup):
    script = soup.find("script", id=lambda i: i and i.startswith("MopVariantPrices"))
    if not script:
        return {}
    try:
        data = json.loads(script.string)
    except (json.JSONDecodeError, TypeError):
        return {}

    result = {}
    for v in data.get("variants", []):
        price = v.get("price", 0)
        compare = v.get("compare")
        if compare and compare != price:
            result[str(v["id"])] = compare / 100
    return result


def append_and_dedup_json(file_path, new_data, key):
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    if os.path.exists(file_path):
        with open(file_path, "r", encoding="utf-8") as f:
            old_data = json.load(f)
    else:
        old_data = []

    combined = old_data + new_data
    unique_data = {str(item[key]): item for item in combined}.values()

    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(list(unique_data), f, indent=2, ensure_ascii=False)