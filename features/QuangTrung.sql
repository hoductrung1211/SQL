-- 4. SP xem toàn bộ mặt hàng trong 1 khoảng thời gian, trạng thái --
CREATE PROCEDURE SP_XemDonHangTrongKhoangThoiGian
    @TrangThai INT, -- Thêm tham số cho trạng thái đơn hàng
    @TuNgay DATETIME = NULL,
    @DenNgay DATETIME = NULL    
AS
BEGIN
    -- Nếu cả ngày bắt đầu và ngày kết thúc là NULL, chỉ lọc theo trạng thái
    IF @TuNgay IS NULL AND @DenNgay IS NULL
    BEGIN
        SELECT 
DH.MADH, DH.TG_DAT, DH.HOTEN, DH.DIACHI, DH.SDT, DH.LUUY_GIAO, DH.TG_HENGIAO, SUM(CTDH.GIA) AS TONGTIEN, DH.MANV, 
TTDH.TENTT_DH, DH.LIDO_HUY
        FROM 
            DONHANG DH
        INNER JOIN 
            TRANGTHAIDONHANG TTDH ON DH.MATT_DH = TTDH.MATT_DH
        INNER JOIN 
            CT_DONHANG CTDH ON DH.MADH = CTDH.MADH
        WHERE 
            TTDH.MATT_DH = @TrangThai -- Chỉ lọc theo trạng thái
        GROUP BY
            DH.MADH, DH.TG_DAT, DH.HOTEN, DH.DIACHI, DH.SDT, DH.LUUY_GIAO, DH.TG_HENGIAO, DH.MANV, TTDH.TENTT_DH, DH.LIDO_HUY;
    END
    ELSE
    BEGIN
        -- Nếu ngày kết thúc là NULL, gán ngày kết thúc là 24 giờ sau ngày bắt đầu
        IF @DenNgay IS NULL
        BEGIN
            SET @DenNgay = DATEADD(HOUR, 24, @TuNgay)
        END
        
        SELECT 
DH.MADH, DH.TG_DAT, DH.HOTEN, DH.DIACHI, DH.SDT, DH.LUUY_GIAO, DH.TG_HENGIAO, SUM(CTDH.GIA) AS TONGTIEN, DH.MANV, 
TTDH.TENTT_DH, DH.LIDO_HUY
        FROM 
            DONHANG DH
        INNER JOIN 
            TRANGTHAIDONHANG TTDH ON DH.MATT_DH = TTDH.MATT_DH
        INNER JOIN 
            CT_DONHANG CTDH ON DH.MADH = CTDH.MADH
        WHERE 
            DH.TG_DAT BETWEEN @TuNgay AND @DenNgay -- Lọc theo khoảng thời gian
            AND TTDH.MATT_DH = @TrangThai -- Lọc theo trạng thái
        GROUP BY
            DH.MADH, DH.TG_DAT, DH.HOTEN, DH.DIACHI, DH.SDT, DH.LUUY_GIAO, DH.TG_HENGIAO, DH.MANV, TTDH.TENTT_DH, DH.LIDO_HUY;
    END
END;

-- Cách chạy:

--EXEC SP_XemDonHangTrongKhoangThoiGian '6'


-------------------------------------
-- === === 2.Tạo tài khoản === === --
-------------------------------------

CREATE PROCEDURE SP_TaoTaiKhoan
	@SDT VARCHAR(11), 
    @pass VARCHAR(50),
	@MAVT INT, -- 0: khách hàng, 1: Nhân Viên
	@MAKH INT,
	@HO NVARCHAR(80), @TEN NVARCHAR(20),
	@GIOITINH BIT, @NGAYSINH DATETIME,
	@DIACHI NVARCHAR(500), @MAIL VARCHAR(200)
AS
BEGIN
    IF EXISTS (SELECT * FROM TAIKHOAN WHERE SDT = @SDT)
    BEGIN
        PRINT N'Tài khoản đã tồn tại.'
    END
    ELSE
    BEGIN
        
        INSERT INTO TAIKHOAN(SDT, MATKHAU, MAVT)
        VALUES (@SDT, @pass, @MAVT)
        PRINT N'Tạo tài khoản thành công.'
		
		IF @MAVT = 0
		BEGIN
			INSERT INTO KHACHHANG(MAKH, HO, TEN, GIOITINH, NGAYSINH, SDT,  DIACHI, MAIL)
            VALUES (@MAKH, @HO, @TEN, @GIOITINH, @NGAYSINH, @SDT, @DIACHI, @MAIL)
            PRINT 'Tạo mới khách hàng thành công.'
		END
		ELSE
		BEGIN
			INSERT INTO NHANVIEN(MANV, HO, TEN, GIOITINH, NGAYSINH, SDT,  DIACHI, MAIL)
            VALUES (@MAKH, @HO, @TEN, @GIOITINH, @NGAYSINH, @SDT, @DIACHI, @MAIL)
            PRINT 'Tạo mới Nhân viên thành công.'
		END
    END
END

-- 2. SP xem sản phẩm thuộc danh mục --
CREATE PROCEDURE SP_SanPhamThuocDanhMuc
	@MADM INT
AS
BEGIN
    SELECT SP.MASP, SP.TENSP, SP.SKU, TH.TENTH, DM.TENDM, TRANGTHAI
    FROM SANPHAM SP
	INNER JOIN DANHMUC DM ON SP.MADM = @MADM AND SP.MADM = DM.MADM
	INNER JOIN THUONGHIEU TH ON SP.MATH = TH.MATH 
END;

-- Cách chạy
--EXEC SP_SanPhamThuocDanhMuc '1'

-- 3. SP xem sản phẩm thuộc thương hiệu --
CREATE PROCEDURE SP_SanPhamThuocThuongHieu
	@MATH INT
AS
BEGIN
    SELECT SP.MASP, SP.TENSP, SP.SKU, TH.TENTH, DM.TENDM, TRANGTHAI
    FROM SANPHAM SP
	INNER JOIN THUONGHIEU TH ON SP.MATH = @MATH AND SP.MATH = TH.MATH 
	INNER JOIN DANHMUC DM ON SP.MADM = DM.MADM
END;

--Cách chạy
--EXEC SP_SanPhamThuocThuongHieu '1'

-- 4. SP xem các mặt hàng của sản phẩm 
CREATE PROCEDURE SP_MatHangCuaSanPham
	@MASP INT
AS
BEGIN
    SELECT MH.MAMH, SP.TENSP, DVT.TENDVT, SOLUONG
    FROM MATHANG MH
	INNER JOIN SANPHAM SP ON MH.MASP = @MASP AND MH.MASP = SP.MASP
	INNER JOIN DONVITINH DVT ON MH.MADVT = DVT.MADVT
END;

--Cách chạy
--EXEC SP_MatHangCuaSanPham '4'

