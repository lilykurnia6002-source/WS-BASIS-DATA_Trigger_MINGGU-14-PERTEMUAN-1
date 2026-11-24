USE dbmahasiswa;

-- ==========================================
-- ACARA 49-50 : TRIGGER BEFORE UPDATE
-- ==========================================

CREATE TABLE IF NOT EXISTS tbl_mhs_w14 (
    nim CHAR(9) PRIMARY KEY,
    nama_mhs VARCHAR(50),
    alamat VARCHAR(35),
    phone VARCHAR(20),
    nip VARCHAR(20),
    kode_jur VARCHAR(10)
);

INSERT IGNORE INTO tbl_mhs_w14 (nim, nama_mhs, alamat, phone, nip, kode_jur) VALUES
('E2021003', 'Sita', 'Temanggung', '098745633', NULL, NULL),
('E20211001', 'Abizar', 'Jember', '0821236789', '199305102021032001', '00JTI'),
('E20211002', 'Bili', 'Jember', '0821236789', '199305102021032001', '00JTI'),
('E20211003', 'Ina', 'Mojokerto', '0987654322', NULL, NULL),
('E20212001', 'Arka', 'Bondowoso', '08212236789', '199305102021032001', 'OJTEK'),
('E20212002', 'Caca', 'Nganjuk', '08212236789', '199308312021032001', 'OJTEK'),
('E20212003', 'Rama', 'Pasuruan', '0987643323', NULL, NULL);

CREATE TABLE IF NOT EXISTS tbl_log_mhs_w14 (
    id_log INT(10) AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(9),
    alamat_lama VARCHAR(35),
    alamat_baru VARCHAR(35),
    waktu DATE
);

DROP TRIGGER IF EXISTS update_alamat_mahasiswa_w14;

DELIMITER $$
CREATE TRIGGER update_alamat_mahasiswa_w14
BEFORE UPDATE
ON tbl_mhs_w14
FOR EACH ROW
BEGIN
    INSERT INTO tbl_log_mhs_w14
    SET nim = OLD.nim,
        alamat_lama = OLD.alamat,
        alamat_baru = NEW.alamat,
        waktu = NOW();
END $$
DELIMITER ;

UPDATE tbl_mhs_w14
SET alamat = "Jember"
WHERE nim = "E2021003";

SELECT * FROM tbl_mhs_w14;
SELECT * FROM tbl_log_mhs_w14;

-- ==========================================
-- ACARA 51-52 : TRIGGER BEFORE DELETE
-- ==========================================

CREATE TABLE IF NOT EXISTS tbl_dosen_w14 (
    nip CHAR(18) PRIMARY KEY,
    nama_dosen VARCHAR(50),
    alamat CHAR(25),
    phone CHAR(13)
);

INSERT IGNORE INTO tbl_dosen_w14 (nip, nama_dosen, alamat, phone) VALUES
('198005172008121002', 'Dwi Putro Sarwo Setyohadi', 'jember', '085111222333'),
('198804042021032001', 'Pramudhita Shinta Dewi Pu', 'Surabaya', '081246456789'),
('199002272021032001', 'Trismayanti Dwi Puspitasa', 'Yogyakarta', '081231456789'),
('199205292021032001', 'Bety Etikasari', 'Trenggalek', '081456789123'),
('199305102021032001', 'Lukie Perdanasari', 'Jember', '081123456789'),
('199308312021032001', 'Arvita Agus Kurniasari', 'Malang', '081123987654');

CREATE TABLE IF NOT EXISTS history_hapus_dosen_w14 (
    id_log INT(10) AUTO_INCREMENT PRIMARY KEY,
    nip CHAR(18),
    nama_dosen VARCHAR(25),
    alamat CHAR(25),
    phone CHAR(13),
    waktu DATE
);

DROP TRIGGER IF EXISTS before_delete_dosen_w14;

DELIMITER $$
CREATE TRIGGER before_delete_dosen_w14
BEFORE DELETE
ON tbl_dosen_w14
FOR EACH ROW
BEGIN
    INSERT INTO history_hapus_dosen_w14
    SET nip = OLD.nip,
        nama_dosen = OLD.nama_dosen,
        alamat = OLD.alamat,
        phone = OLD.phone,
        waktu = NOW();
END $$
DELIMITER ;

DELETE FROM tbl_dosen_w14 WHERE nip = "198005172008121002";

SELECT * FROM tbl_dosen_w14;
SELECT * FROM history_hapus_dosen_w14;