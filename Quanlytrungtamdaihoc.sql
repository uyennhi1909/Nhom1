-- Tạo database Quanlytrungtamdaihoc
CREATE DATABASE Quanlytrungtamdaihoc
GO
-- Sử dụng database Quanlytrungtamdaihoc
USE Quanlytrungtamdaihoc
GO
-- Tạo bảng TRUNGTAM
CREATE TABLE TRUNGTAM (
    MaTT NVARCHAR(10) PRIMARY KEY,
    TenTT NVARCHAR(100),
    DiaChi NVARCHAR(255) 	)
-- Tạo bảng TRUONG
CREATE TABLE TRUONG (
    MaTruong NVARCHAR(10) PRIMARY KEY,
    TenTruong NVARCHAR(100),
    MaTT NVARCHAR(10),
    CONSTRAINT FK_TRUONG_TRUNGTAM FOREIGN KEY (MaTT) REFERENCES TRUNGTAM(MaTT)	)
-- Tạo bảng HIEUTRUONG
CREATE TABLE HIEUTRUONG (
    MaHT NVARCHAR(10) PRIMARY KEY,
    TenHT NVARCHAR(100),
    MaTruong NVARCHAR(10),
    CONSTRAINT FK_TRUONG_HIEUTRUONG FOREIGN KEY (MaTruong) REFERENCES TRUONG(MaTruong)	)
-- Tạo bảng KHOA
CREATE TABLE KHOA (
    MaKhoa NVARCHAR(10) PRIMARY KEY,
    TenKhoa NVARCHAR(100),
    MaTruong NVARCHAR(10),
    MaGVChuNhiem NVARCHAR(10),
    CONSTRAINT FK_KHOA_TRUONG FOREIGN KEY (MaTruong) REFERENCES TRUONG(MaTruong)	)
-- Tạo bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    MaGV NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    HocVi NVARCHAR(20),
    MaKhoa NVARCHAR(10),
    CONSTRAINT FK_GIAOVIEN_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)	)
-- Tạo bảng LOP
CREATE TABLE LOP (
    MaLop NVARCHAR(10) PRIMARY KEY,
    TenLop NVARCHAR(50),
    MaGVChuNhiem NVARCHAR(10),
    CONSTRAINT FK_LOP_GIAOVIEN FOREIGN KEY (MaGVChuNhiem) REFERENCES GIAOVIEN(MaGV)	)
-- Tạo bảng SINHVIEN
CREATE TABLE SINHVIEN (
    MaSV NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    MaKhoa NVARCHAR(10),
    MaLop NVARCHAR(10) NOT NULL,
    CONSTRAINT FK_SINHVIEN_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa),
    CONSTRAINT FK_SINHVIEN_LOP FOREIGN KEY (MaLop) REFERENCES LOP(MaLop)	)
-- Tạo bảng MONHOC
CREATE TABLE MONHOC (
    MaMH NVARCHAR(10) PRIMARY KEY,
    TenMH NVARCHAR(100),
    SoTinChi INT,
    MaKhoa NVARCHAR(10),
    CONSTRAINT FK_MONHOC_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa)	)
-- Tạo bảng GIAOVIEN_MONHOC (bảng liên kết cho quan hệ m-n giữa GIAOVIEN và MONHOC)
CREATE TABLE GIAOVIEN_MONHOC (
    MaGV NVARCHAR(10),
    MaMH NVARCHAR(10),
	SoTiet INT,
    PRIMARY KEY (MaGV, MaMH),
    CONSTRAINT FK_GVMH_GIAOVIEN FOREIGN KEY (MaGV) REFERENCES GIAOVIEN(MaGV),
    CONSTRAINT FK_GVMH_MONHOC FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)	)
-- Tạo bảng SINHVIEN_MONHOC (bảng liên kết cho quan hệ m-n giữa SINHVIEN và MONHOC)
CREATE TABLE SINHVIEN_MONHOC (
    MaSV NVARCHAR(10),
    MaMH NVARCHAR(10),
    DiemSo FLOAT,
    PRIMARY KEY (MaSV, MaMH),
    CONSTRAINT FK_SVMH_SINHVIEN FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV),
    CONSTRAINT FK_SVMH_MONHOC FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH)	)
-- Thêm các ràng buộc khóa ngoại còn thiếu 
ALTER TABLE KHOA
ADD CONSTRAINT FK_KHOA_GIAOVIEN FOREIGN KEY (MaGVChuNhiem) REFERENCES GIAOVIEN(MaGV)
-- Nhập dữ liệu mẫu
-- 1. TRUNGTAM
INSERT INTO TRUNGTAM VALUES
('TT001', N'Trung tâm Đại học A', N'123 Lê Lợi, Q1'),
('TT002', N'Trung tâm Đại học B', N'456 Nguyễn Huệ, Q3'),
('TT003', N'Trung tâm Đại học C', N'789 Trần Hưng Đạo, Q5'),
('TT004', N'Trung tâm Đại học D', N'12 Bạch Đằng, Q2'),
('TT005', N'Trung tâm Đại học E', N'34 CMT8, Q10');
-- 2. TRUONG
INSERT INTO TRUONG VALUES
('TR001', N'Trường Công nghiệp', 'TT001'),
('TR002', N'Trường Kinh tế', 'TT001'),
('TR003', N'Trường Ngoại ngữ', 'TT001'),
('TR004', N'Trường Kỹ thuật Điện tử', 'TT002'),
('TR005', N'Trường Quản trị Kinh doanh', 'TT003')
-- 3. HIEUTRUONG
INSERT INTO HIEUTRUONG VALUES
('HT001', N'Nguyễn Văn A', 'TR001'),
('HT002', N'Trần Thị B', 'TR002'),
('HT003', N'Lê Văn C', 'TR003'),
('HT004', N'Phạm Thị D', 'TR004'),
('HT005', N'Võ Văn E', 'TR005')
-- 4. KHOA 
INSERT INTO KHOA VALUES
('KH001', N'Tin học', 'TR001', NULL),
('KH002', N'Thương Mại Điện Tử', 'TR003', NULL),
('KH003', N'Kế toán', 'TR002', NULL),
('KH004', N'Ngoại Ngữ', 'TR001', NULL),
('KH005', N'Cơ khí', 'TR003', NULL)
-- 5. GIAOVIEN 
INSERT INTO GIAOVIEN VALUES
('GV001', N'Nguyễn Văn An', N'Tiến sĩ', 'KH001'),
('GV002', N'Trần Thị Bình', N'Thạc sĩ', 'KH001'),
('GV003', N'Lê Văn Cường', N'Tiến sĩ', 'KH002'),
('GV004', N'Phạm Thị Dung', N'Thạc sĩ', 'KH002'),
('GV005', N'Hoàng Văn Em', N'Tiến sĩ', 'KH003'),
('GV006', N'Nguyễn Thị Phương', N'Thạc sĩ', 'KH003'),
('GV007', N'Trần Văn Giang', N'Tiến sĩ', 'KH004'),
('GV008', N'Lê Thị Hương', N'Thạc sĩ', 'KH004'),
('GV009', N'Nguyễn Văn', N'Tiến sĩ', 'KH005'),
('GV010', N'Phạm Thị Yến', N'Thạc sĩ', 'KH005')
-- Cập nhật dữ liệu chủ nhiệm khoa của bảng KHOA
UPDATE KHOA SET MaGVChuNhiem = 'GV001' WHERE MaKhoa = 'KH001'
UPDATE KHOA SET MaGVChuNhiem = 'GV003' WHERE MaKhoa = 'KH002'
UPDATE KHOA SET MaGVChuNhiem = 'GV005' WHERE MaKhoa = 'KH003'
UPDATE KHOA SET MaGVChuNhiem = 'GV007' WHERE MaKhoa = 'KH004'
UPDATE KHOA SET MaGVChuNhiem = 'GV009' WHERE MaKhoa = 'KH005'
-- 6. LOP 
INSERT INTO LOP VALUES
('L0001', 'DHTH8', 'GV001'),
('L0002', 'DHTH9', 'GV002'),
('L0003', 'DHNN5', 'GV007'),
('L0004', 'DHKT3', 'GV005'),
('L0005', 'DHCK6', 'GV009')
-- 7. SINHVIEN table 
INSERT INTO SINHVIEN VALUES
('SV000001', N'Nguyễn Văn A', '2005-01-01', 'KH001', 'L0001'),
('SV000002', N'Trần Thị B', '2005-02-02', 'KH001', 'L0001'),
('SV000003', N'Lê Văn C', '2005-03-03', 'KH001', 'L0001'),
('SV000004', N'Phạm Thị D', '2005-04-04', 'KH001', 'L0001'),
('SV000005', N'Hoàng Văn E', '2005-05-05', 'KH001', 'L0001'),
('SV000006', N'Nguyễn Thị F', '2005-06-06', 'KH001', 'L0002'),
('SV000007', N'Trần Văn G', '2005-07-07', 'KH001', 'L0002'),
('SV000008', N'Lê Thị H', '2005-08-08', 'KH001', 'L0002'),
('SV000009', N'Phạm Văn I', '2005-09-09', 'KH001', 'L0002'),
('SV000010', N'Hoàng Thị K', '2005-10-10', 'KH001', 'L0002'),
('SV000011', N'Nguyễn Văn L', '2005-11-11', 'KH004', 'L0003'),
('SV000012', N'Trần Thị M', '2005-12-12', 'KH004', 'L0003'),
('SV000013', N'Lê Văn N', '2004-01-01', 'KH004', 'L0003'),
('SV000014', N'Phạm Thị O', '2004-02-02', 'KH004', 'L0003'),
('SV000015', N'Hoàng Văn P', '2004-03-03', 'KH004', 'L0003'),
('SV000016', N'Nguyễn Thị Q', '2004-04-04', 'KH003', 'L0004'),
('SV000017', N'Trần Văn R', '2004-05-05', 'KH003', 'L0004'),
('SV000018', N'Lê Thị S', '2004-06-06', 'KH003', 'L0004'),
('SV000019', N'Phạm Văn T', '2004-07-07', 'KH003', 'L0004'),
('SV000020', N'Hoàng Thị U', '2004-08-08', 'KH003', 'L0004'),
('SV000021', N'Nguyễn Văn V', '2004-09-09', 'KH005', 'L0005'),
('SV000022', N'Trần Thị X', '2004-10-10', 'KH005', 'L0005')
-- 8. MONHOC 
INSERT INTO MONHOC VALUES
('MH001', N'Cơ sở dữ liệu', 4, 'KH001'),
('MH002', N'Cấu trúc dữ liệu', 3, 'KH001'),
('MH003', N'Nhập môn lập trình', 4, 'KH001'),
('MH004', N'Kỹ năng giao tiếp', 3, 'KH002'),
('MH005', N'Văn hoá đa quốc gia', 4, 'KH002'),
('MH006', N'Tài chính doanh nghiệp', 4, 'KH003'),
('MH007', N'Tiếng Anh 1', 3, 'KH004'),
('MH008', N'Marketing Số', 3, 'KH005'),
('MH009', N'Toán cao cấp', 3, 'KH001'),
('MH010', N'Đồ họa ứng dụng', 3, 'KH001'),
('MH011', N'Nguyên lý kế toán', 3, 'KH001') 
-- 9. GIAOVIEN_MONHOC 
INSERT INTO GIAOVIEN_MONHOC VALUES
('GV001', 'MH001',3), ('GV001', 'MH002',3), ('GV001', 'MH003',3), ('GV002', 'MH004',3), 
('GV002', 'MH005',6), ('GV003', 'MH006',6), ('GV004', 'MH007',2), ('GV005', 'MH006',3), 
('GV006', 'MH009',2), ('GV007', 'MH007',2), ('GV008', 'MH008',3), ('GV009', 'MH001',3), 
('GV009', 'MH002',2), ('GV009', 'MH008',3), ('GV010', 'MH010',4) 
-- 10. SINHVIEN_MONHOC 
INSERT INTO SINHVIEN_MONHOC VALUES
('SV000001', 'MH001', 8.5), ('SV000001', 'MH002', 7.5),
('SV000002', 'MH001', 9.0), ('SV000002', 'MH002', 8.0),
('SV000003', 'MH001', 7.0), ('SV000003', 'MH002', 8.5),
('SV000004', 'MH001', 6.5), ('SV000004', 'MH002', 7.0),
('SV000005', 'MH001', 8.0), ('SV000005', 'MH002', 7.5),
('SV000006', 'MH003', 8.0), ('SV000007', 'MH003', 7.5),
('SV000011', 'MH007', 8.5), ('SV000012', 'MH007', 7.0),
('SV000016', 'MH006', 9.0), ('SV000017', 'MH006', 8.0),
('SV000021', 'MH008', 7.5), ('SV000022', 'MH008', 8.5)
