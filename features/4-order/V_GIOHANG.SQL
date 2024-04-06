CREATE VIEW V_GIOHANG -- SAI
AS
    SELECT 
        GH.MAKH 'Mã khách hàng',
        CONVERT(varchar(10), GH.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
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
        V_GIABAN_HIENTAI GB
        ON GB.MAMH = MH.MAMH;