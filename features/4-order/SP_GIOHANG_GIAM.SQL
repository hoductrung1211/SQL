CREATE PROC SP_GIOHANG_GIAM
    @MAKH INT,
    @MAMH INT,
    @SOLUONG_GIAM INT
AS
BEGIN
    -- Get the current quantity of item in Cart
    DECLARE @SOLUONG_HIENTAI INT = NULL;

    SELECT @SOLUONG_HIENTAI = GH.SOLUONG
    FROM GIOHANG GH
    WHERE 
        GH.MAKH = @MAKH AND
        GH.MAMH = @MAMH

    IF @SOLUONG_HIENTAI IS NOT NULL 
        BEGIN
        IF @SOLUONG_HIENTAI - @SOLUONG_GIAM <= 0
            BEGIN
            DELETE GIOHANG
            WHERE 
                MAMH = @MAMH AND
                MAKH = @MAKH;

            PRINT ('Remove item out of Cart');
            END;
        ELSE 
            BEGIN
            UPDATE GIOHANG
            SET 
                SOLUONG = SOLUONG - @SOLUONG_GIAM
            WHERE 
                MAMH = @MAMH AND 
                MAKH = @MAKH;
            END;
        END;
END;