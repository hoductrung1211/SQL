-- 1. Get list
-- 2. Get detail
--      Product info
--      Item, QuantityUnit, Quantity
--      Total quantity of this Product
--      Note if this Product can be turned off

CREATE PROC SP_SANPHAM
    @MASP INT = NULL -- MÃ SẢN PHẨM
    AS BEGIN
        IF @MASP IS NOT NULL 
        BEGIN
            -- Get Product info 
            SELECT 
                CONVERT(varchar(10), SP.MASP) + ' - ' + SP.TENSP 'Sản phẩm',
                TH.TENTH 'Thương hiệu',
                DM.TENDM 'Danh mục',
                SP.TRANGTHAI 'Trạng thái' 
            FROM 
                SANPHAM SP
            INNER JOIN THUONGHIEU TH 
                ON SP.MATH = TH.MATH
            INNER JOIN DANHMUC DM 
                ON SP.MADM = DM.MADM
            WHERE SP.MASP = @MASP

            -- Get Item info
            SELECT 
                MH.MAMH 'Mã mặt hàng',
                DVT.TENDVT 'Đơn vị tính',
                MH.SOLUONG 'Số lượng'
            FROM MATHANG MH
            INNER JOIN 
                DONVITINH DVT 
                ON @MASP = MH.MASP
                    AND MH.MADVT = DVT.MADVT
            
            -- Get more info
            DECLARE @TONG_SL INT;
            SELECT @TONG_SL = SUM(SOLUONG)
            FROM MATHANG MH  
            WHERE MH.MASP = @MASP;
            
            SELECT @TONG_SL AS 'Tổng số lượng mặt hàng của sản phẩm';

            IF (@TONG_SL > 0) 
                SELECT N'Không thể tắt trạng thái hoạt động của Sản phẩm này.' AS 'Ghi chú';
            ELSE SELECT N'Có thể tắt trạng thái hoạt động của Sản phẩm này.'  AS 'Ghi chú';

            RETURN;
        END;

        SELECT 
            SP.MASP 'Mã sản phẩm',
            SP.TENSP 'Tên sản phẩm',
            SP.TRANGTHAI 'Trạng thái'
        FROM 
            SANPHAM SP  
    END;
 