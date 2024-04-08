-- THÔNG TIN GIÁ BÁN CỦA TẤT CẢ MẶT HÀNG TẠI 1 THỜI ĐIỂM
-- DEFAULT: THỜI ĐIỂM HIỆN TẠI
-- 1. Từ Table Giá bán, lấy các Row có 'Thời gian áp dụng' bé hơn thời điểm INPUT
--      GROUP lại theo Mã mặt hàng và lấy MAX(Thời gian áp dụng) (có nghĩa là thời gian áp dụng gần nhất)
-- 2. Lấy thông tin từ các bảng khác tạo nên Thông tin đầy đủ của Mặt hàng

CREATE PROC SP_GIABAN_MATHANG_TG 
    @TG DATE = NULL
AS BEGIN
    IF @TG IS NULL
        SET @TG = GETDATE()

    SELECT
        CONVERT(nvarchar(5), MH.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
        GB.GIABAN 'Giá bán',
        GB.MAGB 'Mã giá bán',
        GB.TG_TAO 'T/g tạo',
        GB.TG_APDUNG 'T/g áp dụng',
        GB.MANV 'Mã Nhân viên sửa đổi'
    FROM GIABAN GB
        INNER JOIN ( -- Get the latest Price by Item
            SELECT
                MAMH,
                MAX(TG_APDUNG) AS TG_APDUNG_GANNHAT
            FROM GIABAN
            WHERE TG_APDUNG < @TG
                GROUP BY MAMH
        ) AS GB_GANNHAT
            ON GB.MAMH = GB_GANNHAT.MAMH
                AND GB.TG_APDUNG = GB_GANNHAT.TG_APDUNG_GANNHAT
        INNER JOIN MATHANG MH 
            ON GB.MAMH = MH.MAMH
        INNER JOIN SANPHAM SP 
            ON MH.MASP = SP.MASP
        INNER JOIN DONVITINH DVT
            ON MH.MADVT = DVT.MADVT
END;



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