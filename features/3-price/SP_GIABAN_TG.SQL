CREATE PROC SP_GIABAN_TG
    @TG DATE = NULL
AS BEGIN
    IF @TG IS NULL
        SET @TG = GETDATE()

    -- SELECT 
    --     GH.MAMH 'Mã mặt hàng',
    --     SP.TENSP 'Tên sản phẩm',
    --     DVT.TENDVT 'Đơn vị',
    --     CONVERT(varchar(10), GH.SOLUONG) + ' x ' + CONVERT(varchar(10), GB.GIABAN) 'Số lượng',
    --     GH.SOLUONG * GB.GIABAN 'Giá'
    -- FROM 
    --     GIOHANG GH 
    --     INNER JOIN
    --         MATHANG MH
    --         ON GH.MAMH = MH.MAMH
    --     INNER JOIN
    --         SANPHAM SP 
    --         ON MH.MASP = SP.MASP
    --     INNER JOIN
    --         DONVITINH DVT
    --         ON MH.MADVT = DVT.MADVT
    --     INNER JOIN 
    --         (SELECT
    --             GB.*
    --         FROM GIABAN GB
    --             INNER JOIN (
    --             SELECT
    --                 MAMH,
    --                 MAX(TG_APDUNG) AS TG_APDUNG_GANNHAT
    --             FROM GIABAN
    --             WHERE TG_APDUNG < @TG
    --                 GROUP BY MAMH
    --             ) AS GB_GANNHAT
    --             ON GB.MAMH = GB_GANNHAT.MAMH
    --                 AND GB.TG_APDUNG = GB_GANNHAT.TG_APDUNG_GANNHAT) GB
    --         ON GB.MAMH = MH.MAMH;
    SELECT
        GB.MAGB,
        GB.MAMH,
        GB.TG_TAO,
        GB.TG_APDUNG,
        GB.GIABAN,
        GB.MANV
    FROM GIABAN GB
        INNER JOIN (
        SELECT
            MAMH,
            MAX(TG_APDUNG) AS TG_APDUNG_GANNHAT
        FROM GIABAN
        WHERE TG_APDUNG < @TG
            GROUP BY MAMH
        ) AS GB_GANNHAT
        ON GB.MAMH = GB_GANNHAT.MAMH
            AND GB.TG_APDUNG = GB_GANNHAT.TG_APDUNG_GANNHAT
END;

