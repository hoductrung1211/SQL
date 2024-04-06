-- 1. Info of Item
-- 2. Price history of this Item
--      Created date, price id, applied date, price, Employee
-- ORDER BY Now -> past

CREATE PROC SP_GIABAN_MH 
    @MAMH INT
AS BEGIN
    SELECT *
    FROM V_MATHANG
    WHERE [Mã MH] = 1

    SELECT 
        TG_TAO 'T/g tạo',
        MAGB 'Mã giá bán',
        TG_APDUNG 'T/g áp dụng',
        GIABAN 'Giá bán',
        CONVERT(varchar(4), NV.MANV) + ' - ' + NV.HO + ' ' + NV.TEN 'NV cập nhật'
    FROM 
        GIABAN GB 
    INNER JOIN 
        NHANVIEN NV 
        ON GB.MANV = NV.MANV
    WHERE MAMH = 1
    ORDER BY [T/g tạo] DESC;
END;