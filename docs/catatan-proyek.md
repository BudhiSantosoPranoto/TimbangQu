# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Ini adalah **living document**. Setiap keputusan desain yang sudah disepakati wajib dikonsolidasikan di sini.

## 1. Konsep Umum

TimbangQu adalah aplikasi SaaS multi-tenant dengan satu database MySQL.

Terminologi:
- **Klien** = istilah bisnis/UI untuk pelanggan TimbangQu.
- **Tenant** = istilah arsitektur untuk klien yang datanya terisolasi.
- **Perusahaan** = badan usaha milik klien. Istilah ini bukan sinonim klien/tenant, karena database existing sudah mempunyai konsep `perusahaan` dengan makna berbeda.
- Fokus tahap awal: **regional Indonesia**. Perpajakan internasional/klien luar Indonesia belum dirancang penuh.

Entitas pelanggan baru menggunakan tabel `klien`.

## 2. Standar Database

- MySQL + InnoDB.
- `utf8mb4`.
- Collation mengikuti database existing (`utf8mb4_general_ci` pada standar saat ini).
- PK master/transaksi non-kecil umumnya `BIGINT UNSIGNED AUTO_INCREMENT`.
- Master kecil yang domainnya terbatas boleh memakai `TINYINT UNSIGNED`.
- Foreign key digunakan secara resmi.
- Default FK: `ON DELETE RESTRICT`, `ON UPDATE CASCADE`, kecuali ada alasan khusus.
- Waktu menggunakan `DATETIME`, bukan `TIMESTAMP`.
- Index harus dipilih dengan mempertimbangkan kemungkinan big data; jangan meng-index semua kolom karena setiap index menambah biaya storage dan INSERT/UPDATE.

## 3. Audit Field

Pola standar:

```text
created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
created_by  BIGINT UNSIGNED NOT NULL
updated_at  DATETIME NULL DEFAULT NULL
updated_by  BIGINT UNSIGNED NULL
deleted_at  DATETIME NULL DEFAULT NULL
deleted_by  BIGINT UNSIGNED NULL
```

INSERT mengisi `created_*`. UPDATE mengisi `updated_*`. `deleted_*` hanya dipakai bila lifecycle tabel memang membutuhkan soft delete.

Untuk tabel history append-only tidak digunakan `updated_*`/`deleted_*`.

## 4. ID Transaksi

Tabel transaksi menggunakan `id_trx VARCHAR(50) PRIMARY KEY` dengan format yang sudah digunakan existing:

```text
PREFIKS/DDMMYYYY/ID_USER/URUTAN
```

Nomor urut reset berdasarkan kombinasi user + tanggal. Detail procedure/trigger existing akan diverifikasi sebelum finalisasi.

## 5. `kode_tabel`

Master konfigurasi global tanpa `id_perusahaan`. `id` digunakan generator `id_trx`; generator tidak mencari berdasarkan nama tabel. Prefix bersifat global dan tidak dapat diubah tenant.

---

# 6. Klien / Tenant

## 6.1 Identitas Klien

Tabel utama: `klien`.

```text
id                    BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY
kode_klien            CHAR(10) NOT NULL UNIQUE
nama_perusahaan       VARCHAR(200) NOT NULL UNIQUE
nama_alias            VARCHAR(200) NULL
id_jenis_badan_usaha  TINYINT UNSIGNED NOT NULL
id_status_klien       TINYINT UNSIGNED NOT NULL
alamat                TEXT
rt                    VARCHAR(3) NULL
rw                    VARCHAR(3) NULL
id_kelurahan          INT(11) UNSIGNED NOT NULL
telp_kantor           VARCHAR(50) NULL
jenis_telp_kantor     ENUM('TELEPON KABEL','MOBILE') NULL
nama_cp               VARCHAR(200) NULL
no_hp_cp              VARCHAR(50) NULL
id_aplikasi_cp        TINYINT UNSIGNED NULL
email                 VARCHAR(200) NULL
website               VARCHAR(255) NULL
npwp                  VARCHAR(50) NULL
created_by            BIGINT UNSIGNED NOT NULL
created_at            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
updated_by            BIGINT UNSIGNED NULL
updated_at            DATETIME NULL
deleted_by            BIGINT UNSIGNED NULL
deleted_at            DATETIME NULL
```

Catatan:
- `id` adalah PK teknis.
- `kode_klien` adalah business identifier terpisah dari AUTO_INCREMENT dan UNIQUE.
- Konsep `kode_klien`: 10 karakter Crockford Base32. Tanda `-` hanya untuk tampilan UI dengan format `1-3-3-3`.
- `nama_perusahaan` adalah nama legal/resmi badan usaha milik klien.
- Nama badan usaha harus UNIQUE. Database wajib menolak duplikat sebagai pengaman concurrency.
- Untuk duplicate business rule, API harus mengenali SQLSTATE/error database dan memberikan pesan yang jelas kepada admin. Trigger `SIGNAL SQLSTATE '45000'` boleh digunakan untuk pesan business-rule bilingual, tetapi UNIQUE constraint tetap menjadi pengaman utama.
- `nama_alias` adalah nama singkat untuk pencarian/UI/laporan dan tidak harus unik.
- `deleted_at`/`deleted_by` dipertahankan untuk konsistensi database, tetapi **UI tidak menyediakan tombol Delete** untuk klien. Lifecycle bisnis menggunakan status `NONAKTIF`.

## 6.2 Jenis Badan Usaha

Menggunakan master table, bukan ENUM.

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

Record nomor 1 wajib:

```text
id = 1
nama = 'BELUM DIKETAHUI'
```

Default Indonesia disediakan selengkap mungkin, termasuk bentuk umum seperti `PT`, `CV`, `Firma`, `Koperasi`, `Yayasan`, dan bentuk usaha relevan lainnya.

CRUD UI tidak wajib untuk master yang sudah lengkap/stabil, tetapi field audit tetap tersedia untuk kemungkinan kebutuhan masa depan.

`klien.id_jenis_badan_usaha` menggunakan `TINYINT UNSIGNED NOT NULL` dan FK. Jika jenis belum diketahui gunakan `BELUM DIKETAHUI`, bukan NULL.

## 6.3 Status Klien

Menggunakan master table, bukan ENUM.

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

Default status yang sudah disepakati:

1. `MENUNGGU PEMBAYARAN` — klien telah terdaftar tetapi belum melakukan pembayaran untuk mengaktifkan layanan.
2. `AKTIF` — pembayaran telah dilakukan dan layanan berlangganan sedang aktif sesuai periode subscription.
3. `SUSPENDED` — layanan dihentikan sementara karena alasan tertentu, misalnya tagihan belum dibayar, masalah administrasi, atau alasan lain.
4. `NONAKTIF` — tidak lagi berstatus sebagai pelanggan aktif, misalnya kontrak tidak diperpanjang atau tidak melakukan pembayaran dalam jangka waktu yang ditentukan.

`keterangan` adalah definisi resmi status, bukan alasan spesifik suatu perubahan.

Tidak ada workflow transisi yang dikunci. **Semua status boleh berpindah ke status mana pun**, karena kondisi lapangan bisa menghasilkan kasus yang belum diperkirakan. `NONAKTIF -> AKTIF` diperbolehkan langsung. Tidak perlu status `PENDAFTARAN BARU`.

## 6.4 History Status Klien

Setiap perubahan status dicatat pada tabel terpisah, append-only.

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

- `keterangan` wajib menjelaskan alasan perubahan secara manusiawi agar admin dapat diinterogasi/audit jika diperlukan.
- `nama_file` nullable; hanya nama/path file yang disimpan, bukan isi file.
- Tidak ada `updated_*`/`deleted_*`.
- Tidak perlu field `diubah_oleh`; nama user diperoleh dari `created_by -> users.id` melalui VIEW.
- History tidak diedit/dihapus. Jika salah input, buat perubahan baru dengan keterangan koreksi.
- Perubahan status yang sama tetap boleh dicatat bila diperlukan untuk koreksi/penegasan.

VIEW history untuk UI minimal:

```text
Tanggal | Dari | Menjadi | Diubah Oleh | Keterangan | Dokumen
```

VIEW melakukan JOIN status lama, status baru, dan `users`.

## 6.5 Regional dan Alamat

Field regional klien hanya:

```text
alamat       TEXT
rt           VARCHAR(3) NULL
rw           VARCHAR(3) NULL
id_kelurahan INT(11) UNSIGNED NOT NULL
```

Hanya `id_kelurahan` yang disimpan. Jangan menyimpan ulang kecamatan, kabupaten/kota, provinsi, negara, atau kode pos di `klien`.

`regional.sql` sudah dijadikan sumber regional. Struktur `kelurahan` menggunakan `id INT(11) UNSIGNED`, sehingga tipe `klien.id_kelurahan` harus sama.

Relasi konseptual:

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

Detail regional dan kode pos diperoleh melalui JOIN/VIEW. UI membaca VIEW, bukan membuat JOIN regional kompleks sendiri.

`id_kelurahan` diberi INDEX.

## 6.6 Telepon Kantor dan Contact Person

Field yang digunakan:

```text
telp_kantor
jenis_telp_kantor
nama_cp
no_hp_cp
id_aplikasi_cp
```

Nomor telepon selalu VARCHAR, bukan numeric.

`jenis_telp_kantor` adalah ENUM dan **tepat dua jenis**:

```text
TELEPON KABEL
MOBILE
```

Tidak ada opsi ketiga `TIDAK ADA`. Jika tidak memiliki nomor kantor, `telp_kantor` NULL.

Untuk `TELEPON KABEL`:
- UI menyediakan input kode area dan nomor telepon secara terpisah.
- Database menyimpan satu nilai dengan tanda pisah, contoh `0283-353447`.
- Saat edit/autofill, UI mendeteksi bagian sebelum `-` sebagai kode area dan bagian sesudahnya sebagai nomor.

Untuk `MOBILE`, nomor disimpan langsung.

Contact Person **tidak membuat tabel baru**. `id_aplikasi_cp` langsung FK ke master `aplikasi_kontak`.

Master `aplikasi_kontak` wajib memiliki record nomor 1:

```text
id = 1
nama = 'TIDAK ADA'
```

Record berikutnya dapat berisi WhatsApp, WeChat, LINE, KakaoTalk, dan media lain. `nama_cp`, `no_hp_cp`, dan `id_aplikasi_cp` nullable.

## 6.7 Email, Website, dan Pajak

- `email` nullable.
- `website` nullable.
- `npwp` nullable.
- Nama field tetap `npwp`.
- COMMENT database dan label UI: **NPWP / Tax ID**.
- Untuk entitas luar Indonesia, field dapat digunakan untuk Tax ID/identitas pajak setara.
- Modul perpajakan klien belum dirancang. Fokus tahap sekarang adalah Indonesia.

## 6.8 Rekening Perusahaan / Non-Tunai

Satu klien dapat mempunyai lebih dari satu rekening. Rekening tetap direpresentasikan sebagai rekening perusahaan karena objek rekening adalah badan usaha milik klien, sedangkan pemilik di sistem ditunjukkan oleh `id_klien`.

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

- `id_klien` FK ke `klien.id`.
- `id_lk` FK ke `lembaga_keuangan.id`.
- `nomor_reknt` berarti **nomor rekening non tunai** dan wajib diberi COMMENT/keterangan di database.
- Satu klien : banyak rekening.
- SWIFT/SWIFT-BIC belum diperlukan. Transfer internasional dirancang kemudian bila dibutuhkan.

## 6.9 Lembaga Keuangan

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

Tidak perlu `kode_lk` terpisah. Singkatan dan nama lengkap dapat digabung pada `nama`, misalnya `BCA - Bank Central Asia`, sehingga admin dapat mencari dengan singkatan yang dikenal.

`logo` tetap tersedia untuk UI dan mengikuti uniqueness yang sudah ada di database existing.

---

# 7. Index dan Big Data

Index harus mendukung query nyata tanpa membebani INSERT/UPDATE dan storage secara tidak perlu.

Index yang direncanakan pada `klien`:

- PRIMARY KEY `id`.
- UNIQUE `kode_klien`.
- UNIQUE `nama_perusahaan`.
- INDEX `nama_alias` bila pola pencarian yang digunakan dapat memanfaatkannya.
- INDEX `id_status_klien`.
- INDEX `id_jenis_badan_usaha`.
- INDEX `id_kelurahan`.
- INDEX `npwp` jika pencarian/filter NPWP memang digunakan secara rutin.

Jangan otomatis membuat index pada alamat, RT, RW, telepon, CP, email, website, atau semua field lain. Composite index dibuat setelah pola query UI/API diketahui.

---

# 8. VIEW untuk UI

UI sebisa mungkin membaca VIEW, bukan melakukan JOIN kompleks sendiri.

VIEW `klien` minimal menampilkan:

- identitas klien;
- kode klien;
- nama perusahaan;
- nama alias;
- jenis badan usaha dalam bentuk nama/singkatan, bukan ID;
- status klien dalam bentuk nama dan keterangan, bukan ID;
- alamat lengkap hasil JOIN regional;
- RT/RW;
- kelurahan;
- kecamatan;
- kabupaten/kota;
- provinsi;
- negara bila diperlukan;
- kode pos;
- telepon kantor;
- jenis telepon;
- contact person;
- nomor HP CP;
- aplikasi CP dalam bentuk nama, bukan ID;
- email;
- website;
- NPWP/Tax ID;
- nama user audit seperti `diinput_oleh` dan `diubah_oleh` hasil JOIN ke `users`.

UI tidak perlu mengetahui ID master untuk pencarian/filter berbasis nama atau singkatan.

VIEW history status juga menjadi sumber UI untuk riwayat perubahan.

---

# 9. Validasi dan Error SQLSTATE

Business rule penting tidak boleh hanya divalidasi di UI.

Untuk duplicate `nama_perusahaan`:
- UNIQUE constraint wajib ada sebagai pengaman concurrency.
- API harus memetakan error/SQLSTATE ke pesan yang dapat dipahami admin.
- Bila diperlukan pesan business-rule khusus, trigger dapat menggunakan `SIGNAL SQLSTATE '45000'`.
- Pesan sebaiknya bilingual Indonesia/Inggris agar lapisan aplikasi tidak bergantung pada pesan error MySQL generik.

Prinsip ini berlaku juga untuk business rule penting lain yang nanti ditemukan: jika input admin dapat melanggar aturan bisnis, database/API harus memberikan signal/error yang jelas.

---

# 10. Prinsip Master Table vs ENUM

- Gunakan **master table** untuk domain bisnis yang dapat berkembang atau perlu keterangan, audit, FK, dan kemungkinan perubahan.
- Gunakan **ENUM** hanya untuk domain yang benar-benar kecil dan stabil.
- `jenis_telp_kantor` adalah contoh ENUM yang tepat karena hanya dua jenis: `TELEPON KABEL` dan `MOBILE`.
- Master yang sudah lengkap tidak wajib mempunyai CRUD UI, tetapi struktur CRUD/audit tetap boleh disiapkan untuk kemungkinan masa depan.
- Untuk master kecil seperti jenis badan usaha/status/aplikasi CP, `id TINYINT UNSIGNED` sudah cukup dan dipilih demi efisiensi.

---

# 11. Langganan dan Penagihan

Konsep awal subscription yang sudah disepakati:

- Tidak membuat mekanisme tagihan yang rumit berdasarkan awal/akhir bulan.
- Tanggal tagihan menggunakan **tanggal pertama klien mendaftar** sebagai anchor.
- Invoice tetap satu untuk periode tagihan.
- Jika pemasangan/aktivasi terjadi di tengah periode, biaya dihitung proporsional per hari.
- Contoh prinsip: `Rp75.000 / 30 hari x jumlah hari pemakaian`.
- Dengan demikian kasus mulai berlangganan di tengah perjalanan tidak memerlukan aturan billing khusus yang rumit.
- Status `MENUNGGU PEMBAYARAN`, `AKTIF`, `SUSPENDED`, dan `NONAKTIF` menjadi bagian lifecycle bisnis subscription.
- Detail paket, invoice, Midtrans, webhook, grace period, rekonsiliasi, dan implementasi otomatis masih akan dirancang.

---

# 12. Perusahaan, Rekening, dan Pajak

- Entitas `klien`/tenant adalah pelanggan TimbangQu.
- `perusahaan` adalah badan usaha milik klien; jangan menyamakan istilah perusahaan existing dengan tenant.
- Rekening perusahaan milik klien disimpan terpisah karena satu klien dapat mempunyai banyak rekening.
- Perpajakan klien belum menjadi fokus implementasi sekarang. Fokus tahap ini adalah regional Indonesia.
- Struktur pajak perusahaan/klien akan dirancang ketika modul perpajakan dibahas secara khusus.

---

# 13. Dokumentasi dan Sumber Database

Repository GitHub menjadi pusat dokumentasi teknis dan bisnis.

Sumber database contoh yang relevan:

```text
contoh database/contoh.sql
contoh database/data_regional.sql
```

`regional.sql` yang digunakan sebagai sumber proyek berisi database regional Indonesia lengkap dan menjadi acuan untuk struktur wilayah. UI tidak perlu menyalin data regional ke tabel klien.

Dokumen ini adalah satu-satunya catatan desain utama. Jangan membuat dokumen keputusan lain yang menduplikasi keputusan yang sama.

---

# 14. Hal yang Masih Terbuka

Yang belum dikunci bukan berarti boleh ditebak. Jika pembahasan sebelumnya belum menghasilkan keputusan, tandai sebagai terbuka dan bahas ketika waktunya tiba.

1. Algoritma final generator `kode_klien`.
2. Struktur user dan hak akses.
3. Tipe/status user internal dan tenant.
4. Mekanisme multilingual pesan validasi/error secara umum.
5. Struktur paket dan subscription secara lengkap.
6. Struktur invoice dan detail invoice.
7. Integrasi Midtrans.
8. Webhook pembayaran dan rekonsiliasi.
9. Grace period dan lifecycle subscription secara detail.
10. Modul perpajakan klien.

---

# 15. Status Dokumen

Bagian `Klien / Tenant` sudah dikonsolidasikan berdasarkan keputusan yang telah dibahas dalam percakapan proyek sampai tahap ini. SQL final belum dibuat sebelum field, FK, constraint, index, trigger, dan VIEW yang relevan selesai direview.
