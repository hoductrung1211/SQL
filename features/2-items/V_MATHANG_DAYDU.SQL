CREATE VIEW V_MATHANG_DAYDU
AS
SELECT 
    CONVERT(varchar(10), MH.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
    SP.SKU 'SKU',
    TH.TENTH 'Thương hiệu',
    DM.TENDM 'Danh mục',
    SP.[MOTA] 'Mô tả',
    SP.XUATXU 'Nguồn gốc',
    SP.THANHPHAN 'Thành phần',
    SP.HD_SUDUNG 'Hướng dẫn sử dụng',
    SP.HD_BAOQUAN 'Hướng dẫn bảo quản',
    SP.TRANGTHAI 'Trạng thái',
    MH.SOLUONG 'Số lượng'
FROM
    SANPHAM SP
    INNER JOIN 
        MATHANG MH
        ON SP.MASP = MH.MASP
    INNER JOIN 
        DONVITINH DVT
        ON MH.MADVT = DVT.MADVT
    
    INNER JOIN
        THUONGHIEU TH
        ON SP.MATH = TH.MATH
    INNER JOIN
        DANHMUC DM
        ON SP.MADM = DM.MADM;
