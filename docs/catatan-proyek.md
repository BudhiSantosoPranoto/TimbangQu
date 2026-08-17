# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan diperbarui setiap keputusan desain ditetapkan.

## 1. Konsep Umum

TimbangQu adalah aplikasi SaaS multi-tenant dengan satu database MySQL. Data tenant dipisahkan menggunakan `id_perusahaan` yang wajib `NOT NULL` pada tabel tenant.

## 2. Standar Database

- Engine: InnoDB.
- Character set: utf8mb4.
- Collation: utf8mb4_general_ci.
- Primary key tabel master/non-transaksi: `id BIGINT UNSIGNED AUTO_INCREMENT`.
- Foreign key digunakan secara resmi.
- Default FK: `ON DELETE RESTRICT` dan `ON UPDATE CASCADE`, kecuali relasi tertentu membutuhkan aturan berbeda.
- Nama constraint FK boleh mengikuti nama otomatis MySQL.

## 3. Audit Field

Pola audit standar:

```text
created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
created_by  BIGINT UNSIGNED NOT NULL
updated_at  DATETIME NULL DEFAULT NULL
updated_by  BIGINT UNSIGNED NULL
deleted_at  DATETIME NULL DEFAULT NULL
deleted_by  BIGINT UNSIGNED NULL
```

INSERT mengisi created_*. UPDATE mengisi updated_*. Soft delete mengisi deleted_*. User internal TimbangQu dan user tenant menggunakan satu tabel user.

## 4. ID Transaksi

Tabel transaksi menggunakan `id_trx VARCHAR(50) PRIMARY KEY` dengan format `PREFIKS/DDMMYYYY/ID_USER/URUTAN`. Nomor urut reset berdasarkan kombinasi user + tanggal.

## 5. `kode_tabel`

Master konfigurasi global tanpa `id_perusahaan`. `id` digunakan generator `id_trx`; generator tidak mencari berdasarkan nama tabel. Prefix global dan tidak dapat diubah tenant.

## 6. Status Perusahaan

Status: `menunggu_pembayaran`, `aktif`, `suspended`, `nonaktif`. Detail durasi suspended sebelum nonaktif masih menjadi business rule.

## 7. History Status Perusahaan

History status terpisah, append-only dari UI, tidak boleh diedit/dihapus untuk memperbaiki kesalahan. Setiap perubahan wajib punya keterangan. Dokumen pendukung dapat disimpan sebagai nama file/path relatif, sedangkan file fisik berada di folder server.

## 8. Validasi dan Pesan Error

Validasi integritas dapat menggunakan trigger `SIGNAL SQLSTATE '45000'` dengan pesan yang jelas. Warning/error minimal Indonesia dan Inggris; Mandarin masih kemungkinan pengembangan.

## 9. Identitas Perusahaan

### 9.1 Primary Key

```text
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY
```

Gap AUTO_INCREMENT diperbolehkan.

### 9.2 `kode_perusahaan`

Business identifier terpisah dari `id`, tidak diturunkan dari AUTO_INCREMENT. Direncanakan `CHAR(10) NOT NULL UNIQUE`, alfabet Crockford Base32. Nilai database 10 karakter, tanda `-` hanya tampilan UI dengan format `1-3-3-3`, contoh `7-K4M-2X9-QTP`.

### 9.3 Generator `kode_perusahaan`

Tidak memakai AUTO_INCREMENT perusahaan. Konsep generator: sequence terpisah yang transactional, permutation deterministik/bijektif pada ruang 50-bit, encode Crockford Base32 10 karakter, bukan random, UNIQUE sebagai pengaman. Implementasi MySQL final masih harus diuji dengan simulasi concurrency/performance.

### 9.4 Nama Perusahaan

```text
nama_perusahaan VARCHAR(200) NOT NULL
nama_alias     VARCHAR(200) NULL
```

`nama_perusahaan` adalah nama legal/resmi. `nama_alias` adalah nama singkat untuk UI, laporan, dan komunikasi sehari-hari.

### 9.5 Alamat Perusahaan

```text
alamat         TEXT
rt             VARCHAR(3) NULL
rw             VARCHAR(3) NULL
id_kelurahan   INT(11) UNSIGNED NOT NULL
```

`alamat` berisi bagian alamat bebas. `rt` dan `rw` nullable dan tidak divalidasi terlalu ketat. `id_kelurahan` wajib dan menjadi referensi database regional.

**Kode pos, kecamatan, kota/kabupaten, provinsi, dan informasi wilayah lain tidak disimpan ulang di tabel `perusahaan`; semuanya diperoleh melalui `id_kelurahan` dari database regional dan dapat disajikan melalui `VIEW`.** Tujuannya menghindari duplikasi data regional dan menjaga konsistensi.

`id_kelurahan` perlu index karena merupakan FK dan berpotensi digunakan untuk join/filter. `alamat`, `rt`, dan `rw` tidak diberi index biasa tanpa kebutuhan query nyata.

### 9.6 Kontak Perusahaan

```text
telp_kantor
media_telp_kantor
nama_cp
no_hp_cp
media_cp
email
website
npwp
```

`email`, `website`, dan `npwp` nullable. `npwp` tetap bernama `npwp`, tetapi komentar database dan label UI menjelaskan bahwa untuk perusahaan luar Indonesia field ini digunakan untuk Tax ID/Tax Identification Number atau identitas pajak setara.

Nomor kontak disimpan sebagai VARCHAR, bukan numeric. `media_telp_kantor` dan `media_cp` adalah FK ke master `media_kontak`.

### 9.7 Master `media_kontak`

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

`media_kontak` berarti media atau cara yang digunakan untuk menghubungi nomor/contact person. FK yang mengarah ke tabel ini harus diberi komentar database agar developer memahami maknanya.

Primary key `SMALLINT UNSIGNED AUTO_INCREMENT`. Default awal antara lain Tidak ada, Telepon Kabel, WhatsApp, WeChat, LINE, KakaoTalk, dan media populer lainnya. UI hanya Tambah dan Ubah; tidak ada Delete.

### 9.8 Rekening Perusahaan

Rekening perusahaan disiapkan sebagai tabel terpisah walaupun penggunaannya belum wajib untuk operasional awal. Satu perusahaan boleh memiliki lebih dari satu rekening.

Struktur:

```text
rekening_perusahaan
-------------------
id
id_perusahaan
nomor_reknt
id_lk
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

`nomor_reknt` berarti **nomor rekening non tunai** dan field tersebut wajib diberi komentar database agar developer memahami kepanjangannya.

`id_perusahaan` adalah FK ke `perusahaan.id` dan wajib `NOT NULL`.

`id_lk` adalah FK ke `lembaga_keuangan.id`.

Relasi bersifat one-to-many:

```text
perusahaan 1 ---- N rekening_perusahaan N ---- 1 lembaga_keuangan
```

Tidak perlu menyimpan nomor SWIFT/SWIFT-BIC untuk kebutuhan TimbangQu saat ini. Jika kebutuhan transfer internasional muncul di masa depan, kebutuhan tersebut dapat dirancang kemudian.

### 9.9 Master `lembaga_keuangan`

TimbangQu mengikuti struktur existing database yang sudah digunakan:

```text
lembaga_keuangan
---------------
id
nama
logo
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

Tidak perlu menambahkan `kode_lk` terpisah. Informasi singkat dan nama lengkap dapat digabung pada `nama`, misalnya `BCA - Bank Central Asia`, sehingga pencarian oleh admin tetap mudah cukup dengan mengetik `BCA`.

`logo` tetap digunakan untuk kebutuhan tampilan UI dan memiliki nilai unik sesuai struktur existing.

### 9.10 Jenis Badan Usaha

Jenis badan usaha menggunakan master table terpisah, bukan `ENUM`, agar dapat diperluas tanpa mengubah struktur tabel `perusahaan`.

```text
jenis_badan_usaha
-----------------
id TINYINT UNSIGNED
nama
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

Master diisi dengan data default selengkap mungkin untuk kebutuhan Indonesia. Tidak disediakan CRUD UI untuk saat ini karena daftarnya relatif stabil, tetapi audit field tetap disediakan untuk kemungkinan kebutuhan CRUD di masa depan.

Record pertama wajib:

```text
id = 1
nama = 'BELUM DIKETAHUI'
```

Setelah itu baru jenis badan usaha umum seperti `PT`, `CV`, `Firma`, `Koperasi`, `Yayasan`, dan bentuk usaha Indonesia lainnya.

Pada tabel `perusahaan`, `id_jenis_badan_usaha` direncanakan `TINYINT UNSIGNED NOT NULL` dan menjadi FK ke `jenis_badan_usaha.id`, sehingga data perusahaan selalu memiliki nilai yang jelas; jika jenis sebenarnya belum diketahui, gunakan record `BELUM DIKETAHUI`, bukan `NULL`.

## 10. Sequence `id_trx`

Nomor urut `id_trx` menggunakan kombinasi user + tanggal dan reset setiap pergantian tanggal. Detail implementasi mengikuti procedure/trigger SQL yang sudah digunakan dan akan diverifikasi sebelum final.

## 11. Timezone dan Tanggal/Waktu

- Operasional awal wilayah UTC+7 seperti Bangkok/Hanoi/Jakarta.
- Penyimpanan menggunakan DATETIME, bukan TIMESTAMP.
- Format tanggal umum MySQL: YYYY-MM-DD.

## 12. Langganan dan Penagihan

TimbangQu menggunakan mekanisme subscription yang sebisa mungkin otomatis. Detail paket, subscription, invoice, Midtrans, webhook, jatuh tempo, grace period, suspended, dan nonaktif masih dibahas.

## 13. Prinsip Dokumentasi

Repository GitHub adalah pusat dokumentasi teknis dan bisnis TimbangQu. Dokumen Markdown adalah living document dan setiap keputusan yang sudah disepakati langsung dicatat.

## 14. Hal yang Masih Perlu Dibahas

1. Struktur tabel perusahaan secara rinci.
2. Algoritma final generator `kode_perusahaan`.
3. Struktur user dan hak akses.
4. Tipe/status user internal dan tenant.
5. Mekanisme multilingual pesan validasi/error.
6. Struktur paket dan subscription.
7. Struktur invoice dan detail invoice.
8. Integrasi Midtrans dan webhook.
9. Aturan jatuh tempo, grace period, suspended, dan nonaktif.
10. Struktur konektor Bluetooth.
11. Struktur perangkat/timbangan.
12. Struktur transaksi penimbangan.
13. Generator `id_trx` yang aman terhadap concurrency.
14. Index, constraint, dan strategi performa database.
15. Detail struktur final tabel `perusahaan`.
