<div align="center">
  <img src="Data Scraping/screenshot/ss_website.png" alt="Header" width="100%"/>
</div>

<h2 align="center">
  Data Scraping, Storing, dan Warehousing<br/>
  Katalog Produk <a href="https://motherofpearl.id">Mother of Pearl</a>
</h2>

<p align="center">Seleksi Tahap 2 Asisten Basis Data 2026</p>

---

<details open>
<summary><h2>1. Author</h2></summary>

| Nama | NIM |
|------|-----|
| Rafeyfa Dea Putri Ramadhani | 18224044 |

</details>

<details open>
<summary><h2>2. Deskripsi Singkat</h2></summary>

Mother of Pearl adalah brand kosmetik lokal yang menjual produk makeup dan skincare lewat toko Shopify di motherofpearl.id. Website ini menampilkan katalog produk lengkap dengan harga, daftar shade per produk, status stok, dan nomor izin edar BPOM untuk tiap shade.

Website ini dipilih karena datanya memiliki struktur berlapis yang jelas, sehingga relevan untuk dipraktikkan dalam pemodelan basis data relasional. Data harga yang berubah pada setiap shade (bukan pada tingkat produk) juga menjadi tantangan tersendiri dalam merancang skema basis data yang tepat. Selain itu, topik ini dipilih karena sesuai dengan ketertarikan saya terhadap dunia makeup, sehingga proses eksplorasi data dan analisis produk menjadi lebih menarik.
</details>

<details open>
<summary><h2>3. Cara Menjalankan Scraper</h2></summary>

**Requirements:** Python 3.9+, PostgreSQL 14+, library `requests` dan `beautifulsoup4`.

```sh
git clone [URL_REPOSITORY_HASIL_FORK]
cd [NAMA_FOLDER_PROYEK]/Data\ Scraping/src
pip install -r requirements.txt
python3 products.py
python3 variants.py
python3 categories.py
```

Hasilnya empat file JSON di `Data Scraping/data`: `products.json`, `variants.json`, `categories.json`, `product_categories.json`.

**Load ke database:**
```sh
cd ../../Data\ Storing/src
createdb motherofpearl_db
psql motherofpearl_db -f schema.sql
pip install psycopg2-binary
python3 load_to_postgres.py
```

</details>

<details open>
<summary><h2>4. Struktur File JSON</h2></summary>

**products.json** - satu baris per produk.
```json
{
  "product_id": "g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb",
  "name": "G.W.S (Gleaming, Wonderful, Shiny) Plump Gloss",
  "category": "Lip Gloss",
  "description": "...",
  "netto": "4 ml",
  "pao": "12 months",
  "url": "https://motherofpearl.id/products/..."
}
```

**variants.json** - satu baris per shade. Harga dan stok melekat di sini, bukan di produk, karena tiap shade bisa punya harga berbeda.
```json
{
  "variant_id": "46284845351156",
  "product_id": "g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb",
  "sku": "OFB8J22",
  "shade_name": "MLBB",
  "price": 84150.0,
  "compare_at_price": null,
  "availability": "InStock",
  "bpom_number": "NA18231300591"
}
```

**categories.json** dan **product_categories.json** - daftar kategori dan tabel relasi many-to-many antara produk dan kategori (satu produk bisa masuk lebih dari satu kategori).

</details>

<details open>
<summary><h2>5. ERD dan Diagram Relasional</h2></summary>

<div align="center">
  <img src="Data Storing/design/ERD.png" alt="ERD"/>
</div>

<div align="center">
  <img src="Data Storing/design/relational_diagram.png" alt="Diagram Relasional"/>
</div>

Skema terdiri dari 4 entitas hasil scraping murni (`products`, `variants`, `categories`, `product_categories`) dan 7 tabel tambahan untuk simulasi alur belanja (`customers`, `customer_addresses`, `carts`, `cart_items`, `orders`, `order_items`, `payments`, plus dua subtipe `bank_transfer_payments` dan `ewallet_payments`). Tabel tambahan sengaja dibiarkan kosong sesuai ketentuan tugas.

</details>

<details open>
<summary><h2>6. Translasi ERD ke Relasional</h2></summary>

1. **Entitas jadi tabel.** Tiap entitas kuat langsung jadi tabel dengan primary key masing-masing (`product_id`, `variant_id`, `customer_id`, dan seterusnya).

2. **Relasi one-to-many** ditranslasi dengan menaruh foreign key di sisi banyak. Contoh: `variants.product_id` merujuk ke `products.product_id`.

3. **Relasi many-to-many** ditranslasi jadi tabel penghubung dengan composite primary key. Contoh: `product_categories(product_id, category_id)` menghubungkan `products` dan `categories`.

4. **Relasi many-to-many dengan atribut tambahan** (seperti kuantitas) ditranslasi jadi tabel tersendiri, bukan cuma tabel penghubung kosong. Contoh: `order_items` menyimpan `quantity` dan `price_at_purchase`, bukan cuma pasangan `order_id`-`variant_id`.

5. **Generalization (IS A)** ditranslasi dengan pendekatan table-per-subclass. `payments` jadi tabel superclass, sedangkan `bank_transfer_payments` dan `ewallet_payments` jadi tabel subclass yang primary key-nya (`payment_id`) sekaligus jadi foreign key ke `payments`.

</details>

<details open>
<summary><h2>7. Screenshot</h2></summary>

### Tampilan Website
<div align="center">
  <img src="Data Scraping/screenshot/website.png" alt="SS Website"/>
</div>

### Data Scraping
### Hasil Scraping 1

<div align="center">
  <img src="Data Scraping/screenshot/scraping-1.png" width="850">
</div>

---

### Hasil Scraping 2

<div align="center">
  <img src="Data Scraping/screenshot/scraping-2.png" width="850">
</div>

---

### Hasil Scraping 3

<div align="center">
  <img src="Data Scraping/screenshot/scraping-3.png" width="850">
</div>

### Data Storing
### Proses Storing

<div align="center">
  <img src="Data Storing/screenshot/storing-1.png" alt="Proses Storing" width="850"/>
</div>

---

### List of Relations

<div align="center">
  <img src="Data Storing/screenshot/storing-2.png" alt="List of Relations" width="850"/>
</div>

---

### Product_Categories

<div align="center">
  <img src="Data Storing/screenshot/storing-3.png" alt="Product_Categories" width="850"/>
</div>

---

### Categories

<div align="center">
  <img src="Data Storing/screenshot/storing-4.png" alt="Categories" width="850"/>
</div>

---

### Products

<div align="center">
  <img src="Data Storing/screenshot/storing-5.png" alt="Products" width="850"/>
</div>

---

### Variants

<div align="center">
  <img src="Data Storing/screenshot/storing-6.png" alt="Variants" width="850"/>
</div>

<div align="center">
  <img src="Data Storing/screenshot/storing-7.png" alt="Variants-2" width="850"/>
</div>
<summary><h2>8. Bonus: Data Warehouse</h2></summary>

Skema star, dibangun dari tabel `products`, `variants`, dan `categories` (bukan dari data order, karena tabel order sengaja kosong). Fact table `sales` menyimpan harga dan diskon di level varian, dengan foreign key langsung ke `products`, `variants`, `categories`, dan dimensi baru `availability`.

<div align="center">
  <img src="Data Warehouse/design/data_warehouse_ERD.png" alt="ERD Data Warehouse"/>
</div>

<div align="center">
  <img src="Data Warehouse/design/data_warehouse_Relational.png" alt="Star Schema"/>
</div>

### Creating the Schema and Tables

<div align="center">
  <img src="Data Warehouse/screenshot/warehouse-1.png" alt="Creating the Schema and Tables" width="800"/>
</div>

---

### Loading Data into the Data Warehouse

<div align="center">
  <img src="Data Warehouse/screenshot/warehouse-2.png" alt="Loading Data into the Data Warehouse" width="800"/>
</div>

---

### Analysis Queries

<div align="center">
  <img src="Data Warehouse/screenshot/warehouse-3.png" alt="Analysis Queries" width="800"/>
</div>

<details>
<summary><h2>9. Bonus: Query Optimasi</h2></summary>

Tiga optimasi di `Query Optimasi/query_optimasi.sql`:

1. Index pada `variants.product_id` (foreign key tidak otomatis ter-index di PostgreSQL) untuk mempercepat join produk-varian.
2. Index pada `variants.availability` untuk mempercepat filter berdasarkan status stok.
3. Menulis ulang correlated subquery (`EXISTS`) jadi `JOIN` biasa untuk mencari produk dengan varian diskon.

Bukti perubahan dari Seq Scan ke Index Scan ada di screenshot `EXPLAIN ANALYZE` folder `Query Optimasi`.

</details>

<details open>
<summary><h2>10. Penggunaan AI</h2></summary>

Penyusunan kerangka script scraping awal, debugging, penjelasan konsep ERD/diagram relasional/data warehouse, dan penulisan DDL SQL.

Sementara itu, untuk pemilihan topik dan website, verifikasi manual struktur data lewat inspect element, keputusan desain dilakukan secara mandiri dengan melihat referensi

**Refleksi:** AI banyak membantu mempercepat proses debugging saat asumsi awal soal struktur data website ternyata salah (misalnya soal skema `Product` dan `ProductGroup` di JSON-LD), tapi tetap diperlukan verifikasi manual di browser untuk memastikan setiap solusi sesuai kondisi data yang sebenarnya

</details>

<details open>
<summary><h2>11. Referensi</h2></summary>

1. [Mother of Pearl - All Products](https://motherofpearl.id)
2. [Dokumentasi PostgreSQL](https://www.postgresql.org/)
3. [Dokumentasi Requests](https://requests.readthedocs.io/)
4. [Dokumentasi BeautifulSoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
5. [Dokumentasi psycopg2](https://www.psycopg.org/docs/)

</details>
