-- CREATE DATABASE Winmart_Shop;
USE Winmart_Shop;

---------------------------------------
-- === === 1. AUTHENTICATION === === --
---------------------------------------
CREATE TABLE VAITRO (
    MAVT INT PRIMARY KEY IDENTITY,
    TENVT NVARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE TAIKHOAN (
    MATK INT PRIMARY KEY IDENTITY,
    MATKHAU NVARCHAR(100) NOT NULL,
    MAVT INT NOT NULL,

    FOREIGN KEY (MAVT) REFERENCES VAITRO (MAVT)
)

CREATE TABLE KHACHHANG (
    MAKH INT PRIMARY KEY IDENTITY(1, 1),
    TEN NVARCHAR(50) NOT NULL,
    HO NVARCHAR(50) NOT NULL,
    NGAYSINH DATE,
    GIOITINH BIT NOT NULL DEFAULT 1, -- 1 is MALE
    DIACHI NVARCHAR(200),
    SDT VARCHAR(11) NOT NULL UNIQUE,
    EMAIL VARCHAR(100),
    TRANGTHAI BIT NOT NULL DEFAULT 1, -- 1 is ACTIVE, 0 is INACTIVE
    MATK INT,

    FOREIGN KEY (MATK) REFERENCES TAIKHOAN (MATK)
);

CREATE TABLE NHANVIEN (
    MANV INT PRIMARY KEY IDENTITY,
    TEN NVARCHAR(50) NOT NULL,
    HO NVARCHAR(50) NOT NULL,
    NGAYSINH DATE,
    GIOITINH BIT NOT NULL DEFAULT 1,
    DIACHI NVARCHAR(200),
    SDT VARCHAR(11) NOT NULL UNIQUE,
    EMAIL VARCHAR(100),
    TRANGTHAI BIT NOT NULL DEFAULT 1,
    MATK INT,

    FOREIGN KEY (MATK) REFERENCES TAIKHOAN (MATK)
);

CREATE TABLE QUANLY(
    MAQL INT PRIMARY KEY IDENTITY,
    MANV INT NOT NULL,
    TG_BONHIEM DATETIME NOT NULL DEFAULT GETDATE(),
    TG_BATDAU DATETIME NOT NULL,
    TG_KETTHUC DATETIME UNIQUE,
    TRANGTHAI BIT NULL DEFAULT 1, -- 1 is ON, 0 is OFF

    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    -- start_datetime >= created_datetime
    -- end_datetime >= start_datetime
);

-----------------------------
-- === === 2. ITEM === === --
-----------------------------

CREATE TABLE DANHMUC (
    MADM INT PRIMARY KEY IDENTITY (1, 1),
    TENDM NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE THUONGHIEU (
    MATH INT PRIMARY KEY IDENTITY (1, 1),
    TENTH NVARCHAR(100) NOT NULL UNIQUE
); 

CREATE TABLE DONVITINH (
    MADVT INT PRIMARY KEY IDENTITY(1, 1),
    TENDVT NVARCHAR(100) NOT NULL UNIQUE,
); 

CREATE TABLE SANPHAM (
    MASP INT PRIMARY KEY IDENTITY(1, 1),
    TENSP NVARCHAR(100) NOT NULL,
    SKU VARCHAR(8) NOT NULL UNIQUE,
    MATH INT,
    MADM INT NOT NULL,
    
    MOTA NVARCHAR(500),
    XUATXU NVARCHAR(50),
    THANHPHAN NVARCHAR(500),
    HD_SUDUNG NVARCHAR(500),
    HD_BAOQUAN NVARCHAR(500),

    TRANGTHAI BIT NOT NULL,

    FOREIGN KEY (MATH) REFERENCES THUONGHIEU(MATH),
    FOREIGN KEY (MADM) REFERENCES DANHMUC(MADM),
);

CREATE TABLE MATHANG (
    MAMH INT PRIMARY KEY IDENTITY(1, 1),
    MASP INT NOT NULL,
    MADVT INT NOT NULL,
    SOLUONG INT NOT NULL CHECK(SOLUONG >= 0),

    FOREIGN KEY (MASP) REFERENCES SANPHAM(MASP),
    FOREIGN KEY (MADVT) REFERENCES DONVITINH(MADVT),
    UNIQUE (MASP, MADVT),
);


------------------------------
-- === === 3. PRICE === === --
------------------------------

CREATE TABLE GIABAN (
    MAGB INT PRIMARY KEY IDENTITY,
    MAMH INT,
    TG_TAO DATETIME NOT NULL DEFAULT GETDATE(),
    TG_APDUNG DATETIME NOT NULL, -- TODO CHECK (TG_APDUNG >= TG_TAO)
    GIABAN MONEY NOT NULL CHECK(GIABAN > 0),
    MANV INT NOT NULL,

    UNIQUE (MAMH, TG_APDUNG),
    FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
);

CREATE TABLE KHUYENMAI (
    MAKM INT PRIMARY KEY IDENTITY,
    TENKM NVARCHAR(100) NOT NULL,
    TG_BATDAU DATETIME NOT NULL, -- TODO CHECK(start_datetime >= GETDATE()),
    TG_KETTHUC DATETIME NOT NULL, -- TODO CHECK(end_datetime > start_datetime),
    MAQL INT NOT NULL,
    TG_TAO DATETIME NOT NULL DEFAULT GETDATE(),
    TRANGTHAI BIT NOT NULL DEFAULT 1, -- 1 is ON, 0 is OFF

    FOREIGN KEY (MAQL) REFERENCES QUANLY(MAQL),
);

CREATE TABLE CT_KHUYENMAI (
    MAMH INT NOT NULL,
    MAKM INT NOT NULL,
    GIAMGIA INT NOT NULL CHECK(GIAMGIA > 0 AND GIAMGIA <= 50),

    PRIMARY KEY (MAMH, MAKM),
    FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
    FOREIGN KEY (MAKM) REFERENCES KHUYENMAI(MAKM),
);



------------------------------
-- === === 4. ORDER === === --
------------------------------

CREATE TABLE GIOHANG (
    MAKH INT,
    MAMH INT,
    SOLUONG INT NOT NULL CHECK(SOLUONG > 0),

    PRIMARY KEY (MAKH, MAMH),
    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
    FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
);

CREATE TABLE TRANGTHAIDONHANG (
    MATT_DH INT PRIMARY KEY IDENTITY,
    TENTT_DH NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE DONHANG (
    MADH INT PRIMARY KEY IDENTITY,
    MAKH INT NOT NULL,
    HOTEN NVARCHAR(100) NOT NULL,
    SDT VARCHAR(11) NOT NULL,
    DIACHI NVARCHAR(200) NOT NULL,
    LUUY_GIAO NVARCHAR(200),
    LIDO_HUY NVARCHAR(200),
    TG_HENGIAO DATETIME NOT NULL, -- CHECK (delivery_datetime >= created_datetime),

    -- metadata
    MANV INT,
    TG_DAT DATETIME NOT NULL DEFAULT GETDATE(),
    MATT_DH INT NOT NULL,

    FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    FOREIGN KEY (MATT_DH) REFERENCES TRANGTHAIDONHANG(MATT_DH),
);

CREATE TABLE CT_DONHANG (
    MADH INT NOT NULL,
    MAMH INT NOT NULL,
    SOLUONG INT NOT NULL CHECK(SOLUONG > 0), 
    GIA MONEY NOT NULL CHECK(GIA > 0),
    MAKM INT,

    PRIMARY KEY (MADH, MAMH),
    FOREIGN KEY (MADH) REFERENCES DONHANG(MADH),
    FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
    FOREIGN KEY (MAKM) REFERENCES KHUYENMAI(MAKM),
);

CREATE TABLE HOADON (
    MAHD INT PRIMARY KEY IDENTITY,
    MADH INT NOT NULL UNIQUE,
    MANV INT NOT NULL,
    TG_TAO DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (MADH) REFERENCES DONHANG(MADH),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
);


------------------------------------
-- === === 5. LIQUIDATION === === --
------------------------------------

CREATE TABLE LIDO_THANHLY (
    MALD_TL INT PRIMARY KEY IDENTITY,
    TENLD_TL NVARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE THANHLY (
    MATL INT PRIMARY KEY IDENTITY,
    TG_TAO DATETIME NOT NULL DEFAULT GETDATE(),
    MANV INT NOT NULL,
    MAQL INT,

    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    FOREIGN KEY (MAQL) REFERENCES QUANLY(MAQL),
);

CREATE TABLE CT_THANHLY (
    MATL INT NOT NULL,
    MAMH INT NOT NULL,
    SOLUONG INT NOT NULL CHECK (SOLUONG > 0),
    MALD_TL INT NOT NULL,
    TRANGTHAI BIT NOT NULL DEFAULT 0,

    FOREIGN KEY (MATL) REFERENCES THANHLY(MATL),
    FOREIGN KEY (MAMH) REFERENCES MATHANG(MAMH),
    FOREIGN KEY (MALD_TL) REFERENCES LIDO_THANHLY(MALD_TL),
);