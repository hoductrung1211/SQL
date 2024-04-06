CREATE PROC SP_GIOHANG_THEM
    @MAKH INT,
    @MAMH INT,
    @SOLUONG INT
AS BEGIN
    -- 1. Check if the item is currently in active status
    DECLARE @ISACTIVE BIT;

    SELECT @ISACTIVE = SP.TRANGTHAI
    FROM MATHANG MH
    INNER JOIN SANPHAM SP 
        ON MH.MAMH = @MAMH
        AND MH.MASP = SP.MASP

    IF @ISACTIVE <> 1
        RETURN;




    DECLARE @COUNT INT;
    SELECT 
        @COUNT = COUNT(*)
    FROM GIOHANG GH 
    WHERE
        GH.MAKH = @MAKH AND 
        GH.MAMH = @MAMH;

    -- 2. If this item haven't been in Cart, create new one
    IF @COUNT = 0
        BEGIN 
            INSERT INTO GIOHANG (
                MAKH,
                MAMH,
                SOLUONG
            )
            VALUES
                (@MAKH, @MAMH, @SOLUONG)
        END
    -- 3. Else this item have already been in Cart, update by adding quantity
    ELSE BEGIN
        UPDATE GIOHANG 
        SET SOLUONG = SOLUONG + @SOLUONG
        WHERE 
            MAKH = @MAKH AND 
            MAMH = @MAMH
    END 
END;