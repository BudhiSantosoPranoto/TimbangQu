# TimbangQu — VIEW Perusahaan untuk UI

Dokumen ini mendefinisikan konsep VIEW yang menjadi sumber data tampilan/search UI untuk data perusahaan. Database tetap menyimpan foreign key berupa ID; UI tidak perlu menampilkan ID master kepada admin.

## Prinsip

Tabel `perusahaan` menyimpan ID relasi seperti:

- `id_status_perusahaan`
- `id_jenis_badan_usaha`
- `id_kelurahan`

UI menggunakan VIEW yang melakukan JOIN ke tabel master terkait dan menampilkan nilai yang manusiawi.

Contoh: jika `id_jenis_badan_usaha` menunjuk record `PT`, UI menampilkan **PT**, bukan angka ID-nya. Jika `id_status_perusahaan` menunjuk `AKTIF`, UI menampilkan **AKTIF**.

## Contoh kolom VIEW

```text
id
kode_perusahaan
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

Kolom regional seperti `kelurahan`, `kecamatan`, `kota_kabupaten`, `provinsi`, dan `kode_pos` diperoleh dari database regional melalui `id_kelurahan`; tidak disimpan ulang pada tabel `perusahaan`.

`jenis_badan_usaha`, `status_perusahaan`, dan `nama_aplikasi_cp` adalah hasil JOIN ke master masing-masing.

## Pencarian UI

Admin melakukan pencarian menggunakan nilai yang dikenal manusia, misalnya:

- `PT` untuk jenis badan usaha.
- `AKTIF` untuk status perusahaan.
- nama kelurahan/kecamatan/kota.
- nama perusahaan atau alias.

Admin tidak perlu mengetahui atau mengetik `id_jenis_badan_usaha`, `id_status_perusahaan`, atau `id_kelurahan`.

VIEW adalah projection untuk kebutuhan baca/search UI. Tabel sumber tetap menjadi tempat penyimpanan data dan foreign key.
