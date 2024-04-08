--==--== WORKFLOW ==--==--
-- 1. Kiểm tra Sản phẩm tồn tại
-- 2. Nếu TẮT trạng thái sản phẩm thì kiểm tra tổng số lượng mặt hàng của Sản phẩm
--      a. Nếu Sản phẩm còn số lượng thì dừng tiến trình.
--      b. Nếu Sản phẩm không còn số lượng thì xóa hết thông tin Mặt hàng trong Giỏ hàng.
-- 3. Cập nhật trạng thái (TẮT hoặc BẬT) Sản phẩm.

CREATE PROC SP_SANPHAM_KTRA_TONTAI 
    @MASP INT,
    @DEM BIT OUTPUT
    AS BEGIN 
        SELECT @DEM = COUNT(*)
        FROM SANPHAM
        WHERE MASP = @MASP
    END;
GO;

CREATE PROC SP_SANPHAM_TRANGTHAI_CAPNHAT
    @MASP INT,
    @TRANGTHAI BIT
    AS BEGIN 
        DECLARE @DEM INT;
        EXEC SP_SANPHAM_KTRA_TONTAI @MASP, @DEM OUTPUT;

        IF @DEM <> 0 -- TON TAI
        BEGIN
            IF @TRANGTHAI = 0 -- OFF
                BEGIN
                    DECLARE @TONG_SOLUONG INT;
                    
                    SELECT @TONG_SOLUONG = SUM(SOLUONG)
                    FROM MATHANG
                    WHERE MASP = @MASP

                    IF @TONG_SOLUONG > 0 -- TON
                        RETURN;

                    -- XOA SAN PHAM TRONG GIO
                    DELETE 
                    FROM GIOHANG
                    WHERE MAMH IN (
                        SELECT MAMH 
                        FROM SANPHAM SP
                        INNER JOIN MATHANG MH
                            ON SP.MASP = @MASP
                            AND SP.MASP = MH.MAMH
                    );
                END
            
            UPDATE SANPHAM
            SET TRANGTHAI = @TRANGTHAI
            WHERE MASP = @MASP;
        END;
    END;
GO;