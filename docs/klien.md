# TimbangQu — Klien

Dokumen ini menjadi catatan khusus rancangan entitas klien/tenant TimbangQu. Istilah **klien** dipakai untuk konteks bisnis dan UI; **tenant** dipakai untuk konteks arsitektur. Istilah **perusahaan** tidak dipakai sebagai sinonim klien karena pada database existing sudah memiliki makna lain.

## 1. Identitas

Tabel utama direncanakan bernama `klien`.

- `id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY`.
- `kode_klien` adalah business identifier terpisah dari `id`, UNIQUE, dan generatornya tidak bergantung pada AUTO_INCREMENT.
- `nama_perusahaan VARCHAR(200) NOT NULL UNIQUE` menyimpan nama legal/resmi badan usaha milik klien.
- `nama_alias VARCHAR(200) NULL` adalah nama singkat untuk pencarian/UI/laporan dan tidak harus unik.
- Nama perusahaan yang duplikat harus ditolak database. UNIQUE constraint tetap menjadi pengaman concurrency; trigger `SIGNAL SQLSTATE '45000'` digunakan agar pesan ke admin jelas dan minimal bilingual Indonesia/Inggris.

## 2. Jenis Badan Usaha

Menggunakan master table `jenis_badan_usaha`, bukan ENUM.

- `id TINYINT UNSIGNED`.
- Record nomor 1 wajib `BELUM DIKETAHUI`.
- Setelah itu disediakan daftar badan usaha Indonesia selengkap mungkin, seperti PT, CV, Firma, Koperasi, Yayasan, dan bentuk lain yang relevan.
- CRUD UI tidak wajib karena master relatif stabil, tetapi audit field tetap disediakan untuk kemungkinan kebutuhan di masa depan.
- `klien.id_jenis_badan_usaha` `TINYINT UNSIGNED NOT NULL` dan menjadi FK ke master.

## 3. Status Klien

Menggunakan master table terpisah, bukan ENUM.

Struktur master:

```text
status_klien
-----------
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

Status default yang sudah disepakati:

1. `MENUNGGU PEMBAYARAN` — klien telah terdaftar tetapi belum melakukan pembayaran untuk mengaktifkan layanan.
2. `AKTIF` — pembayaran telah dilakukan dan layanan berlangganan sedang aktif sesuai periode subscription.
3. `SUSPENDED` — layanan dihentikan sementara karena alasan tertentu, misalnya tagihan belum dibayar, masalah administrasi, atau alasan lain.
4. `NONAKTIF` — tidak lagi berstatus sebagai pelanggan aktif, misalnya kontrak tidak diperpanjang atau tidak melakukan pembayaran dalam jangka waktu yang ditentukan.

`keterangan` adalah definisi resmi status, bukan alasan spesifik klien tertentu.

Semua status boleh berpindah ke status mana pun. Database tidak mengunci workflow transisi karena kondisi lapangan dapat menghasilkan kasus yang belum diperkirakan. Admin dapat mengubah status langsung dari status apa pun ke status apa pun.

## 4. History Status

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

- `keterangan` wajib diisi dan menjelaskan alasan perubahan secara manusiawi.
- History tidak diedit atau dihapus. Jika salah input, buat perubahan baru dengan keterangan koreksi agar jejak tetap ada.
- `nama_file` nullable; hanya nama/path file yang disimpan di database.
- Tidak ada `updated_*` atau `deleted_*` pada history.
- Tidak perlu `diubah_oleh`; nama user diperoleh dari `created_by -> users.id`.
- Perubahan dari status ke status yang sama tetap boleh dicatat bila admin melakukan koreksi/penegasan.

UI menggunakan VIEW history sehingga admin/direksi melihat minimal:

```text
Tanggal | Dari | Menjadi | Diubah Oleh | Keterangan | Dokumen
```

## 5. Alamat

Field utama:

```text
alamat TEXT
rt VARCHAR(3) NULL
rw VARCHAR(3) NULL
id_kelurahan INT(11) UNSIGNED NOT NULL
```

Hanya `id_kelurahan` yang disimpan untuk referensi regional. Tidak menyimpan ulang kecamatan, kabupaten/kota, provinsi, negara, atau kode pos di tabel klien.

Detail regional diperoleh melalui database regional dan VIEW. Pola ini mengikuti database existing yang sudah melakukan JOIN dari `id_kelurahan` ke tabel regional terkait.

`id_kelurahan` diberi INDEX. `alamat`, `rt`, dan `rw` tidak diberi index biasa tanpa kebutuhan query nyata.

## 6. Telepon dan Contact Person

Field yang disepakati:

```text
telp_kantor
jenis_telp_kantor
nama_cp
no_hp_cp
aplikasi_cp
email
website
npwp
```

Nomor kontak menggunakan VARCHAR, bukan numeric.

`jenis_telp_kantor` menggunakan ENUM dengan tepat dua nilai:

```text
TELEPON KABEL
MOBILE
```

Tidak ada opsi ketiga `TIDAK ADA`. Jika tidak memiliki nomor kantor, `telp_kantor` bernilai NULL.

Untuk `TELEPON KABEL`, UI menyediakan input kode area dan nomor telepon. Database menyimpan satu nilai dengan tanda pisah, misalnya `0283-353447`. UI harus dapat autofill dengan mendeteksi bagian sebelum dan sesudah `-`.

Untuk `MOBILE`, nomor disimpan langsung.

`aplikasi_cp` langsung merujuk ke master `aplikasi_kontak`; tidak dibuat tabel kontak tambahan.

Master `aplikasi_kontak` wajib memiliki record nomor 1:

```text
id = 1
nama = 'TIDAK ADA'
```

Record berikutnya dapat berisi WhatsApp, WeChat, LINE, KakaoTalk, dan media lain. `nama_cp`, `no_hp_cp`, dan `aplikasi_cp` nullable.

## 7. Email, Website, dan Pajak

- `email` nullable karena UMKM belum tentu memiliki email.
- `website` nullable karena tidak semua UMKM memiliki website.
- `npwp` nullable. Nama field tetap `npwp`.
- Label/keterangan UI dan COMMENT database harus menjelaskan: **NPWP / Tax ID**; untuk entitas luar Indonesia, field tersebut digunakan untuk Tax ID atau identitas pajak setara.
- Belum merancang modul perpajakan klien secara khusus; fokus awal Indonesia.

## 8. Rekening Non Tunai Klien

Rekening disiapkan tetapi belum wajib digunakan dalam operasional awal. Relasi one-to-many: satu klien dapat memiliki lebih dari satu rekening.

Tabel direncanakan:

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

- `nomor_reknt` berarti **nomor rekening non tunai** dan wajib diberi COMMENT/keterangan.
- `id_perusahaan` merujuk ke entitas klien dan penamaan FK harus konsisten dengan nama tabel final.
- `id_lk` merujuk ke `lembaga_keuangan.id`.
- Tidak perlu nomor SWIFT/SWIFT-BIC untuk kebutuhan saat ini. Kebutuhan transfer internasional dapat dirancang kemudian.

## 9. Lembaga Keuangan

Mengikuti struktur existing `lembaga_keuangan` yang sudah tersedia:

```text
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

Tidak perlu menambahkan `kode_lk`. Informasi singkatan dan nama panjang dapat digabung pada `nama`, misalnya `BCA - Bank Central Asia`, agar pencarian admin cukup dengan singkatan.

## 10. Audit dan Delete

Tabel klien tetap memiliki audit field standar:

```text
created_by
created_at
updated_by
updated_at
deleted_by
deleted_at
```

`deleted_at`/`deleted_by` dipertahankan untuk konsistensi struktur database, tetapi lifecycle klien tidak menggunakan delete.

- UI tidak menyediakan tombol Delete untuk klien.
- Status `NONAKTIF` digunakan untuk lifecycle bisnis.
- `deleted_at` bukan mekanisme utama untuk mengeluarkan klien dari layanan.

## 11. Index dan Big Data

Index dibuat berdasarkan kebutuhan query nyata dan mempertimbangkan biaya INSERT/UPDATE/storage.

Index yang direncanakan untuk tabel klien:

- PRIMARY KEY pada `id`.
- UNIQUE pada `kode_klien`.
- UNIQUE pada `nama_perusahaan`.
- INDEX pada `nama_alias`.
- INDEX pada `id_status_klien`.
- INDEX pada `id_jenis_badan_usaha`.
- INDEX pada `id_kelurahan`.
- INDEX pada `npwp`.
- INDEX audit FK `created_by`, `updated_by`, `deleted_by`.

Tidak memberi index otomatis pada alamat, RT, RW, telepon, CP, email, website, atau field lain yang belum memiliki pola pencarian nyata. Composite index hanya dibuat setelah pola query aktual diketahui.

## 12. VIEW untuk UI

UI sebisa mungkin membaca VIEW, bukan melakukan JOIN kompleks sendiri.

VIEW klien nantinya menampilkan minimal:

- identitas klien;
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

## 13. Validasi Database

Business rule penting tidak boleh hanya divalidasi di UI. Trigger `SIGNAL SQLSTATE '45000'` digunakan bila diperlukan untuk menghasilkan pesan yang jelas, minimal bilingual Indonesia/Inggris.

Khusus duplikasi `nama_perusahaan`, UNIQUE constraint tetap wajib sebagai pengaman database/concurrency, sementara trigger dapat memberikan pesan business-rule yang lebih ramah.

## 14. Terminologi

- **Klien** = istilah bisnis/UI untuk pelanggan TimbangQu.
- **Tenant** = istilah arsitektur untuk klien yang datanya terisolasi.
- **Perusahaan** = badan usaha milik klien; jangan digunakan sebagai sinonim tenant karena database existing sudah memiliki konsep perusahaan sendiri.

Dokumen ini menjadi checklist keputusan yang sudah disepakati sebelum SQL final `klien` dibuat.
