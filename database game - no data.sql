-- --------------------------------------------------------
-- Host:                         srv1031.hstgr.io
-- Server version:               10.11.8-MariaDB-cll-lve - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for u614272482_sekolah_virtua
CREATE DATABASE IF NOT EXISTS `u614272482_sekolah_virtua` /*!40100 DEFAULT CHARACTER SET utf16 COLLATE utf16_unicode_ci */;
USE `u614272482_sekolah_virtua`;

-- Dumping structure for table u614272482_sekolah_virtua.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `user_id` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.bintang
CREATE TABLE IF NOT EXISTS `bintang` (
  `id` varchar(50) NOT NULL DEFAULT 'AUTO_INCREMENT',
  `user` varchar(50) DEFAULT NULL,
  `bintang` int(11) DEFAULT NULL,
  `id_stage` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.jawaban_soal
CREATE TABLE IF NOT EXISTS `jawaban_soal` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `peserta` varchar(50) NOT NULL,
  `poin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='pola ID tu Email-materi-nomor soal';

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.jenjang-mapel
CREATE TABLE IF NOT EXISTS `jenjang-mapel` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `LEVEL` int(11) DEFAULT NULL,
  `KELAS` varchar(50) NOT NULL DEFAULT '',
  `POSISI_MAP_HORIZONTAL` tinyint(4) DEFAULT NULL,
  `POSISI_MAP_VERTIKAL` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.level_diselesaikan
CREATE TABLE IF NOT EXISTS `level_diselesaikan` (
  `id` varchar(100) NOT NULL DEFAULT '',
  `mapel` int(11) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `peserta` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.log
CREATE TABLE IF NOT EXISTS `log` (
  `user` varchar(50) NOT NULL,
  `aktivitas` tinytext NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.mapel_diselesaikan
CREATE TABLE IF NOT EXISTS `mapel_diselesaikan` (
  `peserta` varchar(50) NOT NULL,
  `mapel_selesai` varchar(50) NOT NULL DEFAULT '',
  `bintang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.mapel_group
CREATE TABLE IF NOT EXISTS `mapel_group` (
  `nama_grup` varchar(50) NOT NULL,
  `mapel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.materi
CREATE TABLE IF NOT EXISTS `materi` (
  `id` varchar(50) NOT NULL,
  `jenjang-mapel` int(11) DEFAULT NULL,
  `no_urut_materi` int(11) DEFAULT NULL,
  `materi` tinytext DEFAULT NULL,
  `link_video` tinytext DEFAULT NULL,
  `deskripsi` varchar(10000) DEFAULT NULL,
  `pembuat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.pendidik
CREATE TABLE IF NOT EXISTS `pendidik` (
  `email` varchar(50) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `no_telpon` varchar(50) DEFAULT NULL,
  `tanggal_lahir` varchar(50) DEFAULT NULL,
  `password` tinytext DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.pengampu-mapel-jenjang
CREATE TABLE IF NOT EXISTS `pengampu-mapel-jenjang` (
  `mapel-jenjang` int(11) NOT NULL,
  `pengampu` varchar(50) NOT NULL,
  PRIMARY KEY (`mapel-jenjang`),
  KEY `FK_pengampu-mapel-jenjang_jenjang-mapel` (`mapel-jenjang`),
  KEY `FK_pengampu-mapel-jenjang_pendidik` (`pengampu`),
  CONSTRAINT `FK_pengampu-mapel-jenjang_jenjang-mapel` FOREIGN KEY (`mapel-jenjang`) REFERENCES `jenjang-mapel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pengampu-mapel-jenjang_pendidik` FOREIGN KEY (`pengampu`) REFERENCES `pendidik` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.peserta
CREATE TABLE IF NOT EXISTS `peserta` (
  `email` varchar(50) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jenjang` int(11) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `password` text NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'peserta',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.sertifikat
CREATE TABLE IF NOT EXISTS `sertifikat` (
  `id_sertifikat` varchar(90) NOT NULL,
  `nama` varchar(90) NOT NULL,
  `materi` varchar(90) NOT NULL,
  `tanggal` date NOT NULL,
  PRIMARY KEY (`id_sertifikat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.soal_checkbox
CREATE TABLE IF NOT EXISTS `soal_checkbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `materi` varchar(50) DEFAULT NULL,
  `soal` text DEFAULT NULL,
  `opsi_a` text DEFAULT '0',
  `opsi_b` text DEFAULT '0',
  `opsi_c` text DEFAULT '0',
  `opsi_d` text DEFAULT '0',
  `jawaban` varchar(50) DEFAULT NULL,
  `pembuat` varchar(50) DEFAULT NULL,
  `gambar` tinytext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1676 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table u614272482_sekolah_virtua.unlock_mapel
CREATE TABLE IF NOT EXISTS `unlock_mapel` (
  `mapel_target` int(11) DEFAULT NULL,
  `needed_to_unlock` int(11) DEFAULT NULL,
  KEY `FK_unlock_mapel_requirement_jenjang-mapel` (`mapel_target`),
  KEY `FK_unlock_mapel_requirement_jenjang-mapel_2` (`needed_to_unlock`),
  CONSTRAINT `FK_unlock_mapel_requirement_jenjang-mapel` FOREIGN KEY (`mapel_target`) REFERENCES `jenjang-mapel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_unlock_mapel_requirement_jenjang-mapel_2` FOREIGN KEY (`needed_to_unlock`) REFERENCES `jenjang-mapel` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for trigger u614272482_sekolah_virtua.peserta_after_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `peserta_after_insert` AFTER INSERT ON `peserta` FOR EACH ROW BEGIN
	INSERT INTO mapel_diselesaikan VALUES (NEW.email,0,0);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
