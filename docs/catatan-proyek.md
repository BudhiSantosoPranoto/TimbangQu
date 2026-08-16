# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan diperbarui setiap keputusan desain ditetapkan.

## 1. Konsep Umum

TimbangQu adalah aplikasi **SaaS multi-tenant** yang digunakan oleh banyak perusahaan klien dalam satu platform dan satu database MySQL.

Prinsip utama:
- Multi-tenant.
- Satu database MySQL untuk banyak perusahaan.
- Data tenant dipisahkan menggunakan `id_perusahaan`.
- Setiap tabel yang datanya dimiliki tenant wajib memiliki `id_perusahaan` dan `NOT NULL`.
- Tabel konfigurasi global seperti `kode_tabel` tidak membutuhkan `id_perusahaan`.

## 2. Standar Database

- Engine: `InnoDB`.
- Character set: `utf8mb4`.
- Collation: `utf8mb4_general_ci`.
- Primary key tabel master/non-transaksi: `id BIGINT UNSIGNED AUTO_INCREMENT`.
- Foreign key digunakan secara resmi.
- Default FK: `ON DELETE RESTRICT` dan `ON UPDATE CASCADE`, kecuali relasi tertentu membutuhkan aturan berbeda.
- Nama constraint FK boleh mengikuti nama otomatis MySQL.

## 3. Konvensi Penamaan

Field domain/bisnis menggunakan Bahasa Indonesia selama tetap jelas dan tidak terlalu panjang.

Field teknis yang umum bagi developer tetap menggunakan Bahasa Inggris:
- `id`
- `created_at`
- `created_by`
- `updated_at`
- `updated_by`
- `deleted_at`
- `deleted_by`

Foreign key menggunakan pola:
- `id_perusahaan`
- `id_user`
- `id_kode_tabel`

## 4. Audit Field

Pola audit standar:

```text
created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
created_by  BIGINT UNSIGNED NOT NULL

updated_at  DATETIME NULL DEFAULT NULL
updated_by  BIGINT UNSIGNED NULL

deleted_at  DATETIME NULL DEFAULT NULL
deleted_by  BIGINT UNSIGNED NULL
```

Lifecycle:
- INSERT: `created_at` dan `created_by` wajib terisi; `updated_*` dan `deleted_*` masih `NULL`.
- UPDATE: `updated_at` dan `updated_by` terisi.
- Soft delete: `deleted_at` dan `deleted_by` terisi.
- Ketiga field user tersebut mengarah ke satu tabel user yang sama.

User internal TimbangQu dan user tenant menggunakan satu tabel user; tipe user yang membedakan keduanya akan dibahas kemudian.

## 5. ID Transaksi

Untuk tabel transaksi digunakan:

```text
id_trx VARCHAR(50) PRIMARY KEY
```

Format:

```text
PREFIKS/DDMMYYYY/ID_USER/URUTAN
```

Contoh:

```text
TBG/04082026/7/00023
```

Arti:
- `TBG` = prefix dari `kode_tabel`.
- `04082026` = tanggal transaksi.
- `7` = `id` user yang melakukan input.
- `00023` = nomor urut.

Nomor urut di-reset berdasarkan kombinasi **user + tanggal**. User yang sama pada tanggal berikutnya kembali ke `00001`; user berbeda pada tanggal yang sama memiliki urutan masing-masing.

Mekanisme generator harus aman terhadap concurrency dan mengikuti pola SQL yang sudah digunakan.

## 6. `kode_tabel`

`kode_tabel` adalah master konfigurasi global dan tidak memiliki `id_perusahaan`.

Struktur:

```text
kode_tabel
-----------
id
nama_tabel
kode
```

`id` digunakan sebagai referensi generator `id_trx`; generator tidak mencari berdasarkan nama tabel. `nama_tabel` digunakan untuk membantu developer dan sebaiknya berisi nama tabel database sebenarnya.

Prefix bersifat global/standar dan tidak dapat diubah oleh tenant.

## 7. Status Perusahaan

Status perusahaan yang disepakati:

```text
menunggu_pembayaran
aktif
suspended
nonaktif
```

Alur umum:

```text
menunggu_pembayaran → aktif → suspended → aktif
                              ↓
                           nonaktif
```

Aturan durasi suspended sebelum menjadi nonaktif belum ditetapkan dan akan dibahas sebagai business rule.

## 8. History Status Perusahaan

Perubahan status memiliki history terpisah, misalnya `status_perusahaan_history`.

History bersifat **append-only** dari sisi UI dan tidak boleh diedit atau dihapus untuk memperbaiki kesalahan. Jika terjadi kesalahan, dibuat record history baru yang menjelaskan koreksi.

Setiap perubahan status wajib memiliki `keterangan` dan tidak boleh kosong.

History minimal memuat konsep:
- `id`
- `id_perusahaan`
- status lama
- status baru
- `keterangan`
- `nama_file` (opsional)
- `created_at`
- `created_by`

Perubahan dengan status lama dan baru yang sama tetap boleh dicatat jika ada kejadian/keterangan baru.

`nama_file` hanya menyimpan nama/path relatif file; file fisiknya disimpan di folder server.

## 9. Validasi Database dan Pesan Error

Validasi penting untuk integritas data tidak hanya bergantung pada UI. Database juga dapat menolak operasi tidak valid menggunakan trigger dan:

```sql
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = '...';
```

Pesan error harus jelas agar admin/developer memahami penyebab kegagalan.

Karena TimbangQu berpotensi digunakan perusahaan asing, warning/error minimal perlu mendukung **Bahasa Indonesia dan Bahasa Inggris**. Bahasa Mandarin diinginkan sebagai kemungkinan pengembangan, tetapi belum diputuskan.

## 10. Identitas Perusahaan

### 10.1 Primary Key

Tabel `perusahaan` menggunakan:

```text
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY
```

`id` adalah technical primary key. Gap pada `AUTO_INCREMENT` diperbolehkan dan tidak menjadi masalah.

### 10.2 `kode_perusahaan`

`kode_perusahaan` adalah business identifier yang terpisah dari `id` dan **tidak diturunkan dari `AUTO_INCREMENT id`**.

Keputusan yang sudah disepakati:
- Panjang database: **10 karakter**.
- Tipe yang direncanakan: `CHAR(10)`.
- Wajib `NOT NULL`.
- Wajib `UNIQUE` secara global.
- Menggunakan alfabet Crockford Base32.
- Tujuan utama: mudah dibaca, mudah disebutkan kepada customer service, dan tidak terlalu panjang.
- Tanda `-` hanya untuk tampilan UI, bukan bagian dari nilai database.

Format UI:

```text
7-K4M-2X9-QTP
```

Pola: `1-3-3-3`.

Nilai database:

```text
7K4M2X9QTP
```

10 karakter Crockford Base32 memberikan:

```text
32^10 = 1.125.899.906.842.624
```

sehingga kapasitasnya jauh melebihi kebutuhan realistis jumlah perusahaan.

### 10.3 Generator `kode_perusahaan`

Sumber kode **tidak menggunakan `AUTO_INCREMENT id` perusahaan**, karena `AUTO_INCREMENT` dapat memiliki gap ketika transaksi gagal/rollback.

Konsep generator yang disepakati untuk dilanjutkan:
- menggunakan sequence khusus yang terpisah dari primary key perusahaan;
- sequence diproses secara transactional sehingga kegagalan transaksi dapat di-rollback;
- sequence dipetakan menggunakan permutation deterministik/bijektif ke ruang 50-bit;
- hasilnya di-encode dengan Crockford Base32 menjadi 10 karakter;
- bukan random sehingga tidak membutuhkan retry collision;
- `UNIQUE` pada database tetap menjadi lapisan pengaman.

Algoritma dan implementasi MySQL final **belum dinyatakan final**. Sebelum diterapkan, harus diuji dengan function/procedure/trigger MySQL dan simulasi concurrency/performance.

### 10.4 Nama Perusahaan

Field nama perusahaan disepakati menggunakan:

```text
nama_perusahaan VARCHAR(200) NOT NULL
```

`VARCHAR(200)` dipilih agar cukup longgar untuk nama perusahaan lokal maupun asing. Panjang `VARCHAR` tidak berarti storage selalu menggunakan 200 karakter; storage mengikuti panjang aktual data. Karena field ini tidak otomatis harus di-index penuh, ukuran 200 karakter tidak dianggap sebagai bottleneck performa.

### 10.5 Alamat Perusahaan

Alamat perusahaan dipisahkan antara alamat bebas dan data wilayah regional:

```text
alamat         TEXT
rt             VARCHAR(3) NULL
rw             VARCHAR(3) NULL
id_kelurahan   INT(11) UNSIGNED NOT NULL
```

`alamat` berisi bagian alamat bebas, misalnya:

```text
Jalan Kaloran nomor 48
```

atau:

```text
Sudirman Tower Kav 33-35
Jalan Jendral Sudirman
```

`rt` dan `rw` bersifat opsional (`NULL`) karena tidak semua alamat kantor memiliki atau mengetahui RT/RW. Nilainya tidak perlu divalidasi terlalu ketat; input seperti `9`, `09`, atau `009` diperbolehkan sesuai kebutuhan.

`id_kelurahan` wajib diisi dan bertipe **`INT(11) UNSIGNED`**, mengikuti tipe primary key/identifier pada database regional. Foreign key harus menggunakan tipe yang kompatibel.

Informasi wilayah seperti kelurahan, kecamatan, kota/kabupaten, provinsi, dan kode pos dapat diperoleh melalui relasi tersebut dan nantinya dapat disediakan melalui `VIEW` untuk kebutuhan tampilan/report.

Index untuk field alamat tidak dibuat otomatis. `id_kelurahan` akan dipertimbangkan/diberi index karena merupakan FK dan berpotensi digunakan untuk filtering/join. `alamat`, `rt`, dan `rw` tidak perlu index biasa tanpa kebutuhan query yang nyata.

### 10.6 Kontak Perusahaan

Field kontak utama perusahaan menggunakan nama singkat:

```text
telp_kantor
media_telp_kantor
nama_cp
no_hp_cp
media_cp
email
website
```

`email` perusahaan **bersifat nullable**, karena perusahaan kecil/UMKM belum tentu memiliki alamat email. Jika tersedia, email dapat digunakan sebagai kanal komunikasi resmi, termasuk kebutuhan invoice, notifikasi subscription, pembayaran, dan komunikasi administratif.

`website` juga **nullable**, karena tidak semua perusahaan memiliki website.

`telp_kantor`, `no_hp_cp`, dan field nomor kontak lainnya disimpan sebagai `VARCHAR`, bukan numeric, karena nomor telepon dapat memiliki kode negara, kode area, format lokal, atau karakter pemisah.

`telp_kantor` bersifat nullable. `media_telp_kantor` membedakan media/cara menghubungi nomor tersebut, misalnya Telepon Kabel atau WhatsApp. Field ini merupakan FK ke master `media_kontak`, bukan ENUM.

`nama_cp` dan `no_hp_cp` juga nullable. Contact person disimpan karena secara operasional lebih nyaman bagi admin/support mengetahui siapa orang yang harus dihubungi.

`media_cp` merupakan FK ke master `media_kontak`, untuk menunjukkan media/cara yang dapat digunakan untuk menghubungi contact person.

### 10.7 Master `media_kontak`

Dibuat tabel master global:

```text
media_kontak
------------
id
nama_media
created_at
created_by
updated_at
updated_by
deleted_at
deleted_by
```

`media_kontak` berarti **media atau cara yang digunakan untuk menghubungi suatu nomor/contact person**. Field FK yang mengarah ke tabel ini harus diberi komentar database agar developer memahami bahwa nilainya bukan sekadar jenis nomor telepon.

Primary key menggunakan `SMALLINT UNSIGNED AUTO_INCREMENT`, karena jumlah media kontak yang mungkin digunakan jauh di bawah kapasitas `SMALLINT UNSIGNED`.

Default awal dapat berisi:

```text
1. Tidak ada
2. Telepon Kabel
3. WhatsApp
4. WeChat
5. LINE
6. KakaoTalk
```

dan aplikasi/media populer lainnya.

UI menyediakan operasi **tambah dan ubah** untuk master ini. Tidak ada operasi delete di UI, agar media kontak yang sudah pernah digunakan tidak mudah menghilang dari referensi data historis.

Jika suatu saat media/aplikasi baru belum tersedia, admin dapat menambahkannya melalui UI tanpa perlu mengubah struktur tabel `perusahaan`.

## 11. Sequence `id_trx`

Nomor urut `id_trx` menggunakan kombinasi user + tanggal dan reset setiap pergantian tanggal. Detail implementasi mengikuti procedure/trigger SQL yang sudah digunakan dan akan diverifikasi sebelum ditulis sebagai standar final.

## 12. Timezone dan Tanggal/Waktu

- Operasional awal menggunakan wilayah UTC+7 seperti Bangkok/Hanoi/Jakarta.
- Penyimpanan tanggal/waktu menggunakan `DATETIME`, bukan `TIMESTAMP`.
- `DATE` digunakan bila hanya membutuhkan tanggal.
- Format tanggal umum MySQL: `YYYY-MM-DD`.

## 13. Langganan dan Penagihan

TimbangQu menggunakan mekanisme subscription yang sebisa mungkin otomatis oleh sistem.

Konsep awal:
- Perusahaan memiliki paket/langganan.
- Ada tanggal mulai langganan.
- Ada tanggal jatuh tempo/tagihan berikutnya.
- Invoice dibuat otomatis.
- Pembayaran melalui Midtrans.
- Status pembayaran diperbarui berdasarkan webhook/notifikasi Midtrans.
- Pembayaran berhasil memperpanjang masa langganan.
- Melewati jatuh tempo tanpa pembayaran dapat menyebabkan akses dinonaktifkan sesuai aturan subscription.

## 14. Paket Langganan

Struktur paket belum final karena harga, fitur/service, harga konektor Bluetooth, komponen biaya, aturan, dan benefit masih dapat berubah. Database harus fleksibel dan tidak meng-hardcode harga/fitur ke tabel perusahaan.

## 15. Prinsip Dokumentasi

Repository GitHub adalah pusat dokumentasi teknis dan bisnis TimbangQu.

Dokumen Markdown adalah **living document**. Jika keputusan berubah, dokumen yang sama diperbarui; Git menyimpan history melalui commit.

Mulai sesi ini, **setiap keputusan yang sudah disepakati langsung dicatat ke Markdown**, bukan menunggu lima keputusan.

## 16. Hal yang Masih Perlu Dibahas

1. Struktur tabel perusahaan secara rinci.
2. Algoritma dan implementasi final generator `kode_perusahaan` di MySQL.
3. Struktur user dan hak akses.
4. Tipe/status user internal dan tenant.
5. Mekanisme multilingual pesan validasi/error.
6. Struktur paket langganan.
7. Struktur subscription perusahaan.
8. Struktur invoice dan detail invoice.
9. Integrasi Midtrans dan webhook.
10. Aturan jatuh tempo, grace period, suspended, dan nonaktif.
11. Struktur konektor Bluetooth.
12. Struktur perangkat/timbangan.
13. Struktur transaksi penimbangan.
14. Mekanisme generator `id_trx` yang aman terhadap concurrency.
15. Index, constraint, dan strategi performa database.

---

**Status:** Fondasi arsitektur sedang dirumuskan. Keputusan yang belum dinyatakan final masih dapat berubah melalui pembahasan berikutnya.
