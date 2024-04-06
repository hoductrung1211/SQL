-- item discount price (after discount)

CREATE PROC SP_KHUYENMAI_MATHANG
    @TG DATE = NULL
AS BEGIN
    IF @TG IS NULL
        SET @TG = GETDATE();

    SELECT
        CONVERT(varchar(10), GIA_BAN.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
        CONVERT(varchar(10), KM.MAKM) + ' - ' + TENKM 'Khuyến mãi',
        CONVERT(varchar(10), GIA_BAN.GIABAN - GIA_BAN.GIABAN * CTKM.GIAMGIA/100) + ' = ' + CONVERT(varchar(10), GIA_BAN.GIABAN) + ' - (' + CONVERT(varchar(10), CTKM.GIAMGIA) + '%)' 'Giá bán'
    FROM KHUYENMAI KM
    INNER JOIN CT_KHUYENMAI CTKM
        ON TG_BATDAU <= @TG 
        AND @TG <= TG_KETTHUC 
        AND CTKM.MAKM = KM.MAKM
    
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
                TG_APDUNG < GETDATE()
                GROUP BY MAMH
        ) AS GB_GANNHAT
            ON GB.MAMH = GB_GANNHAT.MAMH
            AND GB.TG_APDUNG = GB_GANNHAT.TG_APDUNG_GANNHAT) AS GIA_BAN
        ON CTKM.MAMH = GIA_BAN.MAMH
    INNER JOIN MATHANG MH
        ON GIA_BAN.MAMH = MH.MAMH
    INNER JOIN SANPHAM SP 
        ON MH.MASP = SP.MASP
    INNER JOIN DONVITINH DVT 
        ON MH.MADVT = DVT.MADVT
END;