-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 01 Jun 2021 pada 10.41
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pbd`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuCari_Nama` (IN `SLUG` VARCHAR(255), OUT `STATUS_PEMINJAMAN` VARCHAR(255))  BEGIN
	SELECT * FROM `books` b WHERE b.NAMA_BUKU LIKE CONCAT('%', SLUG, '%') COLLATE utf8mb4_general_ci;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuDelete` (IN `ID_BUKU` INT(11))  NO SQL
BEGIN
	DELETE FROM books WHERE books.ID_BUKU = ID_BUKU;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuEdit` (IN `ID_BUKU` INT(11), IN `NAMA_BUKU` VARCHAR(255), IN `PENGARANG` VARCHAR(255))  NO SQL
BEGIN
	UPDATE books b set b.NAMA_BUKU = NAMA_BUKU, b.PENGARANG = PENGARANG WHERE b.ID_BUKU = ID_BUKU;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuGetAll` ()  NO SQL
BEGIN
	SELECT * FROM books;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuInsert` (IN `ID_BUKU` INT(11), IN `NAMA_BUKU` VARCHAR(255), IN `PENGARANG` VARCHAR(255), IN `IS_BORROWED` INT(1))  NO SQL
BEGIN
	INSERT INTO `books` VALUES (`ID_BUKU`,`NAMA_BUKU`,`PENGARANG`, `IS_BORROWED`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `bukuSelect` (IN `ID_BUKU` INT(11))  NO SQL
BEGIN
	SELECT * FROM books b WHERE b.ID_BUKU = ID_BUKU;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteBook` (IN `ID_BUKU` INT(11))  BEGIN
	DELETE FROM `books` WHERE books.ID_BUKU = ID_BUKU;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dendaDelete` (IN `ID_DENDA` INT(11))  BEGIN
	DELETE FROM denda WHERE denda.ID_DENDA = ID_DENDA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dendaEdit` (IN `ID_DENDA` INT(11), IN `NOMINAL` INT(11), IN `Pesanan_ID` INT(11))  BEGIN
	UPDATE denda d SET d.NOMINAL = NOMINAL, d.Pesanan_ID = Pesanan_ID 
    WHERE d.ID_DENDA = ID_DENDA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dendaGetAll` ()  BEGIN
	SELECT * FROM denda;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dendaInsert` (IN `ID_DENDA` INT(11), IN `NOMINAL` INT(11), IN `Pesanan_ID` INT(11))  BEGIN
	INSERT INTO `denda` VALUES(`ID_DENDA`, `NOMINAL`, `Pesanan_ID`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dendaSelect` (IN `ID_DENDA` INT(11))  BEGIN
	SELECT * FROM denda d WHERE d.ID_DENDA = ID_DENDA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_delete` (IN `TBL` VARCHAR(50), IN `COL_WHERE` VARCHAR(50), IN `VAL_WHERE` VARCHAR(50))  BEGIN
	SET @SQL=CONCAT("DELETE FROM ", TBL, " WHERE ", COL_WHERE, "=", VAL_WHERE);
    PREPARE STAT FROM @SQL;
    EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_insert` (IN `TBL` VARCHAR(50), IN `VAL` TEXT)  BEGIN
	SET @SQL = CONCAT("INSERT INTO ", TBL, " VALUES (",VAL,");");
	PREPARE STAT FROM @SQL;
    EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_search` (IN `TBL` VARCHAR(50), IN `COL_WHERE` VARCHAR(50), IN `VAL_WHERE` VARCHAR(50))  BEGIN
	SET @SQL=CONCAT("SELECT * FROM ", TBL, " WHERE ", COL_WHERE, " LIKE '%",VAL_WHERE,"%'");
    PREPARE STAT FROM @SQL;
    EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_update` (IN `TBL` VARCHAR(50), IN `COL_WHERE` VARCHAR(50), IN `VAL_WHERE` VARCHAR(50), IN `COL_DAT` TEXT)  BEGIN
	SET @SQL=CONCAT("UPDATE ", TBL, " SET ", COL_DAT, " WHERE ", COL_WHERE, "=", VAL_WHERE);
    PREPARE STAT FROM @SQL;
    EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `karyawanDelete` (IN `ID_KARYAWAN` INT(11))  BEGIN
	DELETE FROM karyawan WHERE karyawan.ID_KARYAWAN = ID_KARYAWAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `karyawanEdit` (IN `ID_KARYAWAN` INT(11), IN `NAMA_KARYAWAN` VARCHAR(255), IN `JENIS_PEKERJAAN` VARCHAR(11))  BEGIN
	UPDATE karyawan k SET k.NAMA_KARYAWAN =  NAMA_KARYAWAN, k.JENIS_PEKERJAAN = JENIS_PEKERJAAN WHERE k.ID_KARYAWAN = ID_KARYAWAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `karyawanGetAll` ()  BEGIN
	SELECT * from karyawan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `karyawanInsert` (IN `ID_KARYAWAN` INT(11), IN `NAMA_KARYAWAN` VARCHAR(255), IN `JENIS_PEKERJAAN` VARCHAR(255))  NO SQL
BEGIN
	INSERT INTO karyawan VALUES (`ID_KARYAWAN`, `NAMA_KARYAWAN`, `JENIS_PEKERJAAN`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `karyawanSelect` (IN `ID_KARYAWAN` INT(11))  BEGIN
	SELECT * FROM karyawan k WHERE k.ID_KARYAWAN = ID_KARYAWAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p1` ()  BEGIN
	DECLARE v INT;
    SET v = 1;
    WHILE v < 3 DO
    SELECT v;
    SET v = v + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p2` ()  BEGIN
	DECLARE v INT;
    SET v = 0;
    REPEAT
    	SELECT v;
        SET v = v + 1;
    UNTIL v >= 3
    END REPEAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p3` ()  BEGIN
	DECLARE v INT;
    SET v = 0;
    loop_label: LOOP
    	SELECT v;
        SET v = v + 1;
            IF v >= 3 THEN LEAVE loop_label;
            END IF;
    END LOOP;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pelangganDelete` (IN `ID_PELANGGAN` INT(11))  NO SQL
BEGIN
	DELETE FROM pelanggan WHERE pelanggan.ID_PELANGGAN = ID_PELANGGAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pelangganEdit` (IN `ID_PELANGGAN` INT(11), IN `NAMA_PELANGGAN` VARCHAR(255), IN `NO_KTP` VARCHAR(20))  BEGIN
	UPDATE pelanggan p SET p.NAMA_PELANGGAN = NAMA_PELANGGAN, p.NO_KTP = NO_KTP 
    WHERE p.ID_PELANGGAN = ID_PELANGGAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pelangganGetAll` ()  NO SQL
BEGIN
	SELECT * FROM pelanggan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pelangganInsert` (IN `ID_PELANGGAN` INT(11), IN `NAMA_PELANGGAN` VARCHAR(255), IN `NO_KTP` VARCHAR(255))  NO SQL
BEGIN
	INSERT INTO `pelanggan` VALUES (`ID_PELANGGAN`, `NAMA_PELANGGAN`, `NO_KTP`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pelangganSelect` (IN `ID_PELANGGAN` INT(11))  BEGIN
	SELECT * FROM pelanggan p WHERE p.ID_PELANGGAN = ID_PELANGGAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesananDelete` (IN `ID_PESANAN` INT)  BEGIN
	DELETE FROM pesanan WHERE pesanan.ID_PESANAN = ID_PESANAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesananEdit` (IN `ID_PESANAN` INT(11), IN `ID_KARYAWAN` INT(11), IN `ID_PELANGGAN` INT(11), IN `ID_BUKU` INT(11), IN `TGL_PINJAM` DATE, IN `TGL_KEMBALI` DATE, IN `TGL_EXPIRED` DATE, IN `PERPANJANGAN` DECIMAL(1))  BEGIN
	UPDATE pesanan p SET p.ID_KARYAWAN = ID_KARYAWAN, p.ID_PELANGGAN = ID_PELANGGAN, p.ID_BUKU = ID_BUKU, p.TGL_PINJAM = TGL_PINJAM, p.TGL_KEMBALI = p.TGL_KEMBALI, p.TGL_EXPIRED = TGL_EXPIRED, p.PERPANJANGAN = PERPANJANGAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesananGetAll` ()  BEGIN
	SELECT * FROM pesanan;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesananInsert` (IN `ID_PESANAN` INT(11), IN `ID_KARYAWAN` INT(11), IN `ID_PELANGGAN` INT(11), IN `ID_BUKU` INT(11), IN `TGL_PINJAM` DATE, IN `TGL_KEMBALI` DATE, IN `TGL_EXPIRED` DATE, IN `PERPANJANGAN` DECIMAL(1))  BEGIN
	INSERT INTO `pesanan` VALUES (`ID_PESANAN`,`ID_KARYAWAN`,`ID_PELANGGAN`, `ID_BUKU`, `TGL_PINJAM`, `TGL_KEMBALI`, `TGL_EXPIRED`, `PERPANJANGAN`);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pesananSelect` (IN `ID_PESANAN` INT(11))  BEGIN
	SELECT * FROM pesanan p WHERE p.ID_PESANAN = ID_PESANAN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CekPeminjaman` (IN `ID_BUKU` INT(11), OUT `TERPINJAM` VARCHAR(255))  BEGIN
	CASE
    WHEN ((SELECT b.IS_BORROWED FROM `books` b WHERE b.ID_BUKU = ID_BUKU) = 0 )THEN SET TERPINJAM = 'TIDAK TERPINJAM';
    ELSE SET TERPINJAM = 'TERPINJAM';
END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CekPeminjaman2` (IN `ID_BUKU` INT(11), OUT `TERPINJAM` VARCHAR(255))  BEGIN
	CASE
    WHEN ((SELECT p.ID_BUKU FROM `pesanan` p WHERE p.ID_BUKU = ID_BUKU AND p.TGL_KEMBALI IS NULL LIMIT 1 ) = ID_BUKU )THEN SET TERPINJAM = 'TERPINJAM';
    ELSE SET TERPINJAM = 'TIDAK TERPINJAM';
END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_TABEL` (IN `TBL` VARCHAR(50), IN `COL_PK` VARCHAR(50), IN `VAL_PK` VARCHAR(50))  NO SQL
BEGIN
SET @SQL=CONCAT("DELETE FROM ",TBL," WHERE ",COL_PK,"=",VAL_PK);
PREPARE STAT FROM @SQL;
EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERT_TABEL` (IN `TBL` VARCHAR(50), IN `VAL` TEXT)  NO SQL
BEGIN
SET @SQL=CONCAT("INSERT INTO ",TBL," VALUES (",VAL,");");
PREPARE STAT FROM @SQL;
EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_SEARCH_TABEL` (IN `TBL` VARCHAR(50), IN `KEYWORD` VARCHAR(50), IN `KOLOM` VARCHAR(50))  BEGIN
 	SET @SQL =CONCAT("SELECT * FROM ",TBL);
    IF (KEYWORD <> "*") THEN
    	SET @SQL =CONCAT(@SQL," WHERE '",KEYWORD,"' in (",KOLOM,")");
    END IF;
    PREPARE STAT FROM @SQL;
    EXECUTE STAT;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_UPDATE_TABEL` (IN `TBL` VARCHAR(50), IN `COL_PK` VARCHAR(50), IN `VAL_PK` VARCHAR(50), IN `COL_DAT` TEXT)  NO SQL
BEGIN
SET @SQL=CONCAT("UPDATE ",TBL," SET ",COL_DAT," WHERE ",COL_PK,"=",VAL_PK);
PREPARE STAT FROM @SQL;
EXECUTE STAT;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBook` (IN `ID_BUKU` INT(11), IN `NAMA_BUKU` VARCHAR(255), IN `PENGARANG` VARCHAR(255))  BEGIN
	UPDATE `books` SET books.NAMA_BUKU = NAMA_BUKU, books.PENGARANG = PENGARANG WHERE books.ID_BUKU = ID_BUKU;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CekPeminjamanBuku` (`ID_BUKU` INT(11)) RETURNS TINYINT(1) NO SQL
BEGIN
	DECLARE KEMBALIANBUKU INT;
    DECLARE KEBMBALIANKONDISI BOOLEAN;
	SET KEMBALIANBUKU = (SELECT books.IS_BORROWED FROM books WHERE books.ID_BUKU = ID_BUKU LIMIT 1);
    IF(KEMBALIANBUKU = 0) THEN SET KEBMBALIANKONDISI = TRUE;
    ELSE SET KEBMBALIANKONDISI = FALSE;
    END IF;
    RETURN KEBMBALIANKONDISI;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `PenghitunganDenda` (`SELISIH` INT(11)) RETURNS INT(11) NO SQL
BEGIN
	DECLARE ABSSELISIH INT;
	DECLARE KEMBALIANDENDA INT;
    SET ABSSELISIH = ABS(SELISIH);
    IF ABSSELISIH < 60 THEN
    	SET KEMBALIANDENDA = ABS(SELISIH) * 500;
    ELSE
    	SET KEMBALIANDENDA = 30000;
    END IF;
    RETURN KEMBALIANDENDA;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `ID_BUKU` int(11) NOT NULL,
  `NAMA_BUKU` varchar(255) NOT NULL,
  `PENGARANG` varchar(255) NOT NULL,
  `IS_BORROWED` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`ID_BUKU`, `NAMA_BUKU`, `PENGARANG`, `IS_BORROWED`) VALUES
(1, 'Matematika Diskrit', 'Rinaldi Munir', 1),
(2, 'Statistika', 'Tibyani Hambali', 0),
(3, 'Buku Nomer 3 ', 'Ini adalah pengarang fiktif buku nomer 3', 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `denda`
--

CREATE TABLE `denda` (
  `ID_DENDA` int(11) NOT NULL,
  `NOMINAL` int(11) NOT NULL,
  `Pesanan_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `karyawan`
--

CREATE TABLE `karyawan` (
  `ID_KARYAWAN` int(11) NOT NULL,
  `NAMA_KARYAWAN` varchar(255) NOT NULL,
  `JENIS_PEKERJAAN` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `karyawan`
--

INSERT INTO `karyawan` (`ID_KARYAWAN`, `NAMA_KARYAWAN`, `JENIS_PEKERJAAN`) VALUES
(1, 'Wira Zeta Prakosa', 'Keuangan'),
(2, 'Ramdani Koernia', 'Administra');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `ID_PELANGGAN` int(11) NOT NULL,
  `NAMA_PELANGGAN` varchar(255) NOT NULL,
  `NO_KTP` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`ID_PELANGGAN`, `NAMA_PELANGGAN`, `NO_KTP`) VALUES
(1, 'Pelanggan 1', '081217131455'),
(2, 'Pelanggan 2', '1234567890');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pesanan`
--

CREATE TABLE `pesanan` (
  `ID_PESANAN` int(11) NOT NULL,
  `ID_KARYAWAN` int(11) DEFAULT NULL,
  `ID_PELANGGAN` int(11) DEFAULT NULL,
  `ID_BUKU` int(11) DEFAULT NULL,
  `TGL_PINJAM` date DEFAULT NULL,
  `TGL_KEMBALI` date DEFAULT NULL,
  `TGL_EXPIRED` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PERPANJANGAN` decimal(1,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pesanan`
--

INSERT INTO `pesanan` (`ID_PESANAN`, `ID_KARYAWAN`, `ID_PELANGGAN`, `ID_BUKU`, `TGL_PINJAM`, `TGL_KEMBALI`, `TGL_EXPIRED`, `PERPANJANGAN`) VALUES
(1, 2, 1, 1, '2021-06-01', '0000-00-00', '2021-06-07 17:00:00', '0');

--
-- Trigger `pesanan`
--
DELIMITER $$
CREATE TRIGGER `AFT_INS_PEMINJAMAN` AFTER INSERT ON `pesanan` FOR EACH ROW BEGIN
	DECLARE DIPINJAM INT;
    SET DIPINJAM = CekPeminjamanBuku(NEW.ID_BUKU);
	IF DIPINJAM = 1 THEN
		BEGIN
            UPDATE books
	        SET books.IS_BORROWED=1
        	WHERE books.ID_BUKU=NEW.ID_BUKU;
		END;
    ELSE
    	BEGIN
        	DELETE FROM `pesanan` WHERE `pesanan`.`ID_PESANAN` = NEW.ID_PESANAN;
        END;
	END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AFT_UPD_PEMINJAMAN_TANGGAL_ISI` AFTER UPDATE ON `pesanan` FOR EACH ROW BEGIN
	IF NEW.TGL_KEMBALI != NULL THEN
    BEGIN
    	UPDATE books
            SET books.IS_BORROWED=0
            WHERE books.ID_BUKU=OLD.ID_BUKU;
    END;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AFT_UPD_PEMINJAMAN_TANGGAL_TERISI` AFTER UPDATE ON `pesanan` FOR EACH ROW BEGIN
	IF NEW.TGL_KEMBALI != NULL THEN
    BEGIN
    	DECLARE SELISIHTANGGAL INT;
        SET SELISIHTANGGAL = DATEDIFF(OLD.TGL_EXPIRED, NEW.TGL_KEMBALI);
        IF SELISIHTANGGAL < 0 THEN
        	BEGIN
            	INSERT INTO `denda` 
                (NOMINAL, Pesanan_ID) 
                VALUES (PenghitunganDenda(SELISIHTANGGAL), OLD.ID_PESANAN);
            END;
        END IF;
    	UPDATE books
            SET books.IS_BORROWED=0
            WHERE books.ID_BUKU=OLD.ID_BUKU;
    END;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `ID_USER` int(11) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PHONE_NUMBER` varchar(20) NOT NULL,
  `ADDRESS` int(255) NOT NULL,
  `KTP_NUMBER` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`ID_USER`, `NAME`, `PHONE_NUMBER`, `ADDRESS`, `KTP_NUMBER`) VALUES
(1, 'edit', 'edit', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`ID_BUKU`),
  ADD UNIQUE KEY `BUKU_PK` (`ID_BUKU`);

--
-- Indeks untuk tabel `denda`
--
ALTER TABLE `denda`
  ADD PRIMARY KEY (`ID_DENDA`),
  ADD UNIQUE KEY `DENDA_PK` (`ID_DENDA`),
  ADD KEY `pesanan_id_index` (`Pesanan_ID`);

--
-- Indeks untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`ID_KARYAWAN`),
  ADD UNIQUE KEY `KARYAWAN_PK` (`ID_KARYAWAN`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`ID_PELANGGAN`),
  ADD UNIQUE KEY `PELANGGAN_PK` (`ID_PELANGGAN`);

--
-- Indeks untuk tabel `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`ID_PESANAN`),
  ADD UNIQUE KEY `PESANAN_PK` (`ID_PESANAN`),
  ADD KEY `KARYAWAN_TO_PESANAN_FK` (`ID_KARYAWAN`),
  ADD KEY `PELANGGAN_TO_PESANAN_FK` (`ID_PELANGGAN`),
  ADD KEY `BUKU_TO_PESANAN_FK` (`ID_BUKU`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID_USER`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `books`
--
ALTER TABLE `books`
  MODIFY `ID_BUKU` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `denda`
--
ALTER TABLE `denda`
  MODIFY `ID_DENDA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `ID_KARYAWAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `ID_PELANGGAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `ID_PESANAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `ID_USER` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `denda`
--
ALTER TABLE `denda`
  ADD CONSTRAINT `denda_ibfk_1` FOREIGN KEY (`Pesanan_ID`) REFERENCES `pesanan` (`ID_PESANAN`);

--
-- Ketidakleluasaan untuk tabel `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`ID_KARYAWAN`) REFERENCES `karyawan` (`ID_KARYAWAN`),
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`ID_PELANGGAN`) REFERENCES `pelanggan` (`ID_PELANGGAN`),
  ADD CONSTRAINT `pesanan_ibfk_4` FOREIGN KEY (`ID_BUKU`) REFERENCES `books` (`ID_BUKU`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
