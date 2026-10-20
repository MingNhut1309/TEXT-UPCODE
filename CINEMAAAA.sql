-- =====================================================
-- ZANEPN CINEMA - CƠ SỞ DỮ LIỆU RẠP PHIM (BẢN HOÀN CHỈNH)
-- Cách dùng: mở file này trong SQL Server Management Studio rồi bấm Execute (F5).
-- Script tự tạo cơ sở dữ liệu CINEMA nếu chưa có, tạo 7 bảng và nạp dữ liệu mẫu.
-- Chạy lại nhiều lần được: mỗi lần chạy sẽ đặt lại 7 bảng về dữ liệu mẫu ban đầu.
-- =====================================================

SET NOCOUNT ON;
GO

IF DB_ID(N'CINEMA') IS NULL
    CREATE DATABASE CINEMA;
GO

USE CINEMA;
GO

-- =====================================================
-- XÓA BẢNG CŨ (bảng con xóa trước, bảng cha xóa sau)
-- =====================================================
IF OBJECT_ID(N'dbo.ChiTietDatVe', N'U') IS NOT NULL DROP TABLE dbo.ChiTietDatVe;
IF OBJECT_ID(N'dbo.DonDatVe',     N'U') IS NOT NULL DROP TABLE dbo.DonDatVe;
IF OBJECT_ID(N'dbo.Ghe',          N'U') IS NOT NULL DROP TABLE dbo.Ghe;
IF OBJECT_ID(N'dbo.SuatChieu',    N'U') IS NOT NULL DROP TABLE dbo.SuatChieu;
IF OBJECT_ID(N'dbo.PhongChieu',   N'U') IS NOT NULL DROP TABLE dbo.PhongChieu;
IF OBJECT_ID(N'dbo.Phim',         N'U') IS NOT NULL DROP TABLE dbo.Phim;
IF OBJECT_ID(N'dbo.TaiKhoan',     N'U') IS NOT NULL DROP TABLE dbo.TaiKhoan;
GO

-- =====================================================
-- TẠO BẢNG (bảng cha tạo trước, bảng con tạo sau)
-- =====================================================

-- Tài khoản
CREATE TABLE dbo.TaiKhoan (
    TenDangNhap  varchar(50)   NOT NULL PRIMARY KEY,
    MatKhau      nvarchar(50)  NOT NULL,
    HoTen        nvarchar(100) NULL,
    QuyenHan     tinyint       NOT NULL DEFAULT 0,       -- 0 = khách, 1 = quản trị
    Email        varchar(50)   NULL,
    SoDienThoai  varchar(15)   NULL,
    HoatDong     bit           NOT NULL DEFAULT 1,
    NgayTao      datetime      NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT CK_TaiKhoan_QuyenHan CHECK (QuyenHan IN (0, 1))
);
GO

-- Phim
CREATE TABLE dbo.Phim (
    MaPhim          int            NOT NULL PRIMARY KEY,
    ThuongHieu      nvarchar(20)   NULL,                 -- Marvel / DC
    TenPhim         nvarchar(200)  NOT NULL,
    TheLoai         nvarchar(100)  NULL,
    NhanPhim        varchar(10)    NULL,                 -- NEW, HOT, 3D, CLASSIC
    NamPhatHanh     int            NULL,
    LopPoster       varchar(20)    NULL,                 -- poster-1 ... poster-4 (class trong Style.css)
    ThoiLuong       int            NULL,                 -- phút
    DaoDien         nvarchar(100)  NULL,
    MoTa            nvarchar(max)  NULL,
    DoTuoi          varchar(5)     NULL,                 -- P, T13, T16, T18
    DuongDanPoster  nvarchar(300)  NULL,
    DuongDanTrailer nvarchar(300)  NULL,
    DangChieu       bit            NOT NULL DEFAULT 1,
    An              bit            NOT NULL DEFAULT 0,
    NgayTao         datetime       NOT NULL DEFAULT (GETDATE()),
    CONSTRAINT CK_Phim_ThoiLuong   CHECK (ThoiLuong IS NULL OR ThoiLuong > 0),
    CONSTRAINT CK_Phim_NamPhatHanh CHECK (NamPhatHanh IS NULL OR NamPhatHanh BETWEEN 1900 AND 2100),
    CONSTRAINT CK_Phim_NhanPhim    CHECK (NhanPhim IS NULL OR NhanPhim IN ('NEW', 'HOT', '3D', 'CLASSIC')),
    CONSTRAINT CK_Phim_DoTuoi      CHECK (DoTuoi IS NULL OR DoTuoi IN ('P', 'T13', 'T16', 'T18'))
);
GO

-- Phòng chiếu
CREATE TABLE dbo.PhongChieu (
    MaPhong   int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenPhong  nvarchar(20)  NOT NULL UNIQUE,
    LoaiPhong varchar(10)   NOT NULL DEFAULT '2D',       -- 2D / 3D / IMAX
    HoatDong  bit           NOT NULL DEFAULT 1,
    CONSTRAINT CK_PhongChieu_Loai CHECK (LoaiPhong IN ('2D', '3D', 'IMAX'))
);
GO

-- Suất chiếu
CREATE TABLE dbo.SuatChieu (
    MaSuat     int           NOT NULL PRIMARY KEY,
    MaPhim     int           NOT NULL FOREIGN KEY REFERENCES dbo.Phim(MaPhim),
    MaPhong    int           NOT NULL FOREIGN KEY REFERENCES dbo.PhongChieu(MaPhong),
    GioBatDau  smalldatetime NOT NULL,
    GiaVe      int           NOT NULL,
    DinhDang   varchar(10)   NULL,                       -- 2D / 3D / IMAX
    CONSTRAINT CK_SuatChieu_GiaVe    CHECK (GiaVe >= 0),
    CONSTRAINT CK_SuatChieu_DinhDang CHECK (DinhDang IS NULL OR DinhDang IN ('2D', '3D', 'IMAX'))
);
GO

-- Ghế trong phòng
CREATE TABLE dbo.Ghe (
    MaGhe    int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MaPhong  int          NOT NULL FOREIGN KEY REFERENCES dbo.PhongChieu(MaPhong),
    Hang     char(1)      NOT NULL,                      -- A, B, C...
    SoGhe    int          NOT NULL,                      -- 1, 2, 3...
    LoaiGhe  varchar(10)  NOT NULL DEFAULT 'Thuong',     -- Thuong / VIP / Doi
    CONSTRAINT UQ_Ghe_ViTri UNIQUE (MaPhong, Hang, SoGhe),
    CONSTRAINT CK_Ghe_SoGhe CHECK (SoGhe > 0),
    CONSTRAINT CK_Ghe_Loai  CHECK (LoaiGhe IN ('Thuong', 'VIP', 'Doi'))
);
GO

-- Đơn đặt vé
CREATE TABLE dbo.DonDatVe (
    MaDon        int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TenDangNhap  varchar(50)  NOT NULL FOREIGN KEY REFERENCES dbo.TaiKhoan(TenDangNhap),
    MaSuat       int          NOT NULL FOREIGN KEY REFERENCES dbo.SuatChieu(MaSuat),
    ThoiGianDat  datetime     NOT NULL DEFAULT (GETDATE()),
    TongTien     int          NOT NULL DEFAULT 0,
    TrangThai    varchar(15)  NOT NULL DEFAULT 'ChoThanhToan', -- ChoThanhToan / DaThanhToan / DaHuy
    CONSTRAINT CK_DonDatVe_TrangThai CHECK (TrangThai IN ('ChoThanhToan', 'DaThanhToan', 'DaHuy')),
    CONSTRAINT CK_DonDatVe_TongTien  CHECK (TongTien >= 0)
);
GO

-- Chi tiết đơn (một ghế không bị bán 2 lần trong cùng một suất chiếu)
CREATE TABLE dbo.ChiTietDatVe (
    MaChiTiet int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MaDon     int NOT NULL FOREIGN KEY REFERENCES dbo.DonDatVe(MaDon),
    MaSuat    int NOT NULL FOREIGN KEY REFERENCES dbo.SuatChieu(MaSuat),
    MaGhe     int NOT NULL FOREIGN KEY REFERENCES dbo.Ghe(MaGhe),
    GiaVe     int NOT NULL,
    CONSTRAINT UQ_ChiTietDatVe_SuatGhe UNIQUE (MaSuat, MaGhe),
    CONSTRAINT CK_ChiTietDatVe_GiaVe   CHECK (GiaVe >= 0)
);
GO

-- Chỉ mục (tìm nhanh hơn)
CREATE INDEX IX_Phim_DangChieu       ON dbo.Phim      (DangChieu, An);
CREATE INDEX IX_SuatChieu_Phim_Gio   ON dbo.SuatChieu (MaPhim, GioBatDau);
CREATE INDEX IX_DonDatVe_TenDangNhap ON dbo.DonDatVe  (TenDangNhap);
GO

-- =====================================================
-- DỮ LIỆU MẪU
-- =====================================================

-- Tài khoản (mật khẩu mẫu, chưa mã hóa)
INSERT INTO dbo.TaiKhoan (TenDangNhap, MatKhau, HoTen, QuyenHan, Email, SoDienThoai) VALUES
 ('admin',   N'123', N'Quản trị viên', 1, 'admin@gmail.com',   '0900000001'),
 ('khach01', N'123', N'Nguyễn Văn An', 0, 'khach01@gmail.com', '0900000002');
GO

-- 10 phim Marvel đang chiếu
INSERT INTO dbo.Phim
 (MaPhim, ThuongHieu, TenPhim, TheLoai, NhanPhim, NamPhatHanh, LopPoster, ThoiLuong, DaoDien, MoTa, DoTuoi, DangChieu, An) VALUES
 (1,  N'Marvel', N'Iron Man',
      N'Siêu anh hùng • Hành động', 'CLASSIC', 2008, 'poster-3', 126, N'Jon Favreau',
      N'Tỷ phú thiên tài Tony Stark chế tạo bộ giáp sắt để thoát khỏi kẻ thù và trở thành người hùng bảo vệ thế giới.',
      'T13', 1, 0),
 (2,  N'Marvel', N'The Avengers',
      N'Siêu anh hùng • Khoa học viễn tưởng', 'CLASSIC', 2012, 'poster-1', 143, N'Joss Whedon',
      N'Nick Fury tập hợp các siêu anh hùng mạnh nhất Trái Đất để chặn đứng Loki cùng đạo quân ngoài hành tinh.',
      'T13', 1, 0),
 (3,  N'Marvel', N'Guardians of the Galaxy',
      N'Siêu anh hùng • Phiêu lưu', NULL, 2014, 'poster-3', 121, N'James Gunn',
      N'Peter Quill cùng nhóm tội phạm bất đắc dĩ liên minh để ngăn Ronan chiếm đoạt viên đá quyền năng.',
      'T13', 1, 0),
 (4,  N'Marvel', N'Doctor Strange',
      N'Siêu anh hùng • Huyền bí', '3D', 2016, 'poster-1', 115, N'Scott Derrickson',
      N'Bác sĩ phẫu thuật Stephen Strange học phép thuật huyền bí để bảo vệ thế giới khỏi các thế lực hắc ám.',
      'T13', 1, 0),
 (5,  N'Marvel', N'Black Panther',
      N'Siêu anh hùng • Phiêu lưu', '3D', 2018, 'poster-3', 134, N'Ryan Coogler',
      N'T''Challa trở về Wakanda lên ngôi vua và phải bảo vệ đất nước cùng nguồn kim loại vibranium quý giá.',
      'T13', 1, 0),
 (6,  N'Marvel', N'Avengers: Infinity War',
      N'Siêu anh hùng • Khoa học viễn tưởng', 'HOT', 2018, 'poster-1', 149, N'Anthony Russo, Joe Russo',
      N'Các siêu anh hùng hợp sức ngăn Thanos thu thập đủ sáu viên đá vô cực để hủy diệt một nửa vũ trụ.',
      'T13', 1, 0),
 (7,  N'Marvel', N'Avengers: Endgame',
      N'Siêu anh hùng • Khoa học viễn tưởng', 'HOT', 2019, 'poster-3', 181, N'Anthony Russo, Joe Russo',
      N'Sau cú búng tay của Thanos, những người hùng còn lại liều mình hành động để đảo ngược tất cả.',
      'T13', 1, 0),
 (8,  N'Marvel', N'Spider-Man: No Way Home',
      N'Siêu anh hùng • Phiêu lưu', 'HOT', 2021, 'poster-1', 148, N'Jon Watts',
      N'Peter Parker nhờ Doctor Strange xóa danh tính, nhưng phép thuật lại mở ra những kẻ thù từ đa vũ trụ.',
      'T13', 1, 0),
 (9,  N'Marvel', N'Shang-Chi and the Legend of the Ten Rings',
      N'Siêu anh hùng • Võ thuật', 'NEW', 2021, 'poster-3', 132, N'Destin Daniel Cretton',
      N'Shang-Chi buộc phải đối mặt với quá khứ khi bị cha mình, thủ lĩnh tổ chức Thập Nhẫn, truy đuổi.',
      'T13', 1, 0),
 (10, N'Marvel', N'Deadpool & Wolverine',
      N'Siêu anh hùng • Hài', 'HOT', 2024, 'poster-1', 128, N'Shawn Levy',
      N'Deadpool bắt tay cùng Wolverine trong một nhiệm vụ nguy hiểm làm rung chuyển cả đa vũ trụ.',
      'T18', 1, 0);
GO

-- Phòng chiếu
INSERT INTO dbo.PhongChieu (TenPhong, LoaiPhong) VALUES
 (N'Phòng 1', '2D'),
 (N'Phòng 2', '2D'),
 (N'Phòng 3', '3D'),
 (N'Phòng 4', 'IMAX');
GO

-- Ghế: mỗi phòng 8 hàng (A-H) x 10 ghế = 80 ghế
-- Hàng A-E: ghế thường, hàng F-G: ghế VIP, hàng H: ghế đôi
INSERT INTO dbo.Ghe (MaPhong, Hang, SoGhe, LoaiGhe)
SELECT p.MaPhong,
       CHAR(64 + h.SoHang),
       g.SoGhe,
       CASE WHEN h.SoHang = 8 THEN 'Doi'
            WHEN h.SoHang IN (6, 7) THEN 'VIP'
            ELSE 'Thuong' END
FROM dbo.PhongChieu p
CROSS JOIN (VALUES (1),(2),(3),(4),(5),(6),(7),(8)) AS h(SoHang)
CROSS JOIN (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS g(SoGhe);
GO

-- Suất chiếu: ngày 10 và 11 tháng 10 năm 2026, mỗi phim 2 suất
-- Giá vé: phòng 2D = 90.000, phòng 3D = 110.000, phòng IMAX = 130.000
DECLARE @p1 int = (SELECT MaPhong FROM dbo.PhongChieu WHERE TenPhong = N'Phòng 1');
DECLARE @p2 int = (SELECT MaPhong FROM dbo.PhongChieu WHERE TenPhong = N'Phòng 2');
DECLARE @p3 int = (SELECT MaPhong FROM dbo.PhongChieu WHERE TenPhong = N'Phòng 3');
DECLARE @p4 int = (SELECT MaPhong FROM dbo.PhongChieu WHERE TenPhong = N'Phòng 4');

INSERT INTO dbo.SuatChieu (MaSuat, MaPhim, MaPhong, GioBatDau, GiaVe, DinhDang) VALUES
 (1,  1,  @p1, '20261010 09:00',  90000, '2D'),
 (2,  2,  @p1, '20261010 13:00',  90000, '2D'),
 (3,  3,  @p1, '20261010 17:00',  90000, '2D'),
 (4,  4,  @p1, '20261010 21:00',  90000, '2D'),
 (5,  5,  @p2, '20261010 09:00',  90000, '2D'),
 (6,  6,  @p2, '20261010 13:00',  90000, '2D'),
 (7,  7,  @p2, '20261010 17:00',  90000, '2D'),
 (8,  8,  @p2, '20261010 21:00',  90000, '2D'),
 (9,  9,  @p3, '20261010 09:00', 110000, '3D'),
 (10, 10, @p3, '20261010 13:00', 110000, '3D'),
 (11, 10, @p1, '20261011 09:00',  90000, '2D'),
 (12, 9,  @p1, '20261011 13:00',  90000, '2D'),
 (13, 8,  @p1, '20261011 17:00',  90000, '2D'),
 (14, 7,  @p1, '20261011 21:00',  90000, '2D'),
 (15, 6,  @p2, '20261011 09:00',  90000, '2D'),
 (16, 5,  @p2, '20261011 13:00',  90000, '2D'),
 (17, 4,  @p2, '20261011 17:00',  90000, '2D'),
 (18, 3,  @p2, '20261011 21:00',  90000, '2D'),
 (19, 1,  @p4, '20261011 09:00', 130000, 'IMAX'),
 (20, 2,  @p4, '20261011 13:00', 130000, 'IMAX');
GO

PRINT N'Đã tạo xong cơ sở dữ liệu CINEMA.';
GO