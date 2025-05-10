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


-- 1. Danh sách các giáo viên thuộc khoa tin học gồm MaGV, Hoten
-- Cách 1:
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
JOIN KHOA K ON GV.MaKhoa = K.MaKhoa
WHERE TenKhoa = N'Tin Học';
-- Cách 2:
SELECT MaGV, HoTen 
FROM GIAOVIEN
WHERE MaKhoa IN (	SELECT MaKhoa 
					FROM KHOA 
					WHERE TenKhoa = N'Tin học');

-- 2. Danh sách các trường của trung tâm có khoa ngoại ngữ và khoa tin học
-- Cách 1:
SELECT DISTINCT T.MaTruong, TenTruong
FROM TRUONG T
JOIN KHOA K ON T.MaTruong = K.MaTruong
WHERE TenKhoa = N'Ngoại Ngữ'
AND T.MaTruong IN (	SELECT K2.MaTruong
					FROM KHOA K2
					WHERE TenKhoa = N'Tin Học');

SELECT DISTINCT K1.MaTruong, T.TenTruong
FROM Truong T
JOIN Khoa K1 ON T.MaTruong = K1.MaTruong
JOIN Khoa K2 ON T.MaTruong = K2.MaTruong
WHERE K1.TenKhoa = N'Tin học' AND K2.TenKhoa = N'Ngoại ngữ'
-- Cách 2:
SELECT DISTINCT T.MaTruong, TenTruong
FROM TRUONG T
JOIN KHOA K ON T.MaTruong = K.MaTruong
WHERE TenKhoa = N'Ngoại Ngữ'
Intersect
SELECT DISTINCT T.MaTruong, TenTruong
FROM TRUONG T
JOIN KHOA K ON T.MaTruong = K.MaTruong
WHERE TenKhoa = N'Tin Học'
-- Cách 3:
SELECT DISTINCT T.MaTruong, TenTruong
FROM TRUONG T
JOIN KHOA K ON T.MaTruong = K.MaTruong
WHERE TenKhoa IN (N'Tin học', N'Ngoại Ngữ')
Group by T.MaTruong, TenTruong
Having count(distinct TenKhoa) = 2

-- 3. Danh sách các sinh viên học môn học Cơ sở dữ liệu thuộc lớp DHTH8 gồm Masv, Hoten
SELECT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
JOIN MONHOC MH ON SVMH.MaMH = MH.MaMH
JOIN LOP L ON SV.MaLop = L.MaLop
WHERE MH.TenMH = N'Cơ sở dữ liệu' AND L.TenLop = 'DHTH8';

-- 4. Danh sách các môn học do Thầy có tên Nguyễn Văn dạy
SELECT DISTINCT MH.MaMH, MH.TenMH
FROM MONHOC MH
JOIN GIAOVIEN_MONHOC GVMH ON MH.MaMH = GVMH.MaMH
JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
WHERE GV.HoTen = N'Nguyễn Văn';

-- 5. Danh sách các lớp do Thầy Nguyễn Văn dạy
SELECT DISTINCT L.MaLop, L.TenLop
FROM LOP L
WHERE L.MaGVChuNhiem IN (
    SELECT GV.MaGV
    FROM GIAOVIEN GV
    WHERE GV.HoTen = N'Nguyễn Văn');
--5. Danh sách các lớp do Thầy Nguyễn Văn dạy
SELECT DISTINCT L.MaLop, L.TenLop
FROM LOP L
JOIN SINHVIEN SV ON L.MaLop = SV.MaLop
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
JOIN GIAOVIEN_MONHOC GVMH ON SVMH.MaMH = GVMH.MaMH
JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
WHERE GV.HoTen = N'Nguyễn Văn'
-- 6. Danh sách các lớp có số sinh viên lớn hơn 50
SELECT L.MaLop, L.TenLop, COUNT(SV.MaSV) AS SoLuongSV
FROM LOP L
JOIN SINHVIEN SV ON L.MaLop = SV.MaLop
GROUP BY L.MaLop, L.TenLop
HAVING COUNT(SV.MaSV) > 50;

-- 7. Danh sách các lớp thuộc khoa Tin học học môn Cấu trúc dữ liệu
SELECT DISTINCT L.MaLop, L.TenLop, K.TenKhoa, MH.TenMH
FROM LOP L
JOIN SINHVIEN SV ON L.MaLop = SV.MaLop
JOIN KHOA K ON SV.MaKhoa = K.MaKhoa
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
JOIN MONHOC MH ON SVMH.MaMH = MH.MaMH
WHERE K.TenKhoa = N'Tin Học'
AND MH.TenMH = N'Cấu trúc dữ liệu';

-- 8. Danh sách các môn học không do thầy Nguyễn Văn dạy
SELECT MH.MaMH, MH.TenMH
--, GV.HoTen
FROM MONHOC MH 
-- JOIN GIAOVIEN_MONHOC GVMH ON MH.MaMH = GVMH.MaMH
-- JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
WHERE MH.MaMH NOT IN (	SELECT DISTINCT GVMH.MaMH
						FROM GIAOVIEN_MONHOC GVMH
						JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
						WHERE GV.HoTen = N'Nguyễn Văn' )
-- 9. Danh sách các môn học không có sinh viên học
-- Cách 1:
SELECT MH.MaMH, MH.TenMH
FROM MONHOC MH
LEFT JOIN SINHVIEN_MONHOC SVMH ON MH.MaMH = SVMH.MaMH
WHERE SVMH.MaSV IS NULL
-- Cách 2:
SELECT MH.MaMH, MH.TenMH
FROM MONHOC MH
WHERE MaMH NOT IN (	SELECT DISTINCT MaMH
					FROM SINHVIEN_MONHOC )
-- Cách 3:
SELECT MH.MaMH, MH.TenMH
FROM MONHOC MH
WHERE NOT EXISTS (	SELECT DISTINCT MaMH
					FROM SINHVIEN_MONHOC SVMH 
					WHERE MH.MaMH = SVMH.MaMH )
-- 10. Danh sách các giáo viên dạy cả hai môn Cơ sở dữ liệu và Cấu trúc dữ liệu
-- Cách 1:
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
WHERE GV.MaGV IN (	SELECT GVMH.MaGV
					FROM GIAOVIEN_MONHOC GVMH
					JOIN MONHOC MH ON GVMH.MaMH = MH.MaMH
					WHERE MH.TenMH = N'Cơ sở dữ liệu'
					INTERSECT
					SELECT GVMH.MaGV
					FROM GIAOVIEN_MONHOC GVMH
					JOIN MONHOC MH ON GVMH.MaMH = MH.MaMH
					WHERE MH.TenMH = N'Cấu trúc dữ liệu')
-- Cách 2:
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
JOIN GIAOVIEN_MONHOC GVMH ON GVMH.MaGV = GV.MaGV
JOIN MONHOC MH ON MH.MaMH = GVMH.MaMH
WHERE MH.TenMH = N'Cơ sở dữ liệu'
INTERSECT
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
JOIN GIAOVIEN_MONHOC GVMH ON GVMH.MaGV = GV.MaGV
JOIN MONHOC MH ON MH.MaMH = GVMH.MaMH
WHERE MH.TenMH = N'Cấu trúc dữ liệu'
-- Cách 3:
SELECT GV.MaGV, GV.HoTen 
FROM GIAOVIEN GV
WHERE GV.MaGV IN (	SELECT GVMH.MaGV 
					FROM GIAOVIEN_MONHOC GVMH
					JOIN MONHOC MH ON GVMH.MaMH = MH.MaMH
					WHERE MH.TenMH = N'Cơ sở dữ liệu' ) 
AND GV.MaGV IN (SELECT GVMH.MaGV 
				FROM GIAOVIEN_MONHOC GVMH
				JOIN MONHOC MH ON GVMH.MaMH = MH.MaMH
				WHERE MH.TenMH = N'Cấu trúc dữ liệu')
-- Cách 4:
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
JOIN GIAOVIEN_MONHOC GVMH ON GV.MaGV = GVMH.MaGV
JOIN MONHOC MH ON GVMH.MaMH = MH.MaMH
WHERE MH.TenMH IN (N'Cơ sở dữ liệu', N'Cấu trúc dữ liệu')
GROUP BY GV.MaGV, GV.HoTen
HAVING COUNT(DISTINCT MH.TenMH) = 2
-- 11. Cho biết mỗi giáo viên dạy bao nhiêu lớp
SELECT GV.MaGV, GV.HoTen, COUNT(DISTINCT SV.MaLop) AS SoLopDay
FROM GIAOVIEN GV
LEFT JOIN GIAOVIEN_MONHOC GVMH ON GV.MaGV = GVMH.MaGV
LEFT JOIN SINHVIEN_MONHOC SVMH ON GVMH.MaMH = SVMH.MaMH
LEFT JOIN SINHVIEN SV ON SVMH.MaSV = SV.MaSV
GROUP BY GV.MaGV, GV.HoTen

-- 12. Cho biết tổng số các môn học của một lớp
SELECT L.MaLop, L.TenLop, COUNT(DISTINCT SVMH.MaMH) AS SoMonHoc
FROM LOP L
JOIN SINHVIEN SV ON L.MaLop = SV.MaLop
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
GROUP BY L.MaLop, L.TenLop;

-- Các câu truy vấn bổ sung
--6 câu thêm
-- 1. (kết nối nhiều bảng): Sinh viên học các môn do giáo viên tên chứa 'Văn' dạy.
SELECT DISTINCT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
JOIN SINHVIEN_MONHOC SMH ON SV.MaSV = SMH.MaSV
JOIN GIAOVIEN_MONHOC GMH ON SMH.MaMH = GMH.MaMH
JOIN GIAOVIEN GV ON GMH.MaGV = GV.MaGV
WHERE GV.HoTen LIKE N'%Văn%'

SELECT DISTINCT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
JOIN MONHOC MH ON SVMH.MaMH = MH. MaMH
JOIN GIAOVIEN_MONHOC GVMH ON MH.MaMH = GVMH.MaMH
JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
WHERE GV.HoTen LIKE N'%Văn%'

--2. (kết nối nhiều bảng): Môn học sinh viên lớp DHTH9 học do GV khoa Tin học dạy
SELECT DISTINCT MH.TenMH
FROM MONHOC MH
JOIN GIAOVIEN_MONHOC GMH ON MH.MaMH = GMH.MaMH
JOIN GIAOVIEN GV ON GMH.MaGV = GV.MaGV
JOIN SINHVIEN_MONHOC SMH ON MH.MaMH = SMH.MaMH
JOIN SINHVIEN SV ON SMH.MaSV = SV.MaSV
JOIN LOP L ON SV.MaLop = L.MaLop
WHERE GV.MaKhoa = (SELECT MaKhoa FROM KHOA WHERE TenKhoa = N'Tin học')
AND L.TenLop = 'DHTH9'

--3. (UPDATE): Cập nhật tên giáo viên thành 'GV_NN' nếu họ thuộc khoa Ngoại ngữ và đang giảng dạy ít nhất 2 môn học.
UPDATE GIAOVIEN
SET HoTen = 'GV_NN'
WHERE MaGV IN 
( SELECT GMH.MaGV
  FROM GIAOVIEN_MONHOC GMH
  JOIN GIAOVIEN GV ON GMH.MaGV = GV.MaGV
  JOIN KHOA K ON GV.MaKhoa = K.MaKhoa
  WHERE K.TenKhoa = N'Ngoại ngữ'
  GROUP BY GMH.MaGV
  HAVING COUNT(DISTINCT GMH.MaMH) >= 2)
--4. (UPDATE): Cập nhật tên lớp 'DHTH8' thành 'DHCNTT_N' nếu lớp này có ít nhất 1 sinh viên đang học môn 'Cơ sở dữ liệu'
UPDATE LOP
SET TenLop = 'DHCNTT_N'
WHERE TenLop = 'DHTH8'
  AND MaLop IN 
( SELECT DISTINCT SV.MaLop
    FROM SINHVIEN SV
    JOIN SINHVIEN_MONHOC SMH ON SV.MaSV = SMH.MaSV
    JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
    WHERE MH.TenMH = N'Cơ sở dữ liệu')

--5. (DELETE): Xoá các đăng ký học đối với các môn thuộc khoa Ngoại ngữ và có điểm dưới 3.
DELETE FROM SINHVIEN_MONHOC
WHERE MaMH IN 
( SELECT MH.MaMH
  FROM MONHOC MH
  JOIN KHOA K ON MH.MaKhoa = K.MaKhoa
  WHERE K.TenKhoa = N'Ngoại ngữ')
AND DiemSo < 3

--6. (DELETE): “Xoá sinh viên thuộc khoa ‘Tin học’ mà chưa đăng ký bất kỳ môn nào và sinh trước năm 2005”
DELETE FROM SINHVIEN
WHERE MaKhoa = ( SELECT MaKhoa FROM KHOA WHERE TenKhoa = N'Tin học')
AND MaSV NOT IN ( SELECT DISTINCT MaSV FROM SINHVIEN_MONHOC)
AND YEAR(NgaySinh) < 2005
--2 group by:
--Thống kê số lượng sinh viên theo từng khoa:
SELECT K.TenKhoa, COUNT(SV.MaSV) AS SoSinhVien
FROM KHOA K
LEFT JOIN SINHVIEN SV ON K.MaKhoa = SV.MaKhoa
GROUP BY K.TenKhoa

--Điểm trung bình của từng môn học:
SELECT MH.TenMH, AVG(SVMH.DiemSo) AS DiemTrungBinh
FROM MONHOC MH
JOIN SINHVIEN_MONHOC SVMH ON MH.MaMH = SVMH.MaMH
GROUP BY MH.TenMH

--2 sub query:
--Danh sách sinh viên có điểm cao hơn điểm trung bình của môn CSDL:
SELECT SV.MaSV, SV.HoTen, SVMH.DiemSo as DiemSoSV, AVG(DiemSo) as DTBM
FROM SINHVIEN SV
JOIN SINHVIEN_MONHOC SVMH ON SV.MaSV = SVMH.MaSV
JOIN MONHOC MH ON MH.MaMH = SVMH.MaMH
WHERE MH.TenMH = N'Cơ sở dữ liệu' 
AND SVMH.DiemSo > (	SELECT AVG(DiemSo) 
					FROM SINHVIEN_MONHOC SVMH
					JOIN MONHOC MH ON MH.MaMH = SVMH.MaMH
					WHERE MH.TenMH = N'Cơ sở dữ liệu' )
Group by SV.MaSV, SV.HoTen, SVMH.DiemSo 
--Danh sách sinh viên có điểm cao nhất từng môn học
-- Cách 1:
SELECT MH.TenMH, SV.MaSV, SV.HoTen, SVMH.DiemSo
FROM SINHVIEN_MONHOC SVMH
JOIN SINHVIEN SV ON SVMH.MaSV = SV.MaSV
JOIN MONHOC MH ON SVMH.MaMH = MH.MaMH
WHERE SVMH.DiemSo = (	SELECT MAX(SVMH2.DiemSo) 
						FROM SINHVIEN_MONHOC SVMH2 
						WHERE SVMH2.MaMH = SVMH.MaMH )
ORDER BY MH.TenMH

--Danh sách tên môn học do giáo viên không phải là chủ nhiệm khoa dạy:
SELECT DISTINCT MH.MaMH, MH.TenMH, GV.HoTen
FROM MONHOC MH
JOIN GIAOVIEN_MONHOC GVMH ON MH.MaMH = GVMH.MaMH
JOIN GIAOVIEN GV ON GVMH.MaGV = GV.MaGV
WHERE GV.MaGV NOT IN (	SELECT MaGVChuNhiem 
						FROM KHOA 
						WHERE MaGVChuNhiem IS NOT NULL)

SELECT MH.MaMH, MH.TenMH
FROM MONHOC MH
WHERE MH.MaMH IN (SELECT GVMH.MaMH FROM GIAOVIEN_MONHOC GVMH
					WHERE GVMH.MaGV IN (SELECT GV.MaGV FROM GIAOVIEN GV
										WHERE GV.MaGV NOT IN (SELECT MaGVChuNhiem FROM KHOA)))


--Danh sách giáo viên không phải là chủ nhiệm khoa 
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
WHERE GV.MaGV NOT IN (	SELECT MaGVChuNhiem FROM KHOA )

--2 câu bất kì:
--Liệt kê số lượng sinh viên theo từng khoa, sắp xếp theo số lượng giảm dần
SELECT K.MaKhoa, K.TenKhoa, COUNT(SV.MaSV) AS SoLuongSinhVien
FROM KHOA K
LEFT JOIN SINHVIEN SV ON K.MaKhoa = SV.MaKhoa
GROUP BY K.MaKhoa, K.TenKhoa
ORDER BY SoLuongSinhVien DESC;

-- Tìm những giáo viên không dạy môn nào
-- Cách 1:
SELECT GV.MaGV, GV.HoTen
FROM GIAOVIEN GV
LEFT JOIN GIAOVIEN_MONHOC GVMH ON GV.MaGV = GVMH.MaGV
WHERE GVMH.MaMH IS NULL;

-- Cách 2:
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (	SELECT *
					FROM GIAOVIEN_MONHOC GVMH
					WHERE GVMH.MaGV = GV.MaGV )
--Hiển thị danh sách giáo viên có điểm trung bình của sinh viên học môn do giáo viên dạy cao nhất
SELECT GV.MaGV, GV.HoTen, AVG_DIEM.DiemTrungBinh
FROM GIAOVIEN GV
JOIN (	SELECT D.MaGV, AVG(H.DiemSo) AS DiemTrungBinh
		FROM GIAOVIEN_MONHOC D
		JOIN SINHVIEN_MONHOC H ON D.MaMH = H.MaMH
		GROUP BY D.MaGV	) 
AS AVG_DIEM ON GV.MaGV = AVG_DIEM.MaGV
WHERE AVG_DIEM.DiemTrungBinh = (	SELECT MAX(DiemTB.DiemTrungBinh)
									FROM (	SELECT AVG(H.DiemSo) AS DiemTrungBinh
											FROM GIAOVIEN_MONHOC D
											JOIN SINHVIEN_MONHOC H ON D.MaMH = H.MaMH
											GROUP BY D.MaGV		) AS DiemTB	)
-- Số lượng môn học GV dạy
SELECT GV.MaGV, GV.HoTen, COUNT(GVMN.MaMH) AS SoLuongMonHoc
FROM GIAOVIEN GV
LEFT JOIN GIAOVIEN_MONHOC GVMN ON GV.MaGV = GVMN.MaGV
GROUP BY GV.MaGV, GV.HoTen

--truy vấn mỗi cá nhân
----2 câu delete (Nô En)
----1. "Xóa sinh viên sinh trước năm 2000, học khoa 'Ngoại ngữ', chưa từng học môn nào có tên bắt đầu bằng 'Tiếng'"
DELETE FROM SINHVIEN
WHERE MaKhoa = (
    SELECT MaKhoa FROM KHOA WHERE TenKhoa = N'Ngoại ngữ'
)
AND YEAR(NgaySinh) < 2000
AND MaSV NOT IN (
    SELECT DISTINCT SMH.MaSV
    FROM SINHVIEN_MONHOC SMH
    JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
    WHERE MH.TenMH LIKE N'Tiếng%'
);

----2. "Xóa các sinh viên có tên chứa chữ "Nguyễn", đã học ít nhất một môn nhưng tất cả các môn đó đều thuộc khoa khác khoa của chính sinh viên"
DELETE FROM SINHVIEN
WHERE HoTen LIKE N'%Nguyễn%'
AND EXISTS (
    SELECT 1
    FROM SINHVIEN_MONHOC SMH
    WHERE SMH.MaSV = SINHVIEN.MaSV
)
AND NOT EXISTS (SELECT 1
				FROM SINHVIEN_MONHOC SMH
				JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
				WHERE SMH.MaSV = SINHVIEN.MaSV
				AND MH.MaKhoa = SINHVIEN.MaKhoa)

--- 2 câu UPDATE (Huy)
--Câu 1: Cập nhật tên các môn học thuộc khoa Ngoại ngữ không có sinh viên học thành 'Môn ít quan tâm'
UPDATE MONHOC
SET TenMH = N'Môn ít quan tâm'
WHERE MaMH IN (
    SELECT MH.MaMH
    FROM MONHOC MH
    JOIN KHOA K ON MH.MaKhoa = K.MaKhoa
    WHERE K.TenKhoa = N'Ngoại ngữ'
    AND MH.MaMH NOT IN (
        SELECT DISTINCT MaMH
        FROM SINHVIEN_MONHOC
    )
)

select * from MONHOC
--Câu 2: Đổi tên lớp DHTH8 thành DHCNTT_N cho sinh viên học CSDL

UPDATE LOP
SET TenLop = 'DHCNTT_N'
WHERE TenLop = 'DHTH8'
  AND MaLop IN
( SELECT DISTINCT SV.MaLop
    FROM SINHVIEN SV
    JOIN SINHVIEN_MONHOC SMH ON SV.MaSV = SMH.MaSV
    JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
    WHERE MH.TenMH = N'Cơ sở dữ liệu')

---2csubquyry (Hằng)
--Liệt kê họ tên sinh viên và tên lớp của những sinh viên học cùng khoa với giáo viên có tên chứa 'An'.
SELECT SV.HoTen AS TenSinhVien, L.TenLop
FROM SINHVIEN SV
JOIN LOP L ON SV.MaLop = L.MaLop
WHERE SV.MaKhoa IN (
    SELECT GV.MaKhoa
    FROM GIAOVIEN GV
    WHERE GV.HoTen LIKE '%An%')
go
--Tìm tên các trường đại học có nhiều hơn 3 khoa.
SELECT TenTruong
FROM TRUONG
WHERE MaTruong IN (
    SELECT MaTruong
    FROM KHOA
    GROUP BY MaTruong
    HAVING COUNT(*) > 3)

--2 group by - Nhi 
--Câu 1: Thống kê số lượng môn học, tổng số tiết và điểm trung bình của sinh viên theo từng trường và khoa
SELECT TR.TenTruong, K.TenKhoa, 
	COUNT(DISTINCT MH.MaMH) AS SoMH,
    SUM(GVMH.SoTiet) AS TongTiet,
    AVG(SVMH.DiemSo) AS DTB
FROM TRUONG TR
JOIN KHOA K ON TR.MaTruong = K.MaTruong
JOIN MONHOC MH ON K.MaKhoa = MH.MaKhoa
LEFT JOIN GIAOVIEN_MONHOC GVMH ON MH.MaMH = GVMH.MaMH
LEFT JOIN SINHVIEN_MONHOC SVMH ON MH.MaMH = SVMH.MaMH
GROUP BY TR.TenTruong, K.TenKhoa
ORDER BY TR.TenTruong, K.TenKhoa


--Câu 2: Tìm các giáo viên dạy nhiều môn nhất trong mỗi khoa
SELECT K.TenKhoa, GV.HoTen HoTenGV, COUNT(GVMH1.MaMH) AS SoMH
FROM KHOA K
JOIN GIAOVIEN GV ON K.MaKhoa = GV.MaKhoa
JOIN GIAOVIEN_MONHOC GVMH1 ON GV.MaGV = GVMH1.MaGV
GROUP BY K.MaKhoa, K.TenKhoa, GV.MaGV, GV.HoTen
HAVING COUNT(GVMH1.MaMH) = (
    SELECT MAX(SoMon.SoLuong)
    FROM (	SELECT COUNT(GVMH2.MaMH) SoLuong
			FROM GIAOVIEN GV2
			JOIN GIAOVIEN_MONHOC GVMH2 ON GV2.MaGV = GVMH2.MaGV
			WHERE GV2.MaKhoa = K.MaKhoa
			GROUP BY GV2.MaGV) AS SoMon)
ORDER BY K.TenKhoa, SoMH DESC


--2 câu truy vấn kết nối nhiều bảng - Trân
--Câu 1: Liệt kê mã và tên các sinh viên đang học môn 'Cơ sở dữ liệu' do giáo viên thuộc khoa 'Tin học' giảng dạy.
SELECT DISTINCT SV.MaSV, SV.HoTen
FROM SINHVIEN SV
JOIN SINHVIEN_MONHOC SMH ON SV.MaSV = SMH.MaSV
JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
JOIN GIAOVIEN_MONHOC GMH ON MH.MaMH = GMH.MaMH
JOIN GIAOVIEN GV ON GMH.MaGV = GV.MaGV
JOIN KHOA K ON GV.MaKhoa = K.MaKhoa
WHERE MH.TenMH = N'Cơ sở dữ liệu'
  AND K.TenKhoa = N'Tin học'

--Câu 2: Liệt kê tên lớp và số lượng sinh viên của mỗi lớp đang học môn có số tín chỉ ≥ 3 do giáo viên tên chứa 'Nguyễn' giảng dạy.
SELECT L.TenLop, COUNT(DISTINCT SV.MaSV) AS SoLuongSV
FROM SINHVIEN SV
JOIN LOP L ON SV.MaLop = L.MaLop
JOIN SINHVIEN_MONHOC SMH ON SV.MaSV = SMH.MaSV
JOIN MONHOC MH ON SMH.MaMH = MH.MaMH
JOIN GIAOVIEN_MONHOC GMH ON MH.MaMH = GMH.MaMH
JOIN GIAOVIEN GV ON GMH.MaGV = GV.MaGV
WHERE GV.HoTen LIKE N'%Nguyễn%'
  AND MH.SoTinChi >= 3
GROUP BY L.TenLop

