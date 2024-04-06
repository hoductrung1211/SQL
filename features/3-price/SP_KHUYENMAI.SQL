-- DROP PROC SP_KHUYENMAI;
CREATE PROC SP_KHUYENMAI
    @MAKM INT = NULL
AS
BEGIN
    IF @MAKM IS NULL 
        BEGIN
        SELECT 
            CONVERT(varchar(18), TG_BATDAU) 'Thời gian bắt đầu',
            CONVERT(varchar(10), MAKM) + ' - ' + TENKM 'Khuyến mãi',
            CONVERT(varchar(18), TG_KETTHUC) 'Thời gian kết thúc',
            CONVERT(varchar(18), TG_TAO) 'Thời gian tạo',
            MAQL 'Mã quản lý tạo',
            TRANGTHAI 'Trạng thái'
        FROM KHUYENMAI;
    END
    ELSE BEGIN
        SELECT
            CONVERT(varchar(18), TG_BATDAU) 'Thời gian bắt đầu',
            CONVERT(varchar(10), MAKM) + ' - ' + TENKM 'Khuyến mãi',
            CONVERT(varchar(18), TG_KETTHUC) 'Thời gian kết thúc',
            CONVERT(varchar(18), TG_TAO) 'Thời gian tạo',
            MAQL 'Mã quản lý tạo',
            TRANGTHAI 'Trạng thái'
        FROM KHUYENMAI
        WHERE MAKM = @MAKM;

        SELECT
            CONVERT(varchar(10), MH.MAMH) + ' - ' + SP.TENSP 'Mặt hàng',
            TH.TENTH 'Thương hiệu',
            DM.TENDM 'Danh mục',
            DVT.TENDVT 'Đơn vị tính',
            CTKM.GIAMGIA 'Giảm giá'
        FROM
            CT_KHUYENMAI CTKM
            INNER JOIN
                MATHANG MH
                ON CTKM.MAMH = MH.MAMH
                AND CTKM.MAKM = @MAKM
            INNER JOIN
                SANPHAM SP
                ON MH.MASP = SP.MASP
            INNER JOIN
                DONVITINH DVT
                ON DVT.MADVT = MH.MADVT
            INNER JOIN 
                DANHMUC DM 
                ON DM.MADM = SP.MADM
            INNER JOIN 
                THUONGHIEU TH 
                ON TH.MATH = SP.MATH
    END
END;