# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan diperbarui ketika keputusan proyek berubah.

## 1. Konsep Umum

TimbangQu adalah aplikasi **SaaS multi-tenant** yang digunakan oleh banyak perusahaan klien dalam satu platform dan satu database MySQL.

Prinsip utama:
- Multi-tenant.
- Satu database MySQL untuk banyak perusahaan.
- Data tenant dipisahkan menggunakan `id_perusahaan`.
- Setiap tabel yang datanya dimiliki tenant wajib memiliki `id_perusahaan` dan `NOT NULL`.
- Tabel konfigurasi global seperti `kode_tabel` tidak membutuhkan `id_perusahaan`.

## 2. Standar Database

- Engine seluruh tabel: `InnoDB`.
- Character set: `utf8mb4`.
- Collation: `utf8mb4_general_ci`.
- Primary key tabel master/non-transaksi: `id BIGINT UNSIGNED AUTO_INCREMENT`.
- Foreign key digunakan secara resmi untuk menjaga integritas relasi.
- Default perilaku FK mengikuti pola yang digunakan pada database sebelumnya: `ON DELETE RESTRICT` dan `ON UPDATE CASCADE`, kecuali relasi tertentu nantinya membutuhkan aturan berbeda.
- Nama constraint FK tidak perlu ditentukan secara manual; boleh mengikuti nama otomatis MySQL.

## 3. Konvensi Penamaan

Field domain/bisnis menggunakan Bahasa Indonesia selama tetap jelas dan tidak terlalu panjang.

Field teknis yang sudah umum bagi developer tetap menggunakan Bahasa Inggris:
- `id`
- `created_at`
- `created_by`
- `updated_at`
- `updated_by`
- `deleted_at`
- `deleted_by`

Foreign key menggunakan pola nama seperti:
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
- Saat INSERT: `created_at` dan `created_by` wajib terisi. `updated_*` dan `deleted_*` masih `NULL`.
- Saat UPDATE: `updated_at` dan `updated_by` terisi.
- Saat soft delete: `deleted_at` dan `deleted_by` terisi.
- `created_by`, `updated_by`, dan `deleted_by` mengarah ke satu tabel user yang sama.

User internal TimbangQu dan user tenant menggunakan satu tabel user; tipe user yang membedakan keduanya akan dibahas kemudian.

## 5. ID Transaksi

Untuk tabel transaksi digunakan business transaction ID:

```text
id_trx VARCHAR(50) PRIMARY KEY
```

Format baku:

```text
PREFIKS/DDMMYYYY/ID_USER/URUTAN
```

Contoh:

```text
TBG/04082026/7/00023
```

Arti komponen:
- `TBG` = prefix dari `kode_tabel`.
- `04082026` = tanggal transaksi.
- `7` = `id` user yang melakukan input.
- `00023` = nomor urut.

Nomor urut di-reset berdasarkan kombinasi **user + tanggal**. Jadi user yang sama pada tanggal berikutnya kembali ke `00001`, sementara user berbeda pada tanggal yang sama memiliki urutan masing-masing.

Mekanisme generator harus aman terhadap transaksi/concurrency dan akan dibahas berdasarkan pola SQL yang sudah digunakan.

## 6. `kode_tabel`

`kode_tabel` adalah master konfigurasi global TimbangQu dan tidak memiliki `id_perusahaan`.

Struktur dasar:

```text
kode_tabel
-----------
id
nama_tabel
kode
```

Contoh:

```text
1 | trx_timbang        | TBG
2 | trx_timbang_detail | TBGDTL
3 | invoice             | INV
```

`id` pada `kode_tabel` digunakan sebagai referensi oleh generator `id_trx`; generator tidak perlu mencari berdasarkan nama tabel. `nama_tabel` digunakan untuk membantu developer memahami mapping dan sebaiknya berisi nama tabel database sebenarnya.

Prefix bersifat global/standar dan tidak dapat diubah oleh tenant. Tenant tidak memiliki konfigurasi prefix masing-masing.

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

`menunggu_pembayaran` digunakan setelah pendaftaran tetapi sebelum pembayaran/aktivasi pertama.

`suspended` berarti akses sementara dihentikan, misalnya karena pembayaran terlambat atau masalah administratif tertentu.

`nonaktif` berarti hubungan/langganan sudah dihentikan, misalnya perusahaan tidak memperpanjang atau memenuhi kondisi bisnis tertentu.

Aturan berapa lama suspended sebelum menjadi nonaktif belum ditetapkan dan akan dibahas sebagai business rule tersendiri.

## 8. History Status Perusahaan

Perubahan status perusahaan memiliki history terpisah, misalnya tabel `status_perusahaan_history`.

History bersifat **append-only** dari sisi UI dan tidak boleh diedit atau dihapus untuk memperbaiki kesalahan input. Jika terjadi kesalahan, dibuat record history baru yang menjelaskan koreksi.

Setiap perubahan status wajib memiliki `keterangan` dan `NOT NULL`/tidak boleh kosong.

History minimal memuat konsep:
- `id`
- `id_perusahaan`
- status lama
- status baru
- `keterangan`
- `nama_file` (opsional)
- `created_at`
- `created_by`

Perubahan dengan status lama dan status baru yang sama tetap boleh dicatat jika memang ada kejadian/keterangan baru.

Tujuannya agar direksi/admin dapat melihat kronologi lengkap: tanggal, siapa yang melakukan, perubahan status, alasan, dan dokumen terkait.

`nama_file` hanya menyimpan nama/path relatif file; file fisiknya disimpan di folder server sesuai mekanisme penyimpanan aplikasi.

Index history akan dirancang agar pencarian berdasarkan perusahaan dan waktu tetap efisien walaupun jumlah record membesar.

## 9. Validasi Database

Validasi yang penting untuk integritas data tidak hanya bergantung pada UI. Database juga dapat menolak operasi yang tidak valid menggunakan trigger dan:

```sql
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = '...';
```

Pesan error harus dibuat jelas agar admin/developer memahami penyebab kegagalan, bukan mengandalkan warning MySQL yang membingungkan.

Karena TimbangQu berpotensi digunakan perusahaan asing, mekanisme pesan/warning perlu mendukung minimal **Bahasa Indonesia dan Bahasa Inggris**. Dukungan Bahasa Mandarin diinginkan sebagai kemungkinan pengembangan, tetapi belum diputuskan karena ada pertimbangan implementasi dan maintenance.

## 10. Identitas Perusahaan

Informasi awal perusahaan antara lain:
- `id`
- `kode_perusahaan`
- nama perusahaan
- alamat perusahaan
- informasi kontak
- NPWP, apabila diputuskan diperlukan
- informasi lain yang akan ditentukan saat struktur tabel perusahaan dibahas.

`kode_perusahaan` harus unik secara global dan menggunakan kombinasi huruf serta angka agar mudah disebutkan kepada customer service dibandingkan `id` numerik.

Format dan panjang final `kode_perusahaan` belum ditetapkan.

## 11. Langganan dan Penagihan

TimbangQu akan menggunakan mekanisme subscription yang sebisa mungkin berjalan otomatis oleh sistem.

Konsep awal:
- Perusahaan memiliki paket/langganan.
- Terdapat tanggal mulai langganan.
- Terdapat tanggal jatuh tempo/tagihan berikutnya.
- Invoice dibuat otomatis oleh sistem.
- Pembayaran diproses melalui Midtrans.
- Status pembayaran diperbarui berdasarkan webhook/notifikasi pembayaran Midtrans.
- Jika pembayaran berhasil, masa langganan diperpanjang otomatis.
- Jika melewati jatuh tempo dan pembayaran belum terdeteksi, akses perusahaan dapat dinonaktifkan berdasarkan aturan subscription yang akan ditentukan.

## 12. Paket Langganan

Struktur paket subscription belum final karena masih mungkin terjadi perubahan pada:
- harga paket
- fitur/service yang termasuk dalam paket
- harga konektor Bluetooth
- komponen biaya lainnya
- aturan dan benefit setiap paket

Struktur database harus fleksibel dan tidak meng-hardcode harga atau fitur ke tabel perusahaan.

## 13. Timezone dan Tanggal/Waktu

- Operasional awal menggunakan wilayah UTC+7 seperti Bangkok/Hanoi/Jakarta.
- Standar penyimpanan tanggal/waktu menggunakan `DATETIME`, bukan `TIMESTAMP`.
- `DATE` digunakan untuk data yang memang hanya membutuhkan tanggal.
- Format tanggal yang umum digunakan di MySQL adalah `YYYY-MM-DD`.

## 14. Prinsip Dokumentasi

Repository GitHub ini menjadi pusat dokumentasi teknis dan bisnis TimbangQu.

Dokumen Markdown diperlakukan sebagai **living document**. Jika keputusan berubah, dokumen yang sama diperbarui. Git menyimpan history perubahan melalui commit.

## 15. Hal yang Masih Perlu Dibahas

1. Struktur tabel perusahaan secara rinci.
2. Format dan panjang `kode_perusahaan`.
3. Struktur user dan hak akses.
4. Tipe/status user internal dan tenant.
5. Mekanisme multilingual untuk pesan validasi/error.
6. Struktur paket langganan.
7. Struktur subscription perusahaan.
8. Struktur invoice dan detail invoice.
9. Integrasi Midtrans dan webhook.
10. Aturan jatuh tempo, grace period, suspended, dan nonaktif.
11. Struktur konektor Bluetooth.
12. Struktur perangkat/timbangan.
13. Struktur transaksi penimbangan.
14. Mekanisme generator nomor urut `id_trx` yang aman terhadap concurrency.
15. Index, constraint, dan strategi performa database.

---

**Status:** Fondasi arsitektur sedang dirumuskan. Keputusan yang belum dinyatakan final masih dapat berubah melalui pembahasan berikutnya.
