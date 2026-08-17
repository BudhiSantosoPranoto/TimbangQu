# TimbangQu — VIEW Klien untuk UI

Dokumen ini mendefinisikan konsep VIEW yang menjadi sumber data tampilan/search UI untuk data **klien** TimbangQu.

> Catatan terminologi: nama file ini masih `view-perusahaan.md` karena merupakan dokumen yang sudah ada, tetapi entitas yang dibahas adalah **klien/tenant TimbangQu**, bukan konsep `perusahaan` yang sudah ada pada database existing.

## Terminologi

- **Klien** = istilah bisnis/UI untuk pelanggan TimbangQu.
- **Tenant** = istilah arsitektur/software untuk klien yang datanya terisolasi dalam database multi-tenant.
- **Perusahaan** = badan usaha/perusahaan milik klien. Jangan menggunakan istilah ini sebagai sinonim tenant jika dapat menimbulkan ambiguitas dengan tabel/konsep `perusahaan` pada database existing.

Dengan demikian tabel utama yang sedang dirancang untuk pelanggan TimbangQu secara konseptual adalah `klien`, sedangkan salah satu atributnya adalah `nama_perusahaan`.

## Prinsip VIEW

Tabel `klien` menyimpan ID relasi seperti:

- `id_status_perusahaan`
- `id_jenis_badan_usaha`
- `id_kelurahan`
- `aplikasi_cp`

UI menggunakan VIEW yang melakukan JOIN ke tabel master terkait dan menampilkan nilai yang manusiawi. Database tetap menyimpan foreign key berupa ID; UI tidak perlu menampilkan ID master kepada admin.

Contoh: jika `id_jenis_badan_usaha` menunjuk record `PT`, UI menampilkan **PT**, bukan angka ID-nya. Jika `id_status_perusahaan` menunjuk `AKTIF`, UI menampilkan **AKTIF**.

## Contoh kolom VIEW

```text
id
kode_klien
nama_perusahaan
nama_alias
jenis_badan_usaha
status_perusahaan
alamat
rt
rw
kelurahan
kecamatan
kota_kabupaten
provinsi
kode_pos
telp_kantor
jenis_telp_kantor
nama_cp
no_hp_cp
nama_aplikasi_cp
email
website
npwp
```

Kolom regional seperti `kelurahan`, `kecamatan`, `kota_kabupaten`, `provinsi`, dan `kode_pos` diperoleh dari database regional melalui `id_kelurahan`; tidak disimpan ulang pada tabel `klien`.

`jenis_badan_usaha`, `status_perusahaan`, dan `nama_aplikasi_cp` adalah hasil JOIN ke master masing-masing.

## Pencarian UI

Admin melakukan pencarian menggunakan nilai yang dikenal manusia, misalnya:

- `PT` untuk jenis badan usaha.
- `AKTIF` untuk status klien.
- nama kelurahan/kecamatan/kota.
- nama perusahaan atau alias.
- nama aplikasi kontak.

Admin tidak perlu mengetahui atau mengetik `id_jenis_badan_usaha`, `id_status_perusahaan`, `id_kelurahan`, atau ID master kontak.

VIEW adalah projection untuk kebutuhan baca/search UI. Tabel sumber tetap menjadi tempat penyimpanan data dan foreign key.
