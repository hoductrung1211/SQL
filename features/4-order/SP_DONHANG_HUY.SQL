ALTER PROC SP_DONHANG_HUY
    @MADH INT,
    @LIDO_HUY NVARCHAR(200) = NULL
AS BEGIN 
    DECLARE @TRANGTHAI INT = NULL;

    SELECT @TRANGTHAI = MATT_DH
    FROM DONHANG
    WHERE MADH = @MADH

    IF @TRANGTHAI IS NULL
    BEGIN
        RAISERROR(N'Đơn hàng không tồn tại!', 16, 1);
        RETURN;
    END;

    IF @TRANGTHAI IN (2, 3, 5)
    BEGIN
        RAISERROR(N'Đơn hàng không thể bị hủy!', 16, 1);
        RETURN;
    END;

    UPDATE DONHANG
    SET MATT_DH = 6
    WHERE MADH = @MADH

    SELECT N'Hủy đơn hàng thành công!' 'Message'
END;