-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 01 Jun 2021 pada 07.11
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

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `ID_PESANAN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

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
