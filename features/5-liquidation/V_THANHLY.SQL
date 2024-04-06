CREATE VIEW V_THANHLY
AS 
SELECT
    MATL 'Mã thanh lý',
    TG_TAO 'Thời gian tạo',
    MANV 'Mã nhân viên',
    MAQL 'Mã quản lý'
FROM THANHLY 

SELECT *
FROM V_CT_THANHLY
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
        ON CTTL.MALD_TL = LDTL.MALD_TL