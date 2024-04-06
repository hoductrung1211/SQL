ALTER PROC SP_THANHLY
    @MATL INT
AS
BEGIN
    -- 1. GET APPROVED STATUS
    DECLARE @MAQL INT = NULL

    SELECT 
        @MAQL = MAQL
    FROM
        THANHLY
    WHERE MATL = @MATL

    -- 2. LIQUIDATION
    DECLARE @TRANGTHAI NVARCHAR(100) 
    IF @MAQL IS NULL
        SET @TRANGTHAI = N'Chưa được duyệt'
    ELSE SET @TRANGTHAI = N'Đã được duyệt'

    SELECT
        MATL 'Mã thanh lý',
        TG_TAO 'Thời gian tạo',
        MANV 'Mã nhân viên',
        MAQL 'Mã quản lý duyệt',
        @TRANGTHAI 'Trạng thái'
    FROM
        THANHLY
    WHERE MATL = @MATL
    
    -- 3. LIQUIDATION DETAILS
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