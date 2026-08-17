-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Agu 2026 pada 19.12
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan_ikan`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createNewIdTrx` (IN `idKodeTabel` INT(11) UNSIGNED, IN `newCreatedAt` DATETIME, IN `newCreatedBy` BIGINT(20) UNSIGNED, OUT `idTrx` VARCHAR(50))   begin
  declare kodeTrx Varchar(50);
  declare idSdmVar Varchar(25);
  declare waktuTrxFi Varchar(8);
  declare
    nomorUrutTrx,
    lastTrx Varchar(5);
  declare waktuTrxFo Date;
  declare
    countTrx,
    lastNomorUrutTrx Integer(11) default 0;

  set kodeTrx = (
      select
        kode_awal
      from
        kode_tabel
      where
        id = idKodeTabel
  );

  set waktuTrxFo = newCreatedAt;
  set waktuTrxFi = date_format(waktuTrxFo, '%d%m%Y');
  set idSdmVar = newCreatedBy;
  set nomorUrutTrx = '';

  if (idKodeTabel = 2)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_jurnal_umum
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 3)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_notifikasi
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 4)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_input_modal
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 5)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_prive
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 6)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_deposit_supplier
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 7)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_wd_deposit_supplier
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 8)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_deposit_pelanggan
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 9)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_wd_deposit_pelanggan
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 10)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_kasbon_sdm
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 11)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_bayar_kasbon_sdm
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 12)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_antar_kas
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  elseif (idKodeTabel = 13)
  then
    set countTrx = (
      select
        count(*)
      from
        trx_antar_reknt
      where
        id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
    );
  end if;

  if countTrx = 0 then
    set nomorUrutTrx = '00001';
  else
    if (idKodeTabel = 2)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_jurnal_umum
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 3)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_notifikasi
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 4)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_input_modal
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 5)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_prive
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 6)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_deposit_supplier
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 7)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_wd_deposit_supplier
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 8)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_deposit_pelanggan
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 9)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_wd_deposit_pelanggan
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 10)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_kasbon_sdm
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 11)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_bayar_kasbon_sdm
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 12)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_antar_kas
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    elseif (idKodeTabel = 13)
    then
      set lastTrx = (
        select
          max(substring_index(id_trx, '/', -1))
        from
          trx_antar_reknt
        where
          id_trx like concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/%')
      );
    end if;

    set lastNomorUrutTrx = cast(lastTrx as Unsigned);
    set nomorUrutTrx = lpad(lastNomorUrutTrx + 1, 5, '0');
  end if;

  set idTrx = concat(kodeTrx, '/', waktuTrxFi, '/', idSdmVar, '/', nomorUrutTrx);
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hitungCoaSempurna` ()   begin
  call hitungSaldoSemuaCoa();
  call hitungSaldoCoaVertikal();
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hitungSaldoCoaVertikal` ()   begin
  declare
    tingkatMax,
    jumlahData,
    jumlahBaris,
    baris Integer(11) Unsigned;
  declare
    nomorCoaInduk,
    oldNomorCoaInduk Varchar(100);
  declare
    sumDebet,
    sumKredit Double;

  set oldNomorCoaInduk = '!@#';

  select
    max(tingkat)
  into
    tingkatMax
  from
    coa;

  while (tingkatMax > 0) do
  begin
    select
      count(nomor_coa)
    into
      jumlahData
    from
      coa
    where
      tingkat = tingkatMax;

    set jumlahBaris = jumlahData;
    set baris = 0;
    
    while (baris < jumlahBaris) do
    begin      
      select
        nomor_coa_induk
      into
        nomorCoaInduk
      from
        coa
      where
        tingkat = tingkatMax
      order by
        nomor_coa_induk asc
      limit
        baris, 1;
      
      if (nomorCoaInduk <> oldNomorCoaInduk)
      then
        select
          coalesce(sum(trx_debet), 0),
          coalesce(sum(trx_kredit), 0)
        into
          sumDebet,
          sumKredit
        from
          coa
        where
          nomor_coa_induk = nomorCoaInduk;
      
        update
          coa
        set
          trx_debet = coa.trx_debet + sumDebet,
          trx_kredit = coa.trx_kredit + sumKredit
        where
          nomor_coa = nomorCoaInduk;
          
        set oldNomorCoaInduk = nomorCoaInduk;
        set baris = baris + 1;
      elseif (nomorCoaInduk = oldNomorCoaInduk)
      then
        set baris = baris + 1;
      end if;
    end;
    end while;
    set tingkatMax = tingkatMax - 1;
  end;
  end while;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `hitungSaldoSemuaCoa` ()   begin
  declare
    tingkatMax,
    jumlahData,
    jumlahBaris,
    baris Integer(11) Unsigned;
  declare
    nomorCoa Varchar(100);
  declare
    sumDebet,
    sumKredit Double;
  
  update
    coa
  set
    trx_debet = 0,
    trx_kredit = 0,
    saldo = 0;
    
  select
    max(tingkat)
  into
    tingkatMax
  from
    coa;

  while (tingkatMax > 0) do
  begin
    select
      count(nomor_coa)
    into
      jumlahData
    from
      coa
    where
      tingkat = tingkatMax;

    set jumlahBaris = jumlahData + 1;
    set baris = 0;
    
    while (baris < jumlahBaris) do
    begin      
      select
        nomor_coa
      into
        nomorCoa
      from
        coa
      where
        tingkat = tingkatMax
      order by
        nomor_coa asc
      limit
        baris, 1;
        
      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumDebet,
        sumKredit
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoa
      and
        validasi_trx = 1
      and
        deleted_at is null;
      
      update
        coa
      set
        trx_debet = sumDebet,
        trx_kredit = sumKredit
      where
        nomor_coa = nomorCoa;

      set baris = baris + 1;
    end;
    end while;

	  set tingkatMax = tingkatMax - 1;
  end;
  end while;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertTrxNotifikasi` (IN `waktuTrx` DATETIME, IN `sumberIdTrx` VARCHAR(50), IN `namaKolomPrimary` VARCHAR(50), IN `jenisNotifikasi` ENUM('Informasi','Validasi'), IN `judulNotif` TEXT, IN `isiNotif` TEXT, IN `jenisEntitas` ENUM('User','Lembaga Keuangan','Supplier','Pelanggan'), IN `idEntitas` BIGINT(20) UNSIGNED, IN `namaTabel` VARCHAR(50), IN `namaKolom` VARCHAR(50), IN `createdBy` BIGINT(20) UNSIGNED)   begin
  insert into trx_notifikasi (
    waktu_trx,
    sumber_id_trx,
    nama_kolom_primary,
    jenis_notifikasi,
    judul_notif,
    isi_notif,
    jenis_entitas,
    id_entitas,
    nama_tabel,
    nama_kolom,
    created_by)
  values (
    waktuTrx,
    sumberIdTrx,
    namaKolomPrimary,
    jenisNotifikasi,
    judulNotif,
    isiNotif,
    jenisEntitas,
    idEntitas,
    namaTabel,
    namaKolom,
    createdBy);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `akun_kas`
--

CREATE TABLE `akun_kas` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama_akun_kas` varchar(50) NOT NULL,
  `nomor_coa` varchar(100) NOT NULL COMMENT 'triger',
  `id_pj` bigint(20) UNSIGNED NOT NULL,
  `validasi_pj` tinyint(1) NOT NULL DEFAULT 0,
  `aktif` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `akun_kas`
--

INSERT INTO `akun_kas` (`id`, `nama_akun_kas`, `nomor_coa`, `id_pj`, `validasi_pj`, `aktif`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'Kas Maha Dewa', '100-1-1-1', 1, 1, 1, 1, '2025-12-19 09:15:04', 1, '2025-12-19 09:48:33', NULL, NULL),
(2, 'Kas Owner', '100-1-1-2', 4, 1, 1, 1, '2025-12-19 09:49:44', 4, '2025-12-19 09:50:23', NULL, NULL),
(3, 'Kas Paijem', '100-1-1-3', 5, 1, 1, 1, '2026-03-13 16:17:43', 5, '2026-03-13 16:20:22', NULL, NULL);

--
-- Trigger `akun_kas`
--
DELIMITER $$
CREATE TRIGGER `akun_kas_ai1` AFTER INSERT ON `akun_kas` FOR EACH ROW begin
  declare nomorCoaInduk Varchar(100);

  set nomorCoaInduk = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 3
  );

  insert into coa (
    nomor_coa,
    nama_coa,
    nomor_coa_induk,
    saldo_normal,
    created_by)
  values (
    new.nomor_coa,
    new.nama_akun_kas,
    nomorCoaInduk,
    'debet',
    new.created_by);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_ai2` AFTER INSERT ON `akun_kas` FOR EACH ROW begin
  declare
    kodeUserPjAkunKas Varchar(18);
  declare
    namaPjAkunKas,
    namaCreatedBy Varchar(100);
  declare
    namaCoaAkunKas Varchar(200);
  declare
    judulNotif,
    isiNotif Text;

  if (new.validasi_pj = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 1;

    select
      kode_user,
      nama
    into
      kodeUserPjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = new.id_pj;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = new.nomor_coa
    );

    set namaCreatedBy = (
      select
        nama
      from
        users
      where
        id = new.created_by
    );

    set isiNotif = replace(isiNotif, '{{kodePj}}', kodeUserPjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPj}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', new.nama_akun_kas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      concat(new.id),
      'id',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'akun_kas',
      'validasi_pj',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_au1` AFTER UPDATE ON `akun_kas` FOR EACH ROW begin
  declare pesanError Text;

  if
    ( 
      (new.nama_akun_kas != old.nama_akun_kas) or
      (new.updated_by is null) or
      (new.updated_at is null)
    )
  then
    update
      coa
    set
      nama_coa = new.nama_akun_kas,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      nomor_coa = old.nomor_coa;
  elseif (new.id_pj != old.id_pj)
  then
    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      deleted_by = new.updated_by,
      deleted_at = current_timestamp()
    where
      nama_tabel = 'akun_kas'
    and
      jenis_entitas = 'User'
    and
      id_entitas = old.id_pj
    and
      sumber_id_trx = old.id;
  elseif
    (
      (not (new.deleted_by <=> old.deleted_by)) or
      (not (new.deleted_at <=> old.deleted_at))
    ) 
  then
    update
      coa
    set
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      nomor_coa = old.nomor_coa;

    update
      trx_notifikasi
    set
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      nama_tabel = 'akun_kas'
    and
      sumber_id_trx = old.id;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_au2` AFTER UPDATE ON `akun_kas` FOR EACH ROW begin
  declare
    kodeUserNewPjAkunKas,
    kodeUserOldPjAkunKas Varchar(18);
  declare
    namaNewPjAkunKas,
    namaOldPjAkunKas,
    namaCreatedBy,
    namaUpdatedBy Varchar(100);
  declare
    namaCoaAkunKas Varchar(200);
  declare
    judulNotif,
    isiNotif Text;

  select
    kode_user,
    nama
  into
    kodeUserNewPjAkunKas,
    namaNewPjAkunKas
  from
    users
  where
    id = new.id_pj;

  select
    kode_user,
    nama
  into
    kodeUserOldPjAkunKas,
    namaOldPjAkunKas
  from
    users
  where
    id = old.id_pj;

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  set namaUpdatedBy = (
    select
      nama
    from
      users
    where
      id = new.updated_by
  );

  set namaCoaAkunKas = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = new.nomor_coa
  );

  if
    (
      (new.id_pj != old.id_pj) and
      (new.validasi_pj = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 2;

    set isiNotif = replace(isiNotif, '{{oldKodePj}}', kodeUserOldPjAkunKas);
    set isiNotif = replace(isiNotif, '{{oldNamaPj}}', namaOldPjAkunKas);
    set isiNotif = replace(isiNotif, '{{newKodePj}}', kodeUserNewPjAkunKas);
    set isiNotif = replace(isiNotif, '{{newNamaPj}}', namaNewPjAkunKas);
    set isiNotif = replace(isiNotif, '{{oldNamaAkunKas}}', old.nama_akun_kas);
    set isiNotif = replace(isiNotif, '{{newNamaAkunKas}}', new.nama_akun_kas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
    set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));

    update
      trx_notifikasi
    set
      deleted_by = new.updated_by,
      deleted_at = new.updated_at
    where
      jenis_entitas = 'User'
    and
      nama_tabel = 'akun_kas'
    and
      id_entitas = old.id_pj
    and  
      sumber_id_trx = old.id;

    call insertTrxNotifikasi (
      new.created_at,
      concat(new.id),
      'id',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'akun_kas',
      'validasi_pj',
      new.created_by
    );

    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 3;

    set isiNotif = replace(isiNotif, '{{oldKodePj}}', kodeUserOldPjAkunKas);
    set isiNotif = replace(isiNotif, '{{oldNamaPj}}', namaOldPjAkunKas);
    set isiNotif = replace(isiNotif, '{{newKodePj}}', kodeUserNewPjAkunKas);
    set isiNotif = replace(isiNotif, '{{newNamaPj}}', namaNewPjAkunKas);
    set isiNotif = replace(isiNotif, '{{oldNamaAkunKas}}', old.nama_akun_kas);
    set isiNotif = replace(isiNotif, '{{newNamaAkunKas}}', new.nama_akun_kas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
    set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      concat(old.id),
      'id',
      'Informasi',
      judulNotif,
      isiNotif,
      'User',
      old.id_pj,
      'akun_kas',
      'validasi_pj',
      new.created_by
    );
  end if;

  if 
    (
      (new.aktif != old.aktif) and
      (old.id_pj != new.updated_by)
    )
  then
    if (new.aktif = 1)
    then
      select
        judul_notif,
        isi_notif
      into
        judulNotif,
        isiNotif
      from
        template_notifikasi
      where
        id = 4;
        
      set isiNotif = replace(isiNotif, '{{oldKodePj}}', kodeUserOldPjAkunKas);
      set isiNotif = replace(isiNotif, '{{oldNamaPj}}', namaOldPjAkunKas);
      set isiNotif = replace(isiNotif, '{{newKodePj}}', kodeUserNewPjAkunKas);
      set isiNotif = replace(isiNotif, '{{newNamaPj}}', namaNewPjAkunKas);
      set isiNotif = replace(isiNotif, '{{oldNamaAkunKas}}', old.nama_akun_kas);
      set isiNotif = replace(isiNotif, '{{newNamaAkunKas}}', new.nama_akun_kas);
      set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', new.nomor_coa);
      set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
      set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
      set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
      set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
      set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));
    elseif (new.aktif = 0)
    then
      select
        judul_notif,
        isi_notif
      into
        judulNotif,
        isiNotif
      from
        template_notifikasi
      where
        id = 5;
        
      set isiNotif = replace(isiNotif, '{{oldKodePj}}', kodeUserOldPjAkunKas);
      set isiNotif = replace(isiNotif, '{{oldNamaPj}}', namaOldPjAkunKas);
      set isiNotif = replace(isiNotif, '{{newKodePj}}', kodeUserNewPjAkunKas);
      set isiNotif = replace(isiNotif, '{{newNamaPj}}', namaNewPjAkunKas);
      set isiNotif = replace(isiNotif, '{{oldNamaAkunKas}}', old.nama_akun_kas);
      set isiNotif = replace(isiNotif, '{{newNamaAkunKas}}', new.nama_akun_kas);
      set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', new.nomor_coa);
      set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
      set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
      set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
      set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
      set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));
    end if;

    call insertTrxNotifikasi (
      new.created_at,
      concat(old.id),
      'id',
      'Informasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'akun_kas',
      'validasi_pj',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_bd1` BEFORE DELETE ON `akun_kas` FOR EACH ROW begin
  declare jmlTrxAkunKas Integer(11) Unsigned;
  declare pesanError Text;

  set jmlTrxAkunKas = (
    select
      count(id_trx)
    from
      trx_jurnal_umum
    where
      nomor_coa = old.nomor_coa
  );

  if (jmlTrxAkunKas > 0)
  then
    set pesanError = concat(
      'Akun kas ini tidak dapat dihapus karena sudah pernah ditransaksikan.\n',
      'Permintaan penghapusan ditolak.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (jmlTrxAkunKas = 0)
  then
    delete from
      coa
    where
      nomor_coa = old.nomor_coa;
    
    delete from
      trx_notifikasi
    where
      nama_tabel = 'akun_kas'
    and
      sumber_id_trx = old.id;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_bi1` BEFORE INSERT ON `akun_kas` FOR EACH ROW begin
  declare jumlahPjKembar Integer(11) Unsigned;
  declare pesanError Text;
  
  set jumlahPjKembar = (
    select
      count(id_pj)
    from
      akun_kas
    where
      id_pj = new.id_pj
  );

  if (jumlahPjKembar > 0)
  then
    set pesanError = concat(
      'Penanggung jawab akun kas tidak boleh ada yang sama.\n\n',
      'Penanggung jawab akun kas yang Anda input sudah bertanggung jawab terhadap akun kas yang lain.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_bi2` BEFORE INSERT ON `akun_kas` FOR EACH ROW begin
  declare namaCoaInduk Varchar(200);
  declare varNomorCoaAkunKas Varchar(100);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    tingkatCoaInduk,
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;

  set varNomorCoaAkunKas = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 3
  );
  
  if (new.nomor_coa = '') or (new.nomor_coa is null)
  then
    set jmlAnakCoa = (
      select
        count(nomor_coa)
      from
        coa
      where
        nomor_coa like concat(varNomorCoaAkunKas, '-_%')
      and
        char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varNomorCoaAkunKas) - char_length(replace(varNomorCoaAkunKas, '-', ''))) + 1
    );

    if (jmlAnakCoa = 0)
    then
      set urutanAngkaAkhirNomorCoa = '0';
    elseif (jmlAnakCoa > 0)
    then
      set urutanAngkaAkhirNomorCoa = (
        select
          max(substring_index(nomor_coa, '-', -1))
        from
          coa
        where
          nomor_coa like concat(varNomorCoaAkunKas, '-_%')
        and
        char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varNomorCoaAkunKas) - char_length(replace(varNomorCoaAkunKas, '-', ''))) + 1
      );

        
    end if;

    set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
    set new.nomor_coa = concat(varNomorCoaAkunKas, '-', angkaSaatIniNomorCoa);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_bu1` BEFORE UPDATE ON `akun_kas` FOR EACH ROW begin
  declare jumlahPjKembar Integer(11) Unsigned;
  declare pesanError Text;

  if (not (new.nomor_coa <=> old.nomor_coa))
  then
    set pesanError = concat(
      'Nomor COA dari akun kas tidak boleh diubah.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (not (new.id_pj <=> old.id_pj))
  then
    set jumlahPjKembar = (
      select
        count(id_pj)
      from
        akun_kas
      where
        id_pj = new.id_pj
      and
        id != old.id
    );
    
    if (jumlahPjKembar > 0)
    then
      set pesanError = concat(
        'Penanggung jawab akun kas tidak boleh ada yang sama.\n\n',
        'Penanggung jawab akun kas yang Anda input sudah bertanggung jawab terhadap akun kas yang lain.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahPjKembar = 0)
    then
      set new.validasi_pj = 0;
      set new.aktif = 0;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `akun_kas_bu2` BEFORE UPDATE ON `akun_kas` FOR EACH ROW begin
  declare pesanError Text;

  if
    (
      (new.validasi_pj = 0) and
      (new.aktif = 1)
    )
  then
    set pesanError = concat(
      'Penanggung jawab akun kas yang ditunjuk belum melakukan validasi, maka belum bisa diaktifkan untuk sementara.'    
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cabang`
--

CREATE TABLE `cabang` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama_cabang` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `rt` varchar(3) NOT NULL,
  `rw` varchar(3) NOT NULL,
  `id_kelurahan` int(10) UNSIGNED NOT NULL,
  `nomor_telp` varchar(20) NOT NULL,
  `nomor_wa` varchar(20) NOT NULL,
  `fax` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `id_kepala_cabang` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `cabang`
--

INSERT INTO `cabang` (`id`, `nama_cabang`, `alamat`, `rt`, `rw`, `id_kelurahan`, `nomor_telp`, `nomor_wa`, `fax`, `email`, `id_kepala_cabang`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'Pusat', 'BNI Tower\nJalan Jendral Sudirman 01', '10', '09', 27391, '02155533322', '081233338848', '02155533323', 'mataram.kentjana.nusantara.sakti@gmail.com', 2, 1, '2025-12-21 23:14:16', 1, '2026-01-05 14:50:38', NULL, NULL),
(2, 'Laut Kidul', 'Jalan Parangkusumo nomor gaib', '01', '01', 51021, '', '081700000000', '', 'pantai.selatan@gmail.com', 1, 1, '2026-01-05 12:33:03', 1, '2026-01-05 13:02:58', NULL, NULL),
(3, 'Pulau Bali', 'Jalan Bali', '01', '01', 4804, '', '081611133322', '', 'cabang.bali@gmail.com', 3, 1, '2026-01-05 14:53:48', 1, '2026-01-05 14:54:07', NULL, NULL);

--
-- Trigger `cabang`
--
DELIMITER $$
CREATE TRIGGER `cabang_bd1` BEFORE DELETE ON `cabang` FOR EACH ROW begin
  if (old.id = 1)
  then
    signal sqlstate '45000'
    set message_text = 'Cabang pusat tidak dapat dihapus.';
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `coa`
--

CREATE TABLE `coa` (
  `nomor_coa` varchar(100) NOT NULL,
  `nama_coa` varchar(200) NOT NULL,
  `nomor_coa_induk` varchar(100) NOT NULL,
  `nama_coa_induk` varchar(200) NOT NULL,
  `tingkat` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `saldo_normal` enum('debet','kredit') NOT NULL DEFAULT 'debet',
  `trx_debet` double NOT NULL DEFAULT 0,
  `trx_kredit` double NOT NULL DEFAULT 0,
  `saldo` double NOT NULL DEFAULT 0,
  `permanen` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `coa`
--

INSERT INTO `coa` (`nomor_coa`, `nama_coa`, `nomor_coa_induk`, `nama_coa_induk`, `tingkat`, `saldo_normal`, `trx_debet`, `trx_kredit`, `saldo`, `permanen`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('100', 'Harta', '', '', 1, 'debet', 140150000, 22600000, 117550000, 1, 1, '2025-12-16 19:43:11', 1, '2026-03-25 20:53:53', NULL, NULL),
('100-1', 'Harta Lancar', '100', 'Harta', 2, 'debet', 140150000, 22600000, 117550000, 1, 1, '2025-12-16 19:49:14', 1, '2026-03-25 20:53:53', NULL, NULL),
('100-1-1', 'Kas', '100-1', 'Harta Lancar', 3, 'debet', 129150000, 21100000, 108050000, 1, 1, '2025-12-16 20:01:54', 1, '2026-03-25 20:53:53', NULL, NULL),
('100-1-1-1', 'Kas Maha Dewa', '100-1-1', 'Kas', 4, 'debet', 0, 0, 0, 0, 1, '2025-12-19 09:15:04', NULL, NULL, NULL, NULL),
('100-1-1-2', 'Kas Owner', '100-1-1', 'Kas', 4, 'debet', 129150000, 21100000, 108050000, 0, 1, '2025-12-19 09:49:44', 1, '2026-03-25 20:53:53', NULL, NULL),
('100-1-1-3', 'Kas Paijem', '100-1-1', 'Kas', 4, 'debet', 0, 0, 0, 0, 1, '2026-03-13 16:17:43', NULL, NULL, NULL, NULL),
('100-1-2', 'Bank', '100-1', 'Harta Lancar', 3, 'debet', 0, 0, 0, 1, 1, '2025-12-16 20:02:31', NULL, NULL, NULL, NULL),
('100-1-2-1', 'Bank Permata [9933957125]', '100-1-2', 'Bank', 4, 'debet', 0, 0, 0, 0, 1, '2025-12-19 10:03:29', 1, '2026-03-04 04:54:55', NULL, NULL),
('100-1-2-2', 'BCA (Bank Central Asia) [0471223432]', '100-1-2', 'Bank', 4, 'debet', 0, 0, 0, 0, 1, '2026-03-03 22:28:56', NULL, NULL, NULL, NULL),
('100-1-3', 'Deposit Supplier', '100-1', 'Harta Lancar', 3, 'debet', 11000000, 1500000, 9500000, 1, 1, '2026-03-18 22:37:42', NULL, '2026-03-26 21:30:08', NULL, NULL),
('100-1-4', 'Kasbon Anggota Manajemen', '100-1', 'Harta Lancar', 3, 'debet', 0, 0, 0, 1, 1, '2026-03-26 21:29:54', NULL, NULL, NULL, NULL),
('100-2', 'Harta Jangka Panjang', '100', 'Harta', 2, 'debet', 0, 0, 0, 1, 1, '2025-12-16 19:49:41', NULL, NULL, NULL, NULL),
('100-2-1', 'Harta Qorun Leluhur', '100-2', 'Harta Jangka Panjang', 3, 'debet', 0, 0, 0, 0, 1, '2026-03-05 18:20:29', 1, '2026-03-05 18:20:56', NULL, NULL),
('200', 'Hutang', '', '', 1, 'kredit', 100000, 54300000, 54200000, 1, 1, '2025-12-16 19:44:25', NULL, '2026-03-25 20:53:53', NULL, NULL),
('200-1', 'Hutang Lancar', '200', 'Hutang', 2, 'kredit', 100000, 54300000, 54200000, 0, 1, '2026-03-18 22:38:29', NULL, '2026-03-25 20:53:53', NULL, NULL),
('200-1-1', 'Hutang Dagang', '200-1', 'Hutang Lancar', 3, 'kredit', 0, 0, 0, 0, 1, '2026-03-18 22:39:28', NULL, NULL, NULL, NULL),
('200-1-2', 'Deposit Pelanggan', '200-1', 'Hutang Lancar', 3, 'kredit', 100000, 54300000, 54200000, 1, 1, '2026-03-18 22:40:18', NULL, '2026-03-26 21:30:24', NULL, NULL),
('200-2', 'Hutang Jangka Panjang', '200', 'Hutang', 2, 'kredit', 0, 0, 0, 0, 1, '2026-03-18 22:38:59', NULL, NULL, NULL, NULL),
('300', 'Modal', '', '', 1, 'kredit', 10000000, 73350000, 63350000, 1, 1, '2025-12-16 19:46:24', 1, '2026-03-25 20:53:53', NULL, NULL),
('300-1', 'Modal Owners', '300', 'Modal', 2, 'kredit', 0, 73350000, 73350000, 1, 1, '2025-12-18 05:56:47', 1, '2026-03-25 20:53:53', NULL, NULL),
('300-1-1', 'Modal Investor - Shofant Hedhiyanto', '300-1', 'Modal Owners', 3, 'kredit', 0, 73350000, 73350000, 0, 1, '2025-12-18 07:03:06', 1, '2026-03-25 20:53:53', NULL, NULL),
('300-2', 'Prive Owners', '300', 'Modal', 2, 'debet', 10000000, 0, 10000000, 1, 1, '2025-12-18 06:21:18', 1, '2026-03-25 20:53:53', NULL, NULL),
('300-2-1', 'Prive Investor - Shofant Hedhiyanto', '300-2', 'Prive Owners', 3, 'debet', 10000000, 0, 10000000, 0, 1, '2025-12-18 07:03:06', NULL, '2026-03-25 20:53:53', NULL, NULL),
('400', 'Pendapatan', '', '', 1, 'kredit', 0, 0, 0, 1, 1, '2025-12-16 19:47:23', NULL, NULL, NULL, NULL),
('500', 'HPP (Harga Pokok Penjualan)', '', '', 1, 'debet', 0, 0, 0, 1, 1, '2025-12-16 19:48:05', NULL, NULL, NULL, NULL),
('600', 'Biaya', '', '', 1, 'debet', 0, 0, 0, 1, 1, '2025-12-16 19:48:23', NULL, NULL, NULL, NULL);

--
-- Trigger `coa`
--
DELIMITER $$
CREATE TRIGGER `coa_bd1` BEFORE DELETE ON `coa` FOR EACH ROW begin
  declare nomorCoaAnak Varchar(100);
  declare
    jumlahTrxNomorCoaOriDiJu,
    jumlahTrxNomorCoaAnakDiJu BigInt(20) Unsigned;
  declare
    jumlahDataRepetisi,
    baris Integer(11) Unsigned default 0;
  declare
    varPermanen,
    semuaCoaAnakBolehDihapus Boolean default 0;
  declare pesanError Text;

  if (old.permanen = 1)
  then
    set pesanError = concat(
      'COA ini adalah COA permanen, tidak boleh dihapus.'
    );
    
    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.permanen = 0)
  then
    # cek apakah ada transaksi nang jurnal umum?
    set jumlahTrxNomorCoaOriDiJu = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = old.nomor_coa
    );

    if (jumlahTrxNomorCoaOriDiJu > 0)
    then
      set pesanError = concat(
        'Nomor COA ini sudah pernah digunakan untuk melakukan transaksi, tidak bisa dilakukan perubahan.\n\n',
        'Permintaan perubahan pada COA ini, DITOLAK.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxNomorCoaOriDiJu = 0)
    then
      # cek apakah anak anake coa kiye ana transaksi nang jurnal umum?
      set jumlahDataRepetisi = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa_induk like old.nomor_coa
      );

      if (jumlahDataRepetisi > 0)
      then
        while (baris < jumlahDataRepetisi) do
        begin
          select
            nomor_coa,
            permanen
          into
            nomorCoaAnak,
            varPermanen
          from
            coa
          where
            nomor_coa_induk like old.nomor_coa
          order by
            nomor_coa asc
          limit
            baris, 1;
          
          set jumlahTrxNomorCoaAnakDiJu = (
            select
              count(id_trx)
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAnak
          );

          if (jumlahTrxNomorCoaAnakDiJu > 0)
          then
            set pesanError = concat(
              'Sub COA dari COA yang akan Anda hapus ternyata sudah pernah digunakan untuk melakukan transaksi.\n\n',
              'Permintaan hapus DITOLAK.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (jumlahTrxNomorCoaAnakDiJu = 0)
          then
            if (varPermanen = 1)
            then
              set pesanError = concat(
                'Sub COA dari COA yang akan Anda hapus ternyata adalah salah satu COA permanen yang tidak boleh dihapus.\n\n',
                'Permintaan hapus DITOLAK.'
              );
              
              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (varPermanen = 0)
            then
              set baris = baris + 1;
            end if;
          end if;
        end;
        end while;

        set semuaCoaAnakBolehDihapus = 1;

        delete from
          coa
        where
          nomor_coa_induk like old.nomor_coa;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coa_bi1` BEFORE INSERT ON `coa` FOR EACH ROW begin
  declare namaCoaInduk Varchar(200);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    tingkatCoaInduk,
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;

  if (new.nomor_coa = '') or (new.nomor_coa is null)
  then
    set jmlAnakCoa = (
      select
        count(nomor_coa)
      from
        coa
      where
        nomor_coa like concat(new.nomor_coa_induk, '-_%')
      and
        char_length(nomor_coa) - char_length(REPLACE(nomor_coa, '-', '')) = (char_length(new.nomor_coa_induk) - char_length(replace(new.nomor_coa_induk, '-', ''))) + 1
    );

    if (jmlAnakCoa = 0)
    then
      set urutanAngkaAkhirNomorCoa = '0';
    elseif (jmlAnakCoa > 0)
    then
      set urutanAngkaAkhirNomorCoa = (
        select
          max(cast(substring_index(nomor_coa, '-', -1) as Unsigned))
        from
          coa
        where
          nomor_coa like concat(new.nomor_coa_induk, '-_%')
        and
          char_length(nomor_coa) - char_length(REPLACE(nomor_coa, '-', '')) = (char_length(new.nomor_coa_induk) - char_length(replace(new.nomor_coa_induk, '-', ''))) + 1
      );
    end if;

    set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
    set new.nomor_coa = concat(new.nomor_coa_induk, '-', angkaSaatIniNomorCoa);
  end if;

  if  ( 
        (new.tingkat = 0) or
        (new.tingkat is null) or
        (new.tingkat = '')
      )
  then
    select
      nama_coa,
      tingkat
    into
      namaCoaInduk,
      tingkatCoaInduk
    from
      coa
    where
      nomor_coa = new.nomor_coa_induk;

    set new.nama_coa_induk = namaCoaInduk;
    set new.tingkat = tingkatCoaInduk + 1;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coa_bu1_bd` BEFORE UPDATE ON `coa` FOR EACH ROW begin
  declare nomorCoaAnak Varchar(100);
  declare
    jumlahTrxNomorCoaOriDiJu,
    jumlahTrxNomorCoaAnakDiJu BigInt(20) Unsigned;
  declare
    jumlahDataRepetisi,
    baris Integer(11) Unsigned default 0;
  declare
    varPermanen,
    semuaCoaAnakBolehDihapus Boolean default 0;
  declare pesanError Text;

  if (new.deleted_by is not null) or (new.deleted_at is not null)
  then
    if (old.permanen = 1)
    then
      set pesanError = concat(
        'COA ini adalah COA permanen, tidak boleh dihapus.'
      );
    elseif (old.permanen = 0)
    then
      # cek apakah ada transaksi nang jurnal umum?
      set jumlahTrxNomorCoaOriDiJu = (
        select
          count(id_trx)
        from
          trx_jurnal_umum
        where
          nomor_coa = old.nomor_coa
      );

      if (jumlahTrxNomorCoaOriDiJu > 0)
      then
        set pesanError = concat(
          'Nomor COA ini sudah pernah digunakan untuk melakukan transaksi, tidak bisa dilakukan perubahan.\n\n',
          'Permintaan perubahan pada COA ini, DITOLAK.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      elseif (jumlahTrxNomorCoaOriDiJu = 0)
      then
        # cek apakah anak anake coa kiye ana transaksi nang jurnal umum?
        set jumlahDataRepetisi = (
          select
            count(nomor_coa)
          from
            coa
          where
            nomor_coa_induk like old.nomor_coa
        );

        if (jumlahDataRepetisi > 0)
        then
          while (baris < jumlahDataRepetisi) do
          begin
            select
              nomor_coa,
              permanen
            into
              nomorCoaAnak,
              varPermanen
            from
              coa
            where
              nomor_coa_induk like old.nomor_coa
            order by
              nomor_coa asc
            limit
              baris, 1;
            
            set jumlahTrxNomorCoaAnakDiJu = (
              select
                count(id_trx)
              from
                trx_jurnal_umum
              where
                nomor_coa = nomorCoaAnak
            );

            if (jumlahTrxNomorCoaAnakDiJu > 0)
            then
              set pesanError = concat(
                'Sub COA dari COA yang akan Anda hapus ternyata sudah pernah digunakan untuk melakukan transaksi.\n\n',
                'Permintaan hapus DITOLAK.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (jumlahTrxNomorCoaAnakDiJu = 0)
            then
              if (varPermanen = 1)
              then
                set pesanError = concat(
                  'Sub COA dari COA yang akan Anda hapus ternyata adalah salah satu COA permanen yang tidak boleh dihapus.\n\n',
                  'Permintaan hapus DITOLAK.'
                );
              elseif (varPermanen = 0)
              then
                set baris = baris + 1;
              end if;
            end if;
          end;
          end while;

          set semuaCoaAnakBolehDihapus = 1;

          update
            coa
          set
            deleted_by = new.deleted_by,
            deleted_at = new.deleted_at
          where
            nomor_coa_induk like old.nomor_coa;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coa_bu2` BEFORE UPDATE ON `coa` FOR EACH ROW begin
  declare namaCoaInduk Varchar(200);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    tingkatCoaInduk,
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;
  declare jumlahTrxPadaJu BigInt(20) Unsigned;
  declare pesanError Text;

  if (new.nomor_coa_induk != old.nomor_coa_induk)
  then
    set jumlahTrxPadaJu = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = old.nomor_coa
    );
    
    if (jumlahTrxPadaJu > 0)
    then
      set pesanError = concat(
        'Nomor COA ini sudah pernah digunakan untuk melakukan transaksi, tidak bisa dilakukan perubahan.\n\n',
        'Permintaan perubahan pada COA ini, DITOLAK.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPadaJu = 0)
    then
      set jmlAnakCoa = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa like concat(new.nomor_coa_induk, '-_%')
        and
          char_length(nomor_coa) - char_length(REPLACE(nomor_coa, '-', '')) = (char_length(new.nomor_coa_induk) - char_length(replace(new.nomor_coa_induk, '-', ''))) + 1
      );

      if (jmlAnakCoa = 0)
      then
        set urutanAngkaAkhirNomorCoa = '0';
      elseif (jmlAnakCoa > 0)
      then
        # nomor coane juga berubah nek induke berubah owh
        set urutanAngkaAkhirNomorCoa = (
          select
            max(cast(substring_index(nomor_coa, '-', -1) as Unsigned))
          from
            coa
          where
            nomor_coa like concat(new.nomor_coa_induk, '-_%')
          and
            char_length(nomor_coa) - char_length(REPLACE(nomor_coa, '-', '')) = (char_length(new.nomor_coa_induk) - char_length(replace(new.nomor_coa_induk, '-', ''))) + 1
        );
      end if;

      set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
      set new.nomor_coa = concat(new.nomor_coa_induk, '-', angkaSaatIniNomorCoa);

      select
        nama_coa,
        tingkat
      into
        namaCoaInduk,
        tingkatCoaInduk
      from
        coa
      where
        nomor_coa = new.nomor_coa_induk;

      set new.nama_coa_induk = namaCoaInduk;
      set new.tingkat = tingkatCoaInduk + 1;
    end if;
  end if;

  if (new.saldo_normal = 'debet')
  then
    set new.saldo = new.trx_debet - new.trx_kredit;
  elseif (new.saldo_normal = 'kredit')
  then
    set new.saldo = new.trx_kredit - new.trx_debet;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `jabatan`
--

CREATE TABLE `jabatan` (
  `id` int(11) UNSIGNED NOT NULL,
  `id_cabang` int(11) UNSIGNED NOT NULL,
  `nama_jabatan` varchar(100) NOT NULL,
  `id_jal` int(11) UNSIGNED DEFAULT NULL COMMENT 'jal = jabatan atasan langsung',
  `tingkat` int(11) UNSIGNED NOT NULL,
  `keterangan_tambahan` text NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jabatan`
--

INSERT INTO `jabatan` (`id`, `id_cabang`, `nama_jabatan`, `id_jal`, `tingkat`, `keterangan_tambahan`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 1, 'CEO Pusat', NULL, 1, '', 1, '2026-03-14 19:39:55', NULL, NULL, NULL, NULL),
(2, 1, 'Wakil CEO Pusat', 1, 2, '', 1, '2026-03-14 19:40:34', NULL, NULL, NULL, NULL),
(3, 1, 'Direktur Operasional Pusat', 2, 3, 'Ngurusi operasional perusahaan nang pusat', 1, '2026-03-14 19:56:29', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kode_tabel`
--

CREATE TABLE `kode_tabel` (
  `id` tinyint(4) UNSIGNED NOT NULL,
  `nama_tabel` varchar(50) NOT NULL,
  `kode_awal` varchar(10) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kode_tabel`
--

INSERT INTO `kode_tabel` (`id`, `nama_tabel`, `kode_awal`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'users', 'USR', 1, '2025-12-16 00:46:45', NULL, NULL, NULL, NULL),
(2, 'trx_jurnal_umum', 'JU', 1, '2025-12-17 01:47:40', NULL, NULL, NULL, NULL),
(3, 'trx_notifikasi', 'NTF', 1, '2025-12-17 15:01:14', NULL, NULL, NULL, NULL),
(4, 'trx_input_modal', 'TIM', 1, '2025-12-17 22:02:23', NULL, NULL, NULL, NULL),
(5, 'trx_prive', 'TPV', 1, '2025-12-17 23:46:13', NULL, NULL, NULL, NULL),
(6, 'trx_deposit_supplier', 'DSP', 1, '2026-03-18 18:49:32', NULL, NULL, NULL, NULL),
(7, 'trx_wd_deposit_supplier', 'WDDS', 1, '2026-03-18 18:51:27', NULL, NULL, NULL, NULL),
(8, 'trx_deposit_pelanggan', 'DPL', 1, '2025-12-17 23:47:09', NULL, NULL, NULL, NULL),
(9, 'trx_wd_deposit_pelanggan', 'WDDPL', 1, '2025-12-17 23:50:44', NULL, NULL, NULL, NULL),
(10, 'trx_kasbon_sdm', 'KBM', 1, '2026-03-25 21:10:19', NULL, NULL, NULL, NULL),
(11, 'trx_bayar_kasbon_sdm', 'BKBM', 1, '2026-03-25 21:10:07', NULL, NULL, NULL, NULL),
(12, 'trx_antar_kas', 'TAK', 1, '2025-12-17 23:51:05', NULL, NULL, NULL, NULL),
(13, 'trx_antar_reknt', 'TAR', 1, '2025-12-17 23:51:19', NULL, NULL, NULL, NULL),
(14, 'trx_kas_ke_reknt', 'TKR', 1, '2025-12-17 23:51:42', NULL, NULL, NULL, NULL),
(15, 'trx_reknt_ke_kas', 'TRK', 1, '2025-12-17 23:51:53', NULL, NULL, NULL, NULL),
(16, 'trx_pendapatan', 'TPD', 1, '2026-03-23 11:33:31', NULL, NULL, NULL, NULL),
(17, 'trx_biaya', 'TBY', 1, '2026-03-23 11:33:41', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kode_trx_ju`
--

CREATE TABLE `kode_trx_ju` (
  `id` smallint(6) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kode_trx_ju`
--

INSERT INTO `kode_trx_ju` (`id`, `nama`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'Transaksi input modal investor', 1, '2025-12-18 19:49:04', NULL, NULL, NULL, NULL),
(2, 'Transaksi prive', 1, '2025-12-18 19:49:20', NULL, NULL, NULL, NULL),
(3, 'Transaksi deposit ke supplier', 1, '2025-12-17 22:24:38', NULL, NULL, NULL, NULL),
(4, 'Transaksi Tarik Deposit Dari Supplier', 1, '2026-03-23 12:07:03', NULL, NULL, NULL, NULL),
(5, 'Transaksi Deposit Dari Pelanggan', 1, '2026-03-23 20:39:07', NULL, NULL, NULL, NULL),
(6, 'Transaksi Tarik Deposit Pelanggan', 1, '2026-03-23 20:39:27', NULL, NULL, NULL, NULL),
(7, 'Transaksi Kasbon Anggota Manajemen', 1, '2026-03-27 22:45:37', NULL, NULL, NULL, NULL),
(8, 'Transaksi Bayar Kasbon Anggota Manajemen', 1, '2026-03-27 22:45:51', NULL, NULL, NULL, NULL),
(9, 'Transaksi Antar Kas Internal', 1, '2026-03-28 16:34:02', NULL, NULL, NULL, NULL),
(10, 'Transaksi Antar Rekening Non Tunai Internal', 1, '2026-03-30 21:18:16', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `lembaga_keuangan`
--

CREATE TABLE `lembaga_keuangan` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `lembaga_keuangan`
--

INSERT INTO `lembaga_keuangan` (`id`, `nama`, `logo`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'BCA (Bank Central Asia)', 'lk_1.jpg', 1, '2025-12-17 20:06:01', NULL, NULL, NULL, NULL),
(2, 'BNI 46 (Bank Negara Indonesia)', 'lk_2.jpg', 1, '2025-12-17 20:06:25', NULL, NULL, NULL, NULL),
(3, 'BRI (Bank Rakyat Indonesia)', 'lk_3.jpg', 1, '2025-12-17 20:06:48', NULL, NULL, NULL, NULL),
(4, 'Bank Mandiri', 'lk_4.jpg', 1, '2025-12-17 20:07:13', NULL, NULL, NULL, NULL),
(5, 'Bank Permata', 'lk_5.jpg', 1, '2025-12-17 20:07:28', NULL, NULL, NULL, NULL),
(6, 'Bank Panin', '', 1, '2026-01-06 23:31:25', 1, '2026-01-06 23:31:36', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `profil_perusahaan`
--

CREATE TABLE `profil_perusahaan` (
  `id` tinyint(4) UNSIGNED NOT NULL,
  `bentuk_perusahaan` enum('Perusahaan Perorangan','C.V.','P.T.','Firma') NOT NULL DEFAULT 'Perusahaan Perorangan',
  `sudah_pkp` tinyint(1) NOT NULL DEFAULT 0,
  `npwp_perusahaan` varchar(21) NOT NULL,
  `nama_perusahaan` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `rt` varchar(3) NOT NULL,
  `rw` varchar(3) NOT NULL,
  `id_kelurahan` int(10) UNSIGNED NOT NULL,
  `nomor_telp` varchar(20) NOT NULL,
  `nomor_wa` varchar(20) NOT NULL,
  `fax` varchar(20) NOT NULL,
  `email` varchar(150) NOT NULL,
  `website` varchar(100) NOT NULL,
  `id_ceo` bigint(20) UNSIGNED NOT NULL,
  `logo` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `profil_perusahaan`
--

INSERT INTO `profil_perusahaan` (`id`, `bentuk_perusahaan`, `sudah_pkp`, `npwp_perusahaan`, `nama_perusahaan`, `alamat`, `rt`, `rw`, `id_kelurahan`, `nomor_telp`, `nomor_wa`, `fax`, `email`, `website`, `id_ceo`, `logo`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'P.T.', 0, '', 'Mataram Kentjana Jaya', 'BNI Tower\nJalan Jendral Sudirman 01', '10', '09', 27391, '02155533322', '081233338848', '02155533323', 'mataram.kentjana.nusantara.sakti@gmail.com', 'https://mkns.com', 4, '', 1, '2025-12-21 23:14:16', 1, '2026-01-05 14:50:38', NULL, NULL);

--
-- Trigger `profil_perusahaan`
--
DELIMITER $$
CREATE TRIGGER `profile_perusahaan_ai1` AFTER INSERT ON `profil_perusahaan` FOR EACH ROW begin
  insert into cabang (
    nama_cabang,
    alamat,
    rt,
    rw,
    id_kelurahan,
    nomor_telp,
    nomor_wa,
    fax,
    email,
    id_kepala_cabang,
    created_by,
    created_at)
  values (
    'Pusat',
    new.alamat,
    new.rt,
    new.rw,
    new.id_kelurahan,
    new.nomor_telp,
    new.nomor_wa,
    new.fax,
    new.email,
    new.id_ceo,
    new.created_by,
    new.created_at);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `profile_perusahaan_au1` AFTER UPDATE ON `profil_perusahaan` FOR EACH ROW begin
  update
    cabang
  set
    nama_cabang = 'Pusat',
    alamat = new.alamat,
    rt = new.rt,
    rw = new.rw,
    id_kelurahan = new.id_kelurahan,
    nomor_telp = new.nomor_telp,
    nomor_wa = new.nomor_wa,
    fax = new.fax,
    email = new.email,
    id_kepala_cabang = new.id_ceo,
    updated_by = new.updated_by,
    updated_at = new.updated_at
  where
    id = 1;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `profile_perusahaan_bd1` BEFORE DELETE ON `profil_perusahaan` FOR EACH ROW begin
  if (old.id = 1)
  then
    signal sqlstate '45000'
    set message_text = 'Profil perusahaan tidak dapat dihapus.';
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reknt`
--

CREATE TABLE `reknt` (
  `id` int(11) UNSIGNED NOT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `nomor_coa` varchar(100) NOT NULL,
  `id_lk` int(11) UNSIGNED NOT NULL,
  `id_pj` bigint(20) UNSIGNED NOT NULL,
  `validasi_pj` tinyint(1) NOT NULL DEFAULT 0,
  `aktif` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reknt`
--

INSERT INTO `reknt` (`id`, `nomor_rekening`, `atas_nama`, `nomor_coa`, `id_lk`, `id_pj`, `validasi_pj`, `aktif`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, '9933957125', 'Shofant Hedhiyanto', '100-1-2-1', 5, 4, 1, 1, 1, '2025-12-19 10:03:29', 1, '2025-12-19 10:48:45', NULL, NULL),
(2, '0471223432', 'Budhi Santoso Pranoto', '100-1-2-2', 1, 1, 1, 1, 1, '2026-03-03 22:28:56', 1, '2026-03-04 03:54:04', NULL, NULL);

--
-- Trigger `reknt`
--
DELIMITER $$
CREATE TRIGGER `reknt_ai1` AFTER INSERT ON `reknt` FOR EACH ROW begin
  declare
    kodePj Varchar(18);
  declare
    namaPj,
    nomorCoaInduk,
    namaLk,
    namaCreatedBy Varchar(100);
  declare
    namaCoaReknt Varchar(200);
  declare
    judulNotif,
    isiNotif Text;

  set nomorCoaInduk = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 4
  );

  set namaLk = (
    select
      nama
    from
      lembaga_keuangan
    where
      id = new.id_lk
  );

  insert into coa (
    nomor_coa,
    nama_coa,
    nomor_coa_induk,
    saldo_normal,
    created_by)
  values (
    new.nomor_coa,
    concat(namaLk, ' ', '[', new.nomor_rekening, ']'),
    nomorCoaInduk,
    'debet',
    new.created_by);

  if (new.validasi_pj = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 6;

    select
      kode_user,
      nama
    into
      kodePj,
      namaPj
    from
      users
    where
      id = new.id_pj;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = new.nomor_coa
    );

    set namaCreatedBy = (
      select
        nama
      from
        users
      where
        id = new.created_by
    );

    set isiNotif = replace(isiNotif, '{{kodePj}}', kodePj);
    set isiNotif = replace(isiNotif, '{{namaPj}}', namaPj);
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', new.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', new.atas_nama);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      concat(new.id),
      'id',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'reknt',
      'validasi_pj',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_au1` AFTER UPDATE ON `reknt` FOR EACH ROW begin
  declare namaLk Varchar(100);
  declare pesanError Text;

  if
    ( 
      (new.nomor_rekening != old.nomor_rekening) or
      (new.atas_nama != old.atas_nama) or
      (new.updated_by is null) or
      (new.updated_at is null)
    )
  then
    set namaLk = (
      select
        nama
      from
        lembaga_keuangan
      where
        id = new.id_lk
    );

    update
      coa
    set
      nama_coa = concat(namaLk, ' ', '[', new.nomor_rekening, ']'),
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      nomor_coa = old.nomor_coa;
  elseif (new.id_pj != old.id_pj)
  then
    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      deleted_by = new.updated_by,
      deleted_at = current_timestamp()
    where
      nama_tabel = 'reknt'
    and
      jenis_entitas = 'User'
    and
      id_entitas = old.id_pj
    and
      sumber_id_trx = old.id;
  elseif
    (
      (not (new.deleted_by <=> old.deleted_by)) or
      (not (new.deleted_at <=> old.deleted_at))
    ) 
  then
    update
      coa
    set
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      nomor_coa = old.nomor_coa;

    update
      trx_notifikasi
    set
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      nama_tabel = 'reknt'
    and
      sumber_id_trx = old.id;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_au2` AFTER UPDATE ON `reknt` FOR EACH ROW begin
  declare
    newKodePj,
    oldKodePj Varchar(18);
  declare
    newNamaPj,
    oldNamaPj,
    oldNamaLk,
    newNamaLk,
    namaCreatedBy,
    namaUpdatedBy Varchar(100);
  declare
    namaCoaReknt Varchar(200);
  declare
    judulNotif,
    isiNotif Text;

  select
    kode_user,
    nama
  into
    newKodePj,
    newNamaPj
  from
    users
  where
    id = new.id_pj;
  
  select
    kode_user,
    nama
  into
    oldKodePj,
    oldNamaPj
  from
    users
  where
    id = old.id_pj;

  set newNamaLk = (
    select
      nama
    from
      lembaga_keuangan
    where
      id = new.id_lk
  );

  set oldNamaLk = (
    select
      nama
    from
      lembaga_keuangan
    where
      id = old.id_lk
  );

  set namaCoaReknt = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = new.nomor_coa
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  set namaUpdatedBy = (
    select
      nama
    from
      users
    where
      id = new.updated_by
  );

  if
    (
      (new.id_pj != old.id_pj) and
      (new.validasi_pj = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 7;

    set isiNotif = replace(isiNotif, '{{oldKodePj}}', oldKodePj);
    set isiNotif = replace(isiNotif, '{{oldNamaPj}}', oldNamaPj);
    set isiNotif = replace(isiNotif, '{{newKodePj}}', newKodePj);
    set isiNotif = replace(isiNotif, '{{newNamaPj}}', newNamaPj);
    set isiNotif = replace(isiNotif, '{{oldNomorReknt}}', old.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{newNomorReknt}}', new.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{oldAtasNamaReknt}}', old.atas_nama);
    set isiNotif = replace(isiNotif, '{{newAtasNamaReknt}}', new.atas_nama);
    set isiNotif = replace(isiNotif, '{{oldNamaLk}}', oldNamaLk);
    set isiNotif = replace(isiNotif, '{{newNamaLk}}', newNamaLk);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
    set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));

    update
      trx_notifikasi
    set
      deleted_by = new.updated_by,
      deleted_at = new.updated_at
    where
      jenis_entitas = 'User'
    and
      nama_tabel = 'reknt'
    and
      id_entitas = old.id_pj
    and  
      sumber_id_trx = old.id;

    call insertTrxNotifikasi (
      new.created_at,
      concat(new.id),
      'id',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'reknt',
      'validasi_pj',
      new.created_by
    );

    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 8;

    set isiNotif = replace(isiNotif, '{{oldKodePj}}', oldKodePj);
    set isiNotif = replace(isiNotif, '{{oldNamaPj}}', oldNamaPj);
    set isiNotif = replace(isiNotif, '{{newKodePj}}', newKodePj);
    set isiNotif = replace(isiNotif, '{{newNamaPj}}', newNamaPj);
    set isiNotif = replace(isiNotif, '{{oldNomorReknt}}', old.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{newNomorReknt}}', new.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{oldAtasNamaReknt}}', old.atas_nama);
    set isiNotif = replace(isiNotif, '{{newAtasNamaReknt}}', new.atas_nama);
    set isiNotif = replace(isiNotif, '{{oldNamaLk}}', oldNamaLk);
    set isiNotif = replace(isiNotif, '{{newNamaLk}}', newNamaLk);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
    set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      concat(old.id),
      'id',
      'Informasi',
      judulNotif,
      isiNotif,
      'User',
      old.id_pj,
      'reknt',
      'validasi_pj',
      new.created_by
    );
  end if;

  if 
    (
      (new.aktif != old.aktif) and
      (old.id_pj != new.updated_by)
    )
  then
    if (new.aktif = 1)
    then
      select
        judul_notif,
        isi_notif
      into
        judulNotif,
        isiNotif
      from
        template_notifikasi
      where
        id = 9;
    elseif (new.aktif = 0)
    then
      select
        judul_notif,
        isi_notif
      into
        judulNotif,
        isiNotif
      from
        template_notifikasi
      where
        id = 10;
    end if;

    set isiNotif = replace(isiNotif, '{{oldKodePj}}', oldKodePj);
    set isiNotif = replace(isiNotif, '{{oldNamaPj}}', oldNamaPj);
    set isiNotif = replace(isiNotif, '{{newKodePj}}', newKodePj);
    set isiNotif = replace(isiNotif, '{{newNamaPj}}', newNamaPj);
    set isiNotif = replace(isiNotif, '{{oldNomorReknt}}', old.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{newNomorReknt}}', new.nomor_rekening);
    set isiNotif = replace(isiNotif, '{{oldAtasNamaReknt}}', old.atas_nama);
    set isiNotif = replace(isiNotif, '{{newAtasNamaReknt}}', new.atas_nama);
    set isiNotif = replace(isiNotif, '{{oldNamaLk}}', oldNamaLk);
    set isiNotif = replace(isiNotif, '{{newNamaLk}}', newNamaLk);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', new.nomor_coa);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{diupdateOleh}}', namaUpdatedBy);
    set isiNotif = replace(isiNotif, '{{waktuUpdate}}', date_format(new.updated_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      concat(old.id),
      'id',
      'Informasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pj,
      'akun_kas',
      'validasi_pj',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_bd` BEFORE DELETE ON `reknt` FOR EACH ROW begin
  delete from
    coa
  where
    nomor_coa = old.nomor_coa;
  
  delete from
  	trx_notifikasi
  where
    nama_tabel = 'reknt'
  and
    sumber_id_trx = old.id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_bi1` BEFORE INSERT ON `reknt` FOR EACH ROW begin
  declare jumlahPjKembar Integer(11) Unsigned;
  declare pesanError Text;
  
  set jumlahPjKembar = (
    select
      count(id_pj)
    from
      reknt
    where
      id_pj = new.id_pj
  );

  if (jumlahPjKembar > 0)
  then
    set pesanError = concat(
      'Penanggung jawab akun kas tidak boleh ada yang sama.\n\n',
      'Penanggung jawab akun kas yang Anda input sudah bertanggung jawab terhadap akun kas yang lain.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_bi2` BEFORE INSERT ON `reknt` FOR EACH ROW begin
  declare namaCoaInduk Varchar(200);
  declare varNomorCoaReknt Varchar(100);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    tingkatCoaInduk,
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;

  set varNomorCoaReknt = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 4
  );
  
  if (new.nomor_coa = '') or (new.nomor_coa is null)
  then
    set jmlAnakCoa = (
      select
        count(nomor_coa)
      from
        coa
      where
        nomor_coa like concat(varNomorCoaReknt, '-_%')
      and
        char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varNomorCoaReknt) - char_length(replace(varNomorCoaReknt, '-', ''))) + 1
    );

    if (jmlAnakCoa = 0)
    then
      set urutanAngkaAkhirNomorCoa = '0';
    elseif (jmlAnakCoa > 0)
    then
      set urutanAngkaAkhirNomorCoa = (
        select
          max(substring_index(nomor_coa, '-', -1))
        from
          coa
        where
          nomor_coa like concat(varNomorCoaReknt, '-_%')
        and
          char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varNomorCoaReknt) - char_length(replace(varNomorCoaReknt, '-', ''))) + 1
      );
    end if;

    set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
    set new.nomor_coa = concat(varNomorCoaReknt, '-', angkaSaatIniNomorCoa);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_bu1` BEFORE UPDATE ON `reknt` FOR EACH ROW begin
  declare jumlahPjKembar Integer(11) Unsigned;
  declare pesanError Text;

  if (not (new.nomor_coa <=> old.nomor_coa))
  then
    set pesanError = concat(
      'Nomor COA dari rekening perusahaan tidak boleh diubah.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (not (new.id_pj <=> old.id_pj))
  then
    set jumlahPjKembar = (
      select
        count(id_pj)
      from
        reknt
      where
        id_pj = new.id_pj
      and
        id != old.id
    );
    
    if (jumlahPjKembar > 0)
    then
      set pesanError = concat(
        'Penanggung jawab rekening perusahaan tidak boleh ada yang sama.\n\n',
        'Penanggung jawab rekening perusahaan yang Anda input sudah bertanggung jawab terhadap rekening perusahaan yang lain.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahPjKembar = 0)
    then
      set new.validasi_pj = 0;
      set new.aktif = 0;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `reknt_bu2` BEFORE UPDATE ON `reknt` FOR EACH ROW begin
  declare pesanError Text;

  if
    (
      (new.validasi_pj = 0) and
      (new.aktif = 1)
    )
  then
    set pesanError = concat(
      'Penanggung jawab rekening non tunai yang ditunjuk belum melakukan validasi, maka belum bisa diaktifkan untuk sementara.'    
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `reknt_users`
--

CREATE TABLE `reknt_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `id_lk` int(11) UNSIGNED NOT NULL,
  `validasi_admin` tinyint(1) NOT NULL DEFAULT 1,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reknt_users`
--

INSERT INTO `reknt_users` (`id`, `id_user`, `nomor_rekening`, `atas_nama`, `id_lk`, `validasi_admin`, `is_default`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 1, '606501028121535', 'Budhi Santoso Pranoto', 3, 1, 1, 1, '2026-03-14 18:59:32', 1, '2026-03-15 07:52:00', NULL, NULL),
(2, 1, '469293899', 'Budhi Santoso Pranoto', 2, 1, 0, 1, '2026-03-15 07:51:48', 1, '2026-03-15 07:52:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `setting_apps`
--

CREATE TABLE `setting_apps` (
  `id` tinyint(4) UNSIGNED NOT NULL,
  `versi_apps_andro` varchar(20) NOT NULL,
  `versi_apps_desktop` varchar(20) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `setting_apps`
--

INSERT INTO `setting_apps` (`id`, `versi_apps_andro`, `versi_apps_desktop`, `maintenance`) VALUES
(1, '1.00', '1.00', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `setting_coa_default`
--

CREATE TABLE `setting_coa_default` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama_setting` varchar(100) NOT NULL,
  `nomor_coa` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `setting_coa_default`
--

INSERT INTO `setting_coa_default` (`id`, `nama_setting`, `nomor_coa`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'Induk coa modal', '300-1', 1, '2025-12-17 02:23:19', NULL, NULL, NULL, NULL),
(2, 'Induk coa prive', '300-2', 1, '2025-12-17 20:14:03', NULL, NULL, NULL, NULL),
(3, 'Induk coa kas', '100-1-1', 1, '2025-12-18 06:31:36', NULL, NULL, NULL, NULL),
(4, 'Induk coa bank', '100-1-2', 1, '2025-12-18 06:31:59', NULL, NULL, NULL, NULL),
(5, 'Induk COA Deposit ke Supplier', '100-1-3', 1, '2026-03-18 22:41:00', NULL, NULL, NULL, NULL),
(6, 'Induk COA Deposit dari Pelanggan', '200-1-2', 1, '2026-03-18 22:41:36', NULL, NULL, NULL, NULL),
(7, 'Induk COA Kasbon Anggota Manajemen', '100-1-4', 1, '2026-03-26 21:31:25', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `template_notifikasi`
--

CREATE TABLE `template_notifikasi` (
  `id` int(11) UNSIGNED NOT NULL,
  `nama_tabel` varchar(50) NOT NULL,
  `nama_kolom` varchar(50) NOT NULL,
  `fungsi` text NOT NULL,
  `tujuan` enum('User','Lembaga Keuangan','Supplier','Pelanggan') NOT NULL DEFAULT 'User',
  `detail_tujuan` varchar(100) NOT NULL,
  `sifat` enum('Meminta Validasi','Hanya Menginformasikan') NOT NULL DEFAULT 'Meminta Validasi',
  `waktu` enum('Setelah Input','Setelah Update') NOT NULL DEFAULT 'Setelah Input',
  `variabel` text NOT NULL,
  `judul_notif` text NOT NULL,
  `isi_notif` text NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `template_notifikasi`
--

INSERT INTO `template_notifikasi` (`id`, `nama_tabel`, `nama_kolom`, `fungsi`, `tujuan`, `detail_tujuan`, `sifat`, `waktu`, `variabel`, `judul_notif`, `isi_notif`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'akun_kas', 'validasi_pj', 'Meminta persetujuan penanggung jawab akun kas.', 'User', 'Penanggung jawab baru', 'Meminta Validasi', 'Setelah Input', 'Kode Penanggung Jawab: {{kodePj}}\r\nNama Penanggung Jawab: {{namaPj}}\r\nNama Akun Kas: {{namaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\nNama COA {{namaCoaAkunKas}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Ditunjuk Sebagai Penanggung Jawab Salah Satu Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab salah satu akun kas perusahaan.\n\nDetail informasi akun kas perusahaan yang akan dipercayakan kepada Anda adalah:\nNama Akun Kas: {{namaAkunKas}}\nNomor COA: {{nomorCoaAkunKas}}\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 1, '2025-12-18 23:15:28', 1, '2026-03-11 14:33:03'),
(2, 'akun_kas', 'validasi_pj', 'Meminta persetujuan penanggung jawab akun kas yang baru atas peralihan dari penanggung jawab akun kas yang lama.', 'User', 'Penanggung jawab baru', 'Meminta Validasi', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNama Akun Kas Lama: {{oldNamaAkunKas}}\r\nNama Akun Kas Baru: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\nNama COA {{namaCoaAkunKas}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Anda Ditunjuk Sebagai Penanggung Jawab Yang Baru Atas Peralihan Dari Penanggung Jawab Lama Dari Salah Satu Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab yang baru atas peralihan dari penanggung jawab yang lama dari salah satu akun kas perusahaan.\r\n\r\nDetail informasi akun kas perusahaan yang dialihkan dan akan dipercayakan kepada Anda adalah:\r\nNama Akun Kas: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\n\r\nSilahkan Anda terima atau Anda tolak.\r\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-18 23:30:33', 1, '2026-03-11 15:20:36'),
(3, 'akun_kas', 'validasi_pj', 'Menginformasikan kepada penanggung jawab lama yang tanggung jawab dan wewenangnya atas akun kas dialihkan kepada penanggung jawab baru.', 'User', 'Penanggung jawab lama', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNama Akun Kas Lama: {{oldNamaAkunKas}}\r\nNama Akun Kas Baru: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\nNama COA {{namaCoaAkunKas}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Tanggung Jawab Dan Wewenang Anda Atas Salah Satu Akun Kas Perusahaan Telah Dialihkan Kepada Penanggung Jawab Yang Baru', 'Tanggung jawab dan wewenang Anda atas salah satu akun kas perusahaan telah dialihkan kepada penanggung jawab yang baru.\r\n\r\nDetail informasi akun kas yang telah dialihkan adalah:\r\nNama Akun Kas: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\n\r\nDemikian informasi yang kami sampaikan kepada Anda.\r\n\r\nUntuk hal lain, silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nTerima kasih.\r\n\r\nHormat Kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-18 23:36:27', 1, '2026-03-11 15:20:22'),
(4, 'akun_kas', 'aktif', 'Menginformasikan bahwa akun kas diaktifkan kembali.', 'User', 'Penanggung jawab akun kas saat ini', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNama Akun Kas Lama: {{oldNamaAkunKas}}\r\nNama Akun Kas Baru: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\nNama COA {{namaCoaAkunKas}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Akun Kas Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Diaktifkan Kembali', 'Akun kas yang berada di dalam wewenang dan tanggung jawab Anda telah diaktifkan kembali dan sudah bisa digunakan kembali untuk melakukan transaksi.\r\n\r\nDetail informasi akun kas yang diaktifkan kembali:\r\nNama Akun Kas: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-18 23:40:38', 1, '2026-03-11 15:20:10'),
(5, 'akun_kas', 'aktif', 'Menginformasikan bahwa akun kas dinonaktifkan.', 'User', 'Penanggung jawab akun kas saat ini', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNama Akun Kas Lama: {{oldNamaAkunKas}}\r\nNama Akun Kas Baru: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\nNama COA {{namaCoaAkunKas}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Akun Kas Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Dinonaktifkan', 'Akun kas yang berada di dalam wewenang dan tanggung jawab Anda telah dinonaktifkan sehingga untuk sementara tidak dapat digunakan untuk melakukan transaksi sampai batas waktu yang tidak dapat ditentukan.\r\n\r\nDetail informasi akun kas yang dinonaktifkan:\r\nNama Akun Kas: {{newNamaAkunKas}}\r\nNomor COA: {{nomorCoaAkunKas}}\r\n\r\nAnda masih dapat mengaktifkan akun kas Anda setelah manajemen/atasan Anda menyetujui.\r\n\r\nUntuk sebab dari hal ini silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-18 23:41:50', 1, '2026-03-11 15:20:01'),
(6, 'reknt', 'validasi_pj', 'Meminta persetujuan penanggung jawab rekening non tunai.', 'User', 'Penanggung jawab baru', 'Meminta Validasi', 'Setelah Input', 'Kode Penanggung Jawab: {{kodePj}}\r\nNama Penanggung Jawab: {{namaPj}}\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nNama Lembaga Keuangan: {{namaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\nNama COA: {{namaCoaReknt}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\n', 'Anda Ditunjuk Sebagai Penanggung Jawab Salah Satu Rekening Non Tunai Perusahaan', 'Anda ditunjuk sebagai penanggung jawab salah satu rekening non tunai perusahaan.\n\nDetail informasi rekening non tunai perusahaan yang akan dipercayakan kepada Anda adalah:\nNomor Rekening: {{nomorReknt}}\nAtas Nama: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nNomor COA: {{nomorCoaReknt}}\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 1, '2025-12-19 09:53:33', 1, '2026-03-11 15:36:35'),
(7, 'reknt', 'validasi_pj', 'Meminta persetujuan penanggung jawab rekening non tunai yang baru atas peralihan dari penanggung jawab rekening non tunai yang lama.', 'User', 'Penanggung jawab baru', 'Meminta Validasi', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNomor Rekening Lama: {{oldNomorReknt}}\r\nNomor Rekening Baru: {{newNomorReknt}}\r\nAtas Nama Rekening Lama: {{oldAtasNamaReknt}}\r\nAtas Nama Rekening Baru: {{newAtasNamaReknt}}\r\nNama Lembaga Keuangan Lama: {{oldNamaLk}}\r\nNama Lembaga Keuangan Baru: {{newNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\nNama COA: {{namaCoaReknt}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Anda Ditunjuk Sebagai Penanggung Jawab Yang Baru Atas Peralihan Dari Penanggung Jawab Lama Dari Salah Satu Rekening Non Tunai Perusahaan', 'Anda ditunjuk sebagai penanggung jawab yang baru atas peralihan dari penanggung jawab yang lama dari salah satu rekening non tunai perusahaan.\r\n\r\nDetail informasi rekening non tunai perusahaan yang dialihkan dan akan dipercayakan kepada Anda adalah:\r\nNomor Rekening: {{newNomorReknt}}\r\nAtas Nama: {{newAtasNamaReknt}}\r\nLembaga Keuangan: {{newNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\n\r\nSilahkan Anda terima atau Anda tolak.\r\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-19 10:15:04', 1, '2026-03-11 15:55:06'),
(8, 'reknt', 'validasi_pj', 'Menginformasikan kepada penanggung jawab lama yang tanggung jawab dan wewenangnya atas rekening non tunai dialihkan kepada penanggung jawab baru.', 'User', 'Penanggung jawab lama', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNomor Rekening Lama: {{oldNomorReknt}}\r\nNomor Rekening Baru: {{newNomorReknt}}\r\nAtas Nama Rekening Lama: {{oldAtasNamaReknt}}\r\nAtas Nama Rekening Baru: {{newAtasNamaReknt}}\r\nNama Lembaga Keuangan Lama: {{oldNamaLk}}\r\nNama Lembaga Keuangan Baru: {{newNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\nNama COA: {{namaCoaReknt}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Tanggung Jawab Dan Wewenang Anda Atas Salah Satu Rekening Non Tunai Perusahaan Telah Dialihkan Kepada Orang Lain', 'Tanggung jawab dan wewenang Anda atas salah satu rekening non tunai perusahaan telah dialihkan kepada penanggung jawab yang baru.\r\n\r\nDetail informasi rekening non tunai perusahaan telah dialihkan adalah:\r\nNomor Rekening: {{oldNomorReknt}}\r\nAtas Nama: {{oldAtasNamaReknt}}\r\nLembaga Keuangan: {{oldNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\n\r\nDemikian informasi yang kami sampaikan kepada Anda.\r\n\r\nUntuk hal lain, silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nTerima kasih.\r\n\r\nHormat Kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-19 10:29:53', 1, '2026-03-11 16:01:14'),
(9, 'reknt', 'aktif', 'Menginformasikan bahwa rekening non tunai diaktifkan kembali.', 'User', 'Penanggung jawab rekening non tunai saat ini', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNomor Rekening Lama: {{oldNomorReknt}}\r\nNomor Rekening Baru: {{newNomorReknt}}\r\nAtas Nama Rekening Lama: {{oldAtasNamaReknt}}\r\nAtas Nama Rekening Baru: {{newAtasNamaReknt}}\r\nNama Lembaga Keuangan Lama: {{oldNamaLk}}\r\nNama Lembaga Keuangan Baru: {{newNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\nNama COA: {{namaCoaReknt}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Rekening Non Tunai Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Diaktifkan Kembali', 'Rekening non tunai yang berada di dalam wewenang dan tanggung jawab Anda telah diaktifkan kembali dan sudah bisa digunakan kembali untuk melakukan transaksi.\r\n\r\nDetail informasi rekening non tunai yang diaktifkan kembali:\r\nNomor Rekening: {{oldNomorReknt}}\r\nAtas Nama: {{oldAtasNamaReknt}}\r\nLembaga Keuangan: {{oldNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-19 10:37:58', 1, '2026-03-11 16:02:59'),
(10, 'reknt', 'aktif', 'Menginformasikan bahwa rekening non tunai dinonaktifkan.', 'User', 'Penanggung jawab rekening non tunai saat ini', 'Hanya Menginformasikan', 'Setelah Update', 'Kode Penanggung Jawab Lama: {{oldKodePj}}\r\nNama Penanggung Jawab Lama: {{oldNamaPj}}\r\nKode Penanggung Jawab Baru: {{newKodePj}}\r\nNama Penanggung Jawab Baru: {{newNamaPj}}\r\nNomor Rekening Lama: {{oldNomorReknt}}\r\nNomor Rekening Baru: {{newNomorReknt}}\r\nAtas Nama Rekening Lama: {{oldAtasNamaReknt}}\r\nAtas Nama Rekening Baru: {{newAtasNamaReknt}}\r\nNama Lembaga Keuangan Lama: {{oldNamaLk}}\r\nNama Lembaga Keuangan Baru: {{newNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\nNama COA: {{namaCoaReknt}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}\r\nDiupdate Oleh: {{diupdateOleh}}\r\nWaktu Update: {{waktuUpdate}}', 'Rekening Non Tunai Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Dinonaktifkan', 'Rekening non tunai yang berada di dalam wewenang dan tanggung jawab Anda telah dinonaktifkan sehingga untuk sementara tidak dapat digunakan untuk melakukan transaksi sampai batas waktu yang tidak dapat ditentukan.\r\n\r\nDetail informasi rekening non tunai yang dinonaktifkan:\r\nNomor Rekening: {{oldNomorReknt}}\r\nAtas Nama: {{oldAtasNamaReknt}}\r\nLembaga Keuangan: {{oldNamaLk}}\r\nNomor COA: {{nomorCoaReknt}}\r\n\r\nAnda masih dapat mengaktifkan rekening non tunai Anda setelah manajemen/atasan Anda menyetujui.\r\n\r\nUntuk sebab dari hal ini silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 1, '2025-12-19 10:40:22', 1, '2026-03-11 16:03:46'),
(11, 'trx_input_modal', 'validasi_investor', 'Meminta validasi/konfirmasi dari investor pada transaksi input modal.', 'User', 'Investor Yang Menyetorkan Modal', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\n\nHAL TRANSAKSI:\nID Transaksi: {{idTrx}}\nWaktu Transaksi: {{waktuTrx}}\n\nHAL INVESTOR:\nKode Investor: {{kodeInvestor}}\nNama Investor: {{namaInvestor}}\n\nUANG TUNAI PENERIMA INVESTASI:\nNama Akun Kas: {{namaAkunKas}}\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\nNomor COA Kas: {{nomorCoaAkunKas}}\nNama COA Kas: {{namaCoaAkunKas}}\nNominal Tunai: {{nominalKas}}\n\nREKENING NON TUNAI PENERIMA INVESTASI:\nNomor Rekening: {{nomorReknt}}\nAtas Nama Rekening: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\nNominal Non Tunai: {{nominalReknt}}\n\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\n\nDiinput Oleh: {{diinputOleh}}\nWaktu Input: {{waktuInput}}', 'Anda Menginvestasikan Sejumlah Modal ke {{namaPerusahaan}}', 'Anda menginvestasikan sejumlah modal ke {{namaPerusahaan}} dengan detail informasi sebagai berikut:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nKode Anda: {{kodeInvestor}}\r\nNama Anda: {{namaInvestor}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi menggunakan rekening non tunai:\r\nRekening Tujuan: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nTotal Investasi: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:44:49', 1, '2026-03-23 21:33:12'),
(12, 'trx_input_modal', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena menerima sejumlah uang investasi dari investor.', 'User', 'Penanggung jawab akun kas penerima uang investasi dari investor', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\n\nHAL TRANSAKSI:\nID Transaksi: {{idTrx}}\nWaktu Transaksi: {{waktuTrx}}\n\nHAL INVESTOR:\nKode Investor: {{kodeInvestor}}\nNama Investor: {{namaInvestor}}\n\nUANG TUNAI PENERIMA INVESTASI:\nNama Akun Kas: {{namaAkunKas}}\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\nNomor COA Kas: {{nomorCoaAkunKas}}\nNama COA Kas: {{namaCoaAkunKas}}\nNominal Tunai: {{nominalKas}}\n\nREKENING NON TUNAI PENERIMA INVESTASI:\nNomor Rekening: {{nomorReknt}}\nAtas Nama Rekening: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\nNominal Non Tunai: {{nominalReknt}}\n\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\n\nDiinput Oleh: {{diinputOleh}}\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Investasi Dari Investor', 'Telah terjadi transaksi tambah modal, dimana seorang investor telah melakukan investasi dan akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Investor: {{kodeInvestor}}\r\nNama Investor: {{namaInvestor}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-23 21:32:45'),
(13, 'trx_input_modal', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena menerima sejumlah uang investasi dari investor.', 'User', 'Penanggung jawab rekening non tunai penerima uang investasi dari investor', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\n\nHAL TRANSAKSI:\nID Transaksi: {{idTrx}}\nWaktu Transaksi: {{waktuTrx}}\n\nHAL INVESTOR:\nKode Investor: {{kodeInvestor}}\nNama Investor: {{namaInvestor}}\n\nUANG TUNAI PENERIMA INVESTASI:\nNama Akun Kas: {{namaAkunKas}}\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\nNomor COA Kas: {{nomorCoaAkunKas}}\nNama COA Kas: {{namaCoaAkunKas}}\nNominal Tunai: {{nominalKas}}\n\nREKENING NON TUNAI PENERIMA INVESTASI:\nNomor Rekening: {{nomorReknt}}\nAtas Nama Rekening: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\nNominal Non Tunai: {{nominalReknt}}\n\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\n\nDiinput Oleh: {{diinputOleh}}\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Investasi Dari Investor', 'Telah terjadi transaksi tambah modal, dimana seorang investor telah melakukan investasi dan rekening non tunai di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Investor: {{kodeInvestor}}\r\nNama Investor: {{namaInvestor}}\r\n\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', 1, '2026-03-23 21:32:19'),
(14, 'trx_prive', 'validasi_investor', 'Meminta validasi/konfirmasi dari investor pada transaksi prive.', 'User', 'Investor Yang Menarik Modal (Prive)', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\n\nHAL TRANSAKSI:\nID Transaksi: {{idTrx}}\nWaktu Transaksi: {{waktuTrx}}\n\nHAL INVESTOR:\nKode Investor: {{kodeInvestor}}\nNama Investor: {{namaInvestor}}\n\nUANG TUNAI YANG MENCAIRKAN INVESTASI:\nNama Akun Kas: {{namaAkunKas}}\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\nNomor COA Kas: {{nomorCoaAkunKas}}\nNama COA Kas: {{namaCoaAkunKas}}\nNominal Tunai: {{nominalKas}}\n\nREKENING NON TUNAI MENCAIRKAN INVESTASI:\nNomor Rekening: {{nomorReknt}}\nAtas Nama Rekening: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\nNominal Non Tunai: {{nominalReknt}}\n\nREKENING NON TUNAI INVESTOR:\nNomor Rekening: {{nomorRekntInvestor}}\nAtas Nama Rekening: {{atasNamaRekntInvestor}}\nLembaga Keuangan: {{namaLkInvestor}}\n\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\n\nDiinput Oleh: {{diinputOleh}}\nWaktu Input: {{waktuInput}}', 'Anda Menarik Modal Investasi (Prive) Sejumlah Dari {{namaPerusahaan}}', 'Anda menarik investasi modal (prive) dari {{namaPerusahaan}} dengan detail informasi sebagai berikut:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nKode Anda: {{kodeInvestor}}\r\nNama Anda: {{namaInvestor}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: {{nomorRekntInvestor}}\r\nAtas Nama: {{atasNamaRekntInvestor}}\r\nLembaga Keuangan: {{namaLkInvestor}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nTotal Prive: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2026-03-14 13:33:45', 1, '2026-03-23 21:31:38'),
(15, 'trx_prive', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena mengeluarkan sejumlah uang penarikan modal (prive) investasi kepada investor.', 'User', 'Penanggung jawab akun kas yang mengelurakan uang penarikan modal (prive) investasi kepada investor', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\n\nHAL TRANSAKSI:\nID Transaksi: {{idTrx}}\nWaktu Transaksi: {{waktuTrx}}\n\nHAL INVESTOR:\nKode Investor: {{kodeInvestor}}\nNama Investor: {{namaInvestor}}\n\nUANG TUNAI YANG MENCAIRKAN INVESTASI:\nNama Akun Kas: {{namaAkunKas}}\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\nNomor COA Kas: {{nomorCoaAkunKas}}\nNama COA Kas: {{namaCoaAkunKas}}\nNominal Tunai: {{nominalKas}}\n\nREKENING NON TUNAI MENCAIRKAN INVESTASI:\nNomor Rekening: {{nomorReknt}}\nAtas Nama Rekening: {{atasNamaReknt}}\nLembaga Keuangan: {{namaLk}}\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\nNominal Non Tunai: {{nominalReknt}}\n\nREKENING NON TUNAI INVESTOR:\nNomor Rekening: {{nomorRekntInvestor}}\nAtas Nama Rekening: {{atasNamaRekntInvestor}}\nLembaga Keuangan: {{namaLkInvestor}}\n\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\n\nDiinput Oleh: {{diinputOleh}}\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Penarikan Modal (Prive) Investasi Kepada Investor', 'Telah terjadi transaksi penarikan modal (prive), dimana seorang investor telah menarik modal investasinya (prive) dan akun kas di dalam tanggung jawab dan wewenang Anda yang mencairkan uangnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Investor: {{kodeInvestor}}\r\nNama Investor: {{namaInvestor}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-23 21:30:59'),
(16, 'trx_prive', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena mengelurakan sejumlah uang penarikan modal (prive) investasi kepada investor.', 'User', 'Penanggung jawab rekening non tunai yang mengeluarkan uang penarikan modal (prive) investasi kepada ', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL INVESTOR\r\nKode Investor: {{kodeInvestor}}\r\nNama Investor: {{namaInvestor}}\r\n\r\nUANG TUNAI YANG MENCAIRKAN INVESTASI:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENCAIRKAN INVESTASI:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI INVESTOR:\r\nNomor Rekening: {{nomorRekntInvestor}}\r\nAtas Nama Rekening: {{atasNamaRekntInvestor}}\r\nLembaga Keuangan: {{namaLkInvestor}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Mengelurkan Sejumlah Uang Penarikan Modal (Prive) Investasi Kepada Investor', 'Telah terjadi transaksi penarikan modal (prive), dimana seorang investor telah menarik modal investasinya (prive) dan rekening non tunai di dalam tanggung jawab dan wewenang Anda yang mencairkan.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Investor: {{kodeInvestor}}\r\nNama Investor: {{namaInvestor}}\r\n\r\nRekening non tunai perusahaan dalam wewenang Anda:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nRekening non tunai tujuan (rekening investor):\r\nNomor Rekening: {{nomorRekntInvestor}}\r\nAtas Nama: {{atasNamaRekntInvestor}}\r\nLembaga Keuangan: {{namaLkInvestor}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', 1, '2026-03-23 21:30:19'),
(17, 'trx_deposit_supplier', 'validasi_supplier', 'Meminta validasi/konfirmasi dari supplier pada transaksi deposit ke supplier', 'User', 'Supplier yang menerima deposit', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI SUPPLIER YANG MENERIMA DEPOSIT:\r\nNomor Rekening: {{nomorRekntSupplier}}\r\nAtas Nama Rekening: {{atasNamaRekntSupplier}}\r\nLembaga Keuangan: {{namaLkSupplier}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Menerima Deposit Dari {{namaPerusahaan}}', 'Anda menerima sejumlah uang dari {{namaPerusahaan}} sebagai deposit kepada Anda/perusahaan Anda dengan detail informasi sebagai berikut:\r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nKode Anda: {{kodeSupplier}}\r\nPerusahaan Anda (jika ada): {{jenisBadanUsahaSupplier}} {{namaBadanUsahaSupplier}}\r\nNama Anda: {{namaSupplier}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: {{nomorRekntSupplier}}\r\nAtas Nama: {{atasNamaRekntSupplier}}\r\nLembaga Keuangan: {{namaLkSupplier}}\r\n\r\nNominal Transfer: Rp {{nominalReknt}}\r\n\r\nTotal Deposit: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2026-03-14 13:33:45', 1, '2026-03-25 15:01:57'),
(18, 'trx_deposit_supplier', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena mengeluarkan sejumlah uang untuk transaksi deposit ke supplier', 'User', 'Penanggung jawab akun kas yang mengelurakan uang untuk transaksi deposit ke supplier', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI YANG MENGELUARKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI SUPPLIER YANG MENERIMA DEPOSIT:\r\nNomor Rekening: {{nomorRekntSupplier}}\r\nAtas Nama Rekening: {{atasNamaRekntSupplier}}\r\nLembaga Keuangan: {{namaLkSupplier}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Deposit ke Supplier', 'Telah terjadi transaksi deposit ke supplier, dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-25 15:03:06'),
(19, 'trx_deposit_supplier', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena mengelurakan sejumlah uang untuk deposit ke supplier', 'User', 'Penanggung jawab rekening non tunai yang mengeluarkan uang untuk transaksi deposit ke supplier', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI SUPPLIER YANG MENERIMA DEPOSIT:\r\nNomor Rekening: {{nomorRekntSupplier}}\r\nAtas Nama Rekening: {{atasNamaRekntSupplier}}\r\nLembaga Keuangan: {{namaLkSupplier}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Mengelurkan Sejumlah Uang Untuk Transaksi Deposit ke Supplier', 'Telah terjadi transaksi deposit ke supplier dimana rekening non tunai yang berada dalam wewenang dan tanggung jawab Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nRekening non tunai perusahaan dalam wewenang Anda:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nRekening non tunai tujuan (rekening supplier):\r\nNomor Rekening: {{nomorRekntSupplier}}\r\nAtas Nama: {{atasNamaRekntSupplier}}\r\nLembaga Keuangan: {{namaLkSupplier}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', 1, '2026-03-25 15:15:24'),
(20, 'trx_wd_deposit_supplier', 'validasi_supplier', 'Meminta validasi/konfirmasi dari supplier pada transaksi tarik deposit dari supplier.', 'User', 'Supplier Dimana Anda/Perusahaan Anda Pernah Melakukan Deposit', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI PENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', '{{namaPerusahaan}} Telah Mengambil Kembali (Menarik) Deposit Yang Pernah Dilakukan', '{{namaPerusahaan}} telah mengambil kembali (menarik) deposit yang pernah dilakukan pada masa lalu.\r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Deposit Yang Ditarik: Rp {{totalNominal}}\r\n\r\nKode Anda: {{kodeSupplier}}\r\nNama Anda: {{namaSupplier}}\r\nJenis Badan Usaha Anda: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Anda: {{namaBadanUsahaSupplier}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi menggunakan rekening non tunai:\r\nRekening Tujuan: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Transfer: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:44:49', 1, '2026-03-23 21:10:35'),
(21, 'trx_wd_deposit_supplier', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena menerima sejumlah uang dari supplier yang ditarik depositnya.', 'User', 'Penanggung jawab akun kas penerima uang penarikan kembali deposit dari supplier', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI PENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Penarikan Deposit Supplier', 'Telah terjadi transaksi penarikan deposit dari supplier dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-23 21:09:38'),
(22, 'trx_wd_deposit_supplier', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena menerima sejumlah uang dari supplier yang ditarik depositnya.', 'User', 'Penanggung jawab rekening non tunai penerima uang penarikan kembali deposit dari supplier', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nUANG TUNAI PENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Penarikan Deposit Supplier', 'Telah terjadi transaksi penarikan deposit dari supplier dimana rekening non tunai di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSupplier}}\r\nJenis Supplier: {{jenisSupplier}}\r\nJenis Badan Usaha Supplier: {{jenisBadanUsahaSupplier}}\r\nNama Badan Usaha Supplier: {{namaBadanUsahaSupplier}}\r\nNama Supplier: {{namaSupplier}}\r\n\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', 1, '2026-03-23 21:09:01'),
(23, 'trx_deposit_pelanggan', 'validasi_pelanggan', 'Meminta validasi/konfirmasi dari pelanggan pada transaksi deposit pelanggan', 'User', 'Pelanggan yang melakukan deposit', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL SUPPLIER:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI YANG MENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI YANG MENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Melakukan Deposit Untuk {{namaPerusahaan}}', 'Anda mengirimkan sejumlah uang untuk {{namaPerusahaan}} sebagai deposit dari Anda/perusahaan Anda dengan detail informasi sebagai berikut: \r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nKode Anda: {{kodeSupplier}}\r\nPerusahaan Anda (jika ada): {{jenisBadanUsahaPelanggan}} {{namaBadanUsahaPelanggan}}\r\nNama Anda: {{namaPelanggan}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nKepada rekening non tunai:\r\nRekening Asal: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nTotal Deposit: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2026-03-14 13:33:45', 1, '2026-03-23 21:08:19'),
(24, 'trx_deposit_pelanggan', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena menerima sejumlah uang deposit dari pelanggan', 'User', 'Penanggung jawab akun kas penerima uang deposit dari pelanggan', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL PELANGGAN:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI PENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Deposit Pelanggan', 'Telah terjadi transaksi deposit dari pelanggan dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Pelanggan: {{kodePelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-23 21:07:28'),
(25, 'trx_deposit_pelanggan', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena menerima sejumlah uang deposit pelanggan', 'User', 'Penanggung jawab rekening non tunai penerima uang deposit pelanggan', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL PELANGGAN:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI PENERIMA:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Deposit Pelanggan', 'Telah terjadi transaksi deposit dari pelanggan dimana rekening non tunai di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', 1, '2026-03-23 21:07:04');
INSERT INTO `template_notifikasi` (`id`, `nama_tabel`, `nama_kolom`, `fungsi`, `tujuan`, `detail_tujuan`, `sifat`, `waktu`, `variabel`, `judul_notif`, `isi_notif`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(26, 'trx_wd_deposit_pelanggan', 'validasi_supplier', 'Meminta validasi/konfirmasi dari pelanggan pada transaksi kembalikan deposit pelanggan', 'User', 'Pelanggan yang pernah melakukan deposit', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL PELANGGAN:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI YANG MENGEMBALIKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGEMBALIKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI PELANGGAN YANG MENERIMA PENGEMBALIAN DEPOSIT:\r\nNomor Rekening: {{nomorRekntPelanggan}}\r\nAtas Nama Rekening: {{atasNamaRekntPelanggan}}\r\nLembaga Keuangan: {{namaLkPelanggan}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Menerima Pengembalian Deposit Dari {{namaPerusahaan}}', 'Anda menerima sejumlah uang dari {{namaPerusahaan}} sebagai pengembalian deposit kepada Anda/perusahaan Anda dengan detail informasi sebagai berikut:\r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nKode Anda: {{kodePelanggan}}\r\nPerusahaan Anda (jika ada): {{jenisBadanUsahaPelanggan}} {{namaBadanUsahaPelanggan}}\r\nNama Anda: {{namaPelanggan}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: {{nomorRekntPelanggan}}\r\nAtas Nama: {{atasNamaRekntPelanggan}}\r\nLembaga Keuangan: {{namaLkPelanggan}}\r\n\r\nNominal Transfer: Rp {{nominalReknt}}\r\n\r\nTotal Deposit: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2026-03-14 13:33:45', 1, '2026-03-25 15:10:57'),
(27, 'trx_wd_deposit_pelanggan', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena mengeluarkan sejumlah uang untuk transaksi pengembalian deposit ke pelanggan', 'User', 'Penanggung jawab akun kas yang mengelurakan uang untuk transaksi pengembalian deposit ke pelanggan', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL PELANGGAN:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI YANG MENGEMBALIKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGEMBALIKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI PELANGGAN YANG MENERIMA PENGEMBALIAN DEPOSIT:\r\nNomor Rekening: {{nomorRekntPelanggan}}\r\nAtas Nama Rekening: {{atasNamaRekntPelanggan}}\r\nLembaga Keuangan: {{namaLkPelanggan}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Pengembalian Deposit ke Pelanggan', 'Telah terjadi transaksi pengembalian deposit ke pelanggan, dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', 1, '2026-03-25 15:14:17'),
(28, 'trx_wd_deposit_pelanggan', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena mengeluarkan sejumlah uang untuk transaksi pengembalian deposit ke pelanggan', 'User', 'Penanggung jawab rekening non tunai yang mengelurakan uang untuk transaksi pengembalian deposit ke p', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL PELANGGAN:\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nUANG TUNAI YANG MENGEMBALIKAN DEPOSIT:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGEMBALIKAN DEPOSIT:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI PELANGGAN YANG MENERIMA PENGEMBALIAN DEPOSIT:\r\nNomor Rekening: {{nomorRekntPelanggan}}\r\nAtas Nama Rekening: {{atasNamaRekntPelanggan}}\r\nLembaga Keuangan: {{namaLkPelanggan}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Pengembalian Deposit ke Pelanggan', 'Telah terjadi transaksi pengembalian deposit ke pelanggan, dimana rekening non tunai di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Pelanggan: {{kodePelanggan}}\r\nJenis Pelanggan: {{jenisPelanggan}}\r\nJenis Badan Usaha Pelanggan: {{jenisBadanUsahaPelanggan}}\r\nNama Badan Usaha Pelanggan: {{namaBadanUsahaPelanggan}}\r\nNama Pelanggan: {{namaPelanggan}}\r\n\r\nRekening non tunai perusahaan dalam wewenang Anda:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nRekening non tunai tujuan (rekening pelanggan):\r\nNomor Rekening: {{nomorRekntPelanggan}}\r\nAtas Nama: {{atasNamaRekntPelanggan}}\r\nLembaga Keuangan: {{namaLkPelanggan}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', NULL, NULL),
(29, 'trx_kasbon_sdm', 'validasi_sdm', 'Meminta validasi/konfirmasi dari anggota manajemen yang diberi kasbon.', 'User', 'Anggota manajemen yang diberi kasbon', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI ANGGOTA MANAJEMEN YANG MENERIMA KASBON:\r\nNomor Rekening: {{nomorRekntSdm}}\r\nAtas Nama Rekening: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Menerima Kasbon Dari {{namaPerusahaan}}', 'Anda menerima kasbon dari {{namaPerusahaan}} dengan informasi sebagai berikut:\r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nKode Anda: {{kodeSdm}}\r\nNama Anda: {{namaSdm}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: {{nomorRekntSdm}}\r\nAtas Nama: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\n\r\nNominal Transfer: Rp {{nominalReknt}}\r\n\r\nTotal Deposit: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2026-03-14 13:33:45', NULL, NULL),
(30, 'trx_kasbon_sdm', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena mengeluarkan sejumlah uang untuk kasbon anggota manajemen.', 'User', 'Penanggung jawab akun kas yang mengelurakan uang untuk kasbon anggota manajemen.', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI ANGGOTA MANAJEMEN YANG MENERIMA KASBON:\r\nNomor Rekening: {{nomorRekntSdm}}\r\nAtas Nama Rekening: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSdm}}\r\nNama Supplier: {{namaSdm}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', NULL, NULL),
(31, 'trx_kasbon_sdm', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena mengelurakan sejumlah uang untuk kasbon anggota manajemen.', 'User', 'Penanggung jawab rekening non tunai yang mengeluarkan uang untuk kasbon anggota manajemen.', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nREKENING NON TUNAI ANGGOTA MANAJEMEN YANG MENERIMA KASBON:\r\nNomor Rekening: {{nomorRekntSdm}}\r\nAtas Nama Rekening: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Mengelurkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana rekening non tunai yang berada dalam wewenang dan tanggung jawab Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSdm}}\r\nNama Supplier: {{namaSdm}}\r\n\r\nRekening non tunai perusahaan dalam wewenang Anda:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nRekening non tunai tujuan (rekening anggota manajemen):\r\nNomor Rekening: {{nomorRekntSdm}}\r\nAtas Nama: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', NULL, NULL),
(32, 'trx_bayar_kasbon_sdm', 'validasi_sdm', 'Meminta validasi/konfirmasi dari anggota manajemen yang membayar kasbon.', 'User', 'Anggota manajemen yang membayar kasbon', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Anda Membayar Kasbon Kepada {{namaPerusahaan}}', 'Anda telah membayar kasbon dari {{namaPerusahaan}} dengan informasi sebagai berikut:\r\n\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nKode Anda: {{kodeSdm}}\r\nNama Anda: {{namaSdm}}\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: {{namaPjAkunKas}}\r\nNominal Uang Tunai: Rp {{nominalKas}}\r\n\r\nTransaksi ke rekening non tunai perusahaan:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nNominal Transfer: Rp {{nominalReknt}}\r\n\r\nTotal Pembayaran Kasbon: Rp {{totalNominal}}\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:44:49', NULL, NULL),
(33, 'trx_bayar_kasbon_sdm', 'validasi_akun_kas', 'Meminta validasi kepada penanggung jawab akun kas karena menerima sejumlah uang pembayaran kasbon dari anggota manajemen.', 'User', 'Penanggung jawab akun kas yang menerima uang pembayaran kasbon dari anggota manajemen.', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Dari Pembayaran Transaksi Kasbon', 'Telah terjadi transaksi pembayaran kasbon dari anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSdm}}\r\nNama Supplier: {{namaSdm}}\r\n\r\nNama Akun Kas: {{namaAkunKas}}\r\nNominal Kas: Rp {{nominalKas}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 09:49:11', NULL, NULL),
(34, 'trx_bayar_kasbon_sdm', 'validasi_reknt', 'Meminta validasi kepada penanggung jawab rekening non tunai karena menerima sejumlah uang pembayaran kasbon dari anggota manajemen.', 'User', 'Penanggung jawab rekening non tunai yang menerima uang pembayaran kasbon dari anggota manajemen.', 'Meminta Validasi', 'Setelah Input', 'Nama Perusahaan Anda: {{namaPerusahaan}}\r\n\r\nHAL TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\n\r\nHAL ANGGOTA MANAJEMEN:\r\nKode Anggota Manajemen: {{kodeSdm}}\r\nNama Anggota Manajemen: {{namaSdm}}\r\n\r\nUANG TUNAI YANG MENGELUARKAN KASBON:\r\nNama Akun Kas: {{namaAkunKas}}\r\nKode Penanggungjawab Akun Kas: {{kodePjAkunKas}}\r\nNama Penanggungjawab Akun Kas: {{namaPjAkunKas}}\r\nNomor COA Kas: {{nomorCoaAkunKas}}\r\nNama COA Kas: {{namaCoaAkunKas}}\r\nNominal Tunai: {{nominalKas}}\r\n\r\nREKENING NON TUNAI MENGELUARKAN KASBON:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama Rekening: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\nKode Penanggung Jawab Rekening Non Tunai: {{kodePjReknt}}\r\nNama Penanggung Jawab Rekening Non Tunai: {{namaPjReknt}}\r\nNomor COA Rekening Non Tunai: {{nomorCoaReknt}}\r\nNama COA Rekening Non Tunai: {{namaCoaReknt}}\r\nNominal Non Tunai: {{nominalReknt}}\r\n\r\nTotal Nominal (Tunai + Non Tunai): {{totalNominal}}\r\n\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input: {{waktuInput}}', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Pembayaran Transaksi Kasbon', 'Telah terjadi transaksi pembayaran kasbon dari anggota manajemen dimana rekening non tunai yang berada dalam wewenang dan tanggung jawab Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nTotal Nominal: Rp {{totalNominal}}\r\n\r\nKode Supplier: {{kodeSdm}}\r\nNama Supplier: {{namaSdm}}\r\n\r\nRekening non tunai perusahaan dalam wewenang Anda:\r\nNomor Rekening: {{nomorReknt}}\r\nAtas Nama: {{atasNamaReknt}}\r\nLembaga Keuangan: {{namaLk}}\r\n\r\nRekening non tunai tujuan (rekening anggota manajemen):\r\nNomor Rekening: {{nomorRekntSdm}}\r\nAtas Nama: {{atasNamaRekntSdm}}\r\nLembaga Keuangan: {{namaLkSdm}}\r\nNominal Non Tunai: Rp {{nominalReknt}}\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 1, '2025-12-20 10:15:43', NULL, NULL),
(35, 'trx_antar_kas', 'vpj_ak_awal', 'Meminta validasi dari penanggung jawab akun kas pengirim pada transaksi antar kas.', 'User', 'Penanggung jawab akun kas pengirim pada transaksi antar kas.', 'Meminta Validasi', 'Setelah Input', 'HAL NAMA PERUSAHAAN: {{namaPerusahaan}}\r\n\r\nHAL INFORMASI DASAR TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nNominal: {{nominal}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input {{waktuInput}}\r\n\r\nHAL AKUN KAS PENGIRIM:\r\nID Akun Kas: {{idAkunKasPengirim}}\r\nNama Akun Kas: {{namaAkunKasPengirim}}\r\nKode Penanggung Jawab Akun Kas: {{kodePjAkunKasPengirim}}\r\nNama Penanggung Jawab Akun Kas: {{namaPjAkunKasPengirim}}\r\nNomor CoA: {{nomorCoaAkunKasPengirim}}\r\nNama CoA: {{namaCoaAkunKasPengirim}}\r\n\r\nHAL AKUN KAS PENERIMA:\r\nID Akun Kas: {{idAkunKasPenerima}}\r\nNama Akun Kas: {{namaAkunKasPenerima}}\r\nKode Penanggung Jawab Akun Kas: {{kodePjAkunKasPenerima}}\r\nNama Penanggung Jawab Akun Kas: {{namaPjAkunKasPenerima}}\r\nNomor CoA: {{nomorCoaAkunKasPenerima}}\r\nNama CoA: {{namaCoaAkunKasPenerima}}', 'Transaksi Antar Kas Baru', 'Akun kas di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai akun kas pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: {{idTrx}}\r\nWaktu Trx: {{waktuTrx}}\r\nNominal: Rp {{nominal}}\r\n\r\nAKUN KAS PEMBERI (PENGIRIM):\r\nID Akun Kas: {{idAkunKasPengirim}}\r\nNama Akun Kas: {{namaAkunKasPengirim}}\r\nKode Penanggung Jawab: {{kodePjAkunKasPengirim}}\r\nNama Penanggung Jawab: {{namaPjAkunKasPengirim}}\r\nNomor CoA: {{nomorCoaAkunKasPengirim}}\r\nNama CoA: {{namaCoaAkunKasPengirim}}\r\n\r\nAKUN KAS PENERIMA:\r\nID Akun Kas: {{idAkunKasPenerima}}\r\nNama Akun Kas: {{namaAkunKasPenerima}}\r\nKode Penanggung Jawab: {{kodePjAkunKasPenerima}}\r\nNama Penanggung Jawab: {{namaPjAkunKasPenerima}}\r\nNomor CoA: {{nomorCoaAkunKasPenerima}}\r\nNama CoA: {{namaCoaAkunKasPenerima}}\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 1, '2026-03-28 17:35:03', 1, '2026-03-28 17:37:14'),
(36, 'trx_antar_kas', 'vpj_ak_akhir', 'Meminta validasi dari penanggung jawab akun kas penerima pada transaksi antar kas.', 'User', 'Penanggung jawab akun kas penerima pada transaksi antar kas.', 'Meminta Validasi', 'Setelah Input', 'HAL NAMA PERUSAHAAN: {{namaPerusahaan}}\r\n\r\nHAL INFORMASI DASAR TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nNominal: {{nominal}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input {{waktuInput}}\r\n\r\nHAL AKUN KAS PENGIRIM:\r\nID Akun Kas: {{idAkunKasPengirim}}\r\nNama Akun Kas: {{namaAkunKasPengirim}}\r\nKode Penanggung Jawab Akun Kas: {{kodePjAkunKasPengirim}}\r\nNama Penanggung Jawab Akun Kas: {{namaPjAkunKasPengirim}}\r\nNomor CoA: {{nomorCoaAkunKasPengirim}}\r\nNama CoA: {{namaCoaAkunKasPengirim}}\r\n\r\nHAL AKUN KAS PENERIMA:\r\nID Akun Kas: {{idAkunKasPenerima}}\r\nNama Akun Kas: {{namaAkunKasPenerima}}\r\nKode Penanggung Jawab Akun Kas: {{kodePjAkunKasPenerima}}\r\nNama Penanggung Jawab Akun Kas: {{namaPjAkunKasPenerima}}\r\nNomor CoA: {{nomorCoaAkunKasPenerima}}\r\nNama CoA: {{namaCoaAkunKasPenerima}}', 'Transaksi Antar Kas Baru', 'Akun kas di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai akun kas penerima dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: {{idTrx}}\r\nWaktu Trx: {{waktuTrx}}\r\nNominal: Rp {{nominal}}\r\n\r\nAKUN KAS PEMBERI (PENGIRIM):\r\nID Akun Kas: {{idAkunKasPengirim}}\r\nNama Akun Kas: {{namaAkunKasPengirim}}\r\nKode Penanggung Jawab: {{kodePjAkunKasPengirim}}\r\nNama Penanggung Jawab: {{namaPjAkunKasPengirim}}\r\nNomor CoA: {{nomorCoaAkunKasPengirim}}\r\nNama CoA: {{namaCoaAkunKasPengirim}}\r\n\r\nAKUN KAS PENERIMA:\r\nID Akun Kas: {{idAkunKasPenerima}}\r\nNama Akun Kas: {{namaAkunKasPenerima}}\r\nKode Penanggung Jawab: {{kodePjAkunKasPenerima}}\r\nNama Penanggung Jawab: {{namaPjAkunKasPenerima}}\r\nNomor CoA: {{nomorCoaAkunKasPenerima}}\r\nNama CoA: {{namaCoaAkunKasPenerima}}\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 1, '2026-03-28 17:35:03', 1, '2026-03-31 01:13:19'),
(37, 'trx_antar_reknt', 'vpj_reknt_awal', 'Meminta validasi dari penanggung jawab rekening non tunai pengirim pada transaksi antar rekening non tunai.', 'User', 'Penanggung jawab akun kas pengirim pada transaksi antar rekening non tunai.', 'Meminta Validasi', 'Setelah Input', 'HAL NAMA PERUSAHAAN: {{namaPerusahaan}}\r\n\r\nHAL INFORMASI DASAR TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nNominal: {{nominal}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input {{waktuInput}}\r\n\r\nHAL REKENING NON TUNAI PENGIRIM:\r\nID Rekening Non Tunai: {{idRekntPengirim}}\r\nNomor Rekening: {{nomorRekntPengirim}}\r\nAtas Nama Rekening: {{atasNamaRekntPengirim}}\r\nNama Lembaga Keuangan: {{namaLkRekntPengirim}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPengirim}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPengirim}}\r\nNomor CoA: {{nomorCoaRekntPengirim}}\r\nNama CoA: {{namaCoaRektnPengirim}}\r\n\r\nHAL REKENING NON TUNAI PENERIMA:\r\nID Rekening Non Tunai: {{idRekntPenerima}}\r\nNomor Rekening: {{nomorRekntPenerima}}\r\nAtas Nama Rekening: {{atasNamaRekntPenerima}}\r\nNama Lembaga Keuangan: {{namaLkRekntPenerima}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPenerima}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPenerima}}\r\nNomor CoA: {{nomorCoaRekntPenerima}}\r\nNama CoA: {{namaCoaRektnPenerima}}', 'Transaksi Antar Rekening Non Tunai Baru', 'Rekening non tunai di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai rekening non tunai pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: {{idTrx}}\r\nWaktu Trx: {{waktuTrx}}\r\nNominal: Rp {{nominal}}\r\n\r\nREKENING NON TUNAI PEMBERI (PENGIRIM):\r\nID Rekening Non Tunai: {{idRekntPengirim}}\r\nNomor Rekening: {{nomorRekntPengirim}}\r\nAtas Nama Rekening: {{atasNamaRekntPengirim}}\r\nNama Lembaga Keuangan: {{namaLkRekntPengirim}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPengirim}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPengirim}}\r\nNomor CoA: {{nomorCoaRekntPengirim}}\r\nNama CoA: {{namaCoaRektnPengirim}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nID Rekening Non Tunai: {{idRekntPenerima}}\r\nNomor Rekening: {{nomorRekntPenerima}}\r\nAtas Nama Rekening: {{atasNamaRekntPenerima}}\r\nNama Lembaga Keuangan: {{namaLkRekntPenerima}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPenerima}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPenerima}}\r\nNomor CoA: {{nomorCoaRekntPenerima}}\r\nNama CoA: {{namaCoaRektnPenerima}}\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 1, '2026-03-28 17:35:03', 1, '2026-03-31 01:42:29'),
(38, 'trx_antar_reknt', 'vpj_reknt_akhir', 'Meminta validasi dari penanggung jawab rekening non tunai penerim pada transaksi antar rekening non tunai.', 'User', 'Penanggung jawab akun kas penerima pada transaksi antar rekening non tunai.', 'Meminta Validasi', 'Setelah Input', 'HAL NAMA PERUSAHAAN: {{namaPerusahaan}}\r\n\r\nHAL INFORMASI DASAR TRANSAKSI:\r\nID Transaksi: {{idTrx}}\r\nWaktu Transaksi: {{waktuTrx}}\r\nNominal: {{nominal}}\r\nDiinput Oleh: {{diinputOleh}}\r\nWaktu Input {{waktuInput}}\r\n\r\nHAL REKENING NON TUNAI PENGIRIM:\r\nID Rekening Non Tunai: {{idRekntPengirim}}\r\nNomor Rekening: {{nomorRekntPengirim}}\r\nAtas Nama Rekening: {{atasNamaRekntPengirim}}\r\nNama Lembaga Keuangan: {{namaLkRekntPengirim}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPengirim}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPengirim}}\r\nNomor CoA: {{nomorCoaRekntPengirim}}\r\nNama CoA: {{namaCoaRektnPengirim}}\r\n\r\nHAL REKENING NON TUNAI PENERIMA:\r\nID Rekening Non Tunai: {{idRekntPenerima}}\r\nNomor Rekening: {{nomorRekntPenerima}}\r\nAtas Nama Rekening: {{atasNamaRekntPenerima}}\r\nNama Lembaga Keuangan: {{namaLkRekntPenerima}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPenerima}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPenerima}}\r\nNomor CoA: {{nomorCoaRekntPenerima}}\r\nNama CoA: {{namaCoaRektnPenerima}}', 'Transaksi Antar Rekening Non Tunai Baru', 'Rekening non tunai di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai rekening non tunai penerim dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: {{idTrx}}\r\nWaktu Trx: {{waktuTrx}}\r\nNominal: Rp {{nominal}}\r\n\r\nREKENING NON TUNAI PEMBERI (PENGIRIM):\r\nID Rekening Non Tunai: {{idRekntPengirim}}\r\nNomor Rekening: {{nomorRekntPengirim}}\r\nAtas Nama Rekening: {{atasNamaRekntPengirim}}\r\nNama Lembaga Keuangan: {{namaLkRekntPengirim}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPengirim}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPengirim}}\r\nNomor CoA: {{nomorCoaRekntPengirim}}\r\nNama CoA: {{namaCoaRektnPengirim}}\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nID Rekening Non Tunai: {{idRekntPenerima}}\r\nNomor Rekening: {{nomorRekntPenerima}}\r\nAtas Nama Rekening: {{atasNamaRekntPenerima}}\r\nNama Lembaga Keuangan: {{namaLkRekntPenerima}}\r\nKode Penanggung Jawab Rekening: {{kodePjRekntPenerima}}\r\nNama Penanggung Jawab Rekening: {{namaPjRekntPenerima}}\r\nNomor CoA: {{nomorCoaRekntPenerima}}\r\nNama CoA: {{namaCoaRektnPenerima}}\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 1, '2026-03-28 17:35:03', 1, '2026-03-31 01:42:23');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tes`
--

CREATE TABLE `tes` (
  `id` int(10) UNSIGNED NOT NULL,
  `a` int(11) DEFAULT NULL,
  `b` varchar(10) DEFAULT NULL,
  `c` varchar(10) DEFAULT NULL,
  `d` varchar(10) DEFAULT NULL,
  `total_harga` double NOT NULL DEFAULT 0,
  `qty` double NOT NULL DEFAULT 1,
  `harga_satuan` double NOT NULL DEFAULT 0,
  `new_total_harga` double NOT NULL DEFAULT 0,
  `new_total_harga_treatment` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tes`
--

INSERT INTO `tes` (`id`, `a`, `b`, `c`, `d`, `total_harga`, `qty`, `harga_satuan`, `new_total_harga`, `new_total_harga_treatment`) VALUES
(1, 5, 'rr22', NULL, NULL, 123000, 11, 11181.82, 123000.01999999999, 123000);

--
-- Trigger `tes`
--
DELIMITER $$
CREATE TRIGGER `tes_bu` BEFORE UPDATE ON `tes` FOR EACH ROW begin
  if
    (
      (not (new.a <=> old.a)) or
      (not (new.b <=> old.b))
     )
  then
  	if (old.c is null)
    then
      set new.c = 'jalan';
    elseif (old.c is not null) then
      set new.c = null;
    end if;
  end if;

  set new.harga_satuan = round(new.total_harga / new.qty, 2);
  set new.new_total_harga = new.qty * new.harga_satuan;
  set new.new_total_harga_treatment = round(new.qty * new.harga_satuan, 0);
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `to_do`
--

CREATE TABLE `to_do` (
  `id` int(10) UNSIGNED NOT NULL,
  `keterangan` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `to_do`
--

INSERT INTO `to_do` (`id`, `keterangan`) VALUES
(1, 'selesaikan hal template notifikasi di tabel:\n1. akun_kas => done\n2. reknt => done\n3. trx_input_modal');

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_antar_kas`
--

CREATE TABLE `trx_antar_kas` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_ak_awal` int(11) UNSIGNED NOT NULL COMMENT 'id akun kas awal',
  `vpj_ak_awal` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'validasi pj akun kas awal',
  `id_ak_akhir` int(11) UNSIGNED NOT NULL COMMENT 'id akun kas awal',
  `vpj_ak_akhir` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'validasi pj akun kas akhir',
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `nominal` double NOT NULL,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') NOT NULL DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_antar_kas`
--

INSERT INTO `trx_antar_kas` (`id_trx`, `waktu_trx`, `id_ak_awal`, `vpj_ak_awal`, `id_ak_akhir`, `vpj_ak_akhir`, `validasi_trx`, `nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('TAK/29032026/1/00001', '2026-03-29 02:12:41', 2, 1, 1, 1, 1, 10000, '', 'Dokumen', 'trx_antar_kas_TAK-29032026-1-00001.pdf', 1, '2026-03-29 02:12:41', 4, '2026-03-29 16:17:34', NULL, NULL),
('TAK/29032026/1/00002', '2026-03-29 11:12:21', 2, 0, 1, 1, 0, 1230000, 'postman', 'Dokumen', 'trx_antar_kas_TAK-29032026-1-00002.pdf', 1, '2026-03-29 16:12:21', NULL, '2026-03-29 16:15:18', 1, '2026-03-29 11:15:18'),
('TAK/30032026/1/00001', '2026-03-30 16:04:56', 2, 0, 1, 1, 0, 135000, 'Apps', 'Dokumen', 'trx_antar_kas_TAK-30032026-1-00001.pdf', 1, '2026-03-30 21:04:56', NULL, '2026-03-30 21:08:13', 1, '2026-03-30 16:08:13');

--
-- Trigger `trx_antar_kas`
--
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_ai1` AFTER INSERT ON `trx_antar_kas` FOR EACH ROW begin
  declare
    nomorCoaKasAwal,
    nomorCoaKasAkhir Varchar(100);
  declare
    idPjAkunKasAwal,
    idPjAkunKasAkhir BigInt(20) Unsigned;

  select
    nomor_coa,
    id_pj
  into
    nomorCoaKasAwal,
    idPjAkunKasAwal
  from
    akun_kas
  where
    id = new.id_ak_awal;

  select
    nomor_coa,
    id_pj
  into
    nomorCoaKasAkhir,
    idPjAkunKasAkhir
  from
    akun_kas
  where
    id = new.id_ak_akhir;


  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by,
    created_at
  ) values (
    # debet
    new.waktu_trx,
    new.id_trx,
    'User',
    idPjAkunKasAwal,
    9,
    nomorCoaKasAkhir,
    new.nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by,
    new.created_at
  ),
  (
    # kredit
    new.waktu_trx,
    new.id_trx,
    'User',
    idPjAkunKasAwal,
    9,
    nomorCoaKasAwal,
    0,
    new.nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by,
    new.created_at
  );
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_ai2` AFTER INSERT ON `trx_antar_kas` FOR EACH ROW begin
  declare
    kodePjAkunKasAwal,
    kodePjAkunKasAkhir Varchar(18) default '-';
  declare
    bentukPerusahaan Varchar(21) default '-';
  declare
    namaAkunKasAwal,
    namaAkunKasAkhir Varchar(50) default '-';
  declare
    namaPerusahaan,
    nomorCoaAkunKasAwal,
    nomorCoaAkunKasAkhir,
    namaPjAkunKasAwal,
    namaPjAkunKasAkhir,
    namaCreatedBy Varchar(100) default '-';
  declare
    namaCoaAkunKasAwal,
    namaCoaAkunKasAkhir Varchar(200) default '-';
  declare
    idPjAkunKasAwal,
    idPjAkunKasAkhir BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  # ambil info perusahaan
  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  # ambil info akun kas awal
  select
    nama_akun_kas,
    nomor_coa,
    id_pj
  into
    namaAkunKasAwal,
    nomorCoaAkunKasAwal,
    idPjAkunKasAwal
  from
    akun_kas
  where
    id = new.id_ak_awal;
  
  select
    kode_user,
    nama
  into
    kodePjAkunKasAwal,
    namaPjAkunKasAwal
  from
    users
  where
    id = idPjAkunKasAwal;

  set namaCoaAkunKasAwal = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = nomorCoaAkunKasAwal
  );

  # ambil info akun kas akhir
  select
    nama_akun_kas,
    nomor_coa,
    id_pj
  into
    namaAkunKasAkhir,
    nomorCoaAkunKasAkhir,
    idPjAkunKasAkhir
  from
    akun_kas
  where
    id = new.id_ak_akhir;
  
  select
    kode_user,
    nama
  into
    kodePjAkunKasAkhir,
    namaPjAkunKasAkhir
  from
    users
  where
    id = idPjAkunKasAkhir;

  set namaCoaAkunKasAkhir = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = nomorCoaAkunKasAkhir
  );

  # ambil info created by
  set namaCreatedBy = (
    select
      nama
    from
      users
    where
     id = new.created_by
  );

  if (new.vpj_ak_awal = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 35;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{nominal}}', format(new.nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    
    set isiNotif = replace(isiNotif, '{{idAkunKasPengirim}}', new.id_ak_awal);
    set isiNotif = replace(isiNotif, '{{namaAkunKasPengirim}}', namaAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKasPengirim}}', kodePjAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKasPengirim}}', namaPjAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKasPengirim}}', nomorCoaAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKasPengirim}}', namaCoaAkunKasAwal);

    set isiNotif = replace(isiNotif, '{{idAkunKasPenerima}}', new.id_ak_akhir);
    set isiNotif = replace(isiNotif, '{{namaAkunKasPenerima}}', namaAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKasPenerima}}', kodePjAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKasPenerima}}', namaPjAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKasPenerima}}', nomorCoaAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKasPenerima}}', namaCoaAkunKasAkhir);


    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKasAwal,
      'trx_antar_kas',
      'vpj_ak_awal',
      new.created_by
    );
  end if;

  if (new.vpj_ak_akhir = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 36;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{nominal}}', format(new.nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    
    set isiNotif = replace(isiNotif, '{{idAkunKasPengirim}}', new.id_ak_awal);
    set isiNotif = replace(isiNotif, '{{namaAkunKasPengirim}}', namaAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKasPengirim}}', kodePjAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKasPengirim}}', namaPjAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKasPengirim}}', nomorCoaAkunKasAwal);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKasPengirim}}', namaCoaAkunKasAwal);

    set isiNotif = replace(isiNotif, '{{idAkunKasPenerima}}', new.id_ak_akhir);
    set isiNotif = replace(isiNotif, '{{namaAkunKasPenerima}}', namaAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKasPenerima}}', kodePjAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKasPenerima}}', namaPjAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKasPenerima}}', nomorCoaAkunKasAkhir);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKasPenerima}}', namaCoaAkunKasAkhir);


    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKasAkhir,
      'trx_antar_kas',
      'vpj_ak_akhir',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_au1` AFTER UPDATE ON `trx_antar_kas` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bd1` BEFORE DELETE ON `trx_antar_kas` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bi1` BEFORE INSERT ON `trx_antar_kas` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      12,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bi2` BEFORE INSERT ON `trx_antar_kas` FOR EACH ROW begin
  declare pesanError Text;

  if (new.id_ak_awal = 0) or (new.id_ak_awal is null)
  then
    set pesanError = concat(
      'Akun kas pengirim belum ditentukan.\n',
      'Transaksi antar kas tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.id_ak_akhir = 0) or (new.id_ak_akhir is null)
  then
    set pesanError = concat(
      'Akun kas penerima belum ditentukan.\n',
      'Transaksi antar kas tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.nominal = 0) or (new.nominal is null)
  then
    set pesanError = concat(
      'Nominal belum ditentukan.\n',
      'Transaksi antar kas tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bi3` BEFORE INSERT ON `trx_antar_kas` FOR EACH ROW begin
  declare
    idPjAkunKasAwal,
    idPjAkunKasAkhir BigInt(20) Unsigned;
  declare
    jumlahTrxPendingAkunKasAwal,
    jumlahTrxPendingAkunKasAkhir Integer(11) Unsigned;
  declare
    nomorCoaAkunKasAwal,
    nomorCoaAkunKasAkhir Varchar(100);
  declare
    sumTrxDebetAkunKasAwal,
    sumTrxKreditAkunKasAwal,
    saldoKasAwal Double;
  declare
    validasiPjAkunKasAwal,
    akunKasAwalAktif,
    validasiPjAkunKasAkhir,
    akunKasAkhirAktif Boolean default 0;
  declare pesanError Text;
    
  select
    nomor_coa,
    id_pj,
    validasi_pj,
    aktif
  into
    nomorCoaAkunKasAwal,
    idPjAkunKasAwal,
    validasiPjAkunKasAwal,
    akunKasAwalAktif
  from
    akun_kas
  where
    id = new.id_ak_awal;

  select
    nomor_coa,
    id_pj,
    validasi_pj,
    aktif
  into
    nomorCoaAkunKasAkhir,
    idPjAkunKasAkhir,
    validasiPjAkunKasAkhir,
    akunKasAkhirAktif
  from
    akun_kas
  where
    id = new.id_ak_akhir;

  # cek saldo akun kas awal untuk dicompare dengan nominal
  select
    coalesce(sum(trx_debet), 0),
    coalesce(sum(trx_kredit), 0)
  into
    sumTrxDebetAkunKasAwal,
    sumTrxKreditAkunKasAwal
  from
    trx_jurnal_umum
  where
    nomor_coa = nomorCoaAkunKasAwal
  and
    validasi_trx = 1
  and
    deleted_at is null;

  set saldoKasAwal = sumTrxDebetAkunKasAwal - sumTrxKreditAkunKasAwal;

  # cek transaksi pending terkait akun kas awal
  set jumlahTrxPendingAkunKasAwal = (
    select
      count(id_trx)
    from
      trx_jurnal_umum
    where
      nomor_coa = nomorCoaAkunKasAwal
    and
      validasi_trx = 0
    and
      deleted_at is null
  );

  # cek transaksi pending terkait akun kas akhir
  set jumlahTrxPendingAkunKasAkhir = (
    select
      count(id_trx)
    from
      trx_jurnal_umum
    where
      nomor_coa = nomorCoaAkunKasAkhir
    and
      validasi_trx = 0
    and
      deleted_at is null
  );

  if (validasiPjAkunKasAwal != 1)
  then
    set pesanError = concat(
      'Akun kas pemberi tidak valid.\n',
      'Silahkan cek status akun kas pemberi yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (akunKasAwalAktif != 1)
  then
    set pesanError = concat(
      'Akun kas pemberi tidak aktif.\n',
      'Silahkan cek status akun kas pemberi yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (validasiPjAkunKasAkhir != 1)
  then
    set pesanError = concat(
      'Akun kas penerima tidak valid.\n',
      'Silahkan cek status akun kas penerima yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (akunKasAkhirAktif != 1)
  then
    set pesanError = concat(
      'Akun kas penerima tidak aktif.\n',
      'Silahkan cek status akun kas penerima yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (jumlahTrxPendingAkunKasAwal > 0)
  then
    set pesanError = concat(
      'Masih ada transaksi terkait akun kas awal (pengirim) yang mengambang (pending), belum divalidasi.\n',
      'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
      'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (jumlahTrxPendingAkunKasAkhir > 0)
  then
    set pesanError = concat(
      'Masih ada transaksi terkait akun kas akhir (penerima) yang mengambang (pending), belum divalidasi.\n',
      'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
      'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.nominal > saldoKasAwal)
  then
    set pesanError = concat(
      'Saldo kas awal (pengirim) adalah Rp ', format(saldoKasAwal, 2, 'id_ID'), '\n',
      'Sedangkan nilai yang akan dipindahkan adalah Rp', format(new.nominal, 2, 'id_ID'), '\n',
      'Artinya jika transaksi ini dilanjutkan akan mengakibatkan saldo kas awal menjadi minus.\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  else
    if (new.created_by = idPjAkunKasAwal)
    then
      set new.vpj_ak_awal = 1;
    elseif (new.created_by = idPjAkunKasAkhir)
    then
      set new.vpj_ak_akhir = 1;
    else
      set new.vpj_ak_awal = 0;
      set new.vpj_ak_akhir = 0;
    end if;

    if (new.vpj_ak_awal = 1) and (new.vpj_ak_akhir = 1)
    then
      set new.validasi_trx = 1;
    else
      set new.validasi_trx = 0;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bu1` BEFORE UPDATE ON `trx_antar_kas` FOR EACH ROW begin
  declare pesanError Text;

  if
    (
      (new.id_ak_awal != old.id_ak_awal) or
      (new.id_ak_akhir != old.id_ak_akhir) or
      (new.nominal != old.nominal)
    )
  then
    if (new.id_ak_awal = 0) or (new.id_ak_awal is null)
    then
      set pesanError = concat(
        'Akun kas pengirim belum ditentukan.\n',
        'Transaksi antar kas tidak bisa diubah.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.id_ak_akhir = 0) or (new.id_ak_akhir is null)
    then
      set pesanError = concat(
        'Akun kas penerima belum ditentukan.\n',
        'Transaksi antar kas tidak bisa diubah.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.nominal = 0) or (new.nominal is null)
    then
      set pesanError = concat(
        'Nominal belum ditentukan.\n',
        'Transaksi antar kas tidak bisa diubah.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bu2` BEFORE UPDATE ON `trx_antar_kas` FOR EACH ROW begin
  declare
    idPjAkunKasAwal,
    idPjAkunKasAkhir BigInt(20) Unsigned;
  declare
    jumlahTrxPendingAkunKasAwal,
    jumlahTrxPendingAkunKasAkhir Integer(11) Unsigned;
  declare
    nomorCoaAkunKasAwal,
    nomorCoaAkunKasAkhir Varchar(100);
  declare
    sumTrxDebetAkunKasAwal,
    sumTrxKreditAkunKasAkhir,
    saldoKasAwal Double;
  declare
    validasiPjAkunKasAwal,
    akunKasAwalAktif,
    validasiPjAkunKasAkhir,
    akunKasAkhirAktif Boolean default 0;
  declare pesanError Text;
  
  if
    (
      (new.id_ak_awal != old.id_ak_awal) or
      (new.id_ak_akhir != old.id_ak_akhir) or
      (new.nominal != old.nominal)
    )
  then
    select
      nomor_coa,
      id_pj,
      validasi_pj,
      aktif
    into
      nomorCoaAkunKasAwal,
      idPjAkunKasAwal,
      validasiPjAkunKasAwal,
      akunKasAwalAktif
    from
      akun_kas
    where
      id = new.id_ak_awal;

    select
      nomor_coa,
      id_pj,
      validasi_pj,
      aktif
    into
      nomorCoaAkunKasAkhir,
      idPjAkunKasAkhir,
      validasiPjAkunKasAkhir,
      akunKasAkhirAktif
    from
      akun_kas
    where
      id = new.id_ak_akhir;

    # cek saldo akun kas awal untuk dicompare dengan nominal
    select
      coalesce(sum(trx_debet), 0),
      coalesce(sum(trx_kredit), 0)
    into
      sumTrxDebetAkunKasAwal,
      sumTrxKreditAkunKasAkhir
    from
      trx_jurnal_umum
    where
      nomor_coa = nomorCoaAkunKasAwal
    and
      validasi_trx = 1
    and
      deleted_at is null;

    set saldoKasAwal = sumTrxDebetAkunKasAwal - sumTrxKreditAkunKasAkhir;

    # cek transaksi pending terkait akun kas awal
    set jumlahTrxPendingAkunKasAwal = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaAkunKasAwal
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    # cek transaksi pending terkait akun kas akhir
    set jumlahTrxPendingAkunKasAkhir = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaAkunKasAkhir
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (validasiPjAkunKasAwal != 1)
    then
      set pesanError = concat(
        'Akun kas pemberi tidak valid.\n',
        'Silahkan cek status akun kas pemberi yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (akunKasAwalAktif != 1)
    then
      set pesanError = concat(
        'Akun kas pemberi tidak aktif.\n',
        'Silahkan cek status akun kas pemberi yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (validasiPjAkunKasAkhir != 1)
    then
      set pesanError = concat(
        'Akun kas penerima tidak valid.\n',
        'Silahkan cek status akun kas penerima yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (akunKasAkhirAktif != 1)
    then
      set pesanError = concat(
        'Akun kas penerima tidak aktif.\n',
        'Silahkan cek status akun kas penerima yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPendingAkunKasAwal > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi terkait akun kas awal (pengirim) yang mengambang (pending), belum divalidasi.\n',
        'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
        'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPendingAkunKasAkhir > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi terkait akun kas akhir (penerima) yang mengambang (pending), belum divalidasi.\n',
        'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
        'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.nominal > saldoKasAwal)
    then
      set pesanError = concat(
        'Saldo kas awal (pengirim) adalah Rp ', format(saldoKasAwal, 2, 'id_ID'), '\n',
        'Sedangkan nilai yang akan dipindahkan adalah Rp', format(new.nominal, 2, 'id_ID'), '\n',
        'Artinya jika transaksi ini dilanjutkan akan mengakibatkan saldo kas awal menjadi minus.\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if (new.updated_by = idPjAkunKasAwal)
      then
        set new.vpj_ak_awal = 1;
      elseif (new.updated_by = idPjAkunKasAkhir)
      then
        set new.vpj_ak_akhir = 1;
      else
        set new.vpj_ak_awal = 0;
        set new.vpj_ak_akhir = 0;
      end if;

      if (new.vpj_ak_awal = 1) and (new.vpj_ak_akhir = 1)
      then
        set new.validasi_trx = 1;
      else
        set new.validasi_trx = 0;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_kas_bu3` BEFORE UPDATE ON `trx_antar_kas` FOR EACH ROW begin
  declare
    pesanError Text;

  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah divalidasi tidak dapat diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  else
    if (new.vpj_ak_awal = 1) and (new.vpj_ak_akhir = 1)
    then
      set new.validasi_trx = 1;
    else
      set new.validasi_trx = 0;
    end if;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_antar_reknt`
--

CREATE TABLE `trx_antar_reknt` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_reknt_awal` int(11) UNSIGNED NOT NULL COMMENT 'id rekening non tunai awal',
  `vpj_reknt_awal` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'validasi pj rekening non tunai awal',
  `id_reknt_akhir` int(11) UNSIGNED NOT NULL COMMENT 'id rekening non tunai awal',
  `vpj_reknt_akhir` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'validasi pj rekening non tunai akhir',
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `nominal` double NOT NULL,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') NOT NULL DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_antar_reknt`
--

INSERT INTO `trx_antar_reknt` (`id_trx`, `waktu_trx`, `id_reknt_awal`, `vpj_reknt_awal`, `id_reknt_akhir`, `vpj_reknt_akhir`, `validasi_trx`, `nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('TAR/31032026/1/00001', '2026-03-31 11:17:57', 1, 0, 2, 1, 0, 17000, 'postman', 'Dokumen', 'trx_antar_reknt_TAR-31032026-1-00001.pdf', 1, '2026-03-31 16:17:57', NULL, NULL, NULL, NULL);

--
-- Trigger `trx_antar_reknt`
--
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_ai1` AFTER INSERT ON `trx_antar_reknt` FOR EACH ROW begin
  declare
    nomorCoaRekntAwal,
    nomorCoaRekntAkhir Varchar(100);
  declare
    idPjRekntAwal,
    idPjRekntAkhir BigInt(20) Unsigned;

  select
    nomor_coa,
    id_pj
  into
    nomorCoaRekntAwal,
    idPjRekntAwal
  from
    reknt
  where
    id = new.id_reknt_awal;

  select
    nomor_coa,
    id_pj
  into
    nomorCoaRekntAkhir,
    idPjRekntAkhir
  from
    reknt
  where
    id = new.id_reknt_akhir;


  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by,
    created_at
  ) values (
    # debet
    new.waktu_trx,
    new.id_trx,
    'User',
    idPjRekntAwal,
    10,
    nomorCoaRekntAkhir,
    new.nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by,
    new.created_at
  ),
  (
    # kredit
    new.waktu_trx,
    new.id_trx,
    'User',
    idPjRekntAwal,
    10,
    nomorCoaRekntAwal,
    0,
    new.nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by,
    new.created_at
  );
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_ai2` AFTER INSERT ON `trx_antar_reknt` FOR EACH ROW begin
  declare
    kodePjRekntAwal,
    kodePjRekntAkhir Varchar(18) default '-';
  declare
    bentukPerusahaan Varchar(21) default '-';
  declare
    nomorRekntAwal,
    nomorRekntAkhir Varchar(50) default '-';
  declare
    namaPerusahaan,
    atasNamaRekntAwal,
    atasNamaRekntAkhir,
    namaLkRekntAwal,
    namaLkRekntAkhir,
    nomorCoaRekntAwal,
    nomorCoaRekntAkhir,
    namaPjRekntAwal,
    namaPjRekntAkhir,
    namaCreatedBy Varchar(100) default '-';
  declare
    namaCoaRekntAwal,
    namaCoaRekntAkhir Varchar(200) default '-';
  declare
    idPjRekntAwal,
    idPjRekntAkhir BigInt(20) Unsigned;
  declare
    idLkRekntAwal,
    idLkRekntAkhir Integer(11) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  # ambil info perusahaan
  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  # ambil info akun kas awal
  select
    nomor_rekening,
    atas_nama,
    nomor_coa,
    id_lk,
    id_pj
  into
    nomorRekntAwal,
    atasNamaRekntAwal,
    nomorCoaRekntAwal,
    idLkRekntAwal,
    idPjRekntAwal
  from
    reknt
  where
    id = new.id_reknt_awal;
  
  set namaLkRekntAwal = (
    select
      nama
    from
      lembaga_keuangan
    where
      id = idLkRekntAwal
  );

  select
    kode_user,
    nama
  into
    kodePjRekntAwal,
    namaPjRekntAwal
  from
    users
  where
    id = idPjRekntAwal;

  set namaCoaRekntAwal = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = nomorCoaRekntAwal
  );

  # ambil info akun kas akhir
  select
    nomor_rekening,
    atas_nama,
    nomor_coa,
    id_lk,
    id_pj
  into
    nomorRekntAkhir,
    atasNamaRekntAkhir,
    nomorCoaRekntAkhir,
    idLkRekntAkhir,
    idPjRekntAkhir
  from
    reknt
  where
    id = new.id_reknt_akhir;

  set namaLkRekntAkhir = (
    select
      nama
    from
      lembaga_keuangan
    where
      id = idLkRekntAkhir
  );
  
  select
    kode_user,
    nama
  into
    kodePjRekntAkhir,
    namaPjRekntAkhir
  from
    users
  where
    id = idPjRekntAkhir;

  set namaCoaRekntAkhir = (
    select
      nama_coa
    from
      coa
    where
      nomor_coa = nomorCoaRekntAkhir
  );

  # ambil info created by
  set namaCreatedBy = (
    select
      nama
    from
      users
    where
     id = new.created_by
  );

  if (new.vpj_reknt_awal = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 37;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{nominal}}', format(new.nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    
    set isiNotif = replace(isiNotif, '{{idRekntPengirim}}', new.id_reknt_awal);
    set isiNotif = replace(isiNotif, '{{nomorRekntPengirim}}', nomorRekntAwal);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPengirim}}', atasNamaRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaLkRekntPengirim}}', namaLkRekntAwal);
    set isiNotif = replace(isiNotif, '{{kodePjRekntPengirim}}', kodePjRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaPjRekntPengirim}}', namaPjRekntAwal);
    set isiNotif = replace(isiNotif, '{{nomorCoaRekntPengirim}}', nomorCoaRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaCoaRektnPengirim}}', namaCoaRekntAwal);

    set isiNotif = replace(isiNotif, '{{idRekntPenerima}}', new.id_reknt_akhir);
    set isiNotif = replace(isiNotif, '{{nomorRekntPenerima}}', nomorRekntAkhir);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPenerima}}', atasNamaRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaLkRekntPenerima}}', namaLkRekntAkhir);
    set isiNotif = replace(isiNotif, '{{kodePjRekntPenerima}}', kodePjRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaPjRekntPenerima}}', namaPjRekntAkhir);
    set isiNotif = replace(isiNotif, '{{nomorCoaRekntPenerima}}', nomorCoaRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaCoaRektnPenerima}}', namaCoaRekntAkhir);


    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjRekntAwal,
      'trx_antar_reknt',
      'vpj_reknt_awal',
      new.created_by
    );
  end if;

  if (new.vpj_reknt_akhir = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 38;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{nominal}}', format(new.nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));
    
    set isiNotif = replace(isiNotif, '{{idRekntPengirim}}', new.id_reknt_awal);
    set isiNotif = replace(isiNotif, '{{nomorRekntPengirim}}', nomorRekntAwal);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPengirim}}', atasNamaRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaLkRekntPengirim}}', namaLkRekntAwal);
    set isiNotif = replace(isiNotif, '{{kodePjRekntPengirim}}', kodePjRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaPjRekntPengirim}}', namaPjRekntAwal);
    set isiNotif = replace(isiNotif, '{{nomorCoaRekntPengirim}}', nomorCoaRekntAwal);
    set isiNotif = replace(isiNotif, '{{namaCoaRektnPengirim}}', namaCoaRekntAwal);

    set isiNotif = replace(isiNotif, '{{idRekntPenerima}}', new.id_reknt_akhir);
    set isiNotif = replace(isiNotif, '{{nomorRekntPenerima}}', nomorRekntAkhir);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPenerima}}', atasNamaRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaLkRekntPenerima}}', namaLkRekntAkhir);
    set isiNotif = replace(isiNotif, '{{kodePjRekntPenerima}}', kodePjRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaPjRekntPenerima}}', namaPjRekntAkhir);
    set isiNotif = replace(isiNotif, '{{nomorCoaRekntPenerima}}', nomorCoaRekntAkhir);
    set isiNotif = replace(isiNotif, '{{namaCoaRektnPenerima}}', namaCoaRekntAkhir);


    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjRekntAkhir,
      'trx_antar_reknt',
      'vpj_reknt_akhir',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_au1` AFTER UPDATE ON `trx_antar_reknt` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bd1` BEFORE DELETE ON `trx_antar_reknt` FOR EACH ROW begin
  declare pesanError Text;

  /*if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;*/
  
  delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bi1` BEFORE INSERT ON `trx_antar_reknt` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      13,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bi2` BEFORE INSERT ON `trx_antar_reknt` FOR EACH ROW begin
  declare pesanError Text;

  if (new.id_reknt_awal = 0) or (new.id_reknt_awal is null)
  then
    set pesanError = concat(
      'Rekening non tunai pengirim belum ditentukan.\n',
      'Transaksi antar rekening non tunai tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.id_reknt_akhir = 0) or (new.id_reknt_akhir is null)
  then
    set pesanError = concat(
      'Rekening non tunai penerima belum ditentukan.\n',
      'Transaksi antar rekening non tunai tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.nominal = 0) or (new.nominal is null)
  then
    set pesanError = concat(
      'Nominal belum ditentukan.\n',
      'Transaksi antar rekening non tunai tidak bisa diinput.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bi3` BEFORE INSERT ON `trx_antar_reknt` FOR EACH ROW begin
  declare
    idPjRekntAwal,
    idPjRekntAkhir BigInt(20) Unsigned;
  declare
    jumlahTrxPendingRekntAwal,
    jumlahTrxPendingRekntAkhir Integer(11) Unsigned;
  declare
    namaCoaRekntAwal,
    namaCoaRekntAkhir Varchar(100);
  declare
    sumTrxDebetRekntAwal,
    sumTrxKreditRekntAwal,
    saldoRekntAwal Double;
  declare
    validasiPjRekntAwal,
    rekntAwalAktif,
    validasiPjRekntAkhir,
    rekntAkhirAktif Boolean default 0;
  declare pesanError Text;
    
  select
    nomor_coa,
    id_pj,
    validasi_pj,
    aktif
  into
    namaCoaRekntAwal,
    idPjRekntAwal,
    validasiPjRekntAwal,
    rekntAwalAktif
  from
    reknt
  where
    id = new.id_reknt_awal;

  select
    nomor_coa,
    id_pj,
    validasi_pj,
    aktif
  into
    namaCoaRekntAkhir,
    idPjRekntAkhir,
    validasiPjRekntAkhir,
    rekntAkhirAktif
  from
    reknt
  where
    id = new.id_reknt_akhir;

  # cek saldo akun kas awal untuk dicompare dengan nominal
  select
    coalesce(sum(trx_debet), 0),
    coalesce(sum(trx_kredit), 0)
  into
    sumTrxDebetRekntAwal,
    sumTrxKreditRekntAwal
  from
    trx_jurnal_umum
  where
    nomor_coa = namaCoaRekntAwal
  and
    validasi_trx = 1
  and
    deleted_at is null;

  set saldoRekntAwal = sumTrxDebetRekntAwal - sumTrxKreditRekntAwal;

  # cek transaksi pending terkait reknt awal
  set jumlahTrxPendingRekntAwal = (
    select
      count(id_trx)
    from
      trx_jurnal_umum
    where
      nomor_coa = namaCoaRekntAwal
    and
      validasi_trx = 0
    and
      deleted_at is null
  );

  # cek transaksi pending terkait akun kas akhir
  set jumlahTrxPendingRekntAkhir = (
    select
      count(id_trx)
    from
      trx_jurnal_umum
    where
      nomor_coa = namaCoaRekntAkhir
    and
      validasi_trx = 0
    and
      deleted_at is null
  );

  if (validasiPjRekntAwal != 1)
  then
    set pesanError = concat(
      'Rekening non tunai pemberi tidak valid.\n',
      'Silahkan cek status rekening non tunai pemberi yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (rekntAwalAktif != 1)
  then
    set pesanError = concat(
      'Rekening non tunai pemberi tidak aktif.\n',
      'Silahkan cek status rekening non tunai pemberi yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (validasiPjRekntAkhir != 1)
  then
    set pesanError = concat(
      'Rekening non tunai penerima tidak valid.\n',
      'Silahkan cek status rekening non tunai penerima yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (rekntAkhirAktif != 1)
  then
    set pesanError = concat(
      'Rekening non tunai penerima tidak aktif.\n',
      'Silahkan cek status rekening non tunai penerima yang digunakan dalam transaksi ini.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (jumlahTrxPendingRekntAwal > 0)
  then
    set pesanError = concat(
      'Masih ada transaksi terkait rekening non tunai awal (pengirim) yang mengambang (pending), belum divalidasi.\n',
      'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
      'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (jumlahTrxPendingRekntAkhir > 0)
  then
    set pesanError = concat(
      'Masih ada transaksi terkait rekening non tunai akhir (penerima) yang mengambang (pending), belum divalidasi.\n',
      'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
      'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (new.nominal > saldoRekntAwal)
  then
    set pesanError = concat(
      'Saldo rekening non tunai awal (pengirim) adalah Rp ', format(saldoRekntAwal, 2, 'id_ID'), '\n',
      'Sedangkan nilai yang akan dipindahkan adalah Rp', format(new.nominal, 2, 'id_ID'), '\n',
      'Artinya jika transaksi ini dilanjutkan akan mengakibatkan saldo kas awal menjadi minus.\n',
      'Transaksi tidak dapat dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  else
    if (new.created_by = idPjRekntAwal)
    then
      set new.vpj_reknt_awal = 1;
    elseif (new.created_by = idPjRekntAkhir)
    then
      set new.vpj_reknt_akhir = 1;
    else
      set new.vpj_reknt_awal = 0;
      set new.vpj_reknt_akhir = 0;
    end if;

    if (new.vpj_reknt_awal = 1) and (new.vpj_reknt_akhir = 1)
    then
      set new.validasi_trx = 1;
    else
      set new.validasi_trx = 0;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bu1` BEFORE UPDATE ON `trx_antar_reknt` FOR EACH ROW begin
  declare pesanError Text;

  if
    (
      (new.id_reknt_awal != old.id_reknt_awal) or
      (new.id_reknt_akhir != old.id_reknt_akhir) or
      (new.nominal != old.nominal)
    )
  then
    if (new.id_reknt_awal = 0) or (new.id_reknt_awal is null)
    then
      set pesanError = concat(
        'Rekening non tunai pengirim belum ditentukan.\n',
        'Transaksi antar rekening non tunai tidak bisa diinput.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.id_reknt_akhir = 0) or (new.id_reknt_akhir is null)
    then
      set pesanError = concat(
        'Rekening non tunai penerima belum ditentukan.\n',
        'Transaksi antar rekening non tunai tidak bisa diinput.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.nominal = 0) or (new.nominal is null)
    then
      set pesanError = concat(
        'Nominal belum ditentukan.\n',
        'Transaksi antar rekening non tunai tidak bisa diinput.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bu2` BEFORE UPDATE ON `trx_antar_reknt` FOR EACH ROW begin
  declare
    idPjRekntAwal,
    idPjRekntAkhir BigInt(20) Unsigned;
  declare
    jumlahTrxPendingRekntAwal,
    jumlahTrxPendingRekntAkhir Integer(11) Unsigned;
  declare
    namaCoaRekntAwal,
    namaCoaRekntAkhir Varchar(100);
  declare
    sumTrxDebetRekntAwal,
    sumTrxKreditRekntAwal,
    saldoRekntAwal Double;
  declare
    validasiPjRekntAwal,
    rekntAwalAktif,
    validasiPjRekntAkhir,
    rekntAkhirAktif Boolean default 0;
  declare pesanError Text;
    
  if
    (
      (new.id_reknt_awal != old.id_reknt_awal) or
      (new.id_reknt_akhir != old.id_reknt_akhir) or
      (new.nominal != old.nominal)
    )
  then
    select
      nomor_coa,
      id_pj,
      validasi_pj,
      aktif
    into
      namaCoaRekntAwal,
      idPjRekntAwal,
      validasiPjRekntAwal,
      rekntAwalAktif
    from
      reknt
    where
      id = new.id_reknt_awal;

    select
      nomor_coa,
      id_pj,
      validasi_pj,
      aktif
    into
      namaCoaRekntAkhir,
      idPjRekntAkhir,
      validasiPjRekntAkhir,
      rekntAkhirAktif
    from
      reknt
    where
      id = new.id_reknt_akhir;

    # cek saldo akun kas awal untuk dicompare dengan nominal
    select
      coalesce(sum(trx_debet), 0),
      coalesce(sum(trx_kredit), 0)
    into
      sumTrxDebetRekntAwal,
      sumTrxKreditRekntAwal
    from
      trx_jurnal_umum
    where
      nomor_coa = namaCoaRekntAwal
    and
      validasi_trx = 1
    and
      deleted_at is null;

    set saldoRekntAwal = sumTrxDebetRekntAwal - sumTrxKreditRekntAwal;

    # cek transaksi pending terkait reknt awal
    set jumlahTrxPendingRekntAwal = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = namaCoaRekntAwal
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    # cek transaksi pending terkait akun kas akhir
    set jumlahTrxPendingRekntAkhir = (
      select
        count(id_trx)
      from
        trx_jurnal_umum
      where
        nomor_coa = namaCoaRekntAkhir
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (validasiPjRekntAwal != 1)
    then
      set pesanError = concat(
        'Rekening non tunai pemberi tidak valid.\n',
        'Silahkan cek status rekening non tunai pemberi yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (rekntAwalAktif != 1)
    then
      set pesanError = concat(
        'Rekening non tunai pemberi tidak aktif.\n',
        'Silahkan cek status rekening non tunai pemberi yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (validasiPjRekntAkhir != 1)
    then
      set pesanError = concat(
        'Rekening non tunai penerima tidak valid.\n',
        'Silahkan cek status rekening non tunai penerima yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (rekntAkhirAktif != 1)
    then
      set pesanError = concat(
        'Rekening non tunai penerima tidak aktif.\n',
        'Silahkan cek status rekening non tunai penerima yang digunakan dalam transaksi ini.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPendingRekntAwal > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi terkait rekening non tunai awal (pengirim) yang mengambang (pending), belum divalidasi.\n',
        'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
        'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPendingRekntAkhir > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi terkait rekening non tunai akhir (penerima) yang mengambang (pending), belum divalidasi.\n',
        'Jika transaksi dilanjutkan akan mengakibatkan perhitungan sistem tidak akurat.\n',
        'Silahkan divalidasi terlebih dahulu transaksi yang masih mengambang (pending).\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (new.nominal > saldoRekntAwal)
    then
      set pesanError = concat(
        'Saldo rekening non tunai awal (pengirim) adalah Rp ', format(saldoRekntAwal, 2, 'id_ID'), '\n',
        'Sedangkan nilai yang akan dipindahkan adalah Rp', format(new.nominal, 2, 'id_ID'), '\n',
        'Artinya jika transaksi ini dilanjutkan akan mengakibatkan saldo kas awal menjadi minus.\n',
        'Transaksi tidak dapat dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if (new.updated_by = idPjRekntAwal)
      then
        set new.vpj_reknt_awal = 1;
      elseif (new.updated_by = idPjRekntAkhir)
      then
        set new.vpj_reknt_akhir = 1;
      else
        set new.vpj_reknt_awal = 0;
        set new.vpj_reknt_akhir = 0;
      end if;

      if (new.vpj_reknt_awal = 1) and (new.vpj_reknt_akhir = 1)
      then
        set new.validasi_trx = 1;
      else
        set new.validasi_trx = 0;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_antar_reknt_bu3` BEFORE UPDATE ON `trx_antar_reknt` FOR EACH ROW begin
  declare
    pesanError Text;

  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah divalidasi tidak dapat diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  else
    if (new.vpj_reknt_awal = 1) and (new.vpj_reknt_akhir = 1)
    then
      set new.validasi_trx = 1;
    else
      set new.validasi_trx = 0;
    end if;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_bayar_kasbon_sdm`
--

CREATE TABLE `trx_bayar_kasbon_sdm` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_sdm` bigint(20) UNSIGNED NOT NULL,
  `validasi_sdm` tinyint(1) NOT NULL DEFAULT 0,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_bayar_kasbon_sdm`
--

INSERT INTO `trx_bayar_kasbon_sdm` (`id_trx`, `waktu_trx`, `id_sdm`, `validasi_sdm`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('BKBM/28032026/1/00001', '2026-03-28 17:29:19', 5, 1, 2, 90000, 1, NULL, 0, 0, 90000, 'postman', 'Dokumen', 'trx_bayar_kasbon_sdm_BKBM-28032026-1-00001.pdf', 1, 1, '2026-03-28 23:29:19', 4, '2026-03-28 23:30:43', NULL, NULL);

--
-- Trigger `trx_bayar_kasbon_sdm`
--
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_ai1` AFTER INSERT ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaKasbonSdm Varchar(100);
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjAkunKas,
      8,
      nomorCoaKas,
      new.nominal_kas,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaReknt,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      8,
      nomorCoaReknt,
      new.nominal_reknt,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  set nomorCoaKasbonSdm = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 7
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_sdm,
    8,
    nomorCoaKasbonSdm,
    0,
    new.total_nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_ai2` AFTER INSERT ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    kodeSdm,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    jenisSdm Varchar(11) default '-';
  declare
    bentukPerusahaan Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaSdm,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    namaLk Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    nama
  into
    kodeSdm,
    namaSdm
  from
    users
  where
    id = new.id_sdm;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;
  end if;

  if (new.validasi_sdm = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 32;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_sdm,
      'trx_bayar_kasbon_sdm',
      'validasi_sdm',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 33;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_bayar_kasbon_sdm',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 34;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_bayar_kasbon_sdm',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_au1` AFTER UPDATE ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bd1` BEFORE DELETE ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;

  /*if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;*/

  delete from
    trx_jurnal_umum
  where
    sumber_id_trx = old.id_trx;

  delete from
    trx_notifikasi
  where
    sumber_id_trx = old.id_trx;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bi1` BEFORE INSERT ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      11,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bi2` BEFORE INSERT ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    jumlahTrxKasbonPending,
    jumlahTrxBayarKasbonPending Integer(11) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaKasbonSdm,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSdmAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetKasbonSdm,
    sumTrxKreditKasbonSdm,
    sumSaldoKasbonSdm Double;
  declare pesanError Text;

  select
    peran
  into
    peranUser
  from
    users
  where
    id = new.id_sdm;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekSdmAtauBukan != 'Manajemen')
  then
    set pesanError = concat(
      'User yang Anda input bukan anggota manajemen, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekSdmAtauBukan = 'Manajemen')
  then
    # cek apakah ada transaksi pending?, jika ada gagalkan input
    set jumlahTrxKasbonPending = (
      select
        count(id_trx)
      from
        trx_kasbon_sdm
      where
        id_sdm = new.id_sdm
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    set jumlahTrxBayarKasbonPending = (
      select
        count(id_trx)
      from
        trx_bayar_kasbon_sdm
      where
        id_sdm = new.id_sdm
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (jumlahTrxKasbonPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi kasbon mengambang yang belum ditentukan valid atau tidaknya terkait anggota manajemen ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxBayarKasbonPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi bayar kasbon mengambang yang belum ditentukan valid atau tidaknya terkait anggota manajemen ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      # cek saldo kasbon sdm ini
      set nomorCoaKasbonSdm = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 7
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetKasbonSdm,
        sumTrxKreditKasbonSdm
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaKasbonSdm
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoKasbonSdm = sumTrxDebetKasbonSdm - sumTrxKreditKasbonSdm;

      if ((sumSaldoKasbonSdm - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo kasbon yang sudah ada pada sdm ini adalah Rp ', format(sumSaldoKasbonSdm, 2, 'id_ID'), '\n',
          'Nilai transaksi kasbon yang akan dibayarkan adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over bayar.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.created_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into 
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.created_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          if (new.created_by = new.id_sdm)
          then
            set new.validasi_sdm = 1;
          elseif (new.created_by != new.id_sdm)
          then
            set new.validasi_sdm = 0;
          end if;

          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bi3` BEFORE INSERT ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_sdm = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_sdm = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bu1` BEFORE UPDATE ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaKasbonSdm,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSdmAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetKasbonSdm,
    sumTrxKreditKasbonSdm,
    sumSaldoKasbonSdm Double;
  declare pesanError Text;

  if
    (
      (not (new.id_sdm <=> old.id_sdm)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal))
    )
  then
    select
      peran
    into
      peranUser
    from
      users
    where
      id = new.id_sdm;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekSdmAtauBukan != 'Manajemen')
    then
      set pesanError = concat(
        'User yang Anda input bukan anggota manajemen, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekSdmAtauBukan = 'Manajemen')
    then
      # cek saldo kasbon sdm ini
      set nomorCoaKasbonSdm = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 7
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetKasbonSdm,
        sumTrxKreditKasbonSdm
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaKasbonSdm
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoKasbonSdm = sumTrxDebetKasbonSdm - sumTrxKreditKasbonSdm;

      if ((sumSaldoKasbonSdm - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo kasbon yang sudah ada pada sdm ini adalah Rp ', format(sumSaldoKasbonSdm, 2, 'id_ID'), '\n',
          'Nilai transaksi kasbon yang akan dibayarkan adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over bayar.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into 
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          if (new.updated_by = new.id_sdm)
          then
            set new.validasi_sdm = 1;
          elseif (new.updated_by != new.id_sdm)
          then
            set new.validasi_sdm = 0;
          end if;

          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bu2` BEFORE UPDATE ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_sdm = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_sdm = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_bayar_kasbon_sdm_bu3` BEFORE UPDATE ON `trx_bayar_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_deposit_pelanggan`
--

CREATE TABLE `trx_deposit_pelanggan` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_pelanggan` bigint(20) UNSIGNED NOT NULL,
  `validasi_pelanggan` tinyint(1) NOT NULL DEFAULT 1,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_deposit_pelanggan`
--

INSERT INTO `trx_deposit_pelanggan` (`id_trx`, `waktu_trx`, `id_pelanggan`, `validasi_pelanggan`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('DPL/24032026/1/00001', '2026-03-24 08:54:44', 8, 1, 2, 33525000, 0, NULL, 0, 0, 33525000, 'db', 'Dokumen', 'sss', 0, 1, '2026-03-24 14:55:09', NULL, '2026-03-24 15:18:06', 1, '2026-03-24 09:18:06'),
('DPL/24032026/1/00002', '2026-03-24 09:15:18', 8, 1, 2, 54300000, 1, NULL, 0, 0, 54300000, 'postman', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00002.pdf', 1, 1, '2026-03-24 15:15:18', 4, '2026-03-25 15:44:41', NULL, NULL),
('DPL/24032026/1/00003', '2026-03-24 12:15:10', 8, 1, 2, 17170000, 1, NULL, 0, 0, 17170000, 'Apps', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00003.pdf', 1, 1, '2026-03-24 18:15:10', 4, '2026-03-28 23:21:51', NULL, NULL);

--
-- Trigger `trx_deposit_pelanggan`
--
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_ai1` AFTER INSERT ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaDepositPelanggan Varchar(100);
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjAkunKas,
      5,
      nomorCoaKas,
      new.nominal_kas,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaReknt,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      5,
      nomorCoaReknt,
      new.nominal_reknt,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  set nomorCoaDepositPelanggan = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 6
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_pelanggan,
    5,
    nomorCoaDepositPelanggan,
    0,
    new.total_nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_ai2` AFTER INSERT ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    kodePelanggan,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    jenisPelanggan Varchar(11) default '-';
  declare
    bentukPerusahaan,
    jenisBadanUsahaPelanggan Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaPelanggan,
    namaBadanUsahaPelanggan,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    namaLk Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    jenis_user,
    coalesce(jenis_badan_usaha, ''),
    coalesce(nama_badan_usaha, ''),
    nama
  into
    kodePelanggan,
    jenisPelanggan,
    jenisBadanUsahaPelanggan,
    namaBadanUsahaPelanggan,
    namaPelanggan
  from
    users
  where
    id = new.id_pelanggan;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;
  end if;

  if (new.validasi_pelanggan = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 23;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pelanggan,
      'trx_deposit_pelanggan',
      'validasi_pelanggan',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 24;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_deposit_pelanggan',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 25;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_deposit_pelanggan',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_au1` AFTER UPDATE ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bd1` BEFORE DELETE ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;

  /*delete from
    trx_jurnal_umum
  where
    sumber_id_trx = old.id_trx;

  delete from
    trx_notifikasi
  where
    sumber_id_trx = old.id_trx;*/
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bi1` BEFORE INSERT ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      8,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bi2` BEFORE INSERT ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositPelanggan,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekPelangganAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare pesanError Text;

  select
    peran
  into
    peranUser
  from
    users
  where
    id = new.id_pelanggan;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekPelangganAtauBukan != 'Pelanggan')
  then
    set pesanError = concat(
      'User yang Anda input bukan pelanggan, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekPelangganAtauBukan = 'Pelanggan')
  then
    if  
      (
        (new.id_akun_kas is null) or
        (new.id_akun_kas = 0)
      )
        and
      (
        (new.id_reknt is null) or
        (new.id_reknt = 0)
      )
    then
      set pesanError = concat(
        'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
        'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if
        (
          (
            (new.id_akun_kas is not null)
              or
            (new.id_akun_kas > 0)
          )
            and
          (
            (new.nominal_kas > 0)
          )
        )
      then
        select
          id_pj,
          validasi_pj,
          aktif
        into
          idPjAkunKas,
          validasiPjAkunKas,
          statusAktifAkunKas
        from
          akun_kas
        where
          id = new.id_akun_kas;

        if (validasiPjAkunKas = 0)
        then
          set pesanError = concat(
            'Akun kas yang Anda input tidak valid.\n',
            'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (statusAktifAkunKas = 0)
        then
          set pesanError = concat(
            'Akun kas yang Anda input tidak aktif.\n',
            'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (new.created_by = idPjAkunKas)
        then
          set new.validasi_akun_kas = 1;
        elseif (new.created_by != idPjAkunKas)
        then
          set new.validasi_akun_kas = 0;
        end if;
      end if;

      if
        (
          (
            (new.id_reknt is not null)
              or
            (new.id_reknt > 0)
          )
            and
          (
            (new.nominal_reknt > 0)
          )
        )
      then
        select
          id_pj,
          validasi_pj,
          aktif
        into 
          idPjReknt,
          validasiPjReknt,
          statusAktifReknt
        from
          reknt
        where
          id = new.id_reknt;

        if (validasiPjReknt = 0)
        then
          set pesanError = concat(
            'Rekening non tunai yang Anda input tidak valid.\n',
            'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (statusAktifReknt = 0)
        then
          set pesanError = concat(
            'Rekening non tunai yang Anda input tidak aktif.\n',
            'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (new.created_by = idPjReknt)
        then
          set new.validasi_reknt = 1;
        elseif (new.created_by != idPjReknt)
        then
          set new.validasi_reknt = 0;
        end if;
      end if;

      # kiye sementara ora dinggo ndisit, soale suppliere durung gawekna aplikasi, ora bisa validasi:
      # if (new.created_by = new.id_pelanggan)
      # then
      #   set new.validasi_pelanggan = 1;
      # elseif (new.created_by != new.id_pelanggan)
      # then
      #   set new.validasi_pelanggan = 0;
      # end if;

      set new.validasi_pelanggan = 1;
      
      set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bi3` BEFORE INSERT ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_pelanggan = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_pelanggan = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bu1` BEFORE UPDATE ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositPelanggan,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekPelangganAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare pesanError Text;

  if
    (
      (not (new.id_pelanggan <=> old.id_pelanggan)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal))
    )
  then
    select
      peran
    into
      peranUser
    from
      users
    where
      id = new.id_pelanggan;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekPelangganAtauBukan != 'Pelanggan')
    then
      set pesanError = concat(
        'User yang Anda input bukan pelanggan, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekPelangganAtauBukan = 'Pelanggan')
    then
      if  
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        )
          and
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        )
      then
        set pesanError = concat(
          'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
          'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if
          (
            (
              (new.id_akun_kas is not null)
                or
              (new.id_akun_kas > 0)
            )
              and
            (
              (new.nominal_kas > 0)
            )
          )
        then
          select
            id_pj,
            validasi_pj,
            aktif
          into
            idPjAkunKas,
            validasiPjAkunKas,
            statusAktifAkunKas
          from
            akun_kas
          where
            id = new.id_akun_kas;

          if (validasiPjAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak valid.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak aktif.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.updated_by = idPjAkunKas)
          then
            set new.validasi_akun_kas = 1;
          elseif (new.updated_by != idPjAkunKas)
          then
            set new.validasi_akun_kas = 0;
          end if;
        end if;

        if
          (
            (
              (new.id_reknt is not null)
                or
              (new.id_reknt > 0)
            )
              and
            (
              (new.nominal_reknt > 0)
            )
          )
        then
          select
            id_pj,
            validasi_pj,
            aktif
          into 
            idPjReknt,
            validasiPjReknt,
            statusAktifReknt
          from
            reknt
          where
            id = new.id_reknt;

          if (validasiPjReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak valid.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak aktif.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.updated_by = idPjReknt)
          then
            set new.validasi_reknt = 1;
          elseif (new.updated_by != idPjReknt)
          then
            set new.validasi_reknt = 0;
          end if;
        end if;

        # kiye sementara ora dinggo ndisit, soale suppliere durung gawekna aplikasi, ora bisa validasi:
        # if (new.updated_by = new.id_pelanggan)
        # then
        #   set new.validasi_pelanggan = 1;
        # elseif (new.updated_by != new.id_pelanggan)
        # then
        #   set new.validasi_pelanggan = 0;
        # end if;

        set new.validasi_pelanggan = 1;
        
        set new.total_nominal = new.nominal_kas + new.nominal_reknt;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bu2` BEFORE UPDATE ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_pelanggan = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_pelanggan = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_pelanggan_bu3` BEFORE UPDATE ON `trx_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_deposit_supplier`
--

CREATE TABLE `trx_deposit_supplier` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_supplier` bigint(20) UNSIGNED NOT NULL COMMENT 'user sing sebagai supplier',
  `validasi_supplier` tinyint(1) NOT NULL DEFAULT 1,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt_user` bigint(20) UNSIGNED DEFAULT NULL,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_deposit_supplier`
--

INSERT INTO `trx_deposit_supplier` (`id_trx`, `waktu_trx`, `id_supplier`, `validasi_supplier`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `id_reknt_user`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('DSP/22032026/1/00001', '2026-03-22 12:01:24', 7, 1, 2, 11000000, 1, NULL, 0, 0, NULL, 11000000, 'Apps', 'Dokumen', 'trx_deposit_supplier_DSP-22032026-1-00001.pdf', 1, 1, '2026-03-22 18:01:24', 4, '2026-03-23 13:00:46', NULL, NULL);

--
-- Trigger `trx_deposit_supplier`
--
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_ai1` AFTER INSERT ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaDepositSupplier Varchar(100);
  declare
    idPjKas,
    idPjReknt BigInt(20) Unsigned;

  set nomorCoaDepositSupplier = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 5
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_supplier,
    3,
    nomorCoaDepositSupplier,
    new.total_nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjKas,
      3,
      nomorCoaKas,
      0,
      new.nominal_kas,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      3,
      nomorCoaReknt,
      0,
      new.nominal_reknt,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_ai2` AFTER INSERT ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    kodeSupplier,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    jenisSupplier Varchar(11) default '-';
  declare
    bentukPerusahaan,
    jenisBadanUsahaSupplier Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt,
    nomorRekntUser Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaSupplier,
    namaBadanUsahaSupplier,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    atasNamaRekntUser,
    namaLk,
    namaLkRekntUser Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk,
    idLkRekntUser Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    jenis_user,
    coalesce(jenis_badan_usaha, ''),
    coalesce(nama_badan_usaha, ''),
    nama
  into
    kodeSupplier,
    jenisSupplier,
    jenisBadanUsahaSupplier,
    namaBadanUsahaSupplier,
    namaSupplier
  from
    users
  where
    id = new.id_supplier;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;

    # ambil data reknt user
    select
      nomor_rekening,
      atas_nama,
      id_lk
    into
      nomorRekntUser,
      atasNamaRekntUser,
      idLkRekntUser
    from
      reknt_users
    where
      id = new.id_reknt_user;

    select
      nama
    into
      namaLkRekntUser
    from
      lembaga_keuangan
    where
      id = idLkRekntUser;
  end if;

  if (new.validasi_supplier = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 17;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSupplier}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSupplier}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSupplier}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_supplier,
      'trx_deposit_supplier',
      'validasi_supplier',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 18;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSupplier}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSupplier}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSupplier}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_deposit_supplier',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 19;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSupplier}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSupplier}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSupplier}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_deposit_supplier',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_au1` AFTER UPDATE ON `trx_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bd1` BEFORE DELETE ON `trx_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bi1` BEFORE INSERT ON `trx_deposit_supplier` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      6,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bi2` BEFORE INSERT ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositSupplier,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSupplierAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    limitDepositSupplier,
    sumTrxDebetDepositSupplier,
    sumTrxKreditDepositSupplier,
    sumSaldoDepositSupplierSaatIni,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  select
    limit_deposit_supplier,
    peran
  into
    limitDepositSupplier,
    peranUser
  from
    users
  where
    id = new.id_supplier;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekSupplierAtauBukan != 'Supplier')
  then
    set pesanError = concat(
      'User yang Anda input bukan supplier, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekSupplierAtauBukan = 'Supplier')
  then
    # cek deposit sudah berapa di supplierini
    set nomorCoaDepositSupplier = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 5
    );

    select
      coalesce(sum(trx_debet), 0),
      coalesce(sum(trx_kredit), 0)
    into
      sumTrxDebetDepositSupplier,
      sumTrxKreditDepositSupplier
    from
      trx_jurnal_umum
    where
      nomor_coa = nomorCoaDepositSupplier
    and
      id_entitas = new.id_supplier
    and
      validasi_trx = 1
    and
      deleted_at is null;

    set sumSaldoDepositSupplierSaatIni = sumTrxDebetDepositSupplier - sumTrxKreditDepositSupplier;

    if (limitDepositSupplier < (sumSaldoDepositSupplierSaatIni + new.total_nominal))
    then
      set pesanError = concat(
        'Limit deposit untuk supplier ini adalah Rp ', format(limitDepositSupplier, 2, 'id_ID'), '\n',
        'Saldo deposit yang sudah ada pada supplier ini adalah Rp ', format(sumSaldoDepositSupplierSaatIni, 2, 'id_ID'), '\n',
        'Nilai transaksi deposit yang akan diinput adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
        'Artinya sudah melebihi limit yang ditentukan.\n',
        'Transaksi tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if  
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        )
          and
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        )
      then
        set pesanError = concat(
          'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
          'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if
          (
            (
              (new.id_akun_kas is not null)
                or
              (new.id_akun_kas > 0)
            )
              and
            (
              (new.nominal_kas > 0)
            )
          )
        then
          select
            nomor_coa,
            id_pj,
            validasi_pj,
            aktif
          into
            nomorCoaAkunKas,
            idPjAkunKas,
            validasiPjAkunKas,
            statusAktifAkunKas
          from
            akun_kas
          where
            id = new.id_akun_kas;

          select
            coalesce(sum(trx_debet), 0),
            coalesce(sum(trx_kredit), 0)
          into
            sumTrxDebetAkunKas,
            sumTrxKreditAkunKas
          from
            trx_jurnal_umum
          where
            nomor_coa = nomorCoaAkunKas
          and
            validasi_trx = 1
          and
            deleted_at is null;

          set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

          if (validasiPjAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak valid.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak aktif.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (saldoAkunKas < new.nominal_kas)
          then
            set pesanError = concat(
              'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
              'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
              'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.created_by = idPjAkunKas)
          then
            set new.validasi_akun_kas = 1;
          elseif (new.created_by != idPjAkunKas)
          then
            set new.validasi_akun_kas = 0;
          end if;
        end if;

        if
          (
            (
              (new.id_reknt is not null)
                or
              (new.id_reknt > 0)
            )
              and
            (
              (new.nominal_reknt > 0)
            )
          )
        then
          select
            nomor_coa,
            id_pj,
            validasi_pj,
            aktif
          into 
            nomorCoaReknt,
            idPjReknt,
            validasiPjReknt,
            statusAktifReknt
          from
            reknt
          where
            id = new.id_reknt;

          select
            coalesce(sum(trx_debet), 0),
            coalesce(sum(trx_kredit), 0)
          into
            sumTrxDebetReknt,
            sumTrxKreditReknt
          from
            trx_jurnal_umum
          where
            nomor_coa = nomorCoaReknt
          and
            validasi_trx = 1
          and
            deleted_at is null;

          set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

          if (validasiPjReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak valid.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak aktif.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.id_reknt_user is null)
          then
            set pesanError = concat(
              'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
              'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (saldoReknt < new.nominal_reknt)
          then
            set pesanError = concat(
              'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
              'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
              'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.created_by = idPjReknt)
          then
            set new.validasi_reknt = 1;
          elseif (new.created_by != idPjReknt)
          then
            set new.validasi_reknt = 0;
          end if;
        end if;

        # kiye sementara ora dinggo ndisit, soale suppliere durung gawekna aplikasi, ora bisa validasi:
        # if (new.created_by = new.id_supplier)
        # then
        #   set new.validasi_supplier = 1;
        # elseif (new.created_by != new.id_supplier)
        # then
        #   set new.validasi_supplier = 0;
        # end if;

        set new.validasi_supplier = 1;
        
        set new.total_nominal = new.nominal_kas + new.nominal_reknt;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bi3` BEFORE INSERT ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_supplier = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_supplier = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bu1` BEFORE UPDATE ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositSupplier,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSupplierAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    limitDepositSupplier,
    sumTrxDebetDepositSupplier,
    sumTrxKreditDepositSupplier,
    sumSaldoDepositSupplierSaatIni,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  if
    (
      (not (new.id_supplier <=> old.id_supplier)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal)) or
      (not (new.id_reknt_user <=> old.id_reknt_user))
    )
  then
    select
      limit_deposit_supplier,
      peran
    into
      limitDepositSupplier,
      peranUser
    from
      users
    where
      id = new.id_supplier;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekSupplierAtauBukan != 'Supplier')
    then
      set pesanError = concat(
        'User yang Anda input bukan supplier, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekSupplierAtauBukan = 'Supplier')
    then
      # cek deposit sudah berapa di supplierini
      set nomorCoaDepositSupplier = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 5
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetDepositSupplier,
        sumTrxKreditDepositSupplier
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaDepositSupplier
      and
        id_entitas = new.id_supplier
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoDepositSupplierSaatIni = sumTrxDebetDepositSupplier - sumTrxKreditDepositSupplier;

      if (limitDepositSupplier < (sumSaldoDepositSupplierSaatIni + new.total_nominal))
      then
        set pesanError = concat(
          'Limit deposit untuk supplier ini adalah Rp ', format(limitDepositSupplier, 2, 'id_ID'), '\n',
          'Saldo deposit yang sudah ada pada supplier ini adalah Rp ', format(sumSaldoDepositSupplierSaatIni, 2, 'id_ID'), '\n',
          'Nilai transaksi deposit yang akan diinput adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya sudah melebihi limit yang ditentukan.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into 
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.id_reknt_user is null)
            then
              set pesanError = concat(
                'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
                'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          # kiye sementara ora dinggo ndisit soale suppliere ora olih notifikasi
          # if (new.updated_by = new.id_supplier)
          # then
          #   set new.validasi_supplier = 1;
          # elseif (new.updated_by != new.id_supplier)
          # then
          #   set new.validasi_supplier = 0;
          # end if;

          set new.validasi_supplier = 1;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bu2` BEFORE UPDATE ON `trx_deposit_supplier` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_supplier = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_supplier = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_deposit_supplier_bu3` BEFORE UPDATE ON `trx_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_input_modal`
--

CREATE TABLE `trx_input_modal` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_investor` bigint(20) UNSIGNED NOT NULL,
  `validasi_investor` tinyint(1) NOT NULL DEFAULT 0,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_input_modal`
--

INSERT INTO `trx_input_modal` (`id_trx`, `waktu_trx`, `id_investor`, `validasi_investor`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('TIM/23122025/1/00001', '2025-12-23 18:16:27', 4, 1, 2, 73350000, 1, NULL, 0, 0, 73350000, 'tes 1', 'Dokumen', 'trx_input_modal_TIM-23122025-1-00001.pdf', 1, 1, '2025-12-24 05:59:39', 4, '2026-03-28 23:24:04', NULL, NULL),
('TIM/31032026/1/00001', '2026-03-31 11:03:52', 4, 1, NULL, 0, 0, 1, 83600000, 1, 83600000, 'Apps', 'Dokumen', 'trx_input_modal_TIM-31032026-1-00001.pdf', 1, 1, '2026-03-31 16:03:52', 4, '2026-03-31 16:05:04', NULL, NULL);

--
-- Trigger `trx_input_modal`
--
DELIMITER $$
CREATE TRIGGER `trx_input_modal_ai1` AFTER INSERT ON `trx_input_modal` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaModalInvestor Varchar(100);
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjAkunKas,
      1,
      nomorCoaKas,
      new.nominal_kas,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaReknt,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      1,
      nomorCoaReknt,
      new.nominal_reknt,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  set nomorCoaModalInvestor = (
    select
      nomor_coa_modal
    from
      users
    where
      id = new.id_investor
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_investor,
    1,
    nomorCoaModalInvestor,
    0,
    new.total_nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_ai2` AFTER INSERT ON `trx_input_modal` FOR EACH ROW begin
  declare
    kodeInvestor,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare bentukPerusahaan Varchar(21);
  declare
    namaAkunKas,
    nomorReknt Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaInvestor,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    namaLk Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare idLk Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    nama
  into
    kodeInvestor,
    namaInvestor
  from
    users
  where
    id = new.id_investor;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;
  end if;

  if (new.validasi_investor = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 11;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_investor,
      'trx_input_modal',
      'validasi_investor',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 12;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_input_modal',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 13;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_input_modal',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_au1` AFTER UPDATE ON `trx_input_modal` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bd1` BEFORE DELETE ON `trx_input_modal` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bi1` BEFORE INSERT ON `trx_input_modal` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      4,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bi2` BEFORE INSERT ON `trx_input_modal` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    cekInvestorAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare pesanError Text;

  set cekInvestorAtauBukan = (
    select
      investor
    from
      users
    where
      id = new.id_investor
  );

  if (cekInvestorAtauBukan = 0)
  then
    set pesanError = concat(
      'User yang Anda input bukan investor, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekInvestorAtauBukan = 1)
  then
    if  
      (
        (new.id_akun_kas is null) or
        (new.id_akun_kas = 0)
      )
        and
      (
        (new.id_reknt is null) or
        (new.id_reknt = 0)
      )
    then
      set pesanError = concat(
        'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
        'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if
        (
          (
            (new.id_akun_kas is not null)
              or
            (new.id_akun_kas > 0)
          )
            and
          (
            (new.nominal_kas > 0)
          )
        )
      then
        select
          id_pj,
          validasi_pj,
          aktif
        into
          idPjAkunKas,
          validasiPjAkunKas,
          statusAktifAkunKas
        from
          akun_kas
        where
          id = new.id_akun_kas;

        if (validasiPjAkunKas = 0)
        then
          set pesanError = concat(
            'Akun kas yang Anda input tidak valid.\n',
            'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (statusAktifAkunKas = 0)
        then
          set pesanError = concat(
            'Akun kas yang Anda input tidak aktif.\n',
            'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (new.created_by = idPjAkunKas)
        then
          set new.validasi_akun_kas = 1;
        elseif (new.created_by != idPjAkunKas)
        then
          set new.validasi_akun_kas = 0;
        end if;
      end if;

      if
        (
          (
            (new.id_reknt is not null)
              or
            (new.id_reknt > 0)
          )
            and
          (
            (new.nominal_reknt > 0)
          )
        )
      then
        select
          id_pj,
          validasi_pj,
          aktif
        into 
          idPjReknt,
          validasiPjReknt,
          statusAktifReknt
        from
          reknt
        where
          id = new.id_reknt;

        if (validasiPjReknt = 0)
        then
          set pesanError = concat(
            'Rekening non tunai yang Anda input tidak valid.\n',
            'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (statusAktifReknt = 0)
        then
          set pesanError = concat(
            'Rekening non tunai yang Anda input tidak aktif.\n',
            'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        elseif (new.created_by = idPjReknt)
        then
          set new.validasi_reknt = 1;
        elseif (new.created_by != idPjReknt)
        then
          set new.validasi_reknt = 0;
        end if;
      end if;

      if (new.created_by = new.id_investor)
      then
        set new.validasi_investor = 1;
      elseif (new.created_by != new.id_investor)
      then
        set new.validasi_investor = 0;
      end if;
      
      set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bi3` BEFORE INSERT ON `trx_input_modal` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_investor = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_investor = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bu1` BEFORE UPDATE ON `trx_input_modal` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    cekInvestorAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare pesanError Text;

  if
    (
      (not (new.id_investor <=> old.id_investor)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal))
    )
  then
    set cekInvestorAtauBukan = (
      select
        investor
      from
        users
      where
        id = new.id_investor
    );

    if (cekInvestorAtauBukan = 0)
    then
      set pesanError = concat(
        'User yang Anda input bukan investor, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekInvestorAtauBukan = 1)
    then
      if
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        )
          and
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        )
      then
        set pesanError = concat(
          'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
          'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if
          (
            (
              (new.id_akun_kas is not null)
                or
              (new.id_akun_kas > 0)
            )
              and
            (
              (new.nominal_kas > 0)
            )
          )
        then
          select
            id_pj,
            validasi_pj,
            aktif
          into
            idPjAkunKas,
            validasiPjAkunKas,
            statusAktifAkunKas
          from
            akun_kas
          where
            id = new.id_akun_kas;

          if (validasiPjAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak valid.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak aktif.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.updated_by = idPjAkunKas)
          then
            set new.validasi_akun_kas = 1;
          elseif (new.updated_by != idPjAkunKas)
          then
            set new.validasi_akun_kas = 0;
          end if;
        end if;

        if
          (
            (
              (new.id_reknt is not null)
                or
              (new.id_reknt > 0)
            )
              and
            (
              (new.nominal_reknt > 0)
            )
          )
        then
          select
            id_pj,
            validasi_pj,
            aktif
          into 
            idPjReknt,
            validasiPjReknt,
            statusAktifReknt
          from
            reknt
          where
            id = new.id_reknt;

          if (validasiPjReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak valid.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak aktif.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.updated_by = idPjReknt)
          then
            set new.validasi_reknt = 1;
          elseif (new.updated_by != idPjReknt)
          then
            set new.validasi_reknt = 0;
          end if;
        end if;

        if (new.updated_by = new.id_investor)
        then
          set new.validasi_investor = 1;
        elseif (new.updated_by != new.id_investor)
        then
          set new.validasi_investor = 0;
        end if;
        
        set new.total_nominal = new.nominal_kas + new.nominal_reknt;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bu2` BEFORE UPDATE ON `trx_input_modal` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_investor = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_investor = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_input_modal_bu3` BEFORE UPDATE ON `trx_input_modal` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_jurnal_umum`
--

CREATE TABLE `trx_jurnal_umum` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `sumber_id_trx` varchar(50) NOT NULL,
  `jenis_entitas` enum('User','Lembaga Keuangan','Supplier','Pelanggan') NOT NULL DEFAULT 'User',
  `id_entitas` bigint(20) UNSIGNED NOT NULL,
  `kode_ju` smallint(6) UNSIGNED NOT NULL,
  `nomor_coa` varchar(100) NOT NULL,
  `trx_debet` double NOT NULL,
  `trx_kredit` double NOT NULL,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') NOT NULL DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_jurnal_umum`
--

INSERT INTO `trx_jurnal_umum` (`id_trx`, `waktu_trx`, `sumber_id_trx`, `jenis_entitas`, `id_entitas`, `kode_ju`, `nomor_coa`, `trx_debet`, `trx_kredit`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('JU/19032026/1/00001', '2026-03-19 16:15:04', 'TPV/19032026/1/00001', 'User', 4, 2, '300-2-1', 10000000, 0, 'Aplikasi', 'Dokumen', 'trx_prive_TPV-19032026-1-00001.pdf', 1, 1, '2026-03-19 22:15:04', 4, '2026-03-19 22:16:34', NULL, NULL),
('JU/19032026/1/00002', '2026-03-19 16:15:04', 'TPV/19032026/1/00001', 'User', 4, 2, '100-1-1-2', 0, 10000000, 'Aplikasi', 'Dokumen', 'trx_prive_TPV-19032026-1-00001.pdf', 1, 1, '2026-03-19 22:15:04', 4, '2026-03-19 22:16:34', NULL, NULL),
('JU/22032026/1/00001', '2026-03-22 12:01:24', 'DSP/22032026/1/00001', 'User', 7, 3, '100-1-3', 11000000, 0, 'Apps', 'Dokumen', 'trx_deposit_supplier_DSP-22032026-1-00001.pdf', 1, 1, '2026-03-22 18:01:24', 4, '2026-03-23 13:00:46', NULL, NULL),
('JU/22032026/1/00002', '2026-03-22 12:01:24', 'DSP/22032026/1/00001', 'User', 4, 3, '100-1-1-2', 0, 11000000, 'Apps', 'Dokumen', 'trx_deposit_supplier_DSP-22032026-1-00001.pdf', 1, 1, '2026-03-22 18:01:24', 4, '2026-03-23 13:00:46', NULL, NULL),
('JU/23032026/1/00001', '2026-03-23 09:33:49', 'WDDS/23032026/1/00001', 'User', 4, 4, '100-1-1-2', 1000000, 0, 'test postman', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00001.pdf', 1, 1, '2026-03-23 15:33:49', 4, '2026-03-23 15:34:42', NULL, NULL),
('JU/23032026/1/00002', '2026-03-23 09:33:49', 'WDDS/23032026/1/00001', 'User', 7, 4, '100-1-3', 0, 1000000, 'test postman', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00001.pdf', 1, 1, '2026-03-23 15:33:49', 4, '2026-03-23 15:34:42', NULL, NULL),
('JU/23032026/1/00003', '2026-03-23 12:47:21', 'WDDS/23032026/1/00002', 'User', 4, 4, '100-1-1-2', 500000, 0, '', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00002.pdf', 1, 1, '2026-03-23 18:47:21', 4, '2026-03-23 18:51:56', NULL, NULL),
('JU/23032026/1/00004', '2026-03-23 12:47:21', 'WDDS/23032026/1/00002', 'User', 7, 4, '100-1-3', 0, 500000, '', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00002.pdf', 1, 1, '2026-03-23 18:47:21', 4, '2026-03-23 18:51:56', NULL, NULL),
('JU/24032026/1/00001', '2026-03-24 08:54:44', 'DPL/24032026/1/00001', 'User', 4, 5, '100-1-1-2', 33525000, 0, 'db', 'Dokumen', 'sss', 0, 1, '2026-03-24 14:55:09', NULL, '2026-03-24 15:18:06', 1, '2026-03-24 09:18:06'),
('JU/24032026/1/00002', '2026-03-24 08:54:44', 'DPL/24032026/1/00001', 'User', 8, 5, '200-1-2', 0, 33525000, 'db', 'Dokumen', 'sss', 0, 1, '2026-03-24 14:55:09', NULL, '2026-03-24 15:18:06', 1, '2026-03-24 09:18:06'),
('JU/24032026/1/00003', '2026-03-24 09:15:18', 'DPL/24032026/1/00002', 'User', 4, 5, '100-1-1-2', 54300000, 0, 'postman', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00002.pdf', 1, 1, '2026-03-24 15:15:18', 4, '2026-03-25 15:44:41', NULL, NULL),
('JU/24032026/1/00004', '2026-03-24 09:15:18', 'DPL/24032026/1/00002', 'User', 8, 5, '200-1-2', 0, 54300000, 'postman', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00002.pdf', 1, 1, '2026-03-24 15:15:18', 4, '2026-03-25 15:44:41', NULL, NULL),
('JU/24032026/1/00005', '2026-03-24 12:15:10', 'DPL/24032026/1/00003', 'User', 4, 5, '100-1-1-2', 17170000, 0, 'Apps', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00003.pdf', 1, 1, '2026-03-24 18:15:10', 4, '2026-03-28 23:21:51', NULL, NULL),
('JU/24032026/1/00006', '2026-03-24 12:15:10', 'DPL/24032026/1/00003', 'User', 8, 5, '200-1-2', 0, 17170000, 'Apps', 'Dokumen', 'trx_deposit_pelanggan_DPL-24032026-1-00003.pdf', 1, 1, '2026-03-24 18:15:10', 4, '2026-03-28 23:21:51', NULL, NULL),
('JU/24122025/1/00001', '2025-12-23 18:16:27', 'TIM/23122025/1/00001', 'User', 4, 1, '100-1-1-2', 73350000, 0, 'tes 1', 'Dokumen', '', 1, 1, '2025-12-24 05:59:39', 4, '2026-03-18 15:55:26', NULL, NULL),
('JU/24122025/1/00002', '2025-12-23 18:16:27', 'TIM/23122025/1/00001', 'User', 4, 1, '300-1-1', 0, 73350000, 'tes 1', 'Dokumen', '', 1, 1, '2025-12-24 05:59:39', 4, '2026-03-18 15:55:28', NULL, NULL),
('JU/25032026/1/00001', '2026-03-25 10:56:17', 'WDDPL/25032026/1/00001', 'User', 8, 6, '200-1-2', 100000, 0, 'tes postman', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00001.pdf', 1, 1, '2026-03-25 16:56:17', 1, '2026-03-25 16:56:44', NULL, NULL),
('JU/25032026/1/00002', '2026-03-25 10:56:17', 'WDDPL/25032026/1/00001', 'User', 4, 6, '100-1-1-2', 0, 100000, 'tes postman', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00001.pdf', 1, 1, '2026-03-25 16:56:17', 1, '2026-03-25 16:56:44', NULL, NULL),
('JU/25032026/1/00003', '2026-03-25 14:08:05', 'WDDPL/25032026/1/00002', 'User', 8, 6, '200-1-2', 125000, 0, 'Apps', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00002.pdf', 1, 1, '2026-03-25 20:08:05', 4, '2026-03-28 23:25:25', NULL, NULL),
('JU/25032026/1/00004', '2026-03-25 14:08:05', 'WDDPL/25032026/1/00002', 'User', 4, 6, '100-1-1-2', 0, 125000, 'Apps', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00002.pdf', 1, 1, '2026-03-25 20:08:05', 4, '2026-03-28 23:25:25', NULL, NULL),
('JU/26032026/1/00001', '2026-03-26 15:49:15', 'KBM/26032026/1/00001', 'User', 5, 7, '100-1-4', 234000, 0, 'db', 'Dokumen', 'tete', 0, 1, '2026-03-26 21:50:56', NULL, '2026-03-27 22:48:05', 1, '2026-03-26 16:28:46'),
('JU/26032026/1/00002', '2026-03-26 15:49:15', 'KBM/26032026/1/00001', 'User', 4, 7, '100-1-1-2', 0, 234000, 'db', 'Dokumen', 'tete', 0, 1, '2026-03-26 21:50:56', NULL, '2026-03-27 22:48:05', 1, '2026-03-26 16:28:46'),
('JU/26032026/1/00003', '2026-03-26 16:27:32', 'KBM/26032026/1/00002', 'User', 6, 7, '100-1-4', 432000, 0, 'test postman', 'Dokumen', 'trx_kasbon_sdm_KBM-26032026-1-00002.pdf', 0, 1, '2026-03-26 22:27:32', NULL, '2026-03-27 22:48:05', 1, '2026-03-27 12:14:19'),
('JU/26032026/1/00004', '2026-03-26 16:27:32', 'KBM/26032026/1/00002', 'User', 4, 7, '100-1-1-2', 0, 432000, 'test postman', 'Dokumen', 'trx_kasbon_sdm_KBM-26032026-1-00002.pdf', 0, 1, '2026-03-26 22:27:32', NULL, '2026-03-27 22:48:05', 1, '2026-03-27 12:14:19'),
('JU/27032026/1/00001', '2026-03-27 14:24:36', 'KBM/27032026/1/00001', 'User', 5, 7, '100-1-4', 525000, 0, 'Tes input aplikasi', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00001.pdf', 1, 1, '2026-03-27 20:24:36', 4, '2026-03-27 23:30:31', NULL, NULL),
('JU/27032026/1/00002', '2026-03-27 14:24:36', 'KBM/27032026/1/00001', 'User', 4, 7, '100-1-1-2', 0, 525000, 'Tes input aplikasi', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00001.pdf', 1, 1, '2026-03-27 20:24:36', 4, '2026-03-27 23:30:31', NULL, NULL),
('JU/27032026/1/00005', '2026-03-27 17:46:36', 'KBM/27032026/1/00002', 'User', 5, 7, '100-1-4', 660000, 0, '', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00002.pdf', 1, 1, '2026-03-27 23:46:36', 4, '2026-03-27 23:48:57', NULL, NULL),
('JU/27032026/1/00006', '2026-03-27 17:46:36', 'KBM/27032026/1/00002', 'User', 4, 7, '100-1-1-2', 0, 660000, '', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00002.pdf', 1, 1, '2026-03-27 23:46:36', 4, '2026-03-27 23:48:57', NULL, NULL),
('JU/28032026/1/00001', '2026-03-28 17:29:19', 'BKBM/28032026/1/00001', 'User', 4, 8, '100-1-1-2', 90000, 0, 'postman', 'Dokumen', 'trx_bayar_kasbon_sdm_BKBM-28032026-1-00001.pdf', 1, 1, '2026-03-28 23:29:19', 4, '2026-03-28 23:30:43', NULL, NULL),
('JU/28032026/1/00002', '2026-03-28 17:29:19', 'BKBM/28032026/1/00001', 'User', 5, 8, '100-1-4', 0, 90000, 'postman', 'Dokumen', 'trx_bayar_kasbon_sdm_BKBM-28032026-1-00001.pdf', 1, 1, '2026-03-28 23:29:19', 4, '2026-03-28 23:30:43', NULL, NULL),
('JU/29032026/1/00001', '2026-03-29 02:12:41', 'TAK/29032026/1/00001', 'User', 4, 9, '100-1-1-1', 10000, 0, '', 'Dokumen', '', 1, 1, '2026-03-29 02:12:41', 4, '2026-03-29 02:16:30', NULL, NULL),
('JU/29032026/1/00002', '2026-03-29 02:12:41', 'TAK/29032026/1/00001', 'User', 4, 9, '100-1-1-2', 0, 10000, '', 'Dokumen', '', 1, 1, '2026-03-29 02:12:41', 4, '2026-03-29 02:16:30', NULL, NULL),
('JU/29032026/1/00003', '2026-03-29 11:12:21', 'TAK/29032026/1/00002', 'User', 4, 9, '100-1-1-1', 1230000, 0, 'postman', 'Dokumen', 'trx_antar_kas_TAK-29032026-1-00002.pdf', 0, 1, '2026-03-29 16:12:21', NULL, '2026-03-29 16:15:18', 1, '2026-03-29 11:15:18'),
('JU/29032026/1/00004', '2026-03-29 11:12:21', 'TAK/29032026/1/00002', 'User', 4, 9, '100-1-1-2', 0, 1230000, 'postman', 'Dokumen', 'trx_antar_kas_TAK-29032026-1-00002.pdf', 0, 1, '2026-03-29 16:12:21', NULL, '2026-03-29 16:15:18', 1, '2026-03-29 11:15:18'),
('JU/30032026/1/00001', '2026-03-30 16:04:56', 'TAK/30032026/1/00001', 'User', 4, 9, '100-1-1-1', 135000, 0, 'Apps', 'Dokumen', 'trx_antar_kas_TAK-30032026-1-00001.pdf', 0, 1, '2026-03-30 21:04:56', NULL, '2026-03-30 21:08:13', 1, '2026-03-30 16:08:13'),
('JU/30032026/1/00002', '2026-03-30 16:04:56', 'TAK/30032026/1/00001', 'User', 4, 9, '100-1-1-2', 0, 135000, 'Apps', 'Dokumen', 'trx_antar_kas_TAK-30032026-1-00001.pdf', 0, 1, '2026-03-30 21:04:56', NULL, '2026-03-30 21:08:13', 1, '2026-03-30 16:08:13'),
('JU/31032026/1/00001', '2026-03-31 11:03:52', 'TIM/31032026/1/00001', 'User', 4, 1, '100-1-2-1', 83600000, 0, 'Apps', 'Dokumen', 'trx_input_modal_TIM-31032026-1-00001.pdf', 1, 1, '2026-03-31 16:03:52', 4, '2026-03-31 16:05:04', NULL, NULL),
('JU/31032026/1/00002', '2026-03-31 11:03:52', 'TIM/31032026/1/00001', 'User', 4, 1, '300-1-1', 0, 83600000, 'Apps', 'Dokumen', 'trx_input_modal_TIM-31032026-1-00001.pdf', 1, 1, '2026-03-31 16:03:52', 4, '2026-03-31 16:05:04', NULL, NULL),
('JU/31032026/1/00003', '2026-03-31 11:17:57', 'TAR/31032026/1/00001', 'User', 4, 10, '100-1-2-2', 17000, 0, 'postman', 'Dokumen', 'trx_antar_reknt_TAR-31032026-1-00001.pdf', 0, 1, '2026-03-31 16:17:57', NULL, NULL, NULL, NULL),
('JU/31032026/1/00004', '2026-03-31 11:17:57', 'TAR/31032026/1/00001', 'User', 4, 10, '100-1-2-1', 0, 17000, 'postman', 'Dokumen', 'trx_antar_reknt_TAR-31032026-1-00001.pdf', 0, 1, '2026-03-31 16:17:57', NULL, NULL, NULL, NULL);

--
-- Trigger `trx_jurnal_umum`
--
DELIMITER $$
CREATE TRIGGER `trx_jurnal_umum_bi1` BEFORE INSERT ON `trx_jurnal_umum` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      2,
      new.created_at,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_kasbon_sdm`
--

CREATE TABLE `trx_kasbon_sdm` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_sdm` bigint(20) UNSIGNED NOT NULL COMMENT 'user sing sebagai anggota manajemen\r\ngomen = anggota manajemen',
  `validasi_sdm` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'user sing sebagai anggota manajemen\r\ngomen = anggota manajemen',
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt_user` bigint(20) UNSIGNED DEFAULT NULL,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='sdm = sumber daya manusia (anggota manajemen internal)';

--
-- Dumping data untuk tabel `trx_kasbon_sdm`
--

INSERT INTO `trx_kasbon_sdm` (`id_trx`, `waktu_trx`, `id_sdm`, `validasi_sdm`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `id_reknt_user`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('KBM/26032026/1/00001', '2026-03-26 15:49:15', 5, 0, 2, 234000, 0, NULL, 0, 0, NULL, 234000, 'db', 'Dokumen', 'tete', 0, 1, '2026-03-26 21:50:56', NULL, '2026-03-26 22:28:46', 1, '2026-03-26 16:28:46'),
('KBM/26032026/1/00002', '2026-03-26 16:27:32', 6, 0, 2, 432000, 0, NULL, 0, 0, NULL, 432000, 'test postman', 'Dokumen', 'trx_kasbon_sdm_KBM-26032026-1-00002.pdf', 0, 1, '2026-03-26 22:27:32', NULL, '2026-03-27 18:14:19', 1, '2026-03-27 12:14:19'),
('KBM/27032026/1/00001', '2026-03-27 14:24:36', 5, 1, 2, 525000, 1, NULL, 0, 0, NULL, 525000, 'Tes input aplikasi', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00001.pdf', 1, 1, '2026-03-27 20:24:36', 4, '2026-03-27 23:30:31', NULL, NULL),
('KBM/27032026/1/00002', '2026-03-27 17:46:36', 5, 1, 2, 660000, 1, NULL, 0, 0, NULL, 660000, '', 'Dokumen', 'trx_kasbon_sdm_KBM-27032026-1-00002.pdf', 1, 1, '2026-03-27 23:46:36', 4, '2026-03-27 23:48:57', NULL, NULL);

--
-- Trigger `trx_kasbon_sdm`
--
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_ai1` AFTER INSERT ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaKasbonSdm Varchar(100);
  declare
    idPjKas,
    idPjReknt BigInt(20) Unsigned;

  set nomorCoaKasbonSdm = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 7
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_sdm,
    7,
    nomorCoaKasbonSdm,
    new.total_nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjKas,
      7,
      nomorCoaKas,
      0,
      new.nominal_kas,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      7,
      nomorCoaReknt,
      0,
      new.nominal_reknt,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_ai2` AFTER INSERT ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    kodeSdm,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    bentukPerusahaan Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt,
    nomorRekntUser Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaSdm,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    atasNamaRekntUser,
    namaLk,
    namaLkRekntUser Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk,
    idLkRekntUser Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    nama
  into
    kodeSdm,
    namaSdm
  from
    users
  where
    id = new.id_Sdm;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;

    # ambil data reknt user
    select
      nomor_rekening,
      atas_nama,
      id_lk
    into
      nomorRekntUser,
      atasNamaRekntUser,
      idLkRekntUser
    from
      reknt_users
    where
      id = new.id_reknt_user;

    select
      nama
    into
      namaLkRekntUser
    from
      lembaga_keuangan
    where
      id = idLkRekntUser;
  end if;

  if (new.validasi_Sdm = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 29;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSdm}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSdm}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSdm}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_Sdm,
      'trx_kasbon_sdm',
      'validasi_Sdm',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 30;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSdm}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSdm}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSdm}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_kasbon_sdm',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 31;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSdm}}', kodeSdm);
    set isiNotif = replace(isiNotif, '{{namaSdm}}', namaSdm);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntSdm}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntSdm}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkSdm}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_kasbon_sdm',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_au1` AFTER UPDATE ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bd1` BEFORE DELETE ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;

  /*if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;*/

  delete from
    trx_jurnal_umum
  where
    sumber_id_trx = old.id_trx;

  delete from
    trx_notifikasi
  where
    sumber_id_trx = old.id_trx;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bi1` BEFORE INSERT ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      10,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bi2` BEFORE INSERT ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaKasbonSdm,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSdmAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    limitKasbonSdm,
    sumTrxDebetKasbonSdm,
    sumTrxKreditKasbonSdm,
    sumSaldoKasbonSdm,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  select
    limit_kasbon_sdm,
    peran
  into
    limitKasbonSdm,
    peranUser
  from
    users
  where
    id = new.id_sdm;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekSdmAtauBukan != 'Manajemen')
  then
    set pesanError = concat(
      'User yang Anda input bukan anggota manajemen, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekSdmAtauBukan = 'Manajemen')
  then
    # cek saldo kasbon sudah berapa di sdm ini
    set nomorCoaKasbonSdm = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 7
    );

    select
      coalesce(sum(trx_debet), 0),
      coalesce(sum(trx_kredit), 0)
    into
      sumTrxDebetKasbonSdm,
      sumTrxKreditKasbonSdm
    from
      trx_jurnal_umum
    where
      nomor_coa = nomorCoaKasbonSdm
    and
      id_entitas = new.id_sdm
    and
      validasi_trx = 1
    and
      deleted_at is null;

    set sumSaldoKasbonSdm = sumTrxDebetKasbonSdm - sumTrxKreditKasbonSdm;

    if (limitKasbonSdm < (sumSaldoKasbonSdm + new.total_nominal))
    then
      set pesanError = concat(
        'Limit kasbon untuk anggota manajemen ini adalah Rp ', format(limitKasbonSdm, 2, 'id_ID'), '\n',
        'Saldo kasbon yang sudah ada pada anggota manajemen ini adalah Rp ', format(sumSaldoKasbonSdm, 2, 'id_ID'), '\n',
        'Nilai transaksi kasbon yang akan diinput adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
        'Artinya sudah melebihi limit yang ditentukan.\n',
        'Transaksi tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      if  
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        )
          and
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        )
      then
        set pesanError = concat(
          'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
          'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if
          (
            (
              (new.id_akun_kas is not null)
                or
              (new.id_akun_kas > 0)
            )
              and
            (
              (new.nominal_kas > 0)
            )
          )
        then
          select
            nomor_coa,
            id_pj,
            validasi_pj,
            aktif
          into
            nomorCoaAkunKas,
            idPjAkunKas,
            validasiPjAkunKas,
            statusAktifAkunKas
          from
            akun_kas
          where
            id = new.id_akun_kas;

          select
            coalesce(sum(trx_debet), 0),
            coalesce(sum(trx_kredit), 0)
          into
            sumTrxDebetAkunKas,
            sumTrxKreditAkunKas
          from
            trx_jurnal_umum
          where
            nomor_coa = nomorCoaAkunKas
          and
            validasi_trx = 1
          and
            deleted_at is null;

          set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

          if (validasiPjAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak valid.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifAkunKas = 0)
          then
            set pesanError = concat(
              'Akun kas yang Anda input tidak aktif.\n',
              'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (saldoAkunKas < new.nominal_kas)
          then
            set pesanError = concat(
              'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
              'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
              'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.created_by = idPjAkunKas)
          then
            set new.validasi_akun_kas = 1;
          elseif (new.created_by != idPjAkunKas)
          then
            set new.validasi_akun_kas = 0;
          end if;
        end if;

        if
          (
            (
              (new.id_reknt is not null)
                or
              (new.id_reknt > 0)
            )
              and
            (
              (new.nominal_reknt > 0)
            )
          )
        then
          select
            nomor_coa,
            id_pj,
            validasi_pj,
            aktif
          into 
            nomorCoaReknt,
            idPjReknt,
            validasiPjReknt,
            statusAktifReknt
          from
            reknt
          where
            id = new.id_reknt;

          select
            coalesce(sum(trx_debet), 0),
            coalesce(sum(trx_kredit), 0)
          into
            sumTrxDebetReknt,
            sumTrxKreditReknt
          from
            trx_jurnal_umum
          where
            nomor_coa = nomorCoaReknt
          and
            validasi_trx = 1
          and
            deleted_at is null;

          set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

          if (validasiPjReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak valid.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (statusAktifReknt = 0)
          then
            set pesanError = concat(
              'Rekening non tunai yang Anda input tidak aktif.\n',
              'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.id_reknt_user is null)
          then
            set pesanError = concat(
              'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
              'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (saldoReknt < new.nominal_reknt)
          then
            set pesanError = concat(
              'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
              'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
              'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
            );

            signal sqlstate '45000'
            set message_text = pesanError;
          elseif (new.created_by = idPjReknt)
          then
            set new.validasi_reknt = 1;
          elseif (new.created_by != idPjReknt)
          then
            set new.validasi_reknt = 0;
          end if;
        end if;

        if (new.created_by = new.id_sdm)
        then
          set new.validasi_sdm = 1;
        elseif (new.created_by != new.id_sdm)
        then
          set new.validasi_sdm = 0;
        end if;

        set new.total_nominal = new.nominal_kas + new.nominal_reknt;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bi3` BEFORE INSERT ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_sdm = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_sdm = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bu1` BEFORE UPDATE ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaKasbonSdm,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSdmAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    limitKasbonSdm,
    sumTrxDebetKasbonSdm,
    sumTrxKreditKasbonSdm,
    sumSaldoKasbonSdm,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  if
    (
      (not (new.id_sdm <=> old.id_sdm)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal)) or
      (not (new.id_reknt_user <=> old.id_reknt_user))
    )
  then
    select
      limit_kasbon_sdm,
      peran
    into
      limitKasbonSdm,
      peranUser
    from
      users
    where
      id = new.id_sdm;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekSdmAtauBukan != 'Manajemen')
    then
      set pesanError = concat(
        'User yang Anda input bukan anggota manajemen, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekSdmAtauBukan = 'Manajemen')
    then
      # cek deposit sudah berapa di sdm ini
      set nomorCoaKasbonSdm = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 7
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetKasbonSdm,
        sumTrxKreditKasbonSdm
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaKasbonSdm
      and
        id_entitas = new.id_sdm
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoKasbonSdm = sumTrxDebetKasbonSdm - sumTrxKreditKasbonSdm;

      if (limitKasbonSdm < (sumSaldoKasbonSdm + new.total_nominal))
      then
        set pesanError = concat(
          'Limit kasbon untuk anggota manajemen ini adalah Rp ', format(limitKasbonSdm, 2, 'id_ID'), '\n',
          'Saldo kasbon yang sudah ada pada anggota manajemen ini adalah Rp ', format(sumSaldoKasbonSdm, 2, 'id_ID'), '\n',
          'Nilai transaksi kasbon yang akan diinput adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya sudah melebihi limit yang ditentukan.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into 
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.id_reknt_user is null)
            then
              set pesanError = concat(
                'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
                'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          if (new.updated_by = new.id_sdm)
          then
            set new.validasi_sdm = 1;
          elseif (new.updated_by != new.id_sdm)
          then
            set new.validasi_sdm = 0;
          end if;

          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bu2` BEFORE UPDATE ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_sdm = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_sdm = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_kasbon_sdm_bu3` BEFORE UPDATE ON `trx_kasbon_sdm` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_notifikasi`
--

CREATE TABLE `trx_notifikasi` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `sumber_id_trx` varchar(50) NOT NULL,
  `nama_kolom_primary` varchar(50) NOT NULL,
  `jenis_notifikasi` enum('Informasi','Validasi') NOT NULL DEFAULT 'Informasi' COMMENT 'nek informasi, nang aplikasine laka tombole\r\n\r\nnek validasi ana tombole, nek wis dipilih enabled = false dadi ngerti pilihane apa nek esih tampil',
  `judul_notif` text NOT NULL,
  `isi_notif` text NOT NULL,
  `jenis_entitas` enum('User','Lembaga Keuangan') NOT NULL DEFAULT 'User',
  `id_entitas` bigint(20) UNSIGNED NOT NULL,
  `nama_tabel` varchar(50) NOT NULL,
  `nama_kolom` varchar(50) NOT NULL,
  `sudah_dibaca` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'ben admin ngerti asline wis dibaca apa durung',
  `status_selesai` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = pending\r\n1 = setuju\r\n2 = tolak',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'nek wis dihapus ora tampil maning nang aplikasi',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_notifikasi`
--

INSERT INTO `trx_notifikasi` (`id_trx`, `waktu_trx`, `sumber_id_trx`, `nama_kolom_primary`, `jenis_notifikasi`, `judul_notif`, `isi_notif`, `jenis_entitas`, `id_entitas`, `nama_tabel`, `nama_kolom`, `sudah_dibaca`, `status_selesai`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('NTF/03032026/1/00001', '2026-03-03 22:28:56', '2', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Salah Satu Rekening Non Tunai Perusahaan', 'Anda ditunjuk sebagai penanggung jawab salah satu rekening non tunai perusahaan.\n\nDetail informasi rekening non tunai perusahaan yang akan dipercayakan kepada Anda adalah:\nNomor Rekening: 0471223432\nAtas Nama: Budhi Santoso Pranoto\nLembaga Keuangan: BCA (Bank Central Asia)\nNomor COA: 100-1-2-2\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 1, 'reknt', 'validasi_pj', 1, 1, 1, '2026-03-03 22:28:56', 1, '2026-03-04 03:54:03', NULL, NULL),
('NTF/13032026/1/00001', '2026-03-13 16:17:43', '3', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Salah Satu Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab salah satu akun kas perusahaan.\n\nDetail informasi akun kas perusahaan yang akan dipercayakan kepada Anda adalah:\nNama Akun Kas: Kas Paijem\nNomor COA: 100-1-1-3\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 5, 'akun_kas', 'validasi_pj', 1, 1, 1, '2026-03-13 16:17:43', 5, '2026-03-13 16:20:22', NULL, NULL),
('NTF/19032026/1/00001', '2026-03-19 22:15:04', 'TPV/19032026/1/00001', 'id_trx', 'Validasi', 'Anda Menarik Modal Investasi (Prive) Sejumlah Dari P.T. Mataram Kentjana Jaya', 'Anda menarik investasi modal (prive) dari P.T. Mataram Kentjana Jaya dengan detail informasi sebagai berikut:\r\nID Transaksi: TPV/19032026/1/00001\r\nWaktu Transaksi: 19/03/2026 16:15:04\r\nKode Anda: USR/16122025/00001\r\nNama Anda: Shofant Hedhiyanto\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 10.000.000,00\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Prive: Rp 10.000.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_prive', 'validasi_investor', 1, 1, 1, '2026-03-19 22:15:04', 4, '2026-03-19 22:16:13', NULL, NULL),
('NTF/19032026/1/00002', '2026-03-19 22:15:04', 'TPV/19032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Penarikan Modal (Prive) Investasi Kepada Investor', 'Telah terjadi transaksi penarikan modal (prive), dimana seorang investor telah menarik modal investasinya (prive) dan akun kas di dalam tanggung jawab dan wewenang Anda yang mencairkan uangnya.\r\n\r\nDetail informasi:\r\nID Transaksi: TPV/19032026/1/00001\r\nWaktu Transaksi: 19/03/2026 16:15:04\r\nNama Akun Kas: Kas Owner\r\nTotal Nominal: Rp 10.000.000,00\r\nNominal Kas: Rp 10.000.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_prive', 'validasi_akun_kas', 1, 1, 1, '2026-03-19 22:15:04', 4, '2026-03-19 22:16:34', NULL, NULL),
('NTF/19122025/1/00001', '2025-12-19 09:15:04', '1', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab akun kas perusahaan.\n\nDetail informasi akun kas perusahaan yang akan dipercayakan kepada Anda adalah:\nNama Akun Kas: Kas Maha Dewa\nNomor COA: 100-1-1-1\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 4, 'akun_kas', 'validasi_pj', 0, 0, 1, '2025-12-19 09:15:04', 1, '2026-03-02 21:30:01', 1, '2025-12-19 09:15:41'),
('NTF/19122025/1/00002', '2025-12-19 09:15:04', '1', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Yang Baru Atas Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab yang baru atas akun kas perusahaan.\n\nDetail informasi akun kas perusahaan yang akan dipercayakan kepada Anda adalah:\nNama Akun Kas: Kas Maha Dewa\nNomor COA: 100-1-1-1\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 1, 'akun_kas', 'validasi_pj', 1, 1, 1, '2025-12-19 09:15:41', 1, '2026-03-02 21:30:01', NULL, NULL),
('NTF/19122025/1/00003', '2025-12-19 09:15:04', '1', 'id', 'Informasi', 'Tanggung Jawab Dan Wewenang Anda Atas Akun Kas Perusahaan Telah Dialihkan Kepada Orang Lain', 'Tanggung jawab dan wewenang Anda atas akun kas perusahaan telah dicabut.\r\n\r\nNama Akun Kas: Kas Maha Dewa\r\nNomor COA: 100-1-1-1\r\n\r\nDemikian informasi yang kami sampaikan kepada Anda.\r\n\r\nUntuk hal lain, silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nTerima kasih.\r\n\r\nHormat Kami,\r\nSistem Aplikasi Manajemen.', 'User', 4, 'akun_kas', 'validasi_pj', 0, 1, 1, '2025-12-19 09:15:41', NULL, NULL, NULL, NULL),
('NTF/19122025/1/00004', '2025-12-19 09:49:44', '2', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Akun Kas Perusahaan', 'Anda ditunjuk sebagai penanggung jawab akun kas perusahaan.\n\nDetail informasi akun kas perusahaan yang akan dipercayakan kepada Anda adalah:\nNama Akun Kas: Kas Owner\nNomor COA: 100-1-1-2\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 4, 'akun_kas', 'validasi_pj', 1, 1, 1, '2025-12-19 09:49:44', 4, '2026-03-02 21:30:01', NULL, NULL),
('NTF/19122025/1/00005', '2025-12-19 10:03:29', '1', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Salah Satu Rekening Non Tunai Perusahaan', 'Anda ditunjuk sebagai penanggung jawab salah satu rekening non tunai perusahaan.\r\n\r\nDetail informasi rekening non tunai perusahaan yang akan dipercayakan kepada Anda adalah:\r\nNomor Rekening: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNomor COA: 100-1-2-1\r\n\r\nSilahkan Anda terima atau Anda tolak.\r\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 'User', 4, 'reknt', 'validasi_pj', 1, 1, 4, '2025-12-19 10:03:29', 4, '2026-03-02 21:30:01', 4, '2025-12-19 10:43:03'),
('NTF/19122025/1/00007', '2025-12-19 10:03:29', '1', 'id', 'Informasi', 'Tanggung Jawab Dan Wewenang Anda Atas Salah Satu Rekening Non Tunai Perusahaan Telah Dialihkan Kepada Orang Lain', 'Tanggung jawab dan wewenang Anda atas salah satu rekening non tunai perusahaan telah dialihkan kepada penanggung jawab yang baru.\r\n\r\nDetail informasi rekening non tunai perusahaan telah dialihkan adalah:\r\nNomor Rekening: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNomor COA: 100-1-2-1\r\n\r\nDemikian informasi yang kami sampaikan kepada Anda.\r\n\r\nUntuk hal lain, silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nTerima kasih.\r\n\r\nHormat Kami,\r\nSistem Aplikasi Manajemen.', 'User', 4, 'reknt', 'validasi_pj', 0, 1, 1, '2025-12-19 10:43:03', NULL, NULL, NULL, NULL),
('NTF/19122025/1/00008', '2025-12-19 10:03:29', '1', 'id', 'Validasi', 'Anda Ditunjuk Sebagai Penanggung Jawab Yang Baru Atas Peralihan Dari Penanggung Jawab Lama Dari Salah Satu Rekening Non Tunai Perusahaan', 'Anda ditunjuk sebagai penanggung jawab yang baru atas peralihan dari penanggung jawab yang lama dari salah satu rekening non tunai perusahaan.\n\nDetail informasi rekening non tunai perusahaan yang dialihkan dan akan dipercayakan kepada Anda adalah:\nNomor Rekening: 9933957125\nAtas Nama: Shofant Hedhiyanto\nLembaga Keuangan: Bank Permata\nNomor COA: 100-1-2-1\n\nSilahkan Anda terima atau Anda tolak.\nJika Anda menolak maka Anda berharap dipecat.🤣🤣🤣\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 4, 'reknt', 'validasi_pj', 1, 1, 1, '2025-12-19 10:46:02', 4, '2026-03-02 21:30:01', NULL, NULL),
('NTF/19122025/1/00009', '2025-12-19 10:03:29', '1', 'id', 'Informasi', 'Tanggung Jawab Dan Wewenang Anda Atas Salah Satu Rekening Non Tunai Perusahaan Telah Dialihkan Kepada Orang Lain', 'Tanggung jawab dan wewenang Anda atas salah satu rekening non tunai perusahaan telah dialihkan kepada penanggung jawab yang baru.\r\n\r\nDetail informasi rekening non tunai perusahaan telah dialihkan adalah:\r\nNomor Rekening: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNomor COA: 100-1-2-1\r\n\r\nDemikian informasi yang kami sampaikan kepada Anda.\r\n\r\nUntuk hal lain, silahkan ditanyakan kepada manajemen/atasan Anda.\r\n\r\nTerima kasih.\r\n\r\nHormat Kami,\r\nSistem Aplikasi Manajemen.', 'User', 1, 'reknt', 'validasi_pj', 1, 1, 1, '2025-12-19 10:46:02', 1, '2026-03-04 04:47:15', 1, '2026-03-04 04:47:15'),
('NTF/19122025/1/00010', '2025-12-19 10:03:29', '1', 'id', 'Informasi', 'Rekening Non Tunai Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Dinonaktifkan', 'Rekening non tunai yang berada di dalam wewenang dan tanggung jawab Anda telah dinonaktifkan sehingga untuk sementara tidak dapat digunakan untuk melakukan transaksi sampai batas waktu yang tidak dapat ditentukan.\n\nDetail informasi rekening non tunai yang dinonaktifkan:\nNomor Rekening: 9933957125\nAtas Nama: Shofant Hedhiyanto\nLembaga Keuangan: Bank Permata\nNomor COA: 100-1-2-1\n\nAnda masih dapat mengaktifkan rekening non tunai Anda setelah manajemen/atasan Anda menyetujui.\n\nUntuk sebab dari hal ini silahkan ditanyakan kepada manajemen/atasan Anda.\n\nHormat kami,\nSistem Aplikasi Manajemen.', 'User', 4, 'akun_kas', 'validasi_pj', 0, 1, 1, '2025-12-19 10:48:24', NULL, NULL, NULL, NULL),
('NTF/19122025/1/00011', '2025-12-19 10:03:29', '1', 'id', 'Informasi', 'Rekening Non Tunai Yang Berada Dalam Tanggung Jawab dan Wewenang Anda Telah Diaktifkan Kembali', 'Rekening non tunai yang berada di dalam wewenang dan tanggung jawab Anda telah diaktifkan kembali dan sudah bisa digunakan kembali untuk melakukan transaksi.\r\n\r\nDetail informasi rekening non tunai yang diaktifkan kembali:\r\nNomor Rekening: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNomor COA: 100-1-2-1\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen.', 'User', 4, 'akun_kas', 'validasi_pj', 0, 1, 1, '2025-12-19 10:48:45', NULL, NULL, NULL, NULL),
('NTF/22032026/1/00001', '2026-03-22 18:01:24', 'DSP/22032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Deposit ke Supplier', 'Telah terjadi transaksi deposit ke supplier, dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: DSP/22032026/1/00001\r\nWaktu Transaksi: 22/03/2026 12:01:24\r\nNama Akun Kas: Kas Owner\r\nTotal Nominal: Rp 11.000.000,00\r\nNominal Kas: Rp 11.000.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_deposit_supplier', 'validasi_akun_kas', 1, 1, 1, '2026-03-22 18:01:24', 4, '2026-03-23 13:00:46', NULL, NULL),
('NTF/23032026/1/00001', '2026-03-23 15:33:49', 'WDDS/23032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Penarikan Deposit Supplier', 'Telah terjadi transaksi penarikan deposit dari supplier dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: WDDS/23032026/1/00001\r\nWaktu Transaksi: 23/03/2026 09:33:49\r\n\r\nKode Supplier: USR/08032026/00001\r\nNama Supplier: Dalban\r\nJenis Supplier: Individu\r\nJenis Badan Usaha Supplier: \r\nNama Badan Usaha Supplier: \r\n\r\nNama Akun Kas: Kas Owner\r\nTotal Nominal: Rp 1.000.000,00\r\nNominal Kas: Rp 1.000.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_wd_deposit_supplier', 'validasi_akun_kas', 1, 1, 1, '2026-03-23 15:33:49', 4, '2026-03-23 15:34:42', NULL, NULL),
('NTF/23032026/1/00002', '2026-03-23 18:47:21', 'WDDS/23032026/1/00002', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Penarikan Deposit Supplier', 'Telah terjadi transaksi penarikan deposit dari supplier dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: WDDS/23032026/1/00002\r\nWaktu Transaksi: 23/03/2026 12:47:21\r\n\r\nKode Supplier: USR/08032026/00001\r\nNama Supplier: Dalban\r\nJenis Supplier: Individu\r\nJenis Badan Usaha Supplier: \r\nNama Badan Usaha Supplier: \r\n\r\nNama Akun Kas: Kas Owner\r\nTotal Nominal: Rp 500.000,00\r\nNominal Kas: Rp 500.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_wd_deposit_supplier', 'validasi_akun_kas', 1, 1, 1, '2026-03-23 18:47:21', 4, '2026-03-23 18:51:56', NULL, NULL),
('NTF/24032026/1/00001', '2026-03-24 14:55:09', 'DPL/24032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Deposit Pelanggan', 'Telah terjadi transaksi deposit dari pelanggan dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: DPL/24032026/1/00001\r\nWaktu Transaksi: 24/03/2026 08:54:44\r\nTotal Nominal: Rp 33.525.000,00\r\n\r\nKode Pelanggan: USR/08032026/00002\r\nNama Pelanggan: Kuro\r\nJenis Pelanggan: Individu\r\nJenis Badan Usaha Pelanggan: \r\nNama Badan Usaha Pelanggan: \r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 33.525.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_deposit_pelanggan', 'validasi_akun_kas', 0, 0, 1, '2026-03-24 14:55:09', NULL, '2026-03-24 15:18:06', 1, '2026-03-24 09:18:06'),
('NTF/24032026/1/00002', '2026-03-24 15:15:18', 'DPL/24032026/1/00002', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Deposit Pelanggan', 'Telah terjadi transaksi deposit dari pelanggan dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: DPL/24032026/1/00002\r\nWaktu Transaksi: 24/03/2026 09:15:18\r\nTotal Nominal: Rp 54.300.000,00\r\n\r\nKode Pelanggan: USR/08032026/00002\r\nNama Pelanggan: Kuro\r\nJenis Pelanggan: Individu\r\nJenis Badan Usaha Pelanggan: \r\nNama Badan Usaha Pelanggan: \r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 54.300.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_deposit_pelanggan', 'validasi_akun_kas', 1, 1, 1, '2026-03-24 15:15:18', 4, '2026-03-25 15:44:41', NULL, NULL),
('NTF/24032026/1/00003', '2026-03-24 18:15:10', 'DPL/24032026/1/00003', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Karena Deposit Pelanggan', 'Telah terjadi transaksi deposit dari pelanggan dimana akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: DPL/24032026/1/00003\r\nWaktu Transaksi: 24/03/2026 12:15:10\r\nTotal Nominal: Rp 17.170.000,00\r\n\r\nKode Pelanggan: USR/08032026/00002\r\nNama Pelanggan: Kuro\r\nJenis Pelanggan: Individu\r\nJenis Badan Usaha Pelanggan: \r\nNama Badan Usaha Pelanggan: \r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 17.170.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_deposit_pelanggan', 'validasi_akun_kas', 1, 1, 1, '2026-03-24 18:15:10', 4, '2026-03-28 23:21:51', NULL, NULL),
('NTF/24122025/1/00001', '2025-12-24 05:59:39', 'TIM/23122025/1/00001', 'id_trx', 'Validasi', 'Anda Menginvestasikan Sejumlah Modal ke P.T. Mataram Kentjana Sakti', 'Anda menginvestasikan sejumlah modal ke P.T. Mataram Kentjana Sakti dengan detail informasi sebagai berikut:\r\nID Transaksi: TIM/23122025/1/00001\r\nWaktu Transaksi: 23/12/2025 18:16:27\r\nNama Anda: Shofant Hedhiyanto\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenerima Uang Tunai: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 73.350.000,00\r\n\r\nTransaksi menggunakan rekening non tunai:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Investasi: Rp 73.350.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_input_modal', 'validasi_investor', 1, 1, 1, '2025-12-24 05:59:39', 4, '2026-03-02 21:30:01', NULL, NULL),
('NTF/24122025/1/00002', '2025-12-24 05:59:39', 'TIM/23122025/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Investasi Dari Investor', 'Telah terjadi transaksi tambah modal, dimana seorang investor telah melakukan investasi dan akun kas di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: TIM/23122025/1/00001\r\nWaktu Transaksi: 23/12/2025 18:16:27\r\nNama Akun Kas: Kas Owner\r\nTotal Nominal: Rp 73.350.000,00\r\nNominal Kas: Rp 73.350.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_input_modal', 'validasi_akun_kas', 1, 1, 1, '2025-12-24 05:59:39', 4, '2026-03-28 23:24:04', NULL, NULL),
('NTF/25032026/1/00001', '2026-03-25 16:56:17', 'WDDPL/25032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Pengembalian Deposit ke Pelanggan', 'Telah terjadi transaksi pengembalian deposit ke pelanggan, dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: WDDPL/25032026/1/00001\r\nWaktu Transaksi: 25/03/2026 10:56:17\r\nTotal Nominal: Rp 100.000,00\r\n\r\nKode Pelanggan: USR/08032026/00002\r\nJenis Pelanggan: Individu\r\nJenis Badan Usaha Pelanggan: \r\nNama Badan Usaha Pelanggan: \r\nNama Pelanggan: Kuro\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 100.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_wd_deposit_pelanggan', 'validasi_akun_kas', 1, 1, 1, '2026-03-25 16:56:17', 1, '2026-03-25 16:56:44', NULL, NULL),
('NTF/25032026/1/00002', '2026-03-25 20:08:05', 'WDDPL/25032026/1/00002', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Pengembalian Deposit ke Pelanggan', 'Telah terjadi transaksi pengembalian deposit ke pelanggan, dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: WDDPL/25032026/1/00002\r\nWaktu Transaksi: 25/03/2026 14:08:05\r\nTotal Nominal: Rp 125.000,00\r\n\r\nKode Pelanggan: USR/08032026/00002\r\nJenis Pelanggan: Individu\r\nJenis Badan Usaha Pelanggan: \r\nNama Badan Usaha Pelanggan: \r\nNama Pelanggan: Kuro\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 125.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_wd_deposit_pelanggan', 'validasi_akun_kas', 1, 1, 1, '2026-03-25 20:08:05', 4, '2026-03-28 23:25:25', NULL, NULL),
('NTF/26032026/1/00001', '2026-03-26 21:50:56', 'KBM/26032026/1/00001', 'id_trx', 'Validasi', 'Anda Menerima Kasbon Dari P.T. Mataram Kentjana Jaya', 'Anda menerima kasbon dari P.T. Mataram Kentjana Jaya dengan informasi sebagai berikut:\r\n\r\nID Transaksi: KBM/26032026/1/00001\r\nWaktu Transaksi: 26/03/2026 15:49:15\r\nKode Anda: USR/31122025/00001\r\nNama Anda: Christina Indriyani\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 234.000,00\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Deposit: Rp 234.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 5, 'trx_kasbon_sdm', 'validasi_Sdm', 0, 0, 1, '2026-03-26 21:50:56', NULL, '2026-03-26 22:28:46', 1, '2026-03-26 16:28:46'),
('NTF/26032026/1/00002', '2026-03-26 21:50:56', 'KBM/26032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: KBM/26032026/1/00001\r\nWaktu Transaksi: 26/03/2026 15:49:15\r\nTotal Nominal: Rp 234.000,00\r\n\r\nKode Supplier: USR/31122025/00001\r\nNama Supplier: Christina Indriyani\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 234.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_kasbon_sdm', 'validasi_akun_kas', 0, 0, 1, '2026-03-26 21:50:56', NULL, '2026-03-26 22:28:46', 1, '2026-03-26 16:28:46'),
('NTF/26032026/1/00003', '2026-03-26 22:27:32', 'KBM/26032026/1/00002', 'id_trx', 'Validasi', 'Anda Menerima Kasbon Dari P.T. Mataram Kentjana Jaya', 'Anda menerima kasbon dari P.T. Mataram Kentjana Jaya dengan informasi sebagai berikut:\r\n\r\nID Transaksi: KBM/26032026/1/00002\r\nWaktu Transaksi: 26/03/2026 16:27:32\r\nKode Anda: USR/07032026/00001\r\nNama Anda: Sudrun\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 432.000,00\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Deposit: Rp 432.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 6, 'trx_kasbon_sdm', 'validasi_Sdm', 0, 0, 1, '2026-03-26 22:27:32', NULL, '2026-03-27 18:14:19', 1, '2026-03-27 12:14:19'),
('NTF/26032026/1/00004', '2026-03-26 22:27:32', 'KBM/26032026/1/00002', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: KBM/26032026/1/00002\r\nWaktu Transaksi: 26/03/2026 16:27:32\r\nTotal Nominal: Rp 432.000,00\r\n\r\nKode Supplier: USR/07032026/00001\r\nNama Supplier: Sudrun\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 432.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_kasbon_sdm', 'validasi_akun_kas', 0, 0, 1, '2026-03-26 22:27:32', NULL, '2026-03-27 18:14:19', 1, '2026-03-27 12:14:19'),
('NTF/27032026/1/00001', '2026-03-27 20:24:36', 'KBM/27032026/1/00001', 'id_trx', 'Validasi', 'Anda Menerima Kasbon Dari P.T. Mataram Kentjana Jaya', 'Anda menerima kasbon dari P.T. Mataram Kentjana Jaya dengan informasi sebagai berikut:\r\n\r\nID Transaksi: KBM/27032026/1/00001\r\nWaktu Transaksi: 27/03/2026 14:24:36\r\nKode Anda: USR/31122025/00001\r\nNama Anda: Christina Indriyani\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 525.000,00\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Deposit: Rp 525.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 5, 'trx_kasbon_sdm', 'validasi_Sdm', 1, 1, 1, '2026-03-27 20:24:36', 5, '2026-03-27 23:29:59', NULL, NULL),
('NTF/27032026/1/00002', '2026-03-27 20:24:36', 'KBM/27032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: KBM/27032026/1/00001\r\nWaktu Transaksi: 27/03/2026 14:24:36\r\nTotal Nominal: Rp 525.000,00\r\n\r\nKode Supplier: USR/31122025/00001\r\nNama Supplier: Christina Indriyani\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 525.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_kasbon_sdm', 'validasi_akun_kas', 1, 1, 1, '2026-03-27 20:24:36', 4, '2026-03-27 23:30:31', NULL, NULL),
('NTF/27032026/1/00005', '2026-03-27 23:46:36', 'KBM/27032026/1/00002', 'id_trx', 'Validasi', 'Anda Menerima Kasbon Dari P.T. Mataram Kentjana Jaya', 'Anda menerima kasbon dari P.T. Mataram Kentjana Jaya dengan informasi sebagai berikut:\r\n\r\nID Transaksi: KBM/27032026/1/00002\r\nWaktu Transaksi: 27/03/2026 17:46:36\r\nKode Anda: USR/31122025/00001\r\nNama Anda: Christina Indriyani\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 660.000,00\r\n\r\nTransaksi dari rekening non tunai perusahaan:\r\nRekening Asal: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nKepada rekening non tunai Anda:\r\nRekening Tujuan: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Deposit: Rp 660.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 5, 'trx_kasbon_sdm', 'validasi_Sdm', 1, 1, 1, '2026-03-27 23:46:36', 5, '2026-03-27 23:48:47', NULL, NULL),
('NTF/27032026/1/00006', '2026-03-27 23:46:36', 'KBM/27032026/1/00002', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Mengeluarkan Sejumlah Uang Untuk Transaksi Kasbon', 'Telah terjadi transaksi kasbon untuk anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: KBM/27032026/1/00002\r\nWaktu Transaksi: 27/03/2026 17:46:36\r\nTotal Nominal: Rp 660.000,00\r\n\r\nKode Supplier: USR/31122025/00001\r\nNama Supplier: Christina Indriyani\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 660.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_kasbon_sdm', 'validasi_akun_kas', 1, 1, 1, '2026-03-27 23:46:36', 4, '2026-03-27 23:48:57', NULL, NULL),
('NTF/28032026/1/00001', '2026-03-28 23:29:19', 'BKBM/28032026/1/00001', 'id_trx', 'Validasi', 'Anda Membayar Kasbon Kepada P.T. Mataram Kentjana Jaya', 'Anda telah membayar kasbon dari P.T. Mataram Kentjana Jaya dengan informasi sebagai berikut:\r\n\r\nID Transaksi: BKBM/28032026/1/00001\r\nWaktu Transaksi: 28/03/2026 17:29:19\r\nKode Anda: USR/31122025/00001\r\nNama Anda: Christina Indriyani\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: Shofant Hedhiyanto\r\nNominal Uang Tunai: Rp 90.000,00\r\n\r\nTransaksi ke rekening non tunai perusahaan:\r\nNomor Rekening: -\r\nAtas Nama: -\r\nLembaga Keuangan: -\r\n\r\nNominal Transfer: Rp 0,00\r\n\r\nTotal Pembayaran Kasbon: Rp 90.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 5, 'trx_bayar_kasbon_sdm', 'validasi_sdm', 1, 1, 1, '2026-03-28 23:29:19', 5, '2026-03-28 23:30:22', NULL, NULL),
('NTF/28032026/1/00002', '2026-03-28 23:29:19', 'BKBM/28032026/1/00001', 'id_trx', 'Validasi', 'Akun Kas Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Dari Pembayaran Transaksi Kasbon', 'Telah terjadi transaksi pembayaran kasbon dari anggota manajemen dimana akun kas di dalam tanggung jawab dan wewenang Anda terlibat di dalamnya.\r\n\r\nDetail informasi:\r\nID Transaksi: BKBM/28032026/1/00001\r\nWaktu Transaksi: 28/03/2026 17:29:19\r\nTotal Nominal: Rp 90.000,00\r\n\r\nKode Supplier: USR/31122025/00001\r\nNama Supplier: Christina Indriyani\r\n\r\nNama Akun Kas: Kas Owner\r\nNominal Kas: Rp 90.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_bayar_kasbon_sdm', 'validasi_akun_kas', 1, 1, 1, '2026-03-28 23:29:19', 4, '2026-03-28 23:30:43', NULL, NULL),
('NTF/29032026/1/00001', '2026-03-29 02:12:41', 'TAK/29032026/1/00001', 'id_trx', 'Validasi', 'Transaksi Antar Kas Baru', 'Akun kas di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai akun kas pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: TAK/29032026/1/00001\r\nWaktu Trx: 29/03/2026 02:12:41\r\nNominal: Rp 10.000,00\r\n\r\nAKUN KAS PEMBERI (PENGIRIM):\r\nID Akun Kas: 2\r\nNama Akun Kas: Kas Owner\r\nKode Penanggung Jawab: USR/16122025/00001\r\nNama Penanggung Jawab: Shofant Hedhiyanto\r\nNomor CoA: 100-1-1-2\r\nNama CoA: Kas Owner\r\n\r\nAKUN KAS PENERIMA:\r\nID Akun Kas: 1\r\nNama Akun Kas: Kas Maha Dewa\r\nKode Penanggung Jawab: USR/06051980/00001\r\nNama Penanggung Jawab: Budhi Santoso Pranoto\r\nNomor CoA: 100-1-1-1\r\nNama CoA: Kas Maha Dewa\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 'User', 4, 'trx_antar_kas', 'vpj_ak_awal', 1, 1, 1, '2026-03-29 02:12:41', 4, '2026-03-29 02:16:30', NULL, NULL),
('NTF/29032026/1/00002', '2026-03-29 16:12:21', 'TAK/29032026/1/00002', 'id_trx', 'Validasi', 'Transaksi Antar Kas Baru', 'Akun kas di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai akun kas pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: TAK/29032026/1/00002\r\nWaktu Trx: 29/03/2026 11:12:21\r\nNominal: Rp 1.230.000,00\r\n\r\nAKUN KAS PEMBERI (PENGIRIM):\r\nID Akun Kas: 2\r\nNama Akun Kas: Kas Owner\r\nKode Penanggung Jawab: USR/16122025/00001\r\nNama Penanggung Jawab: Shofant Hedhiyanto\r\nNomor CoA: 100-1-1-2\r\nNama CoA: Kas Owner\r\n\r\nAKUN KAS PENERIMA:\r\nID Akun Kas: 1\r\nNama Akun Kas: Kas Maha Dewa\r\nKode Penanggung Jawab: USR/06051980/00001\r\nNama Penanggung Jawab: Budhi Santoso Pranoto\r\nNomor CoA: 100-1-1-1\r\nNama CoA: Kas Maha Dewa\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 'User', 4, 'trx_antar_kas', 'vpj_ak_awal', 0, 0, 1, '2026-03-29 16:12:21', NULL, '2026-03-29 16:15:18', 1, '2026-03-29 11:15:18'),
('NTF/30032026/1/00001', '2026-03-30 21:04:56', 'TAK/30032026/1/00001', 'id_trx', 'Validasi', 'Transaksi Antar Kas Baru', 'Akun kas di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai akun kas pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: TAK/30032026/1/00001\r\nWaktu Trx: 30/03/2026 16:04:56\r\nNominal: Rp 135.000,00\r\n\r\nAKUN KAS PEMBERI (PENGIRIM):\r\nID Akun Kas: 2\r\nNama Akun Kas: Kas Owner\r\nKode Penanggung Jawab: USR/16122025/00001\r\nNama Penanggung Jawab: Shofant Hedhiyanto\r\nNomor CoA: 100-1-1-2\r\nNama CoA: Kas Owner\r\n\r\nAKUN KAS PENERIMA:\r\nID Akun Kas: 1\r\nNama Akun Kas: Kas Maha Dewa\r\nKode Penanggung Jawab: USR/06051980/00001\r\nNama Penanggung Jawab: Budhi Santoso Pranoto\r\nNomor CoA: 100-1-1-1\r\nNama CoA: Kas Maha Dewa\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 'User', 4, 'trx_antar_kas', 'vpj_ak_awal', 0, 0, 1, '2026-03-30 21:04:56', NULL, '2026-03-30 21:08:13', 1, '2026-03-30 16:08:13'),
('NTF/31032026/1/00001', '2026-03-31 16:03:52', 'TIM/31032026/1/00001', 'id_trx', 'Validasi', 'Anda Menginvestasikan Sejumlah Modal ke P.T. Mataram Kentjana Jaya', 'Anda menginvestasikan sejumlah modal ke P.T. Mataram Kentjana Jaya dengan detail informasi sebagai berikut:\r\nID Transaksi: TIM/31032026/1/00001\r\nWaktu Transaksi: 31/03/2026 11:03:52\r\n\r\nKode Anda: USR/16122025/00001\r\nNama Anda: Shofant Hedhiyanto\r\n\r\nTransaksi menggunakan uang tunai:\r\nPenanggung Jawab Akun Kas: -\r\nNominal Uang Tunai: Rp 0,00\r\n\r\nTransaksi menggunakan rekening non tunai:\r\nRekening Tujuan: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNominal Non Tunai: Rp 83.600.000,00\r\n\r\nTotal Investasi: Rp 83.600.000,00\r\n\r\nSilahkan dikonfirmasi apakah benar atau tidak?\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_input_modal', 'validasi_investor', 1, 1, 1, '2026-03-31 16:03:52', 4, '2026-03-31 16:04:47', NULL, NULL),
('NTF/31032026/1/00002', '2026-03-31 16:03:52', 'TIM/31032026/1/00001', 'id_trx', 'Validasi', 'Rekening Non Tunai Dalam Wewenang dan Tanggung Jawab Anda Menerima Sejumlah Uang Investasi Dari Investor', 'Telah terjadi transaksi tambah modal, dimana seorang investor telah melakukan investasi dan rekening non tunai di dalam tanggung jawab dan wewenang Anda adalah penerimanya.\r\n\r\nDetail informasi:\r\nID Transaksi: TIM/31032026/1/00001\r\nWaktu Transaksi: 31/03/2026 11:03:52\r\nTotal Nominal: Rp 83.600.000,00\r\n\r\nKode Investor: USR/16122025/00001\r\nNama Investor: Shofant Hedhiyanto\r\n\r\nNomor Rekening: 9933957125\r\nAtas Nama: Shofant Hedhiyanto\r\nLembaga Keuangan: Bank Permata\r\nNominal Non Tunai: Rp 83.600.000,00\r\n\r\nSilahkan dikonfirmasi kebenarannya.\r\n\r\nHormat kami,\r\nSistem Aplikasi Manajemen', 'User', 4, 'trx_input_modal', 'validasi_reknt', 1, 1, 1, '2026-03-31 16:03:52', 4, '2026-03-31 16:05:04', NULL, NULL),
('NTF/31032026/1/00003', '2026-03-31 16:17:57', 'TAR/31032026/1/00001', 'id_trx', 'Validasi', 'Transaksi Antar Rekening Non Tunai Baru', 'Rekening non tunai di dalam wewenang dan tanggung jawab Anda ditransaksikan sebagai rekening non tunai pemberi (pengirim) dengan detail infromasi sebagai berikut;\r\n\r\nID Trx: TAR/31032026/1/00001\r\nWaktu Trx: 31/03/2026 11:17:57\r\nNominal: Rp 17.000,00\r\n\r\nREKENING NON TUNAI PEMBERI (PENGIRIM):\r\nID Rekening Non Tunai: 1\r\nNomor Rekening: 9933957125\r\nAtas Nama Rekening: Shofant Hedhiyanto\r\nNama Lembaga Keuangan: Bank Permata\r\nKode Penanggung Jawab Rekening: USR/16122025/00001\r\nNama Penanggung Jawab Rekening: Shofant Hedhiyanto\r\nNomor CoA: 100-1-2-1\r\nNama CoA: Bank Permata [9933957125]\r\n\r\nREKENING NON TUNAI PENERIMA:\r\nID Rekening Non Tunai: 2\r\nNomor Rekening: 0471223432\r\nAtas Nama Rekening: Budhi Santoso Pranoto\r\nNama Lembaga Keuangan: BCA (Bank Central Asia)\r\nKode Penanggung Jawab Rekening: USR/06051980/00001\r\nNama Penanggung Jawab Rekening: Budhi Santoso Pranoto\r\nNomor CoA: 100-1-2-2\r\nNama CoA: BCA (Bank Central Asia) [0471223432]\r\n\r\nApakah informasi ini benar?\r\nSegera dikonfirmasi benar atau tidak.', 'User', 4, 'trx_antar_reknt', 'vpj_reknt_awal', 0, 0, 1, '2026-03-31 16:17:57', NULL, NULL, NULL, NULL);

--
-- Trigger `trx_notifikasi`
--
DELIMITER $$
CREATE TRIGGER `trx_notifikasi_au1` AFTER UPDATE ON `trx_notifikasi` FOR EACH ROW begin
  if (new.status_selesai != old.status_selesai)
  then
    if (old.nama_tabel = 'akun_kas')
    then
      if (new.status_selesai = 0) or (new.status_selesai = 2)
      then
        set @akunKasAktif = 0;
      elseif (new.status_selesai = 1)
      then
        set @akunKasAktif = 1;
      end if;

      update
        akun_kas
      set
        validasi_pj = new.status_selesai,
        aktif = @akunKasAktif,
        updated_by = new.updated_by
      where
        id = old.sumber_id_trx;
    elseif (old.nama_tabel = 'reknt')
    then
      if (new.status_selesai = 0) or (new.status_selesai = 2)
      then
        set @rekntAktif = 0;
      elseif (new.status_selesai = 1)
      then
        set @rekntAktif = 1;
      end if;

      update
        reknt
      set
        validasi_pj = new.status_selesai,
        aktif = @rekntAktif,
        updated_by = new.updated_by
      where
        id = old.sumber_id_trx;
    elseif (old.nama_tabel = 'trx_input_modal')
    then
      if (old.nama_kolom = 'validasi_investor')
      then
        update
          trx_input_modal
        set
          validasi_investor = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_input_modal
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_input_modal
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_prive')
    then
      if (old.nama_kolom = 'validasi_investor')
      then
        update
          trx_prive
        set
          validasi_investor = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_prive
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_prive
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_deposit_supplier')
    then
      if (old.nama_kolom = 'validasi_supplier')
      then
        update
          trx_deposit_supplier
        set
          validasi_supplier = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_deposit_supplier
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_deposit_supplier
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_wd_deposit_supplier')
    then
      if (old.nama_kolom = 'validasi_supplier')
      then
        update
          trx_wd_deposit_supplier
        set
          validasi_supplier = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_wd_deposit_supplier
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_wd_deposit_supplier
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_deposit_pelanggan')
    then
      if (old.nama_kolom = 'validasi_pelanggan')
      then
        update
          trx_deposit_pelanggan
        set
          validasi_pelanggan = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_deposit_pelanggan
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_deposit_pelanggan
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_wd_deposit_pelanggan')
    then
      if (old.nama_kolom = 'validasi_pelanggan')
      then
        update
          trx_wd_deposit_pelanggan
        set
          validasi_pelanggan = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_wd_deposit_pelanggan
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_wd_deposit_pelanggan
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_kasbon_sdm')
    then
      if (old.nama_kolom = 'validasi_sdm')
      then
        update
          trx_kasbon_sdm
        set
          validasi_sdm = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_kasbon_sdm
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_kasbon_sdm
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_bayar_kasbon_sdm')
    then
      if (old.nama_kolom = 'validasi_sdm')
      then
        update
          trx_bayar_kasbon_sdm
        set
          validasi_sdm = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_akun_kas')
      then
        update
          trx_bayar_kasbon_sdm
        set
          validasi_akun_kas = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'validasi_reknt')
      then
        update
          trx_bayar_kasbon_sdm
        set
          validasi_reknt = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_antar_kas')
    then
      if (old.nama_kolom = 'vpj_ak_awal')
      then
        update
          trx_antar_kas
        set
          vpj_ak_awal = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'vpj_ak_akhir')
      then
        update
          trx_antar_kas
        set
          vpj_ak_akhir = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    elseif (old.nama_tabel = 'trx_antar_reknt')
    then
      if (old.nama_kolom = 'vpj_reknt_awal')
      then
        update
          trx_antar_reknt
        set
          vpj_reknt_awal = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      elseif (old.nama_kolom = 'vpj_reknt_akhir')
      then
        update
          trx_antar_reknt
        set
          vpj_reknt_akhir = new.status_selesai,
          updated_by = new.updated_by,
          updated_at = new.updated_at
        where
          id_trx = old.sumber_id_trx;
      end if;
    # 
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_notifikasi_bi1` BEFORE INSERT ON `trx_notifikasi` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      3,
      new.created_at,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_notifikasi_bi2` BEFORE INSERT ON `trx_notifikasi` FOR EACH ROW begin
  if (new.jenis_notifikasi = 'Validasi')
  then
  	set new.status_selesai = 0;
  elseif (new.jenis_notifikasi = 'Informasi')
  then
  	set new.status_selesai = 1;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_prive`
--

CREATE TABLE `trx_prive` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_investor` bigint(20) UNSIGNED NOT NULL,
  `validasi_investor` tinyint(1) NOT NULL DEFAULT 0,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt_user` bigint(20) UNSIGNED DEFAULT NULL,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_prive`
--

INSERT INTO `trx_prive` (`id_trx`, `waktu_trx`, `id_investor`, `validasi_investor`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `id_reknt_user`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('TPV/19032026/1/00001', '2026-03-19 16:15:04', 4, 1, 2, 10000000, 1, NULL, 0, 0, NULL, 10000000, 'Aplikasi', 'Dokumen', 'trx_prive_TPV-19032026-1-00001.pdf', 1, 1, '2026-03-19 22:15:04', 4, '2026-03-19 22:16:34', NULL, NULL);

--
-- Trigger `trx_prive`
--
DELIMITER $$
CREATE TRIGGER `trx_prive_ai1` AFTER INSERT ON `trx_prive` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaPriveInvestor Varchar(100);
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;

  set nomorCoaPriveInvestor = (
    select
      nomor_coa_prive
    from
      users
    where
      id = new.id_investor
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_investor,
    2,
    nomorCoaPriveInvestor,
    new.total_nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjAkunKas,
      2,
      nomorCoaKas,
      0,
      new.nominal_kas,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaReknt,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      2,
      nomorCoaReknt,
      0,
      new.nominal_reknt,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_ai2` AFTER INSERT ON `trx_prive` FOR EACH ROW begin
  declare
    kodeInvestor,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare bentukPerusahaan Varchar(21);
  declare
    namaAkunKas,
    nomorReknt,
    nomorRekntUser Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaInvestor,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    atasNamaRekntUser,
    namaLk,
    namaLkRekntUser Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk,
    idLkRekntUser Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    nama
  into
    kodeInvestor,
    namaInvestor
  from
    users
  where
    id = new.id_investor;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;

    # ambil data reknt user
    select
      nomor_rekening,
      atas_nama,
      id_lk
    into
      nomorRekntUser,
      atasNamaRekntUser,
      idLkRekntUser
    from
      reknt_users
    where
      id = new.id_reknt_user;

    select
      nama
    into
      namaLkRekntUser
    from
      lembaga_keuangan
    where
      id = idLkRekntUser;
  end if;

  if (new.validasi_investor = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 14;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntInvestor}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntInvestor}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkInvestor}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_investor,
      'trx_prive',
      'validasi_investor',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 15;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntInvestor}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntInvestor}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkInvestor}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_prive',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 16;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeInvestor}}', kodeInvestor);
    set isiNotif = replace(isiNotif, '{{namaInvestor}}', namaInvestor);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntInvestor}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntInvestor}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkInvestor}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_prive',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_au1` AFTER UPDATE ON `trx_prive` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bd1` BEFORE DELETE ON `trx_prive` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bi1` BEFORE INSERT ON `trx_prive` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      5,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bi2` BEFORE INSERT ON `trx_prive` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    jumlahTrxInputModalPending,
    jumlahTrxPrivePending Integer(11) Unsigned;
  declare
    nomorCoaModal,
    nomorCoaPrive,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekInvestorAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetInvestasi,
    sumTrxKreditInvestasi,
    sumTransaksiInvestasiMasuk,
    sumTrxDebetPrive,
    sumTrxKreditPrive,
    sumTrxPriveKeluar,
    saldoInvestasi,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  select
    investor,
    nomor_coa_modal,
    nomor_coa_prive
  into
    cekInvestorAtauBukan,
    nomorCoaModal,
    nomorCoaPrive
  from
    users
  where
    id = new.id_investor;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekInvestorAtauBukan = 0)
  then
    set pesanError = concat(
      'User yang Anda input bukan investor, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekInvestorAtauBukan = 1)
  then
    # cek apakah ada transaksi pending?, jika ada gagalkan input
    set jumlahTrxInputModalPending = (
      select
        count(id_trx)
      from
        trx_input_modal
      where
        id_investor = new.id_investor
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    set jumlahTrxPrivePending = (
      select
        count(id_trx)
      from
        trx_prive
      where
        id_investor = new.id_investor
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (jumlahTrxInputModalPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi input modal mengambang yang belum ditentukan valid atau tidaknya terkait investor ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxPrivePending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi prive mengambang yang belum ditentukan valid atau tidaknya terkait investor ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      # cek saldo investasi dulu gaes
      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetInvestasi,
        sumTrxKreditInvestasi
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaModal
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumTransaksiInvestasiMasuk = sumTrxKreditInvestasi - sumTrxDebetInvestasi;

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetPrive,
        sumTrxKreditPrive
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaPrive
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumTrxPriveKeluar = sumTrxDebetPrive - sumTrxKreditPrive;

      set saldoInvestasi = sumTransaksiInvestasiMasuk - sumTrxPriveKeluar;

      if (saldoInvestasi < new.total_nominal)
      then
        set pesanError = concat(
          'Saldo investasi investor terkait adalah Rp ', format(saldoInvestasi, 2, 'id_ID'), '\n',
          'Total prive yang akan dilakukan adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Transaksi ditolak.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.created_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into 
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.id_reknt_user is null)
            then
              set pesanError = concat(
                'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
                'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.created_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          if (new.created_by = new.id_investor)
          then
            set new.validasi_investor = 1;
          elseif (new.created_by != new.id_investor)
          then
            set new.validasi_investor = 0;
          end if;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bi3` BEFORE INSERT ON `trx_prive` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_investor = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_investor = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bu1` BEFORE UPDATE ON `trx_prive` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    nomorCoaModal,
    nomorCoaPrive,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekInvestorAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetInvestasi,
    sumTrxKreditInvestasi,
    sumTransaksiInvestasiMasuk,
    sumTrxDebetPrive,
    sumTrxKreditPrive,
    sumTrxPriveKeluar,
    saldoInvestasi,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  select
    investor,
    nomor_coa_modal,
    nomor_coa_prive
  into
    cekInvestorAtauBukan,
    nomorCoaModal,
    nomorCoaPrive
  from
    users
  where
    id = new.id_investor;

  if
    (
      (not (new.id_investor <=> old.id_investor)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.id_reknt_user <=> old.id_reknt_user)) or
      (not (new.total_nominal <=> old.total_nominal))
    )
  then
    if (cekInvestorAtauBukan = 0)
    then
      set pesanError = concat(
        'User yang Anda input bukan investor, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekInvestorAtauBukan = 1)
    then
      # cek saldo investasi dulu gaes
      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetInvestasi,
        sumTrxKreditInvestasi
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaModal
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumTransaksiInvestasiMasuk = sumTrxKreditInvestasi - sumTrxDebetInvestasi;

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetPrive,
        sumTrxKreditPrive
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaPrive
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumTrxPriveKeluar = sumTrxDebetPrive - sumTrxKreditPrive;

      set saldoInvestasi = sumTransaksiInvestasiMasuk - sumTrxPriveKeluar;

      if (saldoInvestasi < new.total_nominal)
      then
        set pesanError = concat(
          'Saldo investasi investor terkait adalah Rp ', format(saldoInvestasi, 2, 'id_ID'), '\n',
          'Total prive yang akan dilakukan adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Transaksi ditolak.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan diambil adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Input nominal kas yang akan diambil adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Saldo kas akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.id_reknt_user is null)
            then
              set pesanError = concat(
                'Anda menggunakan rekening non tunai, tetapi Anda tidak menginput rekening non tunai milik user sebagai tujuan.',
                'Silahakan input rekening non tunai user sebagai tujuan terlebih dahulu.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan diambil adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Input nominal rekening non tunai yang akan diambil adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Saldo rekening non tunai akan minus jika transaksi dilanjutkan, maka dengan hal tersebut transaksi ditolak.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          if (new.updated_by = new.id_investor)
          then
            set new.validasi_investor = 1;
          elseif (new.updated_by != new.id_investor)
          then
            set new.validasi_investor = 0;
          end if;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bu2` BEFORE UPDATE ON `trx_prive` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_investor = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_investor = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_prive_bu3` BEFORE UPDATE ON `trx_prive` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_wd_deposit_pelanggan`
--

CREATE TABLE `trx_wd_deposit_pelanggan` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_pelanggan` bigint(20) UNSIGNED NOT NULL COMMENT 'user sing sebagai pelanggan',
  `validasi_pelanggan` tinyint(1) NOT NULL DEFAULT 1,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt_user` bigint(20) UNSIGNED DEFAULT NULL,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_wd_deposit_pelanggan`
--

INSERT INTO `trx_wd_deposit_pelanggan` (`id_trx`, `waktu_trx`, `id_pelanggan`, `validasi_pelanggan`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `id_reknt_user`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('WDDPL/25032026/1/00001', '2026-03-25 10:56:17', 8, 1, 2, 100000, 1, NULL, 0, 0, NULL, 100000, 'tes postman', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00001.pdf', 1, 1, '2026-03-25 16:56:17', 1, '2026-03-25 16:56:44', NULL, NULL),
('WDDPL/25032026/1/00002', '2026-03-25 14:08:05', 8, 1, 2, 125000, 1, NULL, 0, 0, NULL, 125000, 'Apps', 'Dokumen', 'trx_wd_deposit_pelanggan_WDDPL-25032026-1-00002.pdf', 1, 1, '2026-03-25 20:08:05', 4, '2026-03-28 23:25:25', NULL, NULL);

--
-- Trigger `trx_wd_deposit_pelanggan`
--
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_ai1` AFTER INSERT ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaDepositPelanggan Varchar(100);
  declare
    idPjKas,
    idPjReknt BigInt(20) Unsigned;

  set nomorCoaDepositPelanggan = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 6
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_pelanggan,
    6,
    nomorCoaDepositPelanggan,
    new.total_nominal,
    0,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjKas,
      6,
      nomorCoaKas,
      0,
      new.nominal_kas,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      6,
      nomorCoaReknt,
      0,
      new.nominal_reknt,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_ai2` AFTER INSERT ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    kodePelanggan,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    jenisPelanggan Varchar(11) default '-';
  declare
    bentukPerusahaan,
    jenisBadanUsahaPelanggan Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt,
    nomorRekntUser Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaPelanggan,
    namaBadanUsahaPelanggan,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    atasNamaRekntUser,
    namaLk,
    namaLkRekntUser Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk,
    idLkRekntUser Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    jenis_user,
    coalesce(jenis_badan_usaha, ''),
    coalesce(nama_badan_usaha, ''),
    nama
  into
    kodePelanggan,
    jenisPelanggan,
    jenisBadanUsahaPelanggan,
    namaBadanUsahaPelanggan,
    namaPelanggan
  from
    users
  where
    id = new.id_pelanggan;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;

    # ambil data reknt user
    select
      nomor_rekening,
      atas_nama,
      id_lk
    into
      nomorRekntUser,
      atasNamaRekntUser,
      idLkRekntUser
    from
      reknt_users
    where
      id = new.id_reknt_user;

    select
      nama
    into
      namaLkRekntUser
    from
      lembaga_keuangan
    where
      id = idLkRekntUser;
  end if;

  if (new.validasi_pelanggan = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 26;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntPelanggan}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPelanggan}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkPelanggan}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_pelanggan,
      'trx_wd_deposit_pelanggan',
      'validasi_pelanggan',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 27;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntPelanggan}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPelanggan}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkPelanggan}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_wd_deposit_pelanggan',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 28;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodePelanggan}}', kodePelanggan);
    set isiNotif = replace(isiNotif, '{{jenisPelanggan}}', jenisPelanggan);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaPelanggan}}', jenisBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaPelanggan}}', namaBadanUsahaPelanggan);
    set isiNotif = replace(isiNotif, '{{namaPelanggan}}', namaPelanggan);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorRekntPelanggan}}', nomorRekntUser);
    set isiNotif = replace(isiNotif, '{{atasNamaRekntPelanggan}}', atasNamaRekntUser);
    set isiNotif = replace(isiNotif, '{{namaLkPelanggan}}', namaLkRekntUser);
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_wd_deposit_pelanggan',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_au1` AFTER UPDATE ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bd1` BEFORE DELETE ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;

  /*delete from
    trx_jurnal_umum
  where
    sumber_id_trx = old.id_trx;

  delete from
    trx_notifikasi
  where
    sumber_id_trx = old.id_trx;*/
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bi1` BEFORE INSERT ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      9,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bi2` BEFORE INSERT ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    jumlahTrxDepositPelangganPending,
    jumlahTrxWdDepositPelangganPending Integer(11) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositPelanggan,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekPelangganAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetDepositPelanggan,
    sumTrxKreditDepositPelanggan,
    sumSaldoDepositPelangganSaatIni,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  select
    peran
  into
    peranUser
  from
    users
  where
    id = new.id_pelanggan;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekPelangganAtauBukan != 'Pelanggan')
  then
    set pesanError = concat(
      'User yang Anda input bukan pelanggan, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekPelangganAtauBukan = 'Pelanggan')
  then
    # cek apakah ada transaksi pending?, jika ada gagalkan input
    set jumlahTrxDepositPelangganPending = (
      select
        count(id_trx)
      from
        trx_deposit_pelanggan
      where
        id_pelanggan = new.id_pelanggan
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    set jumlahTrxWdDepositPelangganPending = (
      select
        count(id_trx)
      from
        trx_wd_deposit_pelanggan
      where
        id_pelanggan = new.id_pelanggan
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (jumlahTrxDepositPelangganPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi deposit pelanggan mengambang yang belum ditentukan valid atau tidaknya terkait pelanggan ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxWdDepositPelangganPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi tarik deposit mengambang yang belum ditentukan valid atau tidaknya terkait pelanggan ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      # cek sisa deposit pelanggan ini
      set nomorCoaDepositPelanggan = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 6
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetDepositPelanggan,
        sumTrxKreditDepositPelanggan
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaDepositPelanggan
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoDepositPelangganSaatIni = sumTrxKreditDepositPelanggan - sumTrxDebetDepositPelanggan;

      if ((sumSaldoDepositPelangganSaatIni - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo deposit yang sudah ada pada pelanggan ini adalah Rp ', format(sumSaldoDepositPelangganSaatIni, 2, 'id_ID'), '\n',
          'Nilai transaksi deposit yang akan ditarik adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over withdraw.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan digunakan adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Sedangkan jumlah nominal tunai yang akan digunakan adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Artinya saldo kas akan minus.'
                'Transsaksi tidak dapat dilanjutkan.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.created_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan digunakan adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Sedangkan jumlah nominal non tunai yang akan digunakan adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Artinya saldo rekening non tunai akan minus.'
                'Transsaksi tidak dapat dilanjutkan.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.created_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          # kiye sementara ora dinggo ndisit, soale pelanggane durung gawekna aplikasi, ora bisa validasi:
          # if (new.created_by = new.id_pelanggan)
          # then
          #   set new.validasi_pelanggan = 1;
          # elseif (new.created_by != new.id_pelanggan)
          # then
          #   set new.validasi_pelanggan = 0;
          # end if;

          set new.validasi_pelanggan = 1;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bi3` BEFORE INSERT ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_pelanggan = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_pelanggan = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bu1` BEFORE UPDATE ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositPelanggan,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekPelangganAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetDepositPelanggan,
    sumTrxKreditDepositPelanggan,
    sumSaldoDepositPelangganSaatIni,
    sumTrxDebetAkunKas,
    sumTrxKreditAkunKas,
    saldoAkunKas,
    sumTrxDebetReknt,
    sumTrxKreditReknt,
    saldoReknt Double;
  declare pesanError Text;

  if
    (
      (not (new.id_pelanggan <=> old.id_pelanggan)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal)) or
      (not (new.id_reknt_user <=> old.id_reknt_user))
    )
  then
    select
      peran
    into
      peranUser
    from
      users
    where
      id = new.id_pelanggan;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekPelangganAtauBukan != 'Pelanggan')
    then
      set pesanError = concat(
        'User yang Anda input bukan pelanggan, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekPelangganAtauBukan = 'Pelanggan')
    then
      # cek sisa deposit pelanggan ini
      set nomorCoaDepositPelanggan = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 6
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetDepositPelanggan,
        sumTrxKreditDepositPelanggan
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaDepositPelanggan
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoDepositPelangganSaatIni = sumTrxKreditDepositPelanggan - sumTrxDebetDepositPelanggan;

      if ((sumSaldoDepositPelangganSaatIni - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo deposit yang sudah ada pada pelanggan ini adalah Rp ', format(sumSaldoDepositPelangganSaatIni, 2, 'id_ID'), '\n',
          'Nilai transaksi deposit yang akan ditarik adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over withdraw.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaAkunKas,
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetAkunKas,
              sumTrxKreditAkunKas
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaAkunKas
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoAkunKas = sumTrxDebetAkunKas - sumTrxKreditAkunKas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoAkunKas < new.nominal_kas)
            then
              set pesanError = concat(
                'Saldo akun kas yang akan digunakan adalah Rp ', format(saldoAkunKas, 2, 'id_ID'), '\n',
                'Sedangkan jumlah nominal tunai yang akan digunakan adalah Rp ', format(new.nominal_kas, 2, 'id_ID'), '\n',
                'Artinya saldo kas akan minus.'
                'Transsaksi tidak dapat dilanjutkan.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              nomor_coa,
              id_pj,
              validasi_pj,
              aktif
            into
              nomorCoaReknt,
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              view_reknt
            where
              id = new.id_reknt;

            select
              coalesce(sum(trx_debet), 0),
              coalesce(sum(trx_kredit), 0)
            into
              sumTrxDebetReknt,
              sumTrxKreditReknt
            from
              trx_jurnal_umum
            where
              nomor_coa = nomorCoaReknt
            and
              validasi_trx = 1
            and
              deleted_at is null;

            set saldoReknt = sumTrxDebetReknt - sumTrxKreditReknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (saldoReknt < new.nominal_reknt)
            then
              set pesanError = concat(
                'Saldo rekening non tunai yang akan digunakan adalah Rp ', format(saldoReknt, 2, 'id_ID'), '\n',
                'Sedangkan jumlah nominal non tunai yang akan digunakan adalah Rp ', format(new.nominal_reknt, 2, 'id_ID'), '\n',
                'Artinya saldo rekening non tunai akan minus.'
                'Transsaksi tidak dapat dilanjutkan.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          # kiye sementara ora dinggo ndisit, soale pelanggane durung gawekna aplikasi, ora bisa validasi:
          # if (new.updated_by = new.id_pelanggan)
          # then
          #   set new.validasi_pelanggan = 1;
          # elseif (new.updated_by != new.id_pelanggan)
          # then
          #   set new.validasi_pelanggan = 0;
          # end if;

          set new.validasi_pelanggan = 1;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bu2` BEFORE UPDATE ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_pelanggan = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_pelanggan = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_pelanggan_bu3` BEFORE UPDATE ON `trx_wd_deposit_pelanggan` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `trx_wd_deposit_supplier`
--

CREATE TABLE `trx_wd_deposit_supplier` (
  `id_trx` varchar(50) NOT NULL,
  `waktu_trx` datetime NOT NULL,
  `id_supplier` bigint(20) UNSIGNED NOT NULL,
  `validasi_supplier` tinyint(1) NOT NULL DEFAULT 0,
  `id_akun_kas` int(11) UNSIGNED DEFAULT NULL,
  `nominal_kas` double NOT NULL DEFAULT 0,
  `validasi_akun_kas` tinyint(1) NOT NULL DEFAULT 0,
  `id_reknt` int(11) UNSIGNED DEFAULT NULL,
  `nominal_reknt` double NOT NULL DEFAULT 0,
  `validasi_reknt` tinyint(1) NOT NULL DEFAULT 0,
  `total_nominal` double NOT NULL DEFAULT 0,
  `keterangan_tambahan` text NOT NULL,
  `bentuk_bukti_trx` enum('Foto','Dokumen') DEFAULT 'Dokumen',
  `file_bukti_trx` varchar(100) NOT NULL,
  `validasi_trx` tinyint(1) NOT NULL DEFAULT 0,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `trx_wd_deposit_supplier`
--

INSERT INTO `trx_wd_deposit_supplier` (`id_trx`, `waktu_trx`, `id_supplier`, `validasi_supplier`, `id_akun_kas`, `nominal_kas`, `validasi_akun_kas`, `id_reknt`, `nominal_reknt`, `validasi_reknt`, `total_nominal`, `keterangan_tambahan`, `bentuk_bukti_trx`, `file_bukti_trx`, `validasi_trx`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
('WDDS/23032026/1/00001', '2026-03-23 09:33:49', 7, 1, 2, 1000000, 1, NULL, 0, 0, 1000000, 'test postman', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00001.pdf', 1, 1, '2026-03-23 15:33:49', 4, '2026-03-23 15:34:42', NULL, NULL),
('WDDS/23032026/1/00002', '2026-03-23 12:47:21', 7, 1, 2, 500000, 1, NULL, 0, 0, 500000, '', 'Dokumen', 'trx_wd_deposit_supplier_WDDS-23032026-1-00002.pdf', 1, 1, '2026-03-23 18:47:21', 4, '2026-03-23 18:51:56', NULL, NULL);

--
-- Trigger `trx_wd_deposit_supplier`
--
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_ai1` AFTER INSERT ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    nomorCoaKas,
    nomorCoaReknt,
    nomorCoaDepositSupplier Varchar(100);
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjAkunKas,
      4,
      nomorCoaKas,
      new.nominal_kas,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_coa,
      id_pj
    into
      nomorCoaReknt,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    insert into trx_jurnal_umum (
      waktu_trx,
      sumber_id_trx,
      jenis_entitas,
      id_entitas,
      kode_ju,
      nomor_coa,
      trx_debet,
      trx_kredit,
      keterangan_tambahan,
      bentuk_bukti_trx,
      file_bukti_trx,
      validasi_trx,
      created_by)
    values (
      new.waktu_trx,
      new.id_trx,
      'User',
      idPjReknt,
      4,
      nomorCoaReknt,
      new.nominal_reknt,
      0,
      new.keterangan_tambahan,
      new.bentuk_bukti_trx,
      new.file_bukti_trx,
      new.validasi_trx,
      new.created_by);
  end if;

  set nomorCoaDepositSupplier = (
    select
      nomor_coa
    from
      setting_coa_default
    where
      id = 5
  );

  insert into trx_jurnal_umum (
    waktu_trx,
    sumber_id_trx,
    jenis_entitas,
    id_entitas,
    kode_ju,
    nomor_coa,
    trx_debet,
    trx_kredit,
    keterangan_tambahan,
    bentuk_bukti_trx,
    file_bukti_trx,
    validasi_trx,
    created_by)
  values (
    new.waktu_trx,
    new.id_trx,
    'User',
    new.id_supplier,
    4,
    nomorCoaDepositSupplier,
    0,
    new.total_nominal,
    new.keterangan_tambahan,
    new.bentuk_bukti_trx,
    new.file_bukti_trx,
    new.validasi_trx,
    new.created_by);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_ai2` AFTER INSERT ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    kodeSupplier,
    kodePjAkunKas,
    kodePjReknt Varchar(18) default '-';
  declare
    jenisSupplier Varchar(11) default '-';
  declare
    bentukPerusahaan,
    jenisBadanUsahaSupplier Varchar(21) default '-';
  declare
    namaAkunKas,
    nomorReknt Varchar(50) default '-';
  declare
    namaPerusahaan,
    namaSupplier,
    namaBadanUsahaSupplier,
    nomorCoaAkunKas,
    namaPjAkunKas,
    nomorCoaReknt,
    namaPjReknt,
    atasNamaReknt,
    namaLk Varchar(100) default '-';
  declare
    namaCoaAkunKas,
    namaCoaReknt,
    namaCreatedBy Varchar(200) default '-';
  declare
    idLk Integer(11) Unsigned;
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    judulNotif,
    isiNotif Text;

  select
    bentuk_perusahaan,
    nama_perusahaan
  into
    bentukPerusahaan,
    namaPerusahaan
  from
    profil_perusahaan
  where
    id = 1;

  set namaPerusahaan = concat(
    bentukPerusahaan, ' ', namaPerusahaan
  );

  set namaCreatedBy = (
    select
      nama
    from
      users
    where
      id = new.created_by
  );

  select
    kode_user,
    jenis_user,
    coalesce(jenis_badan_usaha, ''),
    coalesce(nama_badan_usaha, ''),
    nama
  into
    kodeSupplier,
    jenisSupplier,
    jenisBadanUsahaSupplier,
    namaBadanUsahaSupplier,
    namaSupplier
  from
    users
  where
    id = new.id_supplier;

  if 
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0)
    )
  then
    select
      nama_akun_kas,
      nomor_coa,
      id_pj
    into
      namaAkunKas,
      nomorCoaAkunKas,
      idPjAkunKas
    from
      akun_kas
    where
      id = new.id_akun_kas;

    set namaCoaAkunKas = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaAkunKas
    );

    select
      kode_user,
      nama
    into
      kodePjAkunKas,
      namaPjAkunKas
    from
      users
    where
      id = idPjAkunKas;
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0)
    )
  then
    select
      nomor_rekening,
      atas_nama,
      nomor_coa,
      id_lk,
      id_pj
    into
      nomorReknt,
      atasNamaReknt,
      nomorCoaReknt,
      idLk,
      idPjReknt
    from
      reknt
    where
      id = new.id_reknt;

    set namaCoaReknt = (
      select
        nama_coa
      from
        coa
      where
        nomor_coa = nomorCoaReknt
    );

    select
      nama
    into
      namaLk
    from
      lembaga_keuangan
    where
      id = idLk;

    select
      kode_user,
      nama
    into
      kodePjReknt,
      namaPjReknt
    from
      users
    where
      id = idPjReknt;
  end if;

  if (new.validasi_supplier = 0)
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 20;

    set judulNotif = replace(judulNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      new.id_supplier,
      'trx_wd_deposit_supplier',
      'validasi_supplier',
      new.created_by
    );
  end if;

  if
    (
      (new.id_akun_kas > 0) and
      (new.nominal_kas > 0) and
      (new.validasi_akun_kas = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 21;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjAkunKas,
      'trx_wd_deposit_supplier',
      'validasi_akun_kas',
      new.created_by
    );
  end if;

  if
    (
      (new.id_reknt > 0) and
      (new.nominal_reknt > 0) and
      (new.validasi_reknt = 0)
    )
  then
    select
      judul_notif,
      isi_notif
    into
      judulNotif,
      isiNotif
    from
      template_notifikasi
    where
      id = 22;

    set isiNotif = replace(isiNotif, '{{namaPerusahaan}}', namaPerusahaan);
    set isiNotif = replace(isiNotif, '{{kodeSupplier}}', kodeSupplier);
    set isiNotif = replace(isiNotif, '{{jenisSupplier}}', jenisSupplier);
    set isiNotif = replace(isiNotif, '{{jenisBadanUsahaSupplier}}', jenisBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaBadanUsahaSupplier}}', namaBadanUsahaSupplier);
    set isiNotif = replace(isiNotif, '{{namaSupplier}}', namaSupplier);
    set isiNotif = replace(isiNotif, '{{idTrx}}', new.id_trx);
    set isiNotif = replace(isiNotif, '{{waktuTrx}}', date_format(new.waktu_trx, '%d/%m/%Y %H:%i:%s'));
    set isiNotif = replace(isiNotif, '{{namaAkunKas}}', namaAkunKas);
    set isiNotif = replace(isiNotif, '{{kodePjAkunKas}}', kodePjAkunKas);
    set isiNotif = replace(isiNotif, '{{namaPjAkunKas}}', namaPjAkunKas);
    set isiNotif = replace(isiNotif, '{{nomorCoaAkunKas}}', nomorCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{namaCoaAkunKas}}', namaCoaAkunKas);
    set isiNotif = replace(isiNotif, '{{nominalKas}}', format(new.nominal_kas, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{nomorReknt}}', nomorReknt);
    set isiNotif = replace(isiNotif, '{{atasNamaReknt}}', atasNamaReknt);
    set isiNotif = replace(isiNotif, '{{namaLk}}', namaLk);
    set isiNotif = replace(isiNotif, '{{kodePjReknt}}', kodePjReknt);
    set isiNotif = replace(isiNotif, '{{namaPjReknt}}', namaPjReknt);
    set isiNotif = replace(isiNotif, '{{nomorCoaReknt}}', nomorCoaReknt);
    set isiNotif = replace(isiNotif, '{{namaCoaReknt}}', namaCoaReknt);
    set isiNotif = replace(isiNotif, '{{nominalReknt}}', format(new.nominal_reknt, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{totalNominal}}', format(new.total_nominal, 2, 'id_ID'));
    set isiNotif = replace(isiNotif, '{{diinputOleh}}', namaCreatedBy);
    set isiNotif = replace(isiNotif, '{{waktuInput}}', date_format(new.created_at, '%d %M %Y %H:%i:%s'));

    call insertTrxNotifikasi (
      new.created_at,
      new.id_trx,
      'id_trx',
      'Validasi',
      judulNotif,
      isiNotif,
      'User',
      idPjReknt,
      'trx_wd_deposit_supplier',
      'validasi_reknt',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_au1` AFTER UPDATE ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 0)
  then
    update
      trx_jurnal_umum
    set
      validasi_trx = new.validasi_trx,
      updated_by = new.updated_by,
      updated_at = new.updated_at
    where
      sumber_id_trx = old.id_trx;
  end if;

  if
    (
      (
        (not (new.deleted_by <=> old.deleted_by)) or
        (not (new.deleted_at <=> old.deleted_at))
      )
    )
  then
    update
      trx_jurnal_umum
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;

    update
      trx_notifikasi
    set
      updated_by = new.updated_by,
      updated_at = new.updated_at,
      deleted_by = new.deleted_by,
      deleted_at = new.deleted_at
    where
      sumber_id_trx = old.id_trx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bd1` BEFORE DELETE ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;

  if (old.validasi_trx = 1)
  then
    set pesanError = concat(
      'Transaksi ini sudah divalidasi, tidak boleh dihapus.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.validasi_trx = 0)
  then
    delete from
      trx_jurnal_umum
    where
      sumber_id_trx = old.id_trx;

    delete from
      trx_notifikasi
    where
      sumber_id_trx = old.id_trx;
  end if;

  /*delete from
    trx_jurnal_umum
  where
    sumber_id_trx = old.id_trx;

  delete from
    trx_notifikasi
  where
    sumber_id_trx = old.id_trx;*/
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bi1` BEFORE INSERT ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare idTrx Varchar(50);

  if
    ((new.id_trx is null) or
    (new.id_trx = ''))
  then
    call createNewIdTrx (
      7,
      new.waktu_trx,
      new.created_by,
      idTrx
    );

    set new.id_trx = idTrx;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bi2` BEFORE INSERT ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    jumlahTrxDepositSupplierPending,
    jumlahTrxWdDepositSupplierPending Integer(11) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositSupplier,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSupplierAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetDepositSupplier,
    sumTrxKreditDepositSupplier,
    sumSaldoDepositSupplierSaatIni Double;
  declare pesanError Text;

  select
    peran
  into
    peranUser
  from
    users
  where
    id = new.id_supplier;

  set new.total_nominal = new.nominal_kas + new.nominal_reknt;
  
  if (cekSupplierAtauBukan != 'Supplier')
  then
    set pesanError = concat(
      'User yang Anda input bukan supplier, tidak bisa dilanjutkan.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (cekSupplierAtauBukan = 'Supplier')
  then
    # cek apakah ada transaksi pending?, jika ada gagalkan input
    set jumlahTrxDepositSupplierPending = (
      select
        count(id_trx)
      from
        trx_deposit_supplier
      where
        id_supplier = new.id_supplier
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    set jumlahTrxWdDepositSupplierPending = (
      select
        count(id_trx)
      from
        trx_wd_deposit_supplier
      where
        id_supplier = new.id_supplier
      and
        validasi_trx = 0
      and
        deleted_at is null
    );

    if (jumlahTrxDepositSupplierPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi deposit supplier mengambang yang belum ditentukan valid atau tidaknya terkait supplier ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (jumlahTrxWdDepositSupplierPending > 0)
    then
      set pesanError = concat(
        'Masih ada transaksi tarik deposit supplier mengambang yang belum ditentukan valid atau tidaknya terkait supplier ini.\n',
        'Untuk menghindari perhitungan yang kacau, transaksi baru tidak dapat dilanjutkan sebelum transaksi yang mengambang diselesaikan terlebih dahulu.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    else
      # cek deposit sisa berapa di supplier ini
      set nomorCoaDepositSupplier = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 5
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetDepositSupplier,
        sumTrxKreditDepositSupplier
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaDepositSupplier
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoDepositSupplierSaatIni = sumTrxDebetDepositSupplier - sumTrxKreditDepositSupplier;

      if ((sumSaldoDepositSupplierSaatIni - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo deposit yang sudah ada pada supplier ini adalah Rp ', format(sumSaldoDepositSupplierSaatIni, 2, 'id_ID'), '\n',
          'Nilai transaksi deposit yang akan ditarik adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over withdraw.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.created_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into 
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.created_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.created_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          # kiye sementara ora dinggo ndisit, soale suppliere durung gawekna aplikasi, ora bisa validasi:
          # if (new.created_by = new.id_supplier)
          # then
          #   set new.validasi_supplier = 1;
          # elseif (new.created_by != new.id_supplier)
          # then
          #   set new.validasi_supplier = 0;
          # end if;

          set new.validasi_supplier = 1;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bi3` BEFORE INSERT ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_supplier = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_supplier = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bu1` BEFORE UPDATE ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    idPjAkunKas,
    idPjReknt BigInt(20) Unsigned;
  declare
    peranUser Varchar(9);
  declare
    nomorCoaDepositSupplier,
    nomorCoaAkunKas,
    nomorCoaReknt Varchar(100);
  declare
    cekSupplierAtauBukan,
    validasiPjAkunKas,
    statusAktifAkunKas,
    validasiPjReknt,
    statusAktifReknt Boolean default 0;
  declare
    sumTrxDebetDepositSupplier,
    sumTrxKreditDepositSupplier,
    sumSaldoDepositSupplierSaatIni Double;
  declare pesanError Text;

  if
    (
      (not (new.id_supplier <=> old.id_supplier)) or
      (not (new.id_akun_kas <=> old.id_akun_kas)) or
      (not (new.nominal_kas <=> old.nominal_kas)) or
      (not (new.id_reknt <=> old.id_reknt)) or
      (not (new.nominal_reknt <=> old.nominal_reknt)) or
      (not (new.total_nominal <=> old.total_nominal))
    )
  then
    select
      peran
    into
      peranUser
    from
      users
    where
      id = new.id_supplier;

    set new.total_nominal = new.nominal_kas + new.nominal_reknt;
    
    if (cekSupplierAtauBukan != 'Supplier')
    then
      set pesanError = concat(
        'User yang Anda input bukan supplier, tidak bisa dilanjutkan.'
      );

      signal sqlstate '45000'
      set message_text = pesanError;
    elseif (cekSupplierAtauBukan = 'Supplier')
    then
      # cek deposit sisa berapa di supplierini
      set nomorCoaDepositSupplier = (
        select
          nomor_coa
        from
          setting_coa_default
        where
          id = 5
      );

      select
        coalesce(sum(trx_debet), 0),
        coalesce(sum(trx_kredit), 0)
      into
        sumTrxDebetDepositSupplier,
        sumTrxKreditDepositSupplier
      from
        trx_jurnal_umum
      where
        nomor_coa = nomorCoaDepositSupplier
      and
        validasi_trx = 1
      and
        deleted_at is null;

      set sumSaldoDepositSupplierSaatIni = sumTrxDebetDepositSupplier - sumTrxKreditDepositSupplier;

      if ((sumSaldoDepositSupplierSaatIni - new.total_nominal) < 0)
      then
        set pesanError = concat(
          'Saldo deposit yang sudah ada pada supplier ini adalah Rp ', format(sumSaldoDepositSupplierSaatIni, 2, 'id_ID'), '\n',
          'Nilai transaksi deposit yang akan ditarik adalah Rp ', format(new.total_nominal, 2, 'id_ID'), '\n',
          'Artinya over withdraw.\n',
          'Transaksi tidak bisa dilanjutkan.'
        );

        signal sqlstate '45000'
        set message_text = pesanError;
      else
        if  
          (
            (new.id_akun_kas is null) or
            (new.id_akun_kas = 0)
          )
            and
          (
            (new.id_reknt is null) or
            (new.id_reknt = 0)
          )
        then
          set pesanError = concat(
            'Anda tidak menggunakan baik salah satu maupun keduanya dari alat penerimaan uang yang disediakan dalam transaksi ini.\n',
            'Minimal gunakan salah satunya, apakah dalam bentuk tunai atau non tunai, atau keduanya sekaligus.'
          );

          signal sqlstate '45000'
          set message_text = pesanError;
        else
          if
            (
              (
                (new.id_akun_kas is not null)
                  or
                (new.id_akun_kas > 0)
              )
                and
              (
                (new.nominal_kas > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into
              idPjAkunKas,
              validasiPjAkunKas,
              statusAktifAkunKas
            from
              akun_kas
            where
              id = new.id_akun_kas;

            if (validasiPjAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak valid.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifAkunKas = 0)
            then
              set pesanError = concat(
                'Akun kas yang Anda input tidak aktif.\n',
                'Silahkan cek status akun kas yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjAkunKas)
            then
              set new.validasi_akun_kas = 1;
            elseif (new.updated_by != idPjAkunKas)
            then
              set new.validasi_akun_kas = 0;
            end if;
          end if;

          if
            (
              (
                (new.id_reknt is not null)
                  or
                (new.id_reknt > 0)
              )
                and
              (
                (new.nominal_reknt > 0)
              )
            )
          then
            select
              id_pj,
              validasi_pj,
              aktif
            into 
              idPjReknt,
              validasiPjReknt,
              statusAktifReknt
            from
              reknt
            where
              id = new.id_reknt;

            if (validasiPjReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak valid.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (statusAktifReknt = 0)
            then
              set pesanError = concat(
                'Rekening non tunai yang Anda input tidak aktif.\n',
                'Silahkan cek status rekening non tunai yang digunakan dalam transaksi ini.'
              );

              signal sqlstate '45000'
              set message_text = pesanError;
            elseif (new.updated_by = idPjReknt)
            then
              set new.validasi_reknt = 1;
            elseif (new.updated_by != idPjReknt)
            then
              set new.validasi_reknt = 0;
            end if;
          end if;

          # kiye sementara ora dinggo ndisit, soale suppliere durung gawekna aplikasi, ora bisa validasi:
          # if (new.updated_by = new.id_supplier)
          # then
          #   set new.validasi_supplier = 1;
          # elseif (new.updated_by != new.id_supplier)
          # then
          #   set new.validasi_supplier = 0;
          # end if;

          set new.validasi_supplier = 1;
          
          set new.total_nominal = new.nominal_kas + new.nominal_reknt;
        end if;
      end if;
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bu2` BEFORE UPDATE ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare
    validasiAkunKasDianggapValid,
    validasiRekntDianggapValid Boolean default 0;

  if
    (
      (
        (
          (new.id_akun_kas is null) or
          (new.id_akun_kas = 0)
        ) and
        (
          (new.nominal_kas = 0)
        )
      ) or
      (new.validasi_akun_kas = 1)
    )
  then
    set validasiAkunKasDianggapValid = 1;
  end if;

  if
    (
      (
        (
          (new.id_reknt is null) or
          (new.id_reknt = 0)
        ) and
        (
          (new.nominal_reknt = 0)
        )
      ) or
      (new.validasi_reknt = 1)
    )
  then
    set validasiRekntDianggapValid = 1;
  end if;

  if
    (
      (new.validasi_supplier = 1) and
      (validasiAkunKasDianggapValid = 1) and
      (validasiRekntDianggapValid = 1)
    )
  then
    set new.validasi_trx = 1;
  elseif
    (
      (new.validasi_supplier = 2) or
      (new.validasi_akun_kas = 2) or
      (new.validasi_reknt = 2)
    )
  then
    set new.validasi_trx = 2;
  else
    set new.validasi_trx = 0;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trx_wd_deposit_supplier_bu3` BEFORE UPDATE ON `trx_wd_deposit_supplier` FOR EACH ROW begin
  declare pesanError Text;
  
  if (old.validasi_trx != 0)
  then
    set pesanError = concat(
      'Transaksi yang sudah valid tidak bisa diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  elseif (old.deleted_by is not null) or (old.deleted_at is not null)
  then
    set pesanError = concat(
      'Transaksi yang sudah dihapus tidak boleh diubah lagi.'
    );

    signal sqlstate '45000'
    set message_text = pesanError;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kode_user` varchar(18) NOT NULL,
  `jenis_user` enum('Individu','Badan Usaha') NOT NULL DEFAULT 'Individu' COMMENT 'nek user internal = individu\r\n\r\nnek user eksternal = bisa individu bisa badan usaha',
  `jenis_badan_usaha` enum('C.V.','Firma','P.T.','Koperasi','Yayasan') DEFAULT NULL COMMENT 'jika jenis_user = individu maka ini null',
  `nama_badan_usaha` varchar(100) DEFAULT NULL,
  `id_cabang` int(11) UNSIGNED DEFAULT NULL,
  `nama` varchar(100) NOT NULL COMMENT 'jika badan usaha, maka nama user adalah nama pribadi',
  `nomor_nik` varchar(16) DEFAULT NULL,
  `gender` enum('Pria','Wanita') DEFAULT NULL,
  `id_tempat_lahir` int(11) UNSIGNED DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `alamat_tt` text NOT NULL,
  `rt_tt` varchar(3) NOT NULL,
  `rw_tt` varchar(3) NOT NULL,
  `id_kelurahan_tt` int(11) UNSIGNED DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `nomor_wa` varchar(20) NOT NULL,
  `foto_ktp` varchar(100) DEFAULT NULL,
  `foto_diri` varchar(100) DEFAULT NULL,
  `foto_profil` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `peran` enum('Maha Dewa','Owner','Investor','Manajemen','Supplier','Pelanggan') NOT NULL DEFAULT 'Manajemen',
  `investor` tinyint(1) NOT NULL DEFAULT 0,
  `nomor_coa_modal` varchar(100) NOT NULL COMMENT 'triger',
  `nomor_coa_prive` varchar(100) NOT NULL COMMENT 'triger',
  `limit_deposit_supplier` double NOT NULL DEFAULT 0 COMMENT 'rupiah',
  `limit_hutang_pelanggan` double NOT NULL DEFAULT 0 COMMENT 'rupiah',
  `limit_kasbon_sdm` double NOT NULL DEFAULT 0 COMMENT 'khususon ila manajemen',
  `status` enum('Aktif','Suspended','Keluar','Dikeluarkan') NOT NULL DEFAULT 'Aktif',
  `is_logged_in` tinyint(1) NOT NULL DEFAULT 0,
  `last_login_device` enum('Windows','Android','Website','iOS','macOS') DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_active_at` datetime DEFAULT NULL,
  `token_fcm` varchar(255) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_by` bigint(20) UNSIGNED DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `kode_user`, `jenis_user`, `jenis_badan_usaha`, `nama_badan_usaha`, `id_cabang`, `nama`, `nomor_nik`, `gender`, `id_tempat_lahir`, `tanggal_lahir`, `alamat_tt`, `rt_tt`, `rw_tt`, `id_kelurahan_tt`, `email`, `nomor_wa`, `foto_ktp`, `foto_diri`, `foto_profil`, `username`, `password`, `peran`, `investor`, `nomor_coa_modal`, `nomor_coa_prive`, `limit_deposit_supplier`, `limit_hutang_pelanggan`, `limit_kasbon_sdm`, `status`, `is_logged_in`, `last_login_device`, `device_id`, `last_login_at`, `last_active_at`, `token_fcm`, `created_by`, `created_at`, `updated_by`, `updated_at`, `deleted_by`, `deleted_at`) VALUES
(1, 'USR/06051980/00001', 'Individu', NULL, NULL, 1, 'Budhi Santoso Pranoto', '3376020605800002', 'Pria', 509, '1980-05-06', 'Jalan Kaloran nomor 48', '09', '04', 39775, 'budhi.santoso.pranoto@gmail.com', '081902488887', 'fotoKtp_3376020605800002.jpg', 'fotoDiri_3376020605800002.jpg', 'fotoProfil_3376020605800002.jpg', 'KiAntebSejagat', '$2y$12$Kfav.m2NuyDt7JOTxr5TXuFdiDtQrLbdNmLd43pQostjUUtqTC44a', 'Maha Dewa', 0, '', '', 0, 0, 0, 'Aktif', 1, 'Android', 'b57ef546b0fc9282ce9956f0cd9171f6d2cacf7717fb3e7b53b4bc61dc9f007d', '2026-03-31 19:57:40', '2026-03-31 19:57:40', '', 1, '2025-12-16 00:51:32', 1, '2026-03-31 19:57:40', NULL, NULL),
(2, 'USR/18032026/00001', 'Individu', NULL, NULL, NULL, 'Umum', NULL, NULL, NULL, NULL, '', '', '', NULL, 'supplier@umum.com', '081800000000', NULL, NULL, NULL, 'supplier@umum.com', '$2a$12$DlcrVPteN4nKtLvnEFAt9O.OrAYjmr0PIb1ROjxmmGY99fcIyoP3S', 'Supplier', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2026-03-18 15:48:03', 1, '2026-03-18 16:00:27', NULL, NULL),
(3, 'USR/18032026/00001', 'Individu', NULL, NULL, NULL, 'Umum', NULL, NULL, NULL, NULL, '', '', '', NULL, 'pelanggan@umum.com', '081900000000', NULL, NULL, NULL, 'pelanggan@umum.com', '$2a$12$o0CSn5Qhhgl8J3Un.Zvt6O62kbsHjUTCw/58ENdBLjbKAb44ZiNla', 'Pelanggan', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2026-03-18 15:48:03', 1, '2026-03-18 16:00:30', NULL, NULL),
(4, 'USR/16122025/00001', 'Individu', NULL, NULL, 1, 'Shofant Hedhiyanto', '3376020605800001', 'Pria', 509, '1982-01-01', 'Jalan Jalan', '01', '01', 123, 'shofant@gmail.com', '081233338848', 'fotoKtp_3376020605800001.jpg', 'fotoDiri_3376020605800001.jpg', 'fotoProfil_3376020605800001.jpg', 'KiAgengSenopati', '$2a$12$HMDeFGmne2l24teeGEWiI.vP2EmM1wAO2UoxQ.2Xr1tRdFXnQUvre', 'Manajemen', 1, '300-1-1', '300-2-1', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2025-12-16 01:04:01', 1, '2026-03-18 15:58:54', NULL, NULL),
(5, 'USR/31122025/00001', 'Individu', NULL, NULL, 1, 'Christina Indriyani', '3328155305870006', 'Wanita', 393, '1987-05-13', 'Jalan Kaloran nomor 48', '09', '04', 39775, 'cindriyani298@gmail.com', '081280016033', 'fotoKtp_3328155305870006.jpg', 'fotoDiri_3328155305870006.jpg', '', 'testUsername', '$2y$12$u5V06PggvBtoh.rtuvGJf.H2RFrIUuiYevW3hs3bhNDCkDSYDiuye', 'Manajemen', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2025-12-31 11:45:22', 1, '2026-03-18 15:59:16', NULL, NULL),
(6, 'USR/07032026/00001', 'Individu', NULL, NULL, 1, 'Sudrun', '5469853269084563', 'Pria', 509, '1984-12-28', 'Jalan Ular no. 22', '01', '01', 70864, 'sudrun@gmail.com', '085652365987', 'fotoKtp_5469853269084563.jpg', 'fotoDiri_5469853269084563.jpg', '', '5469853269084563', '$2y$12$WADzJAchDXMaVVRNgjNaxO3/Tg4GkO17MR4p0vWtyfalCmIbZJKDi', 'Manajemen', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2026-03-07 18:16:26', 1, '2026-03-18 16:00:32', NULL, NULL),
(7, 'USR/08032026/00001', 'Individu', NULL, NULL, NULL, 'Dalban', NULL, NULL, NULL, NULL, 'Jalan Uler 22\nGang anakonda', '', '', 75193, 'dalban@gmail.com', '081565984587', NULL, NULL, NULL, 'dalban@gmail.com', '$2y$12$IQXTbTFKaibY0pAdcg32RegBjTbt1ZGbPCw3IHX4KInGde42TxWDG', 'Supplier', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2026-03-08 21:39:56', 1, '2026-03-18 16:00:02', NULL, NULL),
(8, 'USR/08032026/00002', 'Individu', NULL, NULL, NULL, 'Kuro', NULL, NULL, NULL, NULL, 'Jalan Udud 23\nGang kebul', '', '', 3, 'kuro@gmail.com', '081265896587', NULL, NULL, NULL, 'kuro@gmail.com', '$2y$12$TZy05EYPqIxwTPjHdNIIpOrz1RqgKDibMdjnyI4BCYKT7mcuQRpmS', 'Pelanggan', 0, '', '', 0, 0, 0, 'Aktif', 0, NULL, NULL, NULL, NULL, '', 1, '2026-03-08 21:42:24', 1, '2026-03-18 15:59:59', NULL, NULL);

--
-- Trigger `users`
--
DELIMITER $$
CREATE TRIGGER `users_ai1` AFTER INSERT ON `users` FOR EACH ROW begin
  declare
    nomorCoaIndukModal,
    nomorCoaIndukPrive Varchar(100);

  if (new.investor = 1)
  then
    set nomorCoaIndukModal = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 1
    );

    set nomorCoaIndukPrive = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 2
    );

    insert into coa (
      nomor_coa,
      nama_coa,
      nomor_coa_induk,
      saldo_normal,
      created_by)
    values (
      new.nomor_coa_modal,
      concat('Modal Investor - ', new.nama),
      nomorCoaIndukModal,
      'kredit',
      new.created_by
    ),
    (
      new.nomor_coa_prive,
      concat('Prive Investor - ', new.nama),
      nomorCoaIndukPrive,
      'debet',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_au1` AFTER UPDATE ON `users` FOR EACH ROW begin
  declare
    nomorCoaIndukModal,
    nomorCoaIndukPrive Varchar(100);

  if
    (
      (new.investor = 1) and
      (
        (new.nomor_coa_modal = '') and
        (new.nomor_coa_prive = '')
      )
    )
  then
    set nomorCoaIndukModal = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 1
    );

    set nomorCoaIndukPrive = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 2
    );

    insert into coa (
      nomor_coa,
      nama_coa,
      nomor_coa_induk,
      saldo_normal,
      created_by)
    values (
      new.nomor_coa_modal,
      concat('Modal Investor - ', new.nama),
      nomorCoaIndukModal,
      'kredit',
      new.created_by
    ),
    (
      new.nomor_coa_prive,
      concat('Prive Investor - ', new.nama),
      nomorCoaIndukPrive,
      'debet',
      new.created_by
    );
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_bi1` BEFORE INSERT ON `users` FOR EACH ROW begin
  declare kodeTrx Varchar(50);
  declare waktuTrxFi Varchar(8);
  declare
    nomorUrutTrx,
    lastTrx Varchar(5);
  declare
    countTrx,
    lastNomorUrutTrx Integer(11);
  declare waktuTrxFo Date;

  if
    ((new.kode_user is null) or
    (new.kode_user = ''))
  then
    # Ambil kodeTrx dari tabel perangkattabel
    set kodeTrx = (
      select
        kode_awal
      from
        kode_tabel
      where
        id = 1
    );

    # Ambil waktuTrxFo dari new.waktu_trx
    set waktuTrxFo = new.created_at;

    # Ubah format waktuTrxFo menjadi DDMMYYYY
    set waktuTrxFi = date_format(waktuTrxFo, '%d%m%Y');

    # Generate nomorUrutTrx
    set nomorUrutTrx = '';

    # Cek jumlah users dengan idTrxPattern yang sama
    set countTrx = (
      select
        count(*)
      from
        users
      where
        kode_user like concat(kodeTrx, '/', waktuTrxFi, '/%')
    );

    if countTrx = 0 then
        set nomorUrutTrx = '00001';
    else
      # Ambil nomor urut users terakhir
      set lastTrx = (
        select
          max(substring_index(kode_user, '/', -1))
        from
          users
        where
          kode_user like concat(kodeTrx, '/', waktuTrxFi, '/%')
      );

      set lastNomorUrutTrx = cast(lastTrx as unsigned);
      set nomorUrutTrx = lpad(lastNomorUrutTrx + 1, 5, '0');
    end if;

    # Generate ID Transaksi dan masukkan ke field kode_user pada data yang akan diinsert
    set new.kode_user = concat(kodeTrx, '/', waktuTrxFi, '/', nomorUrutTrx);
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_bi2` BEFORE INSERT ON `users` FOR EACH ROW begin
  declare
    varIndukNomorCoaModal,
    varIndukNomorCoaPrive Varchar(100);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;

  if (new.investor = 1)
  then
    set varIndukNomorCoaModal = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 1
    );
    
    if (new.nomor_coa_modal = '') or (new.nomor_coa_modal is null)
    then
      set jmlAnakCoa = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaModal, '-_%')
        and
          char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varIndukNomorCoaModal) - char_length(replace(varIndukNomorCoaModal, '-', ''))) + 1
      );

      if (jmlAnakCoa = 0)
      then
        set urutanAngkaAkhirNomorCoa = '0';
      elseif (jmlAnakCoa > 0)
      then
        set urutanAngkaAkhirNomorCoa = (
          select
            max(substring_index(nomor_coa, '-', -1))
          from
            coa
          where
            nomor_coa like concat(varIndukNomorCoaModal, '-_%')
          and
            char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varIndukNomorCoaModal) - char_length(replace(varIndukNomorCoaModal, '-', ''))) + 1
        );
      end if;

      set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
      set new.nomor_coa_modal = concat(varIndukNomorCoaModal, '-', angkaSaatIniNomorCoa);
    end if;

    set varIndukNomorCoaPrive = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 2
    );
    
    if (new.nomor_coa_prive = '') or (new.nomor_coa_prive is null)
    then
      set jmlAnakCoa = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaPrive, '-_%')
        and
          char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varIndukNomorCoaPrive) - char_length(replace(varIndukNomorCoaPrive, '-', ''))) + 1
      );

      if (jmlAnakCoa = 0)
      then
        set urutanAngkaAkhirNomorCoa = '0';
      elseif (jmlAnakCoa > 0)
      then
        set urutanAngkaAkhirNomorCoa = (
          select
            max(substring_index(nomor_coa, '-', -1))
          from
            coa
          where
            nomor_coa like concat(varIndukNomorCoaPrive, '-_%')
          and
            char_length(nomor_coa) - char_length(replace(nomor_coa, '-', '')) = (char_length(varIndukNomorCoaPrive) - char_length(replace(varIndukNomorCoaPrive, '-', ''))) + 1
        );
      end if;

      set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
      set new.nomor_coa_prive = concat(varIndukNomorCoaPrive, '-', angkaSaatIniNomorCoa);
    end if;
  end if;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `users_bu1` BEFORE UPDATE ON `users` FOR EACH ROW begin
  declare
    varIndukNomorCoaModal,
    varIndukNomorCoaPrive Varchar(100);
  declare urutanAngkaAkhirNomorCoa Varchar(5);
  declare
    angkaSaatIniNomorCoa,
    jmlAnakCoa SmallInt(6) Unsigned;

  if
    (
      (new.investor = 1) and
      (
        (new.nomor_coa_modal = '') and
        (new.nomor_coa_prive = '')
      )
    )
  then
    set varIndukNomorCoaModal = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 1
    );
    
    if (new.nomor_coa_modal = '') or (new.nomor_coa_modal is null)
    then
      set jmlAnakCoa = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaModal, '-%')
      );

      if (jmlAnakCoa = 0)
      then
        set urutanAngkaAkhirNomorCoa = '0';
      elseif (jmlAnakCoa > 0)
      then
        select
          max(substring_index(nomor_coa, '-', -1))
        into
          urutanAngkaAkhirNomorCoa 
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaModal, '-%');
      end if;

      set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
      set new.nomor_coa_modal = concat(varIndukNomorCoaModal, '-', angkaSaatIniNomorCoa);
    end if;

    set varIndukNomorCoaPrive = (
      select
        nomor_coa
      from
        setting_coa_default
      where
        id = 2
    );
    
    if (new.nomor_coa_prive = '') or (new.nomor_coa_prive is null)
    then
      set jmlAnakCoa = (
        select
          count(nomor_coa)
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaPrive, '-%')
      );

      if (jmlAnakCoa = 0)
      then
        set urutanAngkaAkhirNomorCoa = '0';
      elseif (jmlAnakCoa > 0)
      then
        select
          max(substring_index(nomor_coa, '-', -1))
        into
          urutanAngkaAkhirNomorCoa 
        from
          coa
        where
          nomor_coa like concat(varIndukNomorCoaPrive, '-%');
      end if;

      set angkaSaatIniNomorCoa = cast(urutanAngkaAkhirNomorCoa as Unsigned) + 1;
      set new.nomor_coa_prive = concat(varIndukNomorCoaPrive, '-', angkaSaatIniNomorCoa);
    end if;
  end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_akun_kas`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_akun_kas` (
`id` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`nomor_coa` varchar(100)
,`nama_coa` varchar(200)
,`id_pj` bigint(20) unsigned
,`kode_user_pj` varchar(18)
,`nama_pj` varchar(100)
,`validasi_pj` tinyint(1)
,`ket_validasi_pj` varchar(9)
,`aktif` tinyint(1)
,`ket_aktif` varchar(17)
,`saldo` double(19,2)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_cabang`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_cabang` (
`id` int(11) unsigned
,`nama_cabang` varchar(100)
,`alamat` text
,`rt` varchar(3)
,`rw` varchar(3)
,`id_kelurahan` int(10) unsigned
,`nama_kelurahan` varchar(100)
,`nama_kecamatan` varchar(100)
,`nama_kokab` varchar(150)
,`nama_propinsi` varchar(100)
,`nama_negara` varchar(200)
,`kode_pos` varchar(5)
,`nomor_telp` varchar(20)
,`nomor_wa` varchar(20)
,`fax` varchar(20)
,`email` varchar(150)
,`id_kepala_cabang` bigint(20) unsigned
,`nama_kepala_cabang` varchar(100)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_coa`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_coa` (
`nomor_coa` varchar(100)
,`nama_coa` varchar(200)
,`nomor_coa_induk` varchar(100)
,`nama_coa_induk` varchar(200)
,`tingkat` smallint(6) unsigned
,`saldo_normal` enum('debet','kredit')
,`trx_debet` double
,`trx_kredit` double
,`saldo` double
,`permanen` tinyint(1)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_lembaga_keuangan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_lembaga_keuangan` (
`id` int(11) unsigned
,`nama` varchar(100)
,`logo` varchar(100)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_profil_perusahaan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_profil_perusahaan` (
`id` tinyint(4) unsigned
,`bentuk_perusahaan` enum('Perusahaan Perorangan','C.V.','P.T.','Firma')
,`sudah_pkp` tinyint(1)
,`npwp_perusahaan` varchar(21)
,`nama_perusahaan` varchar(100)
,`alamat` text
,`rt` varchar(3)
,`rw` varchar(3)
,`id_kelurahan` int(10) unsigned
,`nama_kelurahan` varchar(100)
,`nama_kecamatan` varchar(100)
,`nama_kokab` varchar(150)
,`nama_propinsi` varchar(100)
,`nama_negara` varchar(200)
,`kode_pos` varchar(5)
,`nomor_telp` varchar(20)
,`nomor_wa` varchar(20)
,`fax` varchar(20)
,`email` varchar(150)
,`website` varchar(100)
,`id_ceo` bigint(20) unsigned
,`nama_ceo` varchar(100)
,`logo` varchar(100)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_reknt`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_reknt` (
`id` int(11) unsigned
,`nomor_rekening` varchar(50)
,`atas_nama` varchar(100)
,`nomor_coa` varchar(100)
,`nama_coa` varchar(200)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj` bigint(20) unsigned
,`kode_user_pj` varchar(18)
,`nama_pj` varchar(100)
,`validasi_pj` tinyint(1)
,`ket_validasi_pj` varchar(9)
,`aktif` tinyint(1)
,`ket_aktif` varchar(17)
,`saldo` double(19,2)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_reknt_users`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_reknt_users` (
`id` bigint(20) unsigned
,`id_user` bigint(20) unsigned
,`nomor_rekening` varchar(50)
,`atas_nama` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`validasi_admin` tinyint(1)
,`ket_validasi_admin` varchar(11)
,`is_default` tinyint(1)
,`ket_is_default` varchar(7)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_antar_kas`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_antar_kas` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_ak_awal` int(11) unsigned
,`nama_ak_awal` varchar(50)
,`id_pj_ak_awal` bigint(20) unsigned
,`kode_user_pj_ak_awal` varchar(18)
,`nama_user_pj_ak_awal` varchar(100)
,`vpj_ak_awal` tinyint(1)
,`ket_vpj_ak_awal` varchar(11)
,`id_ak_akhir` int(11) unsigned
,`nama_ak_akhir` varchar(50)
,`id_pj_ak_akhir` bigint(20) unsigned
,`kode_user_pj_ak_akhir` varchar(18)
,`nama_user_pj_ak_akhir` varchar(100)
,`vpj_ak_akhir` tinyint(1)
,`ket_vpj_ak_akhir` varchar(11)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_antar_reknt`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_antar_reknt` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_reknt_awal` int(11) unsigned
,`nomor_reknt_awal` varchar(50)
,`atas_nama_reknt_awal` varchar(100)
,`id_lk_reknt_awal` int(11) unsigned
,`nama_lk_reknt_awal` varchar(100)
,`id_pj_reknt_awal` bigint(20) unsigned
,`kode_user_pj_reknt_awal` varchar(18)
,`nama_pj_reknt_awal` varchar(100)
,`vpj_reknt_awal` tinyint(1)
,`ket_vpj_reknt_awal` varchar(11)
,`id_reknt_akhir` int(11) unsigned
,`nomor_reknt_akhir` varchar(50)
,`atas_nama_reknt_akhir` varchar(100)
,`id_lk_reknt_akhir` int(11) unsigned
,`nama_lk_reknt_akhir` varchar(100)
,`id_pj_reknt_akhir` bigint(20) unsigned
,`kode_user_pj_reknt_akhir` varchar(18)
,`nama_pj_reknt_akhir` varchar(100)
,`vpj_reknt_akhir` tinyint(1)
,`ket_vpj_reknt_akhir` varchar(11)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_bayar_kasbon_sdm`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_bayar_kasbon_sdm` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_sdm` bigint(20) unsigned
,`kode_sdm` varchar(18)
,`nama_sdm` varchar(100)
,`validasi_sdm` tinyint(1)
,`ket_validasi_sdm` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_deposit_pelanggan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_deposit_pelanggan` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_pelanggan` bigint(20) unsigned
,`kode_pelanggan` varchar(18)
,`nama_pelanggan` varchar(100)
,`validasi_pelanggan` tinyint(1)
,`ket_validasi_pelanggan` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_deposit_supplier`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_deposit_supplier` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_supplier` bigint(20) unsigned
,`kode_supplier` varchar(18)
,`nama_supplier` varchar(100)
,`validasi_supplier` tinyint(1)
,`ket_validasi_supplier` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`id_reknt_user` bigint(20) unsigned
,`nomor_reknt_user` varchar(50)
,`atas_nama_reknt_user` varchar(100)
,`id_lk_reknt_user` int(11) unsigned
,`nama_lk_reknt_user` varchar(100)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_input_modal`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_input_modal` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_investor` bigint(20) unsigned
,`kode_investor` varchar(18)
,`nama_investor` varchar(100)
,`validasi_investor` tinyint(1)
,`ket_validasi_investor` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_jurnal_umum`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_jurnal_umum` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`sumber_id_trx` varchar(50)
,`jenis_entitas` enum('User','Lembaga Keuangan','Supplier','Pelanggan')
,`id_entitas` bigint(20) unsigned
,`kode_entitas` varchar(18)
,`nama_entitas` varchar(100)
,`peran_entitas` enum('Maha Dewa','Owner','Investor','Manajemen','Supplier','Pelanggan')
,`kode_ju` smallint(6) unsigned
,`keterangan_ju` varchar(100)
,`nomor_coa` varchar(100)
,`nama_coa` varchar(200)
,`trx_debet` double(19,2)
,`trx_kredit` double(19,2)
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_kasbon_sdm`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_kasbon_sdm` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_sdm` bigint(20) unsigned
,`kode_sdm` varchar(18)
,`nama_sdm` varchar(100)
,`validasi_sdm` tinyint(1)
,`ket_validasi_sdm` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`id_reknt_user` bigint(20) unsigned
,`nomor_reknt_user` varchar(50)
,`atas_nama_reknt_user` varchar(100)
,`id_lk_reknt_user` int(11) unsigned
,`nama_lk_reknt_user` varchar(100)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_notifikasi`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_notifikasi` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`sumber_id_trx` varchar(50)
,`nama_kolom_primary` varchar(50)
,`jenis_notifikasi` enum('Informasi','Validasi')
,`judul_notif` text
,`isi_notif` text
,`jenis_entitas` enum('User','Lembaga Keuangan')
,`id_entitas` bigint(20) unsigned
,`nama_entitas` varchar(100)
,`nama_tabel` varchar(50)
,`nama_kolom` varchar(50)
,`sudah_dibaca` tinyint(1)
,`ket_sudah_dibaca` varchar(12)
,`status_selesai` tinyint(1)
,`ket_status_selesai` varchar(7)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_prive`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_prive` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_investor` bigint(20) unsigned
,`kode_investor` varchar(18)
,`nama_investor` varchar(100)
,`validasi_investor` tinyint(1)
,`ket_validasi_investor` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`id_reknt_user` bigint(20) unsigned
,`nomor_reknt_user` varchar(50)
,`atas_nama_reknt_user` varchar(100)
,`id_lk_reknt_user` int(11) unsigned
,`nama_lk_reknt_user` varchar(100)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_wd_deposit_pelanggan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_wd_deposit_pelanggan` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_pelanggan` bigint(20) unsigned
,`kode_pelanggan` varchar(18)
,`nama_pelanggan` varchar(100)
,`validasi_pelanggan` tinyint(1)
,`ket_validasi_pelanggan` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`id_reknt_user` bigint(20) unsigned
,`nomor_reknt_user` varchar(50)
,`atas_nama_reknt_user` varchar(100)
,`id_lk_reknt_user` int(11) unsigned
,`nama_lk_reknt_user` varchar(100)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_trx_wd_deposit_supplier`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_trx_wd_deposit_supplier` (
`id_trx` varchar(50)
,`waktu_trx` datetime
,`id_supplier` bigint(20) unsigned
,`kode_supplier` varchar(18)
,`nama_supplier` varchar(100)
,`validasi_supplier` tinyint(1)
,`ket_validasi_supplier` varchar(11)
,`id_akun_kas` int(11) unsigned
,`nama_akun_kas` varchar(50)
,`id_pj_akun_kas` bigint(20) unsigned
,`kode_user_pj_akun_kas` varchar(18)
,`nama_pj_akun_kas` varchar(100)
,`nominal_kas` double
,`validasi_akun_kas` tinyint(1)
,`ket_validasi_akun_kas` varchar(11)
,`id_reknt` int(11) unsigned
,`nomor_reknt` varchar(50)
,`atas_nama_reknt` varchar(100)
,`id_lk` int(11) unsigned
,`nama_lk` varchar(100)
,`id_pj_reknt` bigint(20) unsigned
,`kode_user_pj_reknt` varchar(18)
,`nama_pj_reknt` varchar(100)
,`nominal_reknt` double
,`validasi_reknt` tinyint(1)
,`ket_validasi_reknt` varchar(11)
,`total_nominal` double
,`keterangan_tambahan` text
,`bentuk_bukti_trx` enum('Foto','Dokumen')
,`file_bukti_trx` varchar(100)
,`validasi_trx` tinyint(1)
,`ket_validasi_trx` varchar(11)
,`created_by` bigint(20) unsigned
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`updated_by` bigint(20) unsigned
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`deleted_by` bigint(20) unsigned
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `view_users`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `view_users` (
`id` bigint(20) unsigned
,`kode_user` varchar(18)
,`jenis_user` enum('Individu','Badan Usaha')
,`jenis_badan_usaha` enum('C.V.','Firma','P.T.','Koperasi','Yayasan')
,`nama_badan_usaha` varchar(100)
,`id_cabang` int(11) unsigned
,`nama_cabang` varchar(100)
,`nama` varchar(100)
,`nomor_nik` varchar(16)
,`gender` enum('Pria','Wanita')
,`id_tempat_lahir` int(11) unsigned
,`kokab_tempat_lahir` varchar(150)
,`tanggal_lahir` date
,`alamat_tt` text
,`rt_tt` varchar(3)
,`rw_tt` varchar(3)
,`id_kelurahan_tt` int(11) unsigned
,`nama_kelurahan_tt` varchar(100)
,`nama_kecamatan_tt` varchar(100)
,`nama_kokab_tt` varchar(150)
,`nama_propinsi_tt` varchar(100)
,`nama_negara_tt` varchar(200)
,`kode_pos_tt` varchar(5)
,`email` varchar(150)
,`nomor_wa` varchar(20)
,`foto_ktp` varchar(100)
,`foto_diri` varchar(100)
,`foto_profil` varchar(100)
,`username` varchar(50)
,`password` varchar(255)
,`peran` enum('Maha Dewa','Owner','Investor','Manajemen','Supplier','Pelanggan')
,`investor` tinyint(1)
,`nomor_coa_modal` varchar(100)
,`nama_coa_modal` varchar(200)
,`trx_input_modal` double(19,2)
,`nomor_coa_prive` varchar(100)
,`nama_coa_prive` varchar(200)
,`trx_prive` double(19,2)
,`saldo_investasi` double(19,2)
,`prosentase_modal` double(19,2)
,`limit_deposit_supplier` double
,`limit_hutang_pelanggan` double
,`limit_kasbon_sdm` double
,`saldo_deposit` double(19,2)
,`saldo_kasbon` double(19,2)
,`status` enum('Aktif','Suspended','Keluar','Dikeluarkan')
,`is_logged_in` tinyint(1)
,`last_login_device` enum('Windows','Android','Website','iOS','macOS')
,`device_id` varchar(255)
,`last_login_at` datetime
,`last_active_at` datetime
,`diinput_oleh` varchar(100)
,`created_at` datetime
,`diubah_oleh` varchar(100)
,`updated_at` datetime
,`dihapus_oleh` varchar(100)
,`deleted_at` datetime
);

-- --------------------------------------------------------

--
-- Struktur untuk view `view_akun_kas`
--
DROP TABLE IF EXISTS `view_akun_kas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_akun_kas`  AS SELECT `ak`.`id` AS `id`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`nomor_coa` AS `nomor_coa`, `c`.`nama_coa` AS `nama_coa`, `ak`.`id_pj` AS `id_pj`, `u`.`kode_user` AS `kode_user_pj`, `u`.`nama` AS `nama_pj`, `ak`.`validasi_pj` AS `validasi_pj`, CASE `ak`.`validasi_pj` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Disetujui' WHEN 2 THEN 'Ditolak' END AS `ket_validasi_pj`, `ak`.`aktif` AS `aktif`, CASE `ak`.`aktif` WHEN 0 THEN 'Tidak/Belum Aktif' WHEN 1 THEN 'Aktif' END AS `ket_aktif`, round((select coalesce(sum(`trx_jurnal_umum`.`trx_debet`),0) from `trx_jurnal_umum` where `trx_jurnal_umum`.`nomor_coa` = `ak`.`nomor_coa` and `trx_jurnal_umum`.`validasi_trx` = 1 and `trx_jurnal_umum`.`deleted_at` is null) - (select coalesce(sum(`trx_jurnal_umum`.`trx_kredit`),0) from `trx_jurnal_umum` where `trx_jurnal_umum`.`nomor_coa` = `ak`.`nomor_coa` and `trx_jurnal_umum`.`validasi_trx` = 1 and `trx_jurnal_umum`.`deleted_at` is null),2) AS `saldo`, `ak`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `ak`.`created_at` AS `created_at`, `ak`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `ak`.`updated_at` AS `updated_at`, `ak`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `ak`.`deleted_at` AS `deleted_at` FROM (((((`akun_kas` `ak` left join `coa` `c` on(`ak`.`nomor_coa` = `c`.`nomor_coa`)) left join `users` `u` on(`ak`.`id_pj` = `u`.`id`)) left join `users` `ucb` on(`ak`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`ak`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`ak`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_cabang`
--
DROP TABLE IF EXISTS `view_cabang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_cabang`  AS SELECT `cb`.`id` AS `id`, `cb`.`nama_cabang` AS `nama_cabang`, `cb`.`alamat` AS `alamat`, `cb`.`rt` AS `rt`, `cb`.`rw` AS `rw`, `cb`.`id_kelurahan` AS `id_kelurahan`, `rgkl`.`nama_kelurahan` AS `nama_kelurahan`, `rgkc`.`nama_kecamatan` AS `nama_kecamatan`, `rgkkbtt`.`nama_lengkap_kokab` AS `nama_kokab`, `rgprp`.`nama_propinsi` AS `nama_propinsi`, `rgng`.`nama_negara` AS `nama_negara`, `rgkl`.`kode_pos` AS `kode_pos`, `cb`.`nomor_telp` AS `nomor_telp`, `cb`.`nomor_wa` AS `nomor_wa`, `cb`.`fax` AS `fax`, `cb`.`email` AS `email`, `cb`.`id_kepala_cabang` AS `id_kepala_cabang`, `u`.`nama` AS `nama_kepala_cabang`, `cb`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `cb`.`created_at` AS `created_at`, `cb`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `cb`.`updated_at` AS `updated_at`, `cb`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `cb`.`deleted_at` AS `deleted_at` FROM (((((((((`cabang` `cb` left join `regional`.`kelurahan` `rgkl` on(`cb`.`id_kelurahan` = `rgkl`.`id`)) left join `regional`.`kecamatan` `rgkc` on(`rgkl`.`id_kecamatan` = `rgkc`.`id`)) left join `regional`.`kokab` `rgkkbtt` on(`rgkl`.`id_kokab` = `rgkkbtt`.`id`)) left join `regional`.`propinsi` `rgprp` on(`rgkl`.`id_propinsi` = `rgprp`.`id`)) left join `regional`.`negara` `rgng` on(`rgkl`.`id_negara` = `rgng`.`id`)) left join `users` `u` on(`cb`.`id_kepala_cabang` = `u`.`id`)) left join `users` `ucb` on(`u`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`u`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`u`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_coa`
--
DROP TABLE IF EXISTS `view_coa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_coa`  AS SELECT `c`.`nomor_coa` AS `nomor_coa`, `c`.`nama_coa` AS `nama_coa`, `c`.`nomor_coa_induk` AS `nomor_coa_induk`, `c`.`nama_coa_induk` AS `nama_coa_induk`, `c`.`tingkat` AS `tingkat`, `c`.`saldo_normal` AS `saldo_normal`, `c`.`trx_debet` AS `trx_debet`, `c`.`trx_kredit` AS `trx_kredit`, `c`.`saldo` AS `saldo`, `c`.`permanen` AS `permanen`, `c`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `c`.`created_at` AS `created_at`, `c`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `c`.`updated_at` AS `updated_at`, `c`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `c`.`deleted_at` AS `deleted_at` FROM (((`coa` `c` left join `users` `ucb` on(`c`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`c`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`c`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_lembaga_keuangan`
--
DROP TABLE IF EXISTS `view_lembaga_keuangan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_lembaga_keuangan`  AS SELECT `lk`.`id` AS `id`, `lk`.`nama` AS `nama`, `lk`.`logo` AS `logo`, `lk`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `lk`.`created_at` AS `created_at`, `lk`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `lk`.`updated_at` AS `updated_at`, `lk`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `lk`.`deleted_at` AS `deleted_at` FROM (((`lembaga_keuangan` `lk` left join `users` `ucb` on(`lk`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`lk`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`lk`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_profil_perusahaan`
--
DROP TABLE IF EXISTS `view_profil_perusahaan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_profil_perusahaan`  AS SELECT `pp`.`id` AS `id`, `pp`.`bentuk_perusahaan` AS `bentuk_perusahaan`, `pp`.`sudah_pkp` AS `sudah_pkp`, `pp`.`npwp_perusahaan` AS `npwp_perusahaan`, `pp`.`nama_perusahaan` AS `nama_perusahaan`, `pp`.`alamat` AS `alamat`, `pp`.`rt` AS `rt`, `pp`.`rw` AS `rw`, `pp`.`id_kelurahan` AS `id_kelurahan`, `rgkl`.`nama_kelurahan` AS `nama_kelurahan`, `rgkc`.`nama_kecamatan` AS `nama_kecamatan`, `rgkkbtt`.`nama_lengkap_kokab` AS `nama_kokab`, `rgprp`.`nama_propinsi` AS `nama_propinsi`, `rgng`.`nama_negara` AS `nama_negara`, `rgkl`.`kode_pos` AS `kode_pos`, `pp`.`nomor_telp` AS `nomor_telp`, `pp`.`nomor_wa` AS `nomor_wa`, `pp`.`fax` AS `fax`, `pp`.`email` AS `email`, `pp`.`website` AS `website`, `pp`.`id_ceo` AS `id_ceo`, `u`.`nama` AS `nama_ceo`, `pp`.`logo` AS `logo`, `pp`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `pp`.`created_at` AS `created_at`, `pp`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `pp`.`updated_at` AS `updated_at`, `pp`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `pp`.`deleted_at` AS `deleted_at` FROM (((((((((`profil_perusahaan` `pp` left join `regional`.`kelurahan` `rgkl` on(`pp`.`id_kelurahan` = `rgkl`.`id`)) left join `regional`.`kecamatan` `rgkc` on(`rgkl`.`id_kecamatan` = `rgkc`.`id`)) left join `regional`.`kokab` `rgkkbtt` on(`rgkl`.`id_kokab` = `rgkkbtt`.`id`)) left join `regional`.`propinsi` `rgprp` on(`rgkl`.`id_propinsi` = `rgprp`.`id`)) left join `regional`.`negara` `rgng` on(`rgkl`.`id_negara` = `rgng`.`id`)) left join `users` `u` on(`pp`.`id_ceo` = `u`.`id`)) left join `users` `ucb` on(`pp`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`pp`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`pp`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_reknt`
--
DROP TABLE IF EXISTS `view_reknt`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reknt`  AS SELECT `r`.`id` AS `id`, `r`.`nomor_rekening` AS `nomor_rekening`, `r`.`atas_nama` AS `atas_nama`, `r`.`nomor_coa` AS `nomor_coa`, `c`.`nama_coa` AS `nama_coa`, `r`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `r`.`id_pj` AS `id_pj`, `u`.`kode_user` AS `kode_user_pj`, `u`.`nama` AS `nama_pj`, `r`.`validasi_pj` AS `validasi_pj`, CASE `r`.`validasi_pj` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Disetujui' WHEN 2 THEN 'Ditolak' END AS `ket_validasi_pj`, `r`.`aktif` AS `aktif`, CASE `r`.`aktif` WHEN 0 THEN 'Tidak/Belum Aktif' WHEN 1 THEN 'Aktif' END AS `ket_aktif`, round((select coalesce(sum(`trx_jurnal_umum`.`trx_debet`),0) from `trx_jurnal_umum` where `trx_jurnal_umum`.`nomor_coa` = `r`.`nomor_coa` and `trx_jurnal_umum`.`validasi_trx` = 1 and `trx_jurnal_umum`.`deleted_at` is null) - (select coalesce(sum(`trx_jurnal_umum`.`trx_kredit`),0) from `trx_jurnal_umum` where `trx_jurnal_umum`.`nomor_coa` = `r`.`nomor_coa` and `trx_jurnal_umum`.`validasi_trx` = 1 and `trx_jurnal_umum`.`deleted_at` is null),2) AS `saldo`, `r`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `r`.`created_at` AS `created_at`, `r`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `r`.`updated_at` AS `updated_at`, `r`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `r`.`deleted_at` AS `deleted_at` FROM ((((((`reknt` `r` left join `coa` `c` on(`r`.`nomor_coa` = `c`.`nomor_coa`)) left join `lembaga_keuangan` `lk` on(`r`.`id_lk` = `lk`.`id`)) left join `users` `u` on(`r`.`id_pj` = `u`.`id`)) left join `users` `ucb` on(`r`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`r`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`r`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_reknt_users`
--
DROP TABLE IF EXISTS `view_reknt_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_reknt_users`  AS SELECT `ru`.`id` AS `id`, `ru`.`id_user` AS `id_user`, `ru`.`nomor_rekening` AS `nomor_rekening`, `ru`.`atas_nama` AS `atas_nama`, `ru`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `ru`.`validasi_admin` AS `validasi_admin`, CASE `ru`.`validasi_admin` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_admin`, `ru`.`is_default` AS `is_default`, CASE `ru`.`is_default` WHEN 0 THEN '' WHEN 1 THEN 'Default' END AS `ket_is_default`, `ru`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `ru`.`created_at` AS `created_at`, `ru`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `ru`.`updated_at` AS `updated_at`, `ru`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `ru`.`deleted_at` AS `deleted_at` FROM ((((`reknt_users` `ru` left join `lembaga_keuangan` `lk` on(`ru`.`id_lk` = `lk`.`id`)) left join `users` `ucb` on(`ru`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`ru`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`ru`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_antar_kas`
--
DROP TABLE IF EXISTS `view_trx_antar_kas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_antar_kas`  AS SELECT `tak`.`id_trx` AS `id_trx`, `tak`.`waktu_trx` AS `waktu_trx`, `tak`.`id_ak_awal` AS `id_ak_awal`, `ak1`.`nama_akun_kas` AS `nama_ak_awal`, `ak1`.`id_pj` AS `id_pj_ak_awal`, `u1`.`kode_user` AS `kode_user_pj_ak_awal`, `u1`.`nama` AS `nama_user_pj_ak_awal`, `tak`.`vpj_ak_awal` AS `vpj_ak_awal`, CASE `tak`.`vpj_ak_awal` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_vpj_ak_awal`, `tak`.`id_ak_akhir` AS `id_ak_akhir`, `ak2`.`nama_akun_kas` AS `nama_ak_akhir`, `ak2`.`id_pj` AS `id_pj_ak_akhir`, `u2`.`kode_user` AS `kode_user_pj_ak_akhir`, `u2`.`nama` AS `nama_user_pj_ak_akhir`, `tak`.`vpj_ak_akhir` AS `vpj_ak_akhir`, CASE `tak`.`vpj_ak_akhir` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_vpj_ak_akhir`, `tak`.`validasi_trx` AS `validasi_trx`, CASE `tak`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tak`.`nominal` AS `nominal`, `tak`.`keterangan_tambahan` AS `keterangan_tambahan`, `tak`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tak`.`file_bukti_trx` AS `file_bukti_trx`, `tak`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tak`.`created_at` AS `created_at`, `tak`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tak`.`updated_at` AS `updated_at`, `tak`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tak`.`deleted_at` AS `deleted_at` FROM (((((((`trx_antar_kas` `tak` left join `akun_kas` `ak1` on(`tak`.`id_ak_awal` = `ak1`.`id`)) left join `users` `u1` on(`ak1`.`id_pj` = `u1`.`id`)) left join `akun_kas` `ak2` on(`tak`.`id_ak_akhir` = `ak2`.`id`)) left join `users` `u2` on(`ak2`.`id_pj` = `u2`.`id`)) left join `users` `ucb` on(`tak`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tak`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tak`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_antar_reknt`
--
DROP TABLE IF EXISTS `view_trx_antar_reknt`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_antar_reknt`  AS SELECT `tar`.`id_trx` AS `id_trx`, `tar`.`waktu_trx` AS `waktu_trx`, `tar`.`id_reknt_awal` AS `id_reknt_awal`, `r1`.`nomor_rekening` AS `nomor_reknt_awal`, `r1`.`atas_nama` AS `atas_nama_reknt_awal`, `r1`.`id_lk` AS `id_lk_reknt_awal`, `lk1`.`nama` AS `nama_lk_reknt_awal`, `r1`.`id_pj` AS `id_pj_reknt_awal`, `u1`.`kode_user` AS `kode_user_pj_reknt_awal`, `u1`.`nama` AS `nama_pj_reknt_awal`, `tar`.`vpj_reknt_awal` AS `vpj_reknt_awal`, CASE `tar`.`vpj_reknt_awal` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_vpj_reknt_awal`, `tar`.`id_reknt_akhir` AS `id_reknt_akhir`, `r2`.`nomor_rekening` AS `nomor_reknt_akhir`, `r2`.`atas_nama` AS `atas_nama_reknt_akhir`, `r2`.`id_lk` AS `id_lk_reknt_akhir`, `lk2`.`nama` AS `nama_lk_reknt_akhir`, `r2`.`id_pj` AS `id_pj_reknt_akhir`, `u2`.`kode_user` AS `kode_user_pj_reknt_akhir`, `u2`.`nama` AS `nama_pj_reknt_akhir`, `tar`.`vpj_reknt_akhir` AS `vpj_reknt_akhir`, CASE `tar`.`vpj_reknt_akhir` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_vpj_reknt_akhir`, `tar`.`validasi_trx` AS `validasi_trx`, CASE `tar`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tar`.`nominal` AS `nominal`, `tar`.`keterangan_tambahan` AS `keterangan_tambahan`, `tar`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tar`.`file_bukti_trx` AS `file_bukti_trx`, `tar`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tar`.`created_at` AS `created_at`, `tar`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tar`.`updated_at` AS `updated_at`, `tar`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tar`.`deleted_at` AS `deleted_at` FROM (((((((((`trx_antar_reknt` `tar` left join `reknt` `r1` on(`tar`.`id_reknt_awal` = `r1`.`id`)) left join `lembaga_keuangan` `lk1` on(`r1`.`id_lk` = `lk1`.`id`)) left join `users` `u1` on(`r1`.`id_pj` = `u1`.`id`)) left join `reknt` `r2` on(`tar`.`id_reknt_akhir` = `r2`.`id`)) left join `lembaga_keuangan` `lk2` on(`r2`.`id_lk` = `lk2`.`id`)) left join `users` `u2` on(`r2`.`id_pj` = `u2`.`id`)) left join `users` `ucb` on(`tar`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tar`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tar`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_bayar_kasbon_sdm`
--
DROP TABLE IF EXISTS `view_trx_bayar_kasbon_sdm`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_bayar_kasbon_sdm`  AS SELECT `tbks`.`id_trx` AS `id_trx`, `tbks`.`waktu_trx` AS `waktu_trx`, `tbks`.`id_sdm` AS `id_sdm`, `ui`.`kode_user` AS `kode_sdm`, `ui`.`nama` AS `nama_sdm`, `tbks`.`validasi_sdm` AS `validasi_sdm`, CASE `tbks`.`validasi_sdm` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_sdm`, `tbks`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tbks`.`nominal_kas` AS `nominal_kas`, `tbks`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tbks`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tbks`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tbks`.`nominal_reknt` AS `nominal_reknt`, `tbks`.`validasi_reknt` AS `validasi_reknt`, CASE `tbks`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tbks`.`total_nominal` AS `total_nominal`, `tbks`.`keterangan_tambahan` AS `keterangan_tambahan`, `tbks`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tbks`.`file_bukti_trx` AS `file_bukti_trx`, `tbks`.`validasi_trx` AS `validasi_trx`, CASE `tbks`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tbks`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tbks`.`created_at` AS `created_at`, `tbks`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tbks`.`updated_at` AS `updated_at`, `tbks`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tbks`.`deleted_at` AS `deleted_at` FROM (((((((((`trx_bayar_kasbon_sdm` `tbks` left join `users` `ui` on(`tbks`.`id_sdm` = `ui`.`id`)) left join `akun_kas` `ak` on(`tbks`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tbks`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `users` `ucb` on(`tbks`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tbks`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tbks`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_deposit_pelanggan`
--
DROP TABLE IF EXISTS `view_trx_deposit_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_deposit_pelanggan`  AS SELECT `tdp`.`id_trx` AS `id_trx`, `tdp`.`waktu_trx` AS `waktu_trx`, `tdp`.`id_pelanggan` AS `id_pelanggan`, `ui`.`kode_user` AS `kode_pelanggan`, `ui`.`nama` AS `nama_pelanggan`, `tdp`.`validasi_pelanggan` AS `validasi_pelanggan`, CASE `tdp`.`validasi_pelanggan` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_pelanggan`, `tdp`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tdp`.`nominal_kas` AS `nominal_kas`, `tdp`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tdp`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tdp`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tdp`.`nominal_reknt` AS `nominal_reknt`, `tdp`.`validasi_reknt` AS `validasi_reknt`, CASE `tdp`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tdp`.`total_nominal` AS `total_nominal`, `tdp`.`keterangan_tambahan` AS `keterangan_tambahan`, `tdp`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tdp`.`file_bukti_trx` AS `file_bukti_trx`, `tdp`.`validasi_trx` AS `validasi_trx`, CASE `tdp`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tdp`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tdp`.`created_at` AS `created_at`, `tdp`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tdp`.`updated_at` AS `updated_at`, `tdp`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tdp`.`deleted_at` AS `deleted_at` FROM (((((((((`trx_deposit_pelanggan` `tdp` left join `users` `ui` on(`tdp`.`id_pelanggan` = `ui`.`id`)) left join `akun_kas` `ak` on(`tdp`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tdp`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `users` `ucb` on(`tdp`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tdp`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tdp`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_deposit_supplier`
--
DROP TABLE IF EXISTS `view_trx_deposit_supplier`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_deposit_supplier`  AS SELECT `tds`.`id_trx` AS `id_trx`, `tds`.`waktu_trx` AS `waktu_trx`, `tds`.`id_supplier` AS `id_supplier`, `ui`.`kode_user` AS `kode_supplier`, `ui`.`nama` AS `nama_supplier`, `tds`.`validasi_supplier` AS `validasi_supplier`, CASE `tds`.`validasi_supplier` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_supplier`, `tds`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tds`.`nominal_kas` AS `nominal_kas`, `tds`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tds`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tds`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tds`.`nominal_reknt` AS `nominal_reknt`, `tds`.`validasi_reknt` AS `validasi_reknt`, CASE `tds`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tds`.`id_reknt_user` AS `id_reknt_user`, `rntu`.`nomor_rekening` AS `nomor_reknt_user`, `rntu`.`atas_nama` AS `atas_nama_reknt_user`, `rntu`.`id_lk` AS `id_lk_reknt_user`, `lku`.`nama` AS `nama_lk_reknt_user`, `tds`.`total_nominal` AS `total_nominal`, `tds`.`keterangan_tambahan` AS `keterangan_tambahan`, `tds`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tds`.`file_bukti_trx` AS `file_bukti_trx`, `tds`.`validasi_trx` AS `validasi_trx`, CASE `tds`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tds`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tds`.`created_at` AS `created_at`, `tds`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tds`.`updated_at` AS `updated_at`, `tds`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tds`.`deleted_at` AS `deleted_at` FROM (((((((((((`trx_deposit_supplier` `tds` left join `users` `ui` on(`tds`.`id_supplier` = `ui`.`id`)) left join `akun_kas` `ak` on(`tds`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tds`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `reknt_users` `rntu` on(`tds`.`id_reknt_user` = `rntu`.`id`)) left join `lembaga_keuangan` `lku` on(`rntu`.`id_lk` = `lku`.`id`)) left join `users` `ucb` on(`tds`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tds`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tds`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_input_modal`
--
DROP TABLE IF EXISTS `view_trx_input_modal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_input_modal`  AS SELECT `tim`.`id_trx` AS `id_trx`, `tim`.`waktu_trx` AS `waktu_trx`, `tim`.`id_investor` AS `id_investor`, `ui`.`kode_user` AS `kode_investor`, `ui`.`nama` AS `nama_investor`, `tim`.`validasi_investor` AS `validasi_investor`, CASE `tim`.`validasi_investor` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_investor`, `tim`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tim`.`nominal_kas` AS `nominal_kas`, `tim`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tim`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tim`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tim`.`nominal_reknt` AS `nominal_reknt`, `tim`.`validasi_reknt` AS `validasi_reknt`, CASE `tim`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tim`.`total_nominal` AS `total_nominal`, `tim`.`keterangan_tambahan` AS `keterangan_tambahan`, `tim`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tim`.`file_bukti_trx` AS `file_bukti_trx`, `tim`.`validasi_trx` AS `validasi_trx`, CASE `tim`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tim`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tim`.`created_at` AS `created_at`, `tim`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tim`.`updated_at` AS `updated_at`, `tim`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tim`.`deleted_at` AS `deleted_at` FROM (((((((((`trx_input_modal` `tim` left join `users` `ui` on(`tim`.`id_investor` = `ui`.`id`)) left join `akun_kas` `ak` on(`tim`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tim`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `users` `ucb` on(`tim`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tim`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tim`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_jurnal_umum`
--
DROP TABLE IF EXISTS `view_trx_jurnal_umum`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_jurnal_umum`  AS SELECT `tju`.`id_trx` AS `id_trx`, `tju`.`waktu_trx` AS `waktu_trx`, `tju`.`sumber_id_trx` AS `sumber_id_trx`, `tju`.`jenis_entitas` AS `jenis_entitas`, `tju`.`id_entitas` AS `id_entitas`, `uent`.`kode_user` AS `kode_entitas`, `uent`.`nama` AS `nama_entitas`, `uent`.`peran` AS `peran_entitas`, `tju`.`kode_ju` AS `kode_ju`, `kju`.`nama` AS `keterangan_ju`, `tju`.`nomor_coa` AS `nomor_coa`, `c`.`nama_coa` AS `nama_coa`, round(`tju`.`trx_debet`,2) AS `trx_debet`, round(`tju`.`trx_kredit`,2) AS `trx_kredit`, `tju`.`keterangan_tambahan` AS `keterangan_tambahan`, `tju`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tju`.`file_bukti_trx` AS `file_bukti_trx`, `tju`.`validasi_trx` AS `validasi_trx`, CASE `tju`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' ELSE 'Tidak Valid' END AS `ket_validasi_trx`, `tju`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tju`.`created_at` AS `created_at`, `tju`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tju`.`updated_at` AS `updated_at`, `tju`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tju`.`deleted_at` AS `deleted_at` FROM ((((((`trx_jurnal_umum` `tju` left join `users` `uent` on(`tju`.`id_entitas` = `uent`.`id`)) left join `kode_trx_ju` `kju` on(`tju`.`kode_ju` = `kju`.`id`)) left join `coa` `c` on(`tju`.`nomor_coa` = `c`.`nomor_coa`)) left join `users` `ucb` on(`tju`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tju`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tju`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_kasbon_sdm`
--
DROP TABLE IF EXISTS `view_trx_kasbon_sdm`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_kasbon_sdm`  AS SELECT `tks`.`id_trx` AS `id_trx`, `tks`.`waktu_trx` AS `waktu_trx`, `tks`.`id_sdm` AS `id_sdm`, `ui`.`kode_user` AS `kode_sdm`, `ui`.`nama` AS `nama_sdm`, `tks`.`validasi_sdm` AS `validasi_sdm`, CASE `tks`.`validasi_sdm` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_sdm`, `tks`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tks`.`nominal_kas` AS `nominal_kas`, `tks`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tks`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tks`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tks`.`nominal_reknt` AS `nominal_reknt`, `tks`.`validasi_reknt` AS `validasi_reknt`, CASE `tks`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tks`.`id_reknt_user` AS `id_reknt_user`, `rntu`.`nomor_rekening` AS `nomor_reknt_user`, `rntu`.`atas_nama` AS `atas_nama_reknt_user`, `rntu`.`id_lk` AS `id_lk_reknt_user`, `lku`.`nama` AS `nama_lk_reknt_user`, `tks`.`total_nominal` AS `total_nominal`, `tks`.`keterangan_tambahan` AS `keterangan_tambahan`, `tks`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tks`.`file_bukti_trx` AS `file_bukti_trx`, `tks`.`validasi_trx` AS `validasi_trx`, CASE `tks`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tks`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tks`.`created_at` AS `created_at`, `tks`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tks`.`updated_at` AS `updated_at`, `tks`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tks`.`deleted_at` AS `deleted_at` FROM (((((((((((`trx_kasbon_sdm` `tks` left join `users` `ui` on(`tks`.`id_sdm` = `ui`.`id`)) left join `akun_kas` `ak` on(`tks`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tks`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `reknt_users` `rntu` on(`tks`.`id_reknt_user` = `rntu`.`id`)) left join `lembaga_keuangan` `lku` on(`rntu`.`id_lk` = `lku`.`id`)) left join `users` `ucb` on(`tks`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tks`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tks`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_notifikasi`
--
DROP TABLE IF EXISTS `view_trx_notifikasi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_notifikasi`  AS SELECT `tntf`.`id_trx` AS `id_trx`, `tntf`.`waktu_trx` AS `waktu_trx`, `tntf`.`sumber_id_trx` AS `sumber_id_trx`, `tntf`.`nama_kolom_primary` AS `nama_kolom_primary`, `tntf`.`jenis_notifikasi` AS `jenis_notifikasi`, `tntf`.`judul_notif` AS `judul_notif`, `tntf`.`isi_notif` AS `isi_notif`, `tntf`.`jenis_entitas` AS `jenis_entitas`, `tntf`.`id_entitas` AS `id_entitas`, CASE WHEN `tntf`.`jenis_entitas` = 'User' THEN (select `users`.`nama` from `users` where `users`.`id` = `tntf`.`id_entitas`) WHEN `tntf`.`jenis_entitas` = 'Lembaga Keuangan' THEN (select `lembaga_keuangan`.`nama` from `lembaga_keuangan` where `lembaga_keuangan`.`id` = `tntf`.`id_entitas`) END AS `nama_entitas`, `tntf`.`nama_tabel` AS `nama_tabel`, `tntf`.`nama_kolom` AS `nama_kolom`, `tntf`.`sudah_dibaca` AS `sudah_dibaca`, CASE `tntf`.`sudah_dibaca` WHEN 0 THEN 'Belum Dibaca' WHEN 1 THEN 'Sudah Dibaca' END AS `ket_sudah_dibaca`, `tntf`.`status_selesai` AS `status_selesai`, CASE `tntf`.`status_selesai` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Setuju' WHEN 2 THEN 'Ditolak' END AS `ket_status_selesai`, `tntf`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tntf`.`created_at` AS `created_at`, `tntf`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tntf`.`updated_at` AS `updated_at`, `tntf`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tntf`.`deleted_at` AS `deleted_at` FROM (((`trx_notifikasi` `tntf` left join `users` `ucb` on(`tntf`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tntf`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tntf`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_prive`
--
DROP TABLE IF EXISTS `view_trx_prive`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_prive`  AS SELECT `tpv`.`id_trx` AS `id_trx`, `tpv`.`waktu_trx` AS `waktu_trx`, `tpv`.`id_investor` AS `id_investor`, `ui`.`kode_user` AS `kode_investor`, `ui`.`nama` AS `nama_investor`, `tpv`.`validasi_investor` AS `validasi_investor`, CASE `tpv`.`validasi_investor` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_investor`, `tpv`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `tpv`.`nominal_kas` AS `nominal_kas`, `tpv`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `tpv`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `tpv`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `tpv`.`nominal_reknt` AS `nominal_reknt`, `tpv`.`validasi_reknt` AS `validasi_reknt`, CASE `tpv`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `tpv`.`id_reknt_user` AS `id_reknt_user`, `rntu`.`nomor_rekening` AS `nomor_reknt_user`, `rntu`.`atas_nama` AS `atas_nama_reknt_user`, `rntu`.`id_lk` AS `id_lk_reknt_user`, `lku`.`nama` AS `nama_lk_reknt_user`, `tpv`.`total_nominal` AS `total_nominal`, `tpv`.`keterangan_tambahan` AS `keterangan_tambahan`, `tpv`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `tpv`.`file_bukti_trx` AS `file_bukti_trx`, `tpv`.`validasi_trx` AS `validasi_trx`, CASE `tpv`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `tpv`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `tpv`.`created_at` AS `created_at`, `tpv`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `tpv`.`updated_at` AS `updated_at`, `tpv`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `tpv`.`deleted_at` AS `deleted_at` FROM (((((((((((`trx_prive` `tpv` left join `users` `ui` on(`tpv`.`id_investor` = `ui`.`id`)) left join `akun_kas` `ak` on(`tpv`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`tpv`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `reknt_users` `rntu` on(`tpv`.`id_reknt_user` = `rntu`.`id`)) left join `lembaga_keuangan` `lku` on(`rntu`.`id_lk` = `lku`.`id`)) left join `users` `ucb` on(`tpv`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`tpv`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`tpv`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_wd_deposit_pelanggan`
--
DROP TABLE IF EXISTS `view_trx_wd_deposit_pelanggan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_wd_deposit_pelanggan`  AS SELECT `twdp`.`id_trx` AS `id_trx`, `twdp`.`waktu_trx` AS `waktu_trx`, `twdp`.`id_pelanggan` AS `id_pelanggan`, `ui`.`kode_user` AS `kode_pelanggan`, `ui`.`nama` AS `nama_pelanggan`, `twdp`.`validasi_pelanggan` AS `validasi_pelanggan`, CASE `twdp`.`validasi_pelanggan` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_pelanggan`, `twdp`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `twdp`.`nominal_kas` AS `nominal_kas`, `twdp`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `twdp`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `twdp`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `twdp`.`nominal_reknt` AS `nominal_reknt`, `twdp`.`validasi_reknt` AS `validasi_reknt`, CASE `twdp`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `twdp`.`id_reknt_user` AS `id_reknt_user`, `rntu`.`nomor_rekening` AS `nomor_reknt_user`, `rntu`.`atas_nama` AS `atas_nama_reknt_user`, `rntu`.`id_lk` AS `id_lk_reknt_user`, `lku`.`nama` AS `nama_lk_reknt_user`, `twdp`.`total_nominal` AS `total_nominal`, `twdp`.`keterangan_tambahan` AS `keterangan_tambahan`, `twdp`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `twdp`.`file_bukti_trx` AS `file_bukti_trx`, `twdp`.`validasi_trx` AS `validasi_trx`, CASE `twdp`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `twdp`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `twdp`.`created_at` AS `created_at`, `twdp`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `twdp`.`updated_at` AS `updated_at`, `twdp`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `twdp`.`deleted_at` AS `deleted_at` FROM (((((((((((`trx_wd_deposit_pelanggan` `twdp` left join `users` `ui` on(`twdp`.`id_pelanggan` = `ui`.`id`)) left join `akun_kas` `ak` on(`twdp`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`twdp`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `reknt_users` `rntu` on(`twdp`.`id_reknt_user` = `rntu`.`id`)) left join `lembaga_keuangan` `lku` on(`rntu`.`id_lk` = `lku`.`id`)) left join `users` `ucb` on(`twdp`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`twdp`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`twdp`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_trx_wd_deposit_supplier`
--
DROP TABLE IF EXISTS `view_trx_wd_deposit_supplier`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_trx_wd_deposit_supplier`  AS SELECT `twds`.`id_trx` AS `id_trx`, `twds`.`waktu_trx` AS `waktu_trx`, `twds`.`id_supplier` AS `id_supplier`, `ui`.`kode_user` AS `kode_supplier`, `ui`.`nama` AS `nama_supplier`, `twds`.`validasi_supplier` AS `validasi_supplier`, CASE `twds`.`validasi_supplier` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_supplier`, `twds`.`id_akun_kas` AS `id_akun_kas`, `ak`.`nama_akun_kas` AS `nama_akun_kas`, `ak`.`id_pj` AS `id_pj_akun_kas`, `upjak`.`kode_user` AS `kode_user_pj_akun_kas`, `upjak`.`nama` AS `nama_pj_akun_kas`, `twds`.`nominal_kas` AS `nominal_kas`, `twds`.`validasi_akun_kas` AS `validasi_akun_kas`, CASE `twds`.`validasi_akun_kas` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_akun_kas`, `twds`.`id_reknt` AS `id_reknt`, `rnt`.`nomor_rekening` AS `nomor_reknt`, `rnt`.`atas_nama` AS `atas_nama_reknt`, `rnt`.`id_lk` AS `id_lk`, `lk`.`nama` AS `nama_lk`, `rnt`.`id_pj` AS `id_pj_reknt`, `upjrnt`.`kode_user` AS `kode_user_pj_reknt`, `upjrnt`.`nama` AS `nama_pj_reknt`, `twds`.`nominal_reknt` AS `nominal_reknt`, `twds`.`validasi_reknt` AS `validasi_reknt`, CASE `twds`.`validasi_reknt` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Benar' WHEN 2 THEN 'Tidak Benar' END AS `ket_validasi_reknt`, `twds`.`total_nominal` AS `total_nominal`, `twds`.`keterangan_tambahan` AS `keterangan_tambahan`, `twds`.`bentuk_bukti_trx` AS `bentuk_bukti_trx`, `twds`.`file_bukti_trx` AS `file_bukti_trx`, `twds`.`validasi_trx` AS `validasi_trx`, CASE `twds`.`validasi_trx` WHEN 0 THEN 'Pending' WHEN 1 THEN 'Valid' WHEN 2 THEN 'Tidak Valid' END AS `ket_validasi_trx`, `twds`.`created_by` AS `created_by`, `ucb`.`nama` AS `diinput_oleh`, `twds`.`created_at` AS `created_at`, `twds`.`updated_by` AS `updated_by`, `uub`.`nama` AS `diubah_oleh`, `twds`.`updated_at` AS `updated_at`, `twds`.`deleted_by` AS `deleted_by`, `udb`.`nama` AS `dihapus_oleh`, `twds`.`deleted_at` AS `deleted_at` FROM (((((((((`trx_wd_deposit_supplier` `twds` left join `users` `ui` on(`twds`.`id_supplier` = `ui`.`id`)) left join `akun_kas` `ak` on(`twds`.`id_akun_kas` = `ak`.`id`)) left join `users` `upjak` on(`ak`.`id_pj` = `upjak`.`id`)) left join `reknt` `rnt` on(`twds`.`id_reknt` = `rnt`.`id`)) left join `lembaga_keuangan` `lk` on(`rnt`.`id_lk` = `lk`.`id`)) left join `users` `upjrnt` on(`rnt`.`id_pj` = `upjrnt`.`id`)) left join `users` `ucb` on(`twds`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`twds`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`twds`.`deleted_by` = `udb`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `view_users`
--
DROP TABLE IF EXISTS `view_users`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_users`  AS SELECT `u`.`id` AS `id`, `u`.`kode_user` AS `kode_user`, `u`.`jenis_user` AS `jenis_user`, `u`.`jenis_badan_usaha` AS `jenis_badan_usaha`, `u`.`nama_badan_usaha` AS `nama_badan_usaha`, `u`.`id_cabang` AS `id_cabang`, `c`.`nama_cabang` AS `nama_cabang`, `u`.`nama` AS `nama`, `u`.`nomor_nik` AS `nomor_nik`, `u`.`gender` AS `gender`, `u`.`id_tempat_lahir` AS `id_tempat_lahir`, `rgkkb`.`nama_lengkap_kokab` AS `kokab_tempat_lahir`, `u`.`tanggal_lahir` AS `tanggal_lahir`, `u`.`alamat_tt` AS `alamat_tt`, `u`.`rt_tt` AS `rt_tt`, `u`.`rw_tt` AS `rw_tt`, `u`.`id_kelurahan_tt` AS `id_kelurahan_tt`, `rgkl`.`nama_kelurahan` AS `nama_kelurahan_tt`, `rgkc`.`nama_kecamatan` AS `nama_kecamatan_tt`, `rgkkbtt`.`nama_lengkap_kokab` AS `nama_kokab_tt`, `rgprp`.`nama_propinsi` AS `nama_propinsi_tt`, `rgng`.`nama_negara` AS `nama_negara_tt`, `rgkl`.`kode_pos` AS `kode_pos_tt`, `u`.`email` AS `email`, `u`.`nomor_wa` AS `nomor_wa`, `u`.`foto_ktp` AS `foto_ktp`, `u`.`foto_diri` AS `foto_diri`, `u`.`foto_profil` AS `foto_profil`, `u`.`username` AS `username`, `u`.`password` AS `password`, `u`.`peran` AS `peran`, `u`.`investor` AS `investor`, `u`.`nomor_coa_modal` AS `nomor_coa_modal`, `coam`.`nama_coa` AS `nama_coa_modal`, round((select coalesce(sum(`trx_input_modal`.`total_nominal`),0) from `trx_input_modal` where `trx_input_modal`.`id_investor` = `u`.`id` and `trx_input_modal`.`validasi_trx` = 1 and `trx_input_modal`.`deleted_at` is null),2) AS `trx_input_modal`, `u`.`nomor_coa_prive` AS `nomor_coa_prive`, `coap`.`nama_coa` AS `nama_coa_prive`, round((select coalesce(sum(`trx_prive`.`total_nominal`),0) from `trx_prive` where `trx_prive`.`id_investor` = `u`.`id` and `trx_prive`.`validasi_trx` = 1 and `trx_prive`.`deleted_at` is null),2) AS `trx_prive`, round((select coalesce(sum(`trx_input_modal`.`total_nominal`),2) from `trx_input_modal` where `trx_input_modal`.`id_investor` = `u`.`id` and `trx_input_modal`.`validasi_trx` = 1 and `trx_input_modal`.`deleted_at` is null) - (select coalesce(sum(`trx_prive`.`total_nominal`),2) from `trx_prive` where `trx_prive`.`id_investor` = `u`.`id` and `trx_prive`.`validasi_trx` = 1 and `trx_prive`.`deleted_at` is null),2) AS `saldo_investasi`, CASE WHEN (select coalesce(sum(`trx_input_modal`.`total_nominal`),0) from `trx_input_modal` where `trx_input_modal`.`validasi_trx` = 1 AND `trx_input_modal`.`deleted_at` is null) - (select coalesce(sum(`trx_prive`.`total_nominal`),0) from `trx_prive` where `trx_prive`.`validasi_trx` = 1 AND `trx_prive`.`deleted_at` is null) > 0 THEN round(((select coalesce(sum(`trx_input_modal`.`total_nominal`),0) from `trx_input_modal` where `trx_input_modal`.`id_investor` = `u`.`id` and `trx_input_modal`.`validasi_trx` = 1 and `trx_input_modal`.`deleted_at` is null) - (select coalesce(sum(`trx_prive`.`total_nominal`),0) from `trx_prive` where `trx_prive`.`id_investor` = `u`.`id` and `trx_prive`.`validasi_trx` = 1 and `trx_prive`.`deleted_at` is null)) / ((select coalesce(sum(`trx_input_modal`.`total_nominal`),0) from `trx_input_modal` where `trx_input_modal`.`validasi_trx` = 1 and `trx_input_modal`.`deleted_at` is null) - (select coalesce(sum(`trx_prive`.`total_nominal`),0) from `trx_prive` where `trx_prive`.`validasi_trx` = 1 and `trx_prive`.`deleted_at` is null)) * 100,2) ELSE 0 END AS `prosentase_modal`, `u`.`limit_deposit_supplier` AS `limit_deposit_supplier`, `u`.`limit_hutang_pelanggan` AS `limit_hutang_pelanggan`, `u`.`limit_kasbon_sdm` AS `limit_kasbon_sdm`, CASE WHEN `u`.`peran` = 'Supplier' THEN round((select coalesce(sum(`trx_deposit_supplier`.`total_nominal`),0) from `trx_deposit_supplier` where `trx_deposit_supplier`.`id_supplier` = `u`.`id` and `trx_deposit_supplier`.`validasi_trx` = 1 and `trx_deposit_supplier`.`deleted_at` is null) - (select coalesce(sum(`view_trx_wd_deposit_supplier`.`total_nominal`),0) from `view_trx_wd_deposit_supplier` where `view_trx_wd_deposit_supplier`.`id_supplier` = `u`.`id` and `view_trx_wd_deposit_supplier`.`validasi_trx` = 1 and `view_trx_wd_deposit_supplier`.`deleted_at` is null),2) WHEN `u`.`peran` = 'Pelanggan' THEN round((select coalesce(sum(`trx_deposit_pelanggan`.`total_nominal`),0) from `trx_deposit_pelanggan` where `trx_deposit_pelanggan`.`id_pelanggan` = `u`.`id` and `trx_deposit_pelanggan`.`validasi_trx` = 1 and `trx_deposit_pelanggan`.`deleted_at` is null) - (select coalesce(sum(`trx_wd_deposit_pelanggan`.`total_nominal`),0) from `trx_wd_deposit_pelanggan` where `trx_wd_deposit_pelanggan`.`id_pelanggan` = `u`.`id` and `trx_wd_deposit_pelanggan`.`validasi_trx` = 1 and `trx_wd_deposit_pelanggan`.`deleted_at` is null),2) ELSE 0 END AS `saldo_deposit`, CASE WHEN `u`.`peran` = 'Manajemen' THEN round((select coalesce(sum(`trx_kasbon_sdm`.`total_nominal`),0) from `trx_kasbon_sdm` where `trx_kasbon_sdm`.`id_sdm` = `u`.`id` and `trx_kasbon_sdm`.`validasi_trx` = 1 and `trx_kasbon_sdm`.`deleted_at` is null) - (select coalesce(sum(`trx_bayar_kasbon_sdm`.`total_nominal`),0) from `trx_bayar_kasbon_sdm` where `trx_bayar_kasbon_sdm`.`id_sdm` = `u`.`id` and `trx_bayar_kasbon_sdm`.`validasi_trx` = 1 and `trx_bayar_kasbon_sdm`.`deleted_at` is null),2) ELSE 0 END AS `saldo_kasbon`, `u`.`status` AS `status`, `u`.`is_logged_in` AS `is_logged_in`, `u`.`last_login_device` AS `last_login_device`, `u`.`device_id` AS `device_id`, `u`.`last_login_at` AS `last_login_at`, `u`.`last_active_at` AS `last_active_at`, `ucb`.`nama` AS `diinput_oleh`, `u`.`created_at` AS `created_at`, `uub`.`nama` AS `diubah_oleh`, `u`.`updated_at` AS `updated_at`, `udb`.`nama` AS `dihapus_oleh`, `u`.`deleted_at` AS `deleted_at` FROM ((((((((((((`users` `u` left join `cabang` `c` on(`u`.`id_cabang` = `c`.`id`)) left join `regional`.`kokab` `rgkkb` on(`u`.`id_tempat_lahir` = `rgkkb`.`id`)) left join `regional`.`kelurahan` `rgkl` on(`u`.`id_kelurahan_tt` = `rgkl`.`id`)) left join `regional`.`kecamatan` `rgkc` on(`rgkl`.`id_kecamatan` = `rgkc`.`id`)) left join `regional`.`kokab` `rgkkbtt` on(`rgkl`.`id_kokab` = `rgkkbtt`.`id`)) left join `regional`.`propinsi` `rgprp` on(`rgkl`.`id_propinsi` = `rgprp`.`id`)) left join `regional`.`negara` `rgng` on(`rgkl`.`id_negara` = `rgng`.`id`)) left join `coa` `coam` on(`u`.`nomor_coa_modal` = `coam`.`nomor_coa`)) left join `coa` `coap` on(`u`.`nomor_coa_prive` = `coap`.`nomor_coa`)) left join `users` `ucb` on(`u`.`created_by` = `ucb`.`id`)) left join `users` `uub` on(`u`.`updated_by` = `uub`.`id`)) left join `users` `udb` on(`u`.`deleted_by` = `udb`.`id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `akun_kas`
--
ALTER TABLE `akun_kas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_pj_2` (`id_pj`),
  ADD KEY `nomor_coa` (`nomor_coa`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_pj` (`id_pj`);

--
-- Indeks untuk tabel `cabang`
--
ALTER TABLE `cabang`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `coa`
--
ALTER TABLE `coa`
  ADD PRIMARY KEY (`nomor_coa`),
  ADD UNIQUE KEY `nama_coa` (`nama_coa`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indeks untuk tabel `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kode_tabel`
--
ALTER TABLE `kode_tabel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_tabel` (`nama_tabel`),
  ADD UNIQUE KEY `kode` (`kode_awal`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indeks untuk tabel `kode_trx_ju`
--
ALTER TABLE `kode_trx_ju`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indeks untuk tabel `lembaga_keuangan`
--
ALTER TABLE `lembaga_keuangan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `logo` (`logo`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indeks untuk tabel `profil_perusahaan`
--
ALTER TABLE `profil_perusahaan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_kelurahan` (`id_kelurahan`),
  ADD KEY `id_ceo` (`id_ceo`);

--
-- Indeks untuk tabel `reknt`
--
ALTER TABLE `reknt`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_lk` (`id_lk`),
  ADD KEY `id_pj` (`id_pj`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `nomor_coa` (`nomor_coa`);

--
-- Indeks untuk tabel `reknt_users`
--
ALTER TABLE `reknt_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_lk` (`id_lk`);

--
-- Indeks untuk tabel `setting_apps`
--
ALTER TABLE `setting_apps`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `setting_coa_default`
--
ALTER TABLE `setting_coa_default`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_coa_2` (`nomor_coa`),
  ADD KEY `nomor_coa` (`nomor_coa`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`);

--
-- Indeks untuk tabel `template_notifikasi`
--
ALTER TABLE `template_notifikasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`);

--
-- Indeks untuk tabel `tes`
--
ALTER TABLE `tes`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `to_do`
--
ALTER TABLE `to_do`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `trx_antar_kas`
--
ALTER TABLE `trx_antar_kas`
  ADD PRIMARY KEY (`id_trx`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_ak_awal` (`id_ak_awal`),
  ADD KEY `id_ak_akhir` (`id_ak_akhir`);

--
-- Indeks untuk tabel `trx_antar_reknt`
--
ALTER TABLE `trx_antar_reknt`
  ADD PRIMARY KEY (`id_trx`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_ak_awal` (`id_reknt_awal`),
  ADD KEY `id_ak_akhir` (`id_reknt_akhir`);

--
-- Indeks untuk tabel `trx_bayar_kasbon_sdm`
--
ALTER TABLE `trx_bayar_kasbon_sdm`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_sdm`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`);

--
-- Indeks untuk tabel `trx_deposit_pelanggan`
--
ALTER TABLE `trx_deposit_pelanggan`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_pelanggan`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`);

--
-- Indeks untuk tabel `trx_deposit_supplier`
--
ALTER TABLE `trx_deposit_supplier`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_supplier`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`),
  ADD KEY `id_reknt_user` (`id_reknt_user`);

--
-- Indeks untuk tabel `trx_input_modal`
--
ALTER TABLE `trx_input_modal`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_investor`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`);

--
-- Indeks untuk tabel `trx_jurnal_umum`
--
ALTER TABLE `trx_jurnal_umum`
  ADD PRIMARY KEY (`id_trx`),
  ADD KEY `kode_ju` (`kode_ju`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `updated_by` (`updated_by`),
  ADD KEY `deleted_by` (`deleted_by`),
  ADD KEY `id_entitas` (`id_entitas`);

--
-- Indeks untuk tabel `trx_kasbon_sdm`
--
ALTER TABLE `trx_kasbon_sdm`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_sdm`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`),
  ADD KEY `id_reknt_user` (`id_reknt_user`);

--
-- Indeks untuk tabel `trx_notifikasi`
--
ALTER TABLE `trx_notifikasi`
  ADD PRIMARY KEY (`id_trx`),
  ADD KEY `id_user` (`id_entitas`),
  ADD KEY `trx_notifikasi_ibfk_1` (`created_by`),
  ADD KEY `trx_notifikasi_ibfk_2` (`updated_by`),
  ADD KEY `trx_notifikasi_ibfk_3` (`deleted_by`);

--
-- Indeks untuk tabel `trx_prive`
--
ALTER TABLE `trx_prive`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_investor`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`),
  ADD KEY `id_reknt_user` (`id_reknt_user`);

--
-- Indeks untuk tabel `trx_wd_deposit_pelanggan`
--
ALTER TABLE `trx_wd_deposit_pelanggan`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_pelanggan`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`),
  ADD KEY `id_reknt_user` (`id_reknt_user`);

--
-- Indeks untuk tabel `trx_wd_deposit_supplier`
--
ALTER TABLE `trx_wd_deposit_supplier`
  ADD PRIMARY KEY (`id_trx`),
  ADD UNIQUE KEY `file_bukti_trx` (`file_bukti_trx`),
  ADD KEY `trx_input_modal_ibfk_1` (`created_by`),
  ADD KEY `trx_input_modal_ibfk_2` (`updated_by`),
  ADD KEY `trx_input_modal_ibfk_3` (`deleted_by`),
  ADD KEY `id_investor` (`id_supplier`),
  ADD KEY `id_akun_kas` (`id_akun_kas`),
  ADD KEY `id_reknt` (`id_reknt`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `nomor_nik` (`nomor_nik`),
  ADD UNIQUE KEY `nomor_wa` (`nomor_wa`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_tempat_lahir` (`id_tempat_lahir`),
  ADD KEY `id_kelurahan_tt` (`id_kelurahan_tt`),
  ADD KEY `id_cabang` (`id_cabang`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `akun_kas`
--
ALTER TABLE `akun_kas`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `cabang`
--
ALTER TABLE `cabang`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `kode_tabel`
--
ALTER TABLE `kode_tabel`
  MODIFY `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `kode_trx_ju`
--
ALTER TABLE `kode_trx_ju`
  MODIFY `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `lembaga_keuangan`
--
ALTER TABLE `lembaga_keuangan`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `profil_perusahaan`
--
ALTER TABLE `profil_perusahaan`
  MODIFY `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `reknt`
--
ALTER TABLE `reknt`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `reknt_users`
--
ALTER TABLE `reknt_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `setting_apps`
--
ALTER TABLE `setting_apps`
  MODIFY `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `setting_coa_default`
--
ALTER TABLE `setting_coa_default`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `template_notifikasi`
--
ALTER TABLE `template_notifikasi`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT untuk tabel `tes`
--
ALTER TABLE `tes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `to_do`
--
ALTER TABLE `to_do`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `akun_kas`
--
ALTER TABLE `akun_kas`
  ADD CONSTRAINT `akun_kas_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `akun_kas_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `akun_kas_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `akun_kas_ibfk_4` FOREIGN KEY (`id_pj`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `coa`
--
ALTER TABLE `coa`
  ADD CONSTRAINT `coa_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `coa_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `coa_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kode_tabel`
--
ALTER TABLE `kode_tabel`
  ADD CONSTRAINT `kode_tabel_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `kode_tabel_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `kode_tabel_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `kode_trx_ju`
--
ALTER TABLE `kode_trx_ju`
  ADD CONSTRAINT `kode_trx_ju_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `kode_trx_ju_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `kode_trx_ju_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `lembaga_keuangan`
--
ALTER TABLE `lembaga_keuangan`
  ADD CONSTRAINT `lembaga_keuangan_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lembaga_keuangan_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `lembaga_keuangan_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `profil_perusahaan`
--
ALTER TABLE `profil_perusahaan`
  ADD CONSTRAINT `profil_perusahaan_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profil_perusahaan_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profil_perusahaan_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profil_perusahaan_ibfk_4` FOREIGN KEY (`id_kelurahan`) REFERENCES `regional`.`kelurahan` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `profil_perusahaan_ibfk_5` FOREIGN KEY (`id_ceo`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `reknt`
--
ALTER TABLE `reknt`
  ADD CONSTRAINT `reknt_ibfk_1` FOREIGN KEY (`id_lk`) REFERENCES `lembaga_keuangan` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_ibfk_2` FOREIGN KEY (`id_pj`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_ibfk_5` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `reknt_users`
--
ALTER TABLE `reknt_users`
  ADD CONSTRAINT `reknt_users_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_users_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_users_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_users_ibfk_4` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `reknt_users_ibfk_5` FOREIGN KEY (`id_lk`) REFERENCES `lembaga_keuangan` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `setting_coa_default`
--
ALTER TABLE `setting_coa_default`
  ADD CONSTRAINT `setting_coa_default_ibfk_1` FOREIGN KEY (`nomor_coa`) REFERENCES `coa` (`nomor_coa`) ON UPDATE CASCADE,
  ADD CONSTRAINT `setting_coa_default_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `setting_coa_default_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `setting_coa_default_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `template_notifikasi`
--
ALTER TABLE `template_notifikasi`
  ADD CONSTRAINT `template_notifikasi_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `template_notifikasi_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_antar_kas`
--
ALTER TABLE `trx_antar_kas`
  ADD CONSTRAINT `trx_antar_kas_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_kas_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_kas_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_kas_ibfk_4` FOREIGN KEY (`id_ak_awal`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_kas_ibfk_5` FOREIGN KEY (`id_ak_akhir`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_antar_reknt`
--
ALTER TABLE `trx_antar_reknt`
  ADD CONSTRAINT `trx_antar_reknt_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_reknt_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_reknt_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_reknt_ibfk_4` FOREIGN KEY (`id_reknt_awal`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_antar_reknt_ibfk_5` FOREIGN KEY (`id_reknt_akhir`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_bayar_kasbon_sdm`
--
ALTER TABLE `trx_bayar_kasbon_sdm`
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_4` FOREIGN KEY (`id_sdm`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_bayar_kasbon_sdm_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_deposit_pelanggan`
--
ALTER TABLE `trx_deposit_pelanggan`
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_4` FOREIGN KEY (`id_pelanggan`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_pelanggan_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_deposit_supplier`
--
ALTER TABLE `trx_deposit_supplier`
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_4` FOREIGN KEY (`id_supplier`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_deposit_supplier_ibfk_7` FOREIGN KEY (`id_reknt_user`) REFERENCES `reknt_users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_input_modal`
--
ALTER TABLE `trx_input_modal`
  ADD CONSTRAINT `trx_input_modal_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_input_modal_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_input_modal_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_input_modal_ibfk_4` FOREIGN KEY (`id_investor`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_input_modal_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_input_modal_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`);

--
-- Ketidakleluasaan untuk tabel `trx_jurnal_umum`
--
ALTER TABLE `trx_jurnal_umum`
  ADD CONSTRAINT `trx_jurnal_umum_ibfk_1` FOREIGN KEY (`kode_ju`) REFERENCES `kode_trx_ju` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_jurnal_umum_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_jurnal_umum_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_jurnal_umum_ibfk_4` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_jurnal_umum_ibfk_5` FOREIGN KEY (`id_entitas`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_kasbon_sdm`
--
ALTER TABLE `trx_kasbon_sdm`
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_4` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_5` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_6` FOREIGN KEY (`id_reknt_user`) REFERENCES `reknt_users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_kasbon_sdm_ibfk_7` FOREIGN KEY (`id_sdm`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_notifikasi`
--
ALTER TABLE `trx_notifikasi`
  ADD CONSTRAINT `trx_notifikasi_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_notifikasi_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_notifikasi_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_notifikasi_ibfk_4` FOREIGN KEY (`id_entitas`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_prive`
--
ALTER TABLE `trx_prive`
  ADD CONSTRAINT `trx_prive_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_4` FOREIGN KEY (`id_investor`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_prive_ibfk_7` FOREIGN KEY (`id_reknt_user`) REFERENCES `reknt_users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_wd_deposit_pelanggan`
--
ALTER TABLE `trx_wd_deposit_pelanggan`
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_4` FOREIGN KEY (`id_pelanggan`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_pelanggan_ibfk_7` FOREIGN KEY (`id_reknt_user`) REFERENCES `reknt_users` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `trx_wd_deposit_supplier`
--
ALTER TABLE `trx_wd_deposit_supplier`
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_3` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_4` FOREIGN KEY (`id_supplier`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_5` FOREIGN KEY (`id_akun_kas`) REFERENCES `akun_kas` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `trx_wd_deposit_supplier_ibfk_6` FOREIGN KEY (`id_reknt`) REFERENCES `reknt` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_tempat_lahir`) REFERENCES `regional`.`kokab` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_kelurahan_tt`) REFERENCES `regional`.`kelurahan` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_cabang`) REFERENCES `cabang` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
