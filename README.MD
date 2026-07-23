<div align="center">
  <img src="Data Scraping/screenshot/header.png" alt="Header" width="100%"/>
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
<summary><h2>3. Specification and File Structure</h2></summary>

**Requirements:** Python 3.9+, PostgreSQL 14+.

### Specification

Python digunakan untuk seluruh proses scraping dan loading data, sedangkan PostgreSQL digunakan sebagai Relational Database Management System (RDBMS) untuk menyimpan hasil scraping. Berikut adalah library yang digunakan beserta alasan pemilihannya.

<details>
<summary><code>requests</code></summary>

**Alasan:** Halaman produk dan koleksi pada website Mother of Pearl sudah merender data lengkap pada HTML awal tanpa memerlukan JavaScript, sehingga cukup menggunakan HTTP request biasa.

</details>

<details>
<summary><code>beautifulsoup4</code></summary>

**Alasan:** Digunakan untuk melakukan parsing HTML hasil request dan mengambil data dari tag `<script type="application/ld+json">` yang berisi informasi produk dalam format terstruktur.

</details>

<details>
<summary><code>psycopg2</code></summary>

**Alasan:** Digunakan untuk menghubungkan Python dengan PostgreSQL sehingga data hasil scraping dapat dimasukkan langsung ke database melalui program.

</details>

<details>
<summary><code>json</code> (Built-in Python)</summary>

**Alasan:** Digunakan untuk menyimpan hasil scraping ke dalam file berformat JSON yang terstruktur dan mudah digunakan kembali pada proses loading.

</details>

<details>
<summary><code>re</code> (Built-in Python)</summary>

**Alasan:** Digunakan untuk mengekstrak pola teks tertentu dari deskripsi produk, seperti daftar nomor BPOM untuk setiap shade, informasi netto, dan PAO yang tidak memiliki struktur tetap.

</details>

<details>
<summary><code>time</code> (Built-in Python)</summary>

**Alasan:** Digunakan untuk memberikan jeda antar HTTP request agar proses scraping tidak membebani server dan tetap mengikuti etika web scraping.

</details>

<details>
<summary><code>os</code> (Built-in Python)</summary>

**Alasan:** Digunakan untuk memastikan direktori penyimpanan data tersedia sebelum file JSON hasil scraping dibuat.

</details>

 
**Load ke database:**
```sh
cd ../../Data\ Storing/src
createdb motherofpearl_db
psql motherofpearl_db -f schema.sql
pip install psycopg2-binary
python3 load_to_postgres.py
```

</details>


## File Structure

### `products.json`

Berisi informasi utama setiap produk. Data yang disimpan meliputi identitas produk, nama, kategori utama, deskripsi, isi bersih (netto), periode penggunaan setelah dibuka (PAO), dan URL halaman produk.

Contoh:

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

---

### `variants.json`

Berisi informasi setiap **varian (shade)** produk. Atributnya meliputi Harga, SKU, status ketersediaan, dan nomor BPOM disimpan pada level varian karena setiap shade dapat memiliki atribut yang berbeda.

Contoh:

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

---

### `categories.json`

Berisi daftar seluruh kategori produk. Setiap kategori memiliki ID unik, slug, dan nama kategori.

Contoh:

```json
{
  "category_id": 3,
  "slug": "lips-all",
  "name": "Lips All"
}
```

---

### `product_categories.json`

Berisi tabel relasi antara produk dan kategori. Setiap objek merepresentasikan **satu hubungan antara satu produk dan satu kategori**
Contoh:

```json
{
  "product_id": "g-w-s-gleaming-wonderful-shiny-plump-gloss-01-mlbb",
  "category_id": 3
}
```
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

<details open>
<summary><h2>9. Bonus: Query Optimasi</h2></summary>

Berikut 3 query yang dioptimalkan menggunakan index dan penulisan ulang query, beserta perbandingan **EXPLAIN ANALYZE** sebelum dan sesudah.

| No. | Optimasi | Perbaikan yang Ditambahkan | Perubahan Query Plan |
| --- | --- | --- | --- |
| 1 | Index pada **Foreign Key** `variants.product_id` | Menambahkan B-tree index pada `variants.product_id` karena PostgreSQL tidak otomatis membuat index pada foreign key. | **Seq Scan** → **Index Scan** |
| 2 | Index pada `variants.availability` | Menambahkan B-tree index pada kolom `availability` untuk mempercepat pencarian berdasarkan status stok. | **Seq Scan** → **Index Scan** |
| 3 | Menulis Ulang **Correlated Subquery** menjadi **JOIN** | Mengganti `EXISTS` dengan `JOIN` + `DISTINCT` agar tabel `variants` tidak discan berulang kali. | Scan berulang pada `variants` → Satu kali scan gabungan |

---

### Optimasi 1: Index pada Foreign Key `variants.product_id`

**Before Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-1a.png" alt="Before Optimization 1" width="700"/>
</div>

**After Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-1b.png" alt="After Optimization 1" width="700"/>
</div>

---

### Optimasi 2: Index pada `variants.availability`

**Before Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-2a.png" alt="Before Optimization 2" width="700"/>
</div>

**After Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-2b.png" alt="After Optimization 2" width="700"/>
</div>

---

### Optimasi 3: Menulis Ulang Correlated Subquery menjadi JOIN

**Before Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-3a.png" alt="Before Optimization 3" width="700"/>
</div>

**After Optimization**

<div align="left">
  <img src="Query Optimization/screenshot/optimization-3b.png" alt="After Optimization 3" width="700"/>
</div>
<details open>
<summary><h2>10. Bonus: Automated Scheduling</h2></summary>

Seluruh pipeline (**scraping**, **loading ke database**, dan **pencatatan log**) digabungkan ke dalam satu wrapper script `run_pipeline.sh`. Script tersebut kemudian dijadwalkan menggunakan `cron` sehingga proses ETL dapat berjalan secara otomatis tanpa perlu dijalankan secara manual.

Setiap kali pipeline dijalankan, jumlah record pada setiap tabel dicatat ke dalam file `Automated Scheduling/etl_log.txt` beserta timestamp eksekusinya. Karena proses scraping melakukan deduplikasi berdasarkan primary key dan proses loading menggunakan `ON CONFLICT DO NOTHING`, menjalankan pipeline berulang kali tidak menghasilkan data duplikat, melainkan hanya menambahkan catatan waktu eksekusi.

### Menjalankan Pipeline Secara Manual

```bash
cd "Automated Scheduling/src"
chmod +x run_pipeline.sh
./run_pipeline.sh
```

### Menjadwalkan Menggunakan Cron

```bash
crontab -e
```

Tambahkan baris berikut (sesuaikan dengan lokasi project):

```cron
0 */6 * * * /path/to/project/Automated\ Scheduling/src/run_pipeline.sh >> /path/to/project/Automated\ Scheduling/cron_output.log 2>&1
```

Perintah di atas akan menjalankan pipeline setiap **6 jam**. Untuk melihat daftar cron yang telah terpasang, jalankan:

```bash
crontab -l
```

### Screenshot

<div align="left">
  <img src="Automated Scheduling/screenshot/scheduling-1.png" alt="Cron job berhasil terpasang" width="700"/>
</div>

<div align="left">
  <img src="Automated Scheduling/screenshot/scheduling-2.png" alt="Pipeline berjalan otomatis" width="700"/>
</div>

<div align="left">
  <img src="Automated Scheduling/screenshot/scheduling-3.png" alt="ETL log menunjukkan dua kali eksekusi tanpa data duplikat" width="700"/>
</div>

</details>

<details open>
<summary><h2>11. Penggunaan AI</h2></summary>

Penyusunan kerangka script scraping awal, debugging, penjelasan konsep ERD/diagram relasional/data warehouse, dan penulisan DDL SQL.

Sementara itu, untuk pemilihan topik dan website, verifikasi manual struktur data lewat inspect element, keputusan desain dilakukan secara mandiri dengan melihat referensi

**Refleksi:** AI banyak membantu mempercepat proses debugging saat asumsi awal soal struktur data website ternyata salah (misalnya soal skema `Product` dan `ProductGroup` di JSON-LD), tapi tetap diperlukan verifikasi manual di browser untuk memastikan setiap solusi sesuai kondisi data yang sebenarnya

</details>

<details open>
<summary><h2>12. Referensi</h2></summary>

1. [Mother of Pearl - All Products](https://motherofpearl.id)
2. [Dokumentasi PostgreSQL](https://www.postgresql.org/)
3. [Dokumentasi Requests](https://requests.readthedocs.io/)
4. [Dokumentasi BeautifulSoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/)
5. [Dokumentasi psycopg2](https://www.psycopg.org/docs/)

</details>
