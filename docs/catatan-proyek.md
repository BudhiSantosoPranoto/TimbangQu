# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan diperbarui setiap keputusan desain ditetapkan.

## 1. Konsep Umum

TimbangQu adalah aplikasi SaaS multi-tenant dengan satu database MySQL.

Terminologi yang digunakan:
- **Klien** = istilah bisnis/UI untuk pelanggan TimbangQu.
- **Tenant** = istilah arsitektur untuk klien yang datanya terisolasi.
- **Perusahaan** = badan usaha milik klien. Istilah ini **bukan sinonim klien/tenant**, karena database existing sudah memiliki konsep perusahaan dengan makna berbeda.

Entitas pelanggan baru direncanakan menggunakan tabel `klien`.

## 2. Standar Database

- Engine: InnoDB.
- Character set: utf8mb4.
- Collation: utf8mb4_general_ci.
- Primary key tabel master/non-transaksi: `id BIGINT UNSIGNED AUTO_INCREMENT`, kecuali master kecil yang secara sengaja memakai tipe lebih kecil.
- Foreign key digunakan secara resmi.
- Default FK: `ON DELETE RESTRICT` dan `ON UPDATE CASCADE`, kecuali relasi tertentu membutuhkan aturan berbeda.
- Penyimpanan waktu menggunakan `DATETIME`, bukan `TIMESTAMP`.
- Operasional awal berfokus pada Indonesia/UTC+7.

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

INSERT mengisi `created_*`. UPDATE mengisi `updated_*`. Soft delete mengisi `deleted_*` bila lifecycle tabel memang menggunakan soft delete.

## 4. ID Transaksi

Tabel transaksi menggunakan `id_trx VARCHAR(50) PRIMARY KEY` dengan format `PREFIKS/DDMMYYYY/ID_USER/URUTAN`. Nomor urut reset berdasarkan kombinasi user + tanggal.

## 5. `kode_tabel`

Master konfigurasi global tanpa `id_perusahaan`. `id` digunakan generator `id_trx`; generator tidak mencari berdasarkan nama tabel. Prefix global dan tidak dapat diubah tenant.

## 6. Klien / Tenant

### 6.1 Identitas

Tabel utama: `klien`.

```text
id              BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY
kode_klien      CHAR(10) NOT NULL UNIQUE
nama_perusahaan VARCHAR(200) NOT NULL UNIQUE
nama_alias      VARCHAR(200) NULL
id_jenis_badan_usaha TINYINT UNSIGNED NOT NULL
id_status_klien TINYINT UNSIGNED NOT NULL
```

`id` adalah primary key teknis. `kode_klien` adalah business identifier terpisah dari AUTO_INCREMENT dan UNIQUE.

Konsep `kode_klien`: 10 karakter Crockford Base32, bukan sekadar nomor AUTO_INCREMENT. Tanda `-` hanya untuk tampilan UI dengan format `1-3-3-3`.

`nama_perusahaan` menyimpan nama legal/resmi badan usaha milik klien. Nama badan usaha dianggap unik dan database wajib menolaknya jika duplikat. UNIQUE constraint menjadi pengaman concurrency; trigger dapat memberikan `SIGNAL SQLSTATE '45000'` dengan pesan bilingual Indonesia/Inggris agar admin mendapat pesan business-rule yang jelas.

`nama_alias` adalah nama singkat untuk pencarian/UI/laporan dan tidak harus unik. Karena admin cenderung mencari dengan singkatan/nama pendek, field ini diberi index sesuai kebutuhan query.

### 6.2 Jenis Badan Usaha

Menggunakan master table `jenis_badan_usaha`, bukan ENUM.

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

Default Indonesia disediakan selengkap mungkin. CRUD UI tidak wajib karena daftar relatif stabil, tetapi audit field tetap tersedia untuk kemungkinan kebutuhan CRUD di masa depan.

Record nomor 1 wajib:

```text
id = 1
nama = 'BELUM DIKETAHUI'
```

Setelah itu jenis umum seperti `PT`, `CV`, `Firma`, `Koperasi`, `Yayasan`, dan bentuk usaha Indonesia lain yang relevan.

Pada `klien`, `id_jenis_badan_usaha` `TINYINT UNSIGNED NOT NULL` dan menjadi FK. Jika jenis sebenarnya belum diketahui, gunakan `BELUM DIKETAHUI`, bukan NULL.

### 6.3 Status Klien

Status menggunakan master table terpisah, bukan ENUM.

```text
status_klien
------------
id TINYINT UNSIGNED
nama
keterangan
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

Status default:

1. `MENUNGGU PEMBAYARAN` — klien telah terdaftar tetapi belum melakukan pembayaran untuk mengaktifkan layanan.
2. `AKTIF` — pembayaran telah dilakukan dan layanan berlangganan sedang aktif sesuai periode subscription.
3. `SUSPENDED` — layanan dihentikan sementara karena alasan tertentu, misalnya tagihan belum dibayar, masalah administrasi, atau alasan lain.
4. `NONAKTIF` — tidak lagi berstatus sebagai pelanggan aktif, misalnya kontrak tidak diperpanjang atau tidak melakukan pembayaran dalam jangka waktu yang ditentukan.

`keterangan` adalah definisi resmi status, bukan alasan spesifik klien tertentu.

Semua status boleh berpindah ke status mana pun. Database tidak mengunci workflow transisi karena kondisi lapangan dapat menghasilkan kasus yang belum diperkirakan. Dari `NONAKTIF` boleh langsung `AKTIF`, dan demikian pula perubahan arah lainnya.

### 6.4 History Status Klien

Setiap perubahan status dicatat pada tabel terpisah dan bersifat append-only.

```text
history_status_klien
--------------------
id
id_klien
id_status_lama
id_status_baru
keterangan
nama_file
created_by
created_at
```

- `keterangan` wajib diisi untuk menjelaskan alasan perubahan secara manusiawi.
- History tidak diedit atau dihapus. Jika salah input, buat perubahan baru dengan keterangan koreksi agar jejak tetap ada.
- `nama_file` nullable; hanya nama/path file yang disimpan.
- Tidak ada `updated_*` atau `deleted_*` pada history.
- Tidak perlu `diubah_oleh`; nama user diperoleh melalui `created_by -> users.id`.
- Perubahan dari status ke status yang sama tetap boleh dicatat bila admin melakukan koreksi/penegasan.

VIEW history digunakan UI agar admin/direksi dapat melihat:

```text
Tanggal | Dari | Menjadi | Diubah Oleh | Keterangan | Dokumen
```

VIEW melakukan JOIN status lama, status baru, dan `users`.

### 6.5 Alamat dan Regional

Field alamat pada `klien`:

```text
alamat       TEXT
rt           VARCHAR(3) NULL
rw           VARCHAR(3) NULL
id_kelurahan INT(11) UNSIGNED NOT NULL
```

Hanya `id_kelurahan` yang disimpan untuk referensi regional. Tidak menyimpan ulang kecamatan, kabupaten/kota, provinsi, negara, atau kode pos di `klien`.

`regional.sql` sudah diverifikasi sebagai sumber regional. Struktur `kelurahan` menggunakan `id INT(11) UNSIGNED`, sehingga `klien.id_kelurahan` menggunakan tipe yang sama.

Relasi regional:

```text
klien
  |
  +-- id_kelurahan
          |
          +-- kelurahan
               +-- kecamatan
               +-- kokab
               +-- propinsi
               +-- negara
```

Detail regional dan kode pos diperoleh melalui JOIN/VIEW. UI membaca VIEW, bukan melakukan JOIN kompleks sendiri.

`id_kelurahan` diberi INDEX. `alamat`, `rt`, dan `rw` tidak diberi index biasa tanpa kebutuhan query nyata.

### 6.6 Telepon dan Contact Person

Field:

```text
telp_kantor
jenis_telp_kantor
nama_cp
no_hp_cp
aplikasi_cp
```

Nomor kontak menggunakan VARCHAR, bukan numeric.

`jenis_telp_kantor` menggunakan ENUM dengan tepat dua nilai:

```text
TELEPON KABEL
MOBILE
```

Tidak ada opsi ketiga `TIDAK ADA`. Jika klien tidak memiliki nomor kantor, `telp_kantor` NULL.

Untuk `TELEPON KABEL`, UI menyediakan input kode area dan nomor telepon. Database menyimpan satu nilai dengan tanda pisah, misalnya `0283-353447`. Saat edit/autofill, UI mendeteksi bagian sebelum dan sesudah `-` untuk mengisi kembali kode area dan nomor telepon.

Untuk `MOBILE`, nomor disimpan langsung.

`aplikasi_cp` langsung merujuk ke master `aplikasi_kontak`; tidak dibuat tabel kontak tambahan.

Master `aplikasi_kontak` wajib memiliki record nomor 1:

```text
id = 1
nama = 'TIDAK ADA'
```

Record berikutnya dapat berisi WhatsApp, WeChat, LINE, KakaoTalk, dan media lain. `nama_cp`, `no_hp_cp`, dan `aplikasi_cp` nullable.

### 6.7 Email, Website, dan Pajak

- `email` nullable.
- `website` nullable.
- `npwp` nullable.
- Field tetap bernama `npwp`.
- COMMENT database dan label UI: **NPWP / Tax ID**.
- Untuk entitas luar Indonesia, field digunakan untuk Tax ID/identitas pajak setara.
- Modul perpajakan klien secara khusus belum dirancang; fokus awal Indonesia.

### 6.8 Rekening Non Tunai

Satu klien dapat memiliki lebih dari satu rekening. Rekening dibuat sebagai tabel terpisah.

```text
rekening_perusahaan
-------------------
id
id_klien
nomor_reknt
id_lk
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

`nomor_reknt` berarti **nomor rekening non tunai** dan wajib diberi COMMENT/keterangan di database.

Relasi:

```text
klien 1 ---- N rekening_perusahaan N ---- 1 lembaga_keuangan
```

`id_klien` FK ke `klien.id`. `id_lk` FK ke `lembaga_keuangan.id`.

Tidak perlu SWIFT/SWIFT-BIC untuk kebutuhan saat ini. Kebutuhan transfer internasional dapat dirancang kemudian.

### 6.9 Lembaga Keuangan

Mengikuti struktur existing:

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

Tidak perlu `kode_lk` terpisah. Singkatan dan nama lengkap dapat digabung pada `nama`, misalnya `BCA - Bank Central Asia`, agar pencarian admin cukup dengan singkatan.

`logo` tetap digunakan untuk UI dan mengikuti uniqueness yang sudah ada pada database existing.

### 6.10 Audit dan Delete Klien

Tabel `klien` menggunakan audit field standar:

```text
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

`deleted_at`/`deleted_by` dipertahankan untuk konsistensi database, tetapi lifecycle bisnis klien tidak menggunakan delete.

UI **tidak menyediakan tombol Delete** untuk klien. Status `NONAKTIF` digunakan untuk lifecycle bisnis.

## 7. Index dan Big Data

Index dibuat berdasarkan kebutuhan query nyata dan mempertimbangkan biaya INSERT/UPDATE/storage.

Index yang direncanakan pada `klien`:

- PRIMARY KEY `id`.
- UNIQUE `kode_klien`.
- UNIQUE `nama_perusahaan`.
- INDEX `nama_alias`.
- INDEX `id_status_klien`.
- INDEX `id_jenis_badan_usaha`.
- INDEX `id_kelurahan`.
- INDEX `npwp` jika pola pencarian berdasarkan NPWP digunakan.
- Index FK audit bila benar-benar diperlukan oleh query/audit.

Tidak memberi index otomatis pada alamat, RT, RW, telepon, CP, email, website, atau field lain tanpa pola pencarian nyata. Composite index dibuat setelah pola query aktual diketahui.

## 8. VIEW untuk UI

UI sebisa mungkin membaca VIEW, bukan melakukan JOIN kompleks sendiri.

VIEW `klien` nantinya minimal menampilkan:

- identitas klien;
- kode klien;
- jenis badan usaha dalam bentuk nama/singkatan, bukan ID;
- status klien dalam bentuk nama dan keterangan, bukan ID;
- alamat lengkap hasil JOIN regional;
- kode pos;
- kecamatan;
- kabupaten/kota;
- provinsi;
- negara bila diperlukan;
- informasi kontak;
- nama user audit seperti `diinput_oleh` dan `diubah_oleh` hasil JOIN ke `users`.

UI tidak perlu mengetahui ID master untuk pencarian/filter berbasis nama atau singkatan.

## 9. Validasi dan Pesan Error

Business rule penting tidak boleh hanya divalidasi di UI.

Untuk pelanggaran business rule yang dapat diprediksi, terutama duplicate `nama_perusahaan`, database menggunakan UNIQUE constraint sebagai pengaman concurrency dan dapat menggunakan trigger `BEFORE INSERT`/`BEFORE UPDATE` dengan `SIGNAL SQLSTATE '45000'` agar pesan jelas dan minimal bilingual Indonesia/Inggris.

Pesan error database tidak boleh hanya berupa pesan MySQL generik jika business rule dapat dijelaskan dengan lebih baik kepada admin.

## 10. Prinsip Master Table

Master yang relatif stabil tetap menggunakan tabel terpisah bila nilainya merupakan domain bisnis dan kemungkinan berkembang. ENUM hanya digunakan untuk domain yang benar-benar kecil dan stabil, seperti `jenis_telp_kantor` yang hanya memiliki dua jenis.

Untuk master yang sudah lengkap, CRUD UI tidak wajib tersedia, tetapi audit field dapat tetap disediakan untuk kemungkinan kebutuhan masa depan.

## 11. Sequence `id_trx`

Nomor urut `id_trx` menggunakan kombinasi user + tanggal dan reset setiap pergantian tanggal. Detail implementasi mengikuti procedure/trigger SQL yang sudah digunakan dan akan diverifikasi sebelum final.

## 12. Langganan dan Penagihan

TimbangQu menggunakan mekanisme subscription yang sebisa mungkin otomatis. Detail paket, subscription, invoice, Midtrans, webhook, jatuh tempo, grace period, suspended, dan nonaktif masih dibahas.

## 13. Prinsip Dokumentasi

Repository GitHub adalah pusat dokumentasi teknis dan bisnis TimbangQu. Dokumen Markdown ini adalah **living document utama**. Setiap keputusan desain yang sudah disepakati harus diperbarui di dokumen ini; tidak membuat catatan desain utama terpisah untuk keputusan yang sama.

## 14. Hal yang Masih Perlu Dibahas

1. Algoritma final generator `kode_klien`.
2. Struktur user dan hak akses.
3. Tipe/status user internal dan tenant.
4. Mekanisme multilingual pesan validasi/error.
5. Struktur paket dan subscription.
6. Struktur invoice dan detail invoice.
7. Integrasi Midtrans.
8. Webhook pembayaran dan rekonsiliasi.
9. Grace period dan lifecycle subscription.
10. Modul perpajakan klien.

## 15. Status Keputusan

Bagian `Klien / Tenant` pada dokumen ini merupakan konsolidasi keputusan yang sudah dibahas. SQL final belum dibuat sampai seluruh field, FK, index, constraint, trigger, dan VIEW yang relevan selesai direview.
