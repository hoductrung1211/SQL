USE Winmart_Shop;
GO;
---------------------------------------
-- === === 1. AUTHENTICATION === === --
---------------------------------------




-----------------------------
-- === === 2. ITEM === === --
-----------------------------
-- DROP PROC SP_SANPHAM_TRANGTHAI
CREATE PROC SP_KTRA_SANPHAM_TONTAI 
    @MASP INT,
    @DEM BIT OUTPUT
AS BEGIN 
    SELECT @DEM = COUNT(*)
    FROM SANPHAM
    WHERE MASP = @MASP
END;
GO;

CREATE PROC SP_SANPHAM_TRANGTHAI
    @MASP INT,
    @TRANGTHAI BIT
AS BEGIN 
    DECLARE @DEM INT;
    EXEC SP_KTRA_SANPHAM_TONTAI @MASP, @DEM OUTPUT;

    IF @DEM <> 0 -- TON TAI
        BEGIN
            IF @TRANGTHAI = 0 -- TAT
                BEGIN
                    DECLARE @TONG_SOLUONG INT;
                    
                    SELECT @TONG_SOLUONG = SUM(SOLUONG)
                    FROM MATHANG
                    WHERE MASP = @MASP

                    IF @TONG_SOLUONG > 0 -- TON
                        RETURN;

                    -- XOA SAN PHAM TRONG GIO
                    DELETE 
                    FROM GIOHANG
                    WHERE MAMH IN (
                        SELECT MAMH 
                        FROM SANPHAM SP
                        INNER JOIN MATHANG MH
                            ON SP.MASP = @MASP
                            AND SP.MASP = MH.MAMH
                    )   
                END
            
            UPDATE SANPHAM
            SET TRANGTHAI = @TRANGTHAI
            WHERE MASP = @MASP;
        END
END;
GO;

CREATE VIEW V_MATHANG
AS
SELECT 
    MH.MAMH 'Mã mặt hàng', 
    SP.TENSP 'Tên sản phẩm',
    DVT.TENDVT 'Đơn vị',
    SP.SKU 'SKU',
    TH.TENTH 'Thương hiệu',
    DM.TENDM 'Danh mục',
    SP.[MOTA] 'Mô tả',
    SP.XUATXU 'Nguồn gốc',
    SP.THANHPHAN 'Thành phần',
    SP.HD_SUDUNG 'Hướng dẫn sử dụng',
    SP.HD_BAOQUAN 'Hướng dẫn bảo quản',
    SP.TRANGTHAI 'Trạng thái',
    MH.SOLUONG 'Số lượng',
    GB.GIABAN 'Giá'
    FROM
        SANPHAM SP
    INNER JOIN 
        MATHANG MH
        ON SP.MASP = MH.MASP
    INNER JOIN 
        DONVITINH DVT
        ON MH.MADVT = DVT.MADVT
    INNER JOIN 
        GIABAN GB
        ON MH.MAMH = GB.MAMH
    INNER JOIN
        THUONGHIEU TH
        ON SP.MATH = TH.MATH
    INNER JOIN
        DANHMUC DM
        ON SP.MADM = DM.MADM;
GO;

CREATE VIEW V_MATHANG_TOMTAT
AS
SELECT 
    MH.MAMH,
    SP.TENSP 'Tên sản phẩm',
    DVT.TENDVT 'Đơn vị',
    SOLUONG 'Số lượng',
    GB.GIABAN 'Giá'
    -- Discount percent
    -- Price after discount
    FROM
        SANPHAM SP
    INNER JOIN 
        MATHANG MH
        ON SP.MASP = MH.MASP
    INNER JOIN 
        DONVITINH DVT
        ON MH.MADVT = DVT.MADVT
    INNER JOIN 
        GIABAN GB
        ON MH.MAMH = GB.MAMH;
GO;

------------------------------
-- === === 3. PRICE === === --
------------------------------
CREATE VIEW V_KHUYENMAI
AS
    SELECT
        MAKM 'Mã khuyến mãi',
        TENKM 'Tên khuyến mãi',
        TG_BATDAU 'Thời gian bắt đầu',
        TG_KETTHUC 'Thời gian kết thúc',
        MAQL 'Mã quản lý tạo',
        TG_TAO 'Thời gian tạo',
        TRANGTHAI 'Trạng thái'
    FROM KHUYENMAI;
GO;

CREATE PROC SP_KHUYENMAI
    @MAKM INT = NULL
AS
BEGIN
    IF @MAKM IS NULL 
        BEGIN
        SELECT
            MAKM 'Mã khuyến mãi',
            TENKM 'Tên khuyến mãi',
            TG_BATDAU 'Thời gian bắt đầu',
            TG_KETTHUC 'Thời gian kết thúc',
            MAQL 'Mã quản lý tạo',
            TG_TAO 'Thời gian tạo',
            TRANGTHAI 'Trạng thái'
        FROM KHUYENMAI;
    END
    ELSE BEGIN
        SELECT
            MAKM 'Mã khuyến mãi',
            TENKM 'Tên khuyến mãi',
            TG_BATDAU 'Thời gian bắt đầu',
            TG_KETTHUC 'Thời gian kết thúc',
            MAQL 'Mã quản lý tạo',
            TG_TAO 'Thời gian tạo',
            TRANGTHAI 'Trạng thái'
        FROM KHUYENMAI
        WHERE MAKM = @MAKM;

        SELECT
            MH.MAMH 'Mã mặt hàng',
            MH.MASP 'Mã sản phẩm',
            SP.TENSP 'Tên sản phẩm',
            TH.TENTH 'Tên thương hiệu',
            DM.TENDM 'Tên danh mục',
            DVT.TENDVT 'Đơn vị tính',
            CTKM.GIAMGIA 'Giảm giá'
        FROM
            CT_KHUYENMAI CTKM
            INNER JOIN
                MATHANG MH
                ON CTKM.MAMH = MH.MAMH
                AND CTKM.MAKM = @MAKM
            INNER JOIN
                SANPHAM SP
                ON MH.MASP = SP.MASP
            INNER JOIN
                DONVITINH DVT
                ON DVT.MADVT = MH.MADVT
            INNER JOIN 
                DANHMUC DM 
                ON DM.MADM = SP.MADM
            INNER JOIN 
                THUONGHIEU TH 
                ON TH.MATH = SP.MATH
    END
END;
GO;

------------------------------
-- === === 4. ORDER === === --
------------------------------
CREATE VIEW V_GIOHANG
AS 
    SELECT 
        GH.MAKH,
        GH.MAMH,
        SP.TENSP 'Tên sản phẩm',
        DVT.TENDVT 'Đơn vị',
        GH.SOLUONG 'Số lượng',
        GB.GIABAN 'Giá'
    FROM 
        GIOHANG GH
    INNER JOIN
        MATHANG MH
        ON GH.MAMH = MH.MAMH
    INNER JOIN
        SANPHAM SP 
        ON MH.MASP = SP.MASP
    INNER JOIN
        DONVITINH DVT
        ON MH.MADVT = DVT.MADVT
    INNER JOIN 
        GIABAN GB
        ON GB.MAMH = MH.MAMH;
GO;

CREATE PROC SP_GIOHANG_XEM
    @MAKH INT = NULL
AS BEGIN 
    IF @MAKH IS NULL 
        BEGIN
        SELECT *
        FROM V_GIOHANG
        END 

    ELSE 
        BEGIN 
        SELECT 
            GH.MAKH,
            GH.MAMH,
            SP.TENSP 'Tên sản phẩm',
            DVT.TENDVT 'Đơn vị',
            GH.SOLUONG 'Số lượng',
            GB.GIABAN 'Giá'
        FROM 
            GIOHANG GH 
        INNER JOIN
            MATHANG MH
            ON GH.MAKH = @MAKH AND
                GH.MAMH = MH.MAMH
        INNER JOIN
            SANPHAM SP 
            ON MH.MASP = SP.MASP
        INNER JOIN
            DONVITINH DVT
            ON MH.MADVT = DVT.MADVT
        INNER JOIN 
            GIABAN GB
        ON GB.MAMH = MH.MAMH
        END
END;
GO;

-- CREATE
CREATE PROC SP_GIOHANG_THEM
    @MAKH INT,
    @MAMH INT,
    @SOLUONG INT
AS BEGIN
    -- 1. Check if the item is currently in active status
    DECLARE @ISACTIVE BIT;

    SELECT @ISACTIVE = SP.TRANGTHAI
    FROM MATHANG MH
    INNER JOIN SANPHAM SP 
        ON MH.MAMH = @MAMH
        AND MH.MASP = SP.MASP

    IF @ISACTIVE <> 1
        RETURN;




    DECLARE @COUNT INT;
    SELECT 
        @COUNT = COUNT(*)
    FROM GIOHANG GH 
    WHERE
        GH.MAKH = @MAKH AND 
        GH.MAMH = @MAMH;

    -- 2. If this item haven't been in Cart, create new one
    IF @COUNT = 0
        BEGIN 
            INSERT INTO GIOHANG (
                MAKH,
                MAMH,
                SOLUONG
            )
            VALUES
                (@MAKH, @MAMH, @SOLUONG)
        END
    -- 3. Else this item have already been in Cart, update by adding quantity
    ELSE BEGIN
        UPDATE GIOHANG 
        SET SOLUONG = SOLUONG + @SOLUONG
        WHERE 
            MAKH = @MAKH AND 
            MAMH = @MAMH
    END 
END;
GO;

-- DELETE
CREATE PROC SP_GIOHANG_XOA 
    @MAKH INT,
    @MAMH INT
AS BEGIN 
    DELETE GIOHANG
    WHERE 
        MAKH = @MAKH AND 
        MAMH = @MAMH
END;
GO;

-- UPDATE
CREATE PROC SP_GIOHANG_GIAM
    @MAKH INT,
    @MAMH INT,
    @SOLUONG_GIAM INT
AS
BEGIN
    -- Get the current quantity of item in Cart
    DECLARE @SOLUONG_HIENTAI INT = NULL;

    SELECT @SOLUONG_HIENTAI = GH.SOLUONG
    FROM GIOHANG GH
    WHERE 
        GH.MAKH = @MAKH AND
        GH.MAMH = @MAMH

    IF @SOLUONG_HIENTAI IS NOT NULL 
        BEGIN
        IF @SOLUONG_HIENTAI - @SOLUONG_GIAM <= 0
            BEGIN
            DELETE GIOHANG
            WHERE 
                MAMH = @MAMH AND
                MAKH = @MAKH;

            PRINT ('Remove item out of Cart');
            END;
        ELSE 
            BEGIN
            UPDATE GIOHANG
            SET 
                SOLUONG = SOLUONG - @SOLUONG_GIAM
            WHERE 
                MAMH = @MAMH AND 
                MAKH = @MAKH;
            END;
        END;
END;
GO;


CREATE PROC SP_DONHANG
AS BEGIN
    SELECT 
        DH.TG_HENGIAO N'Thời gian hẹn giao',
        DH.TG_DAT N'Thời gian đặt',
        CONVERT(varchar(10), DH.MAKH) + ' - ' +  DH.HOTEN N'khách hàng',
        DH.SDT N'Số điện thoại',
        DH.DIACHI N'Địa chỉ',
        DH.LUUY_GIAO N'Lưu ý giao hàng',
        DH.LIDO_HUY N'Lý do hủy hàng',
        CONVERT(varchar(10), DH.MANV) + ' - ' + NV.HO + ' ' + NV.TEN N'Nhân viên',
        TTDH.TENTT_DH N'Trạng thái đơn hàng'
    FROM DONHANG DH
        INNER JOIN NHANVIEN NV 
            ON DH.MANV = NV.MANV
        INNER JOIN TRANGTHAIDONHANG TTDH
            ON DH.MATT_DH = TTDH.MATT_DH
    ORDER BY TG_HENGIAO DESC;
END;
GO;

CREATE PROC SP_CT_DONHANG
AS BEGIN 
    SELECT 
        MADH N'Mã đơn hàng',
        MAMH N'Mã mặt hàng',
        SOLUONG N'Số lượng',
        GIA N'Giá',
        MAKM N'Mã khuyến mãi',
        'Giá sau khuyến mãi'
    FROM CT_DONHANG;
END;
GO;
------------------------------------
-- === === 5. LIQUIDATION === === --
------------------------------------
CREATE PROC SP_THANHLY
    @MATL INT
AS
BEGIN
    IF @MATL IS NULL 
        BEGIN
        SELECT
            *
        FROM V_THANHLY
    END 
    ELSE BEGIN
        SELECT
            MATL 'Mã thanh lý',
            TG_TAO 'Thời gian tạo',
            MANV 'Mã nhân viên',
            MAQL 'Mã quản lý'
        FROM
            THANHLY
        WHERE MATL = @MATL

        -- --- --- --- --
        SELECT
            CTTL.MAMH 'Mã mặt hàng',
            SP.TENSP 'Tên sản phẩm',
            DVT.TENDVT 'Tên đơn vị tính',
            LDTL.TENLD_TL 'Lý do thanh lý',
            CTTL.SOLUONG 'Số lượng thanh lý'
        FROM
            CT_THANHLY CTTL
            INNER JOIN
                MATHANG MH
                ON CTTL.MAMH = MH.MAMH
                    AND CTTL.MATL = @MATL
            INNER JOIN
                SANPHAM SP
                ON MH.MASP = SP.MASP
            INNER JOIN
                DONVITINH DVT
                ON MH.MADVT = DVT.MADVT
            INNER JOIN 
                LIDO_THANHLY LDTL 
                ON LDTL.MALD_TL = CTTL.MALD_TL
    END
END;
GO;

CREATE VIEW V_THANHLY
AS 
SELECT
    MATL 'Mã thanh lý',
    TG_TAO 'Thời gian tạo',
    MANV 'Mã nhân viên',
    MAQL 'Mã quản lý'
    FROM THANHLY;
GO;

-- DROP VIEW V_CT_THANHLY
CREATE VIEW V_CT_THANHLY
AS
SELECT 
    TL.TG_TAO 'Thời gian tạo',
    TL.MATL 'Mã thanh lý',
    CTTL.MAMH 'Mã mặt hàng',
    SP.TENSP 'Tên sản phẩm',
    DVT.TENDVT 'Tên đơn vị tính',
    LDTL.TENLD_TL 'Lý do thanh lý',
    CTTL.SOLUONG 'Số lượng thanh lý'
    FROM THANHLY TL
        INNER JOIN CT_THANHLY CTTL
            ON TL.MATL = CTTL.MATL 
        INNER JOIN MATHANG MH 
            ON CTTL.MAMH = MH.MAMH
        INNER JOIN SANPHAM SP 
            ON SP.MASP = MH.MASP
        INNER JOIN DONVITINH DVT 
            ON DVT.MADVT = MH.MADVT
        INNER JOIN LIDO_THANHLY LDTL
            ON CTTL.MALD_TL = LDTL.MALD_TL;
GO;