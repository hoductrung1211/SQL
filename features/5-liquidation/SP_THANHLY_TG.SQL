ALTER PROC SP_THANHLY_TG 
    @TG_BATDAU DATETIME = NULL,
    @TG_KETTHUC DATETIME = NULL
AS BEGIN
    -- 1. CHECK @TG_BATDAU, @TG_KETTHUC
    IF @TG_KETTHUC IS NULL
    BEGIN
        SET @TG_KETTHUC = GETDATE();

        IF @TG_BATDAU IS NULL
            SET @TG_BATDAU = GETDATE();
    END
    ELSE IF @TG_BATDAU IS NULL
    BEGIN
        DECLARE @MONTH INT = MONTH(GETDATE());
        DECLARE @YEAR INT = YEAR(GETDATE());

        SET @TG_BATDAU = CONVERT(VARCHAR(4), @YEAR) + '-' + CONVERT(VARCHAR(2), @MONTH) + '-01';
    END;

    -- 2. 
    SELECT
        MATL 'Mã thanh lý',
        TG_TAO 'Thời gian tạo',
        MANV 'Mã nhân viên',
        MAQL 'Mã quản lý duyệt'
    FROM
        THANHLY
    WHERE TG_TAO >= @TG_BATDAU
    AND TG_TAO <= @TG_KETTHUC
END;