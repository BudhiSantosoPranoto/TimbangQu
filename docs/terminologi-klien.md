# TimbangQu — Terminologi Klien dan Tenant

## Keputusan Terminologi

Untuk menghindari benturan dengan database existing, istilah **klien** digunakan sebagai istilah bisnis/UI untuk pelanggan TimbangQu.

Istilah **tenant** digunakan dalam konteks arsitektur/software untuk menjelaskan bahwa satu klien merupakan satu logical tenant dengan data yang terisolasi dalam database multi-tenant.

Istilah **perusahaan** tidak digunakan sebagai sinonim klien/tenant. Perusahaan adalah badan usaha milik klien. Database existing sudah memiliki konsep/tabel perusahaan dengan makna yang berbeda, sehingga penggunaan istilah yang sama untuk tenant akan membingungkan developer.

## Konsep

```text
TimbangQu
  |
  +-- Klien A
  |     +-- nama_perusahaan
  |     +-- user
  |     +-- subscription
  |     +-- transaksi
  |     +-- perangkat
  |
  +-- Klien B
  |
  +-- Klien C
```

Secara database, tabel utama pelanggan TimbangQu direncanakan bernama `klien`.

Field `nama_perusahaan` tetap digunakan karena berisi nama badan usaha/perusahaan milik klien.

Contoh:

```text
klien
-----
id
kode_klien
nama_perusahaan
nama_alias
...
```

## Aturan Konsistensi

- UI/business discussion: gunakan **klien**.
- Arsitektur/database discussion: boleh gunakan **tenant** ketika membahas isolasi data/multi-tenancy.
- Gunakan **perusahaan** hanya ketika benar-benar membahas badan usaha/perusahaan milik klien atau struktur existing yang memang bernama perusahaan.
- Jangan menyebut tabel `klien` sebagai `perusahaan` secara bergantian.
