# TimbangQu — Catatan Proyek

> Dokumen ini adalah catatan kerja utama dan acuan pengembangan TimbangQu. Dokumen bersifat **living document** dan diperbarui setiap keputusan desain ditetapkan.

## 10. Identitas Perusahaan

### 10.4 Nama Perusahaan

Field nama perusahaan:

```text
nama_perusahaan VARCHAR(200) NOT NULL
nama_alias     VARCHAR(200) NULL
```

`nama_perusahaan` adalah nama legal/resmi perusahaan. `nama_alias` adalah nama singkat/nama yang umum digunakan untuk keperluan UI, laporan, dan komunikasi sehari-hari. `nama_alias` nullable karena tidak semua perusahaan membutuhkan alias.

### 10.5 Alamat Perusahaan

Alamat perusahaan dipisahkan antara alamat bebas dan data wilayah regional:

```text
alamat         TEXT
rt             VARCHAR(3) NULL
rw             VARCHAR(3) NULL
id_kelurahan   INT(11) UNSIGNED NOT NULL
```

`alamat` berisi bagian alamat bebas. `rt` dan `rw` opsional. `id_kelurahan` wajib.

### 10.6 Kontak Perusahaan

Field kontak utama:

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

`email`, `website`, dan `npwp` nullable. `npwp` tetap bernama `npwp`, tetapi komentar database dan label UI menjelaskan bahwa perusahaan luar Indonesia menggunakan Tax ID/Tax Identification Number yang setara.

`media_telp_kantor` dan `media_cp` adalah FK ke master `media_kontak`.

## 10.7 Master `media_kontak`

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

Primary key `SMALLINT UNSIGNED AUTO_INCREMENT`.

Default awal antara lain: Tidak ada, Telepon Kabel, WhatsApp, WeChat, LINE, KakaoTalk, dan media populer lainnya.

UI hanya menyediakan Tambah dan Ubah; tidak menyediakan Delete.

## 11. Sequence `id_trx`

Nomor urut `id_trx` menggunakan kombinasi user + tanggal dan reset setiap pergantian tanggal. Detail implementasi mengikuti procedure/trigger SQL yang sudah digunakan dan akan diverifikasi sebelum ditulis sebagai standar final.

## 12. Timezone dan Tanggal/Waktu

- Operasional awal menggunakan wilayah UTC+7 seperti Bangkok/Hanoi/Jakarta.
- Penyimpanan menggunakan `DATETIME`, bukan `TIMESTAMP`.
- Format tanggal umum MySQL: `YYYY-MM-DD`.

## 13. Langganan dan Penagihan

TimbangQu menggunakan mekanisme subscription yang sebisa mungkin otomatis. Detail paket, invoice, Midtrans, webhook, jatuh tempo, grace period, suspended, dan nonaktif masih akan dibahas.

## 14. Prinsip Dokumentasi

Repository GitHub adalah pusat dokumentasi teknis dan bisnis TimbangQu. Dokumen Markdown adalah living document dan setiap keputusan yang sudah disepakati langsung dicatat.

## 15. Hal yang Masih Perlu Dibahas

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
