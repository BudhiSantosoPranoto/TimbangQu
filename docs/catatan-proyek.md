# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja awal dan menjadi acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan dapat diperbarui seiring keputusan desain berubah.

## 1. Konsep Umum

TimbangQu dirancang sebagai aplikasi SaaS yang digunakan oleh banyak perusahaan klien dalam satu platform dan satu database MySQL.

Prinsip awal:
- Multi-company / multi-tenant.
- Satu database untuk banyak perusahaan klien.
- Setiap perusahaan memiliki `id` sebagai primary key teknis.
- `id` menggunakan `BIGINT UNSIGNED`.
- Setiap perusahaan juga memiliki `kode_perusahaan` yang unik dan mudah dibaca/diucapkan untuk kebutuhan customer service dan operasional.

## 2. Konvensi Penamaan Field

Field domain/bisnis menggunakan Bahasa Indonesia selama tetap jelas dan tidak terlalu panjang.

Field teknis yang sudah umum bagi developer tetap menggunakan Bahasa Inggris, misalnya:
- `id`
- `created_at`
- `created_by`
- `updated_at`
- `updated_by`
- `deleted_at`
- `deleted_by`

Field penting nantinya diberi komentar/deskripsi di database agar developer dapat memahami tujuannya ketika melakukan maintenance atau perubahan manual.

## 3. Identitas Perusahaan

Informasi awal perusahaan antara lain:
- `id`
- `kode_perusahaan`
- nama perusahaan
- alamat perusahaan
- informasi kontak
- NPWP, apabila diputuskan diperlukan
- informasi lain yang akan ditentukan saat struktur tabel perusahaan dibahas.

`kode_perusahaan` harus unik secara global dan menggunakan kombinasi huruf serta angka agar lebih mudah disebutkan kepada customer service dibandingkan `id` numerik.

Format dan panjang final `kode_perusahaan` belum ditetapkan dan akan dibahas khusus.

## 4. Langganan dan Penagihan

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

### 4.1 Grace Period

Sebagai rancangan awal, kemungkinan digunakan masa tenggang sebelum perusahaan benar-benar disuspend. Durasi dan perilakunya belum final.

### 4.2 Status

Status subscription dan status invoice sebaiknya dipisahkan karena lifecycle keduanya berbeda.

Contoh status subscription:
- `trial`
- `active`
- `grace_period`
- `suspended`
- `cancelled`

Contoh status invoice:
- `draft`
- `issued`
- `paid`
- `overdue`
- `expired`
- `void`

Daftar status tersebut masih berupa rancangan dan dapat berubah.

## 5. Paket Langganan

Struktur paket subscription belum final karena masih mungkin terjadi perubahan pada:
- harga paket
- fitur/service yang termasuk dalam paket
- harga konektor Bluetooth
- komponen biaya lainnya
- aturan dan benefit setiap paket

Struktur database harus fleksibel dan tidak meng-hardcode harga atau fitur ke tabel perusahaan.

## 6. Audit Field

Untuk tabel yang membutuhkan audit internal, pola berikut akan dipertimbangkan:

- `created_at` — waktu data dibuat.
- `created_by` — user/system yang membuat data.
- `updated_at` — waktu terakhir data diubah.
- `updated_by` — user/system yang terakhir mengubah data.
- `deleted_at` — waktu data di-soft-delete.
- `deleted_by` — user/system yang melakukan soft delete.

Soft delete digunakan agar data tidak langsung hilang secara fisik dan histori operasional tetap dapat dipertahankan.

## 7. Prinsip Dokumentasi

Repository GitHub ini menjadi pusat dokumentasi teknis dan bisnis TimbangQu.

Dokumen Markdown diperlakukan sebagai **living document**. Jika keputusan berubah, dokumen yang sama diperbarui. Tidak perlu membuat salinan dokumen untuk setiap versi karena Git sudah menyimpan riwayat perubahan melalui commit history.

Perubahan besar nantinya dapat dicatat dalam `CHANGELOG.md`.

## 8. Hal yang Masih Perlu Dibahas

1. Struktur tabel perusahaan.
2. Format dan panjang `kode_perusahaan`.
3. Struktur user dan hak akses.
4. Struktur paket langganan.
5. Struktur subscription perusahaan.
6. Struktur invoice dan detail invoice.
7. Integrasi Midtrans dan webhook.
8. Aturan jatuh tempo dan grace period.
9. Struktur konektor Bluetooth.
10. Struktur perangkat/timbangan.
11. Struktur transaksi penimbangan.
12. Aturan multi-tenant dan isolasi data antar perusahaan.
13. Index, foreign key, constraint, dan strategi performa database.

---

**Status:** Draft awal — keputusan yang belum dinyatakan final masih dapat berubah melalui pembahasan berikutnya.
