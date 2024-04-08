-- THÔNG TIN GIÁ BÁN CỦA 1 MẶT HÀNG --
-- 1. Thông tin chi tiết 1 Mặt hàng + Giá bán hiện tại
-- 2. Lịch sử cập nhật giá bán của Mặt hàng (được sắp xếp từ Hiện tại -> Quá khứ)

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