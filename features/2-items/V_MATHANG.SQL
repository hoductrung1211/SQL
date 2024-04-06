CREATE VIEW V_MATHANG
AS
    SELECT 
        MH.MAMH 'Mã MH',
        SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
        TH.TENTH 'Thương hiệu',
        DM.TENDM 'Danh mục',
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
        V_GIABAN_HIENTAI GB
        ON MH.MAMH = GB.MAMH
    INNER JOIN
        THUONGHIEU TH
        ON SP.MATH = TH.MATH
    INNER JOIN
        DANHMUC DM
        ON SP.MADM = DM.MADM