CREATE PROC SP_MUAHANG
    @MAKH INT,
    @TG_HENGIAO DATETIME,
    @HOTEN NVARCHAR(200) = NULL,
    @SDT VARCHAR(10) = NULL,
    @DIACHI NVARCHAR(500) = NULL,
    @LUUY_GIAO NVARCHAR(500) = NULL
AS BEGIN 
    CREATE TABLE #KHACHHANG (
        HOTEN NVARCHAR(200),
        SDT VARCHAR(10),
        DIACHI NVARCHAR(500)
    );
    INSERT INTO #KHACHHANG
        (HOTEN, SDT, DIACHI)
    SELECT 
        HO + ' ' + TEN HOTEN,
        SDT,
        DIACHI
    FROM KHACHHANG
    WHERE MAKH = @MAKH;

    -- 1. CHECK KHACH HANG TON TAI
        DECLARE @COUNT INT = 0;
        SELECT @COUNT = COUNT(*)
        FROM #KHACHHANG

        IF @COUNT < 1
            BEGIN 
                SELECT N'Khách hàng không tồn tại' 'Thông báo'
                RETURN;
            END;

    -- 2. CHECK GIO HANG TON TAI
        SELECT @COUNT = COUNT(*)
        FROM GIOHANG
        WHERE MAKH = @MAKH

        IF @COUNT < 1
            BEGIN 
                SELECT N'Giỏ hàng trống' 'Thông báo'
                RETURN;
            END;

    -- 3. ENRICH INFO
    IF @HOTEN IS NULL 
        SELECT @HOTEN = HOTEN 
        FROM #KHACHHANG
    IF @SDT IS NULL 
        SELECT @SDT = SDT 
        FROM #KHACHHANG
    IF @DIACHI IS NULL
        SELECT @DIACHI = DIACHI 
        FROM #KHACHHANG

    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @MATT_DH INT;
        IF @MAKH = 1
            SET @MATT_DH = 5; -- DONE
        ELSE SET @MATT_DH = 1; -- INIT

        -- 4. CREATE ORDER
        INSERT INTO DONHANG 
            (MAKH, HOTEN, SDT, DIACHI, LUUY_GIAO, TG_HENGIAO, TG_DAT, MATT_DH)
        VALUES 
            (@MAKH, @HOTEN, @SDT, @DIACHI, @LUUY_GIAO, @TG_HENGIAO, GETDATE(), @MATT_DH);
        
        DECLARE @MADH INT;
        SET @MADH = SCOPE_IDENTITY();

        -- 5. CREATE ORDER ITEMS
        INSERT INTO CT_DONHANG
            (MADH, MAMH, SOLUONG, GIA, MAKM)
        SELECT @MADH, GH.MAMH, SOLUONG, GB.GIABAN, NULL 
        FROM GIOHANG GH
        INNER JOIN V_GIABAN_HIENTAI GB 
            ON MAKH = @MAKH
            AND GH.MAMH = GB.MAMH;

        -- 6. DELETE CART
        DELETE GIOHANG 
        WHERE MAKH = @MAKH

        COMMIT;
    END TRY
    BEGIN CATCH 
        ROLLBACK;
    END CATCH
END