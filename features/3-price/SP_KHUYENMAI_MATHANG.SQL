-- TRA CỨU THÔNG TIN CÁC MẶT HÀNG ĐƯỢC ÁP DỤNG KHUYẾN MÃI TẠI 1 THỜI ĐIỂM --
-- DEFAULT: THỜI ĐIỂM HIỆN TẠI
--  1. Lấy các Sự kiện khuyến mãi hiệu lực tại 1 thời điểm (INPUT)
--  2. Lấy thông tin Mặt hàng được áp dụng khuyến mãi của Sự kiện
--  3. Tính toán giá trước và sau khi khuyến mãi của Mặt hàng

ALTER PROC SP_KHUYENMAI_MATHANG
    @TG DATE = NULL
AS BEGIN
    IF @TG IS NULL
        SET @TG = GETDATE();

    -- 1. Get valid Discount Event
    SELECT
        CONVERT(varchar(10), GIA_BAN.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
        CONVERT(varchar(10), KM.MAKM) + ' - ' + TENKM 'Khuyến mãi',
        CONVERT(varchar(10), GIA_BAN.GIABAN - GIA_BAN.GIABAN * CTKM.GIAMGIA/100) + ' = ' + CONVERT(varchar(10), GIA_BAN.GIABAN) + ' - (' + CONVERT(varchar(10), CTKM.GIAMGIA) + '%)' 'Giá bán'
    FROM KHUYENMAI KM
    INNER JOIN 
        CT_KHUYENMAI CTKM
        ON TG_BATDAU <= @TG 
            AND @TG <= TG_KETTHUC 
            AND CTKM.MAKM = KM.MAKM
    
    -- 2, 3. Get info of Items & Prices applied to them
    INNER JOIN (
        SELECT
            GB.*
        FROM GIABAN GB
        INNER JOIN (
            SELECT
                MAMH,
                MAX(TG_APDUNG) AS TG_APDUNG_GANNHAT
            FROM GIABAN
            WHERE 
                TG_APDUNG < @TG
                GROUP BY MAMH
        ) AS GB_GANNHAT
            ON GB.MAMH = GB_GANNHAT.MAMH
            AND GB.TG_APDUNG = GB_GANNHAT.TG_APDUNG_GANNHAT) AS GIA_BAN
        ON CTKM.MAMH = GIA_BAN.MAMH
    INNER JOIN 
        MATHANG MH
        ON GIA_BAN.MAMH = MH.MAMH
    INNER JOIN 
        SANPHAM SP 
        ON MH.MASP = SP.MASP
    INNER JOIN 
        DONVITINH DVT 
        ON MH.MADVT = DVT.MADVT
END;