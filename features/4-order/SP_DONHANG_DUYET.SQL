CREATE PROCEDURE [dbo].[SP_DONHANG_DUYET]
    @MADH INT,
    @MANV INT -- Tham số mới: mã nhân viên duyệt đơn
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
        BEGIN TRY
            -- Kiểm tra trạng thái hiện tại của đơn hàng
            DECLARE @TrangThaiHienTai INT;
            SELECT @TrangThaiHienTai = MATT_DH 
            FROM DONHANG 
            WHERE MADH = @MADH;

            -- Kiểm tra nếu trạng thái là 1 (Chờ duyệt)
            IF @TrangThaiHienTai = 1
            BEGIN
                -- Cập nhật trạng thái sang 2 (Đã duyệt) và lưu mã nhân viên duyệt
                UPDATE DONHANG
                SET MATT_DH = 2, MANV = @MANV -- Sử dụng cột MANV có sẵn
                WHERE MADH = @MADH;

                SELECT N'Đơn hàng với MADH là ' + CAST(@MADH AS NVARCHAR) + N' đã được nhân viên với Mã NV '
                + CAST(@MANV AS NVARCHAR) + N' duyệt và chuyển sang trạng thái "Chuẩn bị đơn".';
            END
            ELSE
            BEGIN
                -- Nếu trạng thái không phải là 1, thông báo không thể duyệt
                RAISERROR (N'Đơn hàng với MADH %d không ở trạng thái "Chờ duyệt" và do đó không thể duyệt bởi nhân viên với Mã NV %d.', 16, 1, @MADH, @MANV);
            END

            COMMIT TRANSACTION;
        END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;