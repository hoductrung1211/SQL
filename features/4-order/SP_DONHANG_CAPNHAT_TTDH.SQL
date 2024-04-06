ALTER PROCEDURE [dbo].[SP_DONHANG_CAPNHAT_TTDH]
    @MADH INT,
    @MATT_DH INT
AS
BEGIN
    SET NOCOUNT ON; -- Để ngăn chặn hiển thị các thông báo không cần thiết

    BEGIN TRY
        -- Kiểm tra mã trạng thái đơn hàng hiện tại
        DECLARE @MATT_DH_HIENTAI INT;
        DECLARE @TEN_TRANGTHAI NVARCHAR(255);

        SELECT @MATT_DH_HIENTAI = MATT_DH 
        FROM DONHANG 
        WHERE MADH = @MADH;

        IF @MATT_DH_HIENTAI IS NULL
            BEGIN
                -- Đơn hàng không tồn tại
                SELECT N'Đơn hàng không tồn tại hoặc đã bị xóa.';
            END
        ELSE IF @MATT_DH_MOI = @MATT_DH_HIENTAI
            BEGIN
                -- Lấy tên trạng thái hiện tại
                SELECT @TEN_TRANGTHAI = TENTT_DH 
                FROM TRANGTHAIDONHANG 
                WHERE MATT_DH = @MATT_DH_HIENTAI;
                
                -- Đơn hàng đã ở trạng thái cập nhật, không cần cập nhật lại
                SELECT N'Đơn hàng đã ở trạng thái ' + @TEN_TRANGTHAI + N', không cần cập nhật.';
            END
        ELSE IF @MATT_DH_HIENTAI = 5
            BEGIN
                -- Đơn hàng đã hoàn thành không thể cập nhật thêm
                SELECT N'Đơn hàng đã hoàn thành và không thể cập nhật trạng thái.';
            END
        ELSE IF @MATT_DH_MOI - @MATT_DH_HIENTAI != 1
            BEGIN
                -- Trạng thái cập nhật không theo quy trình
                SELECT N'Trạng thái cập nhật không hợp lệ, vui lòng cập nhật theo trình tự từ trạng thái hiện tại.';
            END
        ELSE
            BEGIN
                -- Lấy tên trạng thái mới
                SELECT @TEN_TRANGTHAI = TENTT_DH FROM TRANGTHAIDONHANG WHERE MATT_DH = @MATT_DH_MOI;

                -- Cập nhật trạng thái đơn hàng theo quy trình
                UPDATE DONHANG
                SET MATT_DH = @MATT_DH_MOI
                WHERE MADH = @MADH;

                -- Thông báo thành công
                SELECT N'Đã cập nhật thành công trạng thái đơn hàng sang ' + @TEN_TRANGTHAI + '.';
            END
    END TRY
    BEGIN CATCH
        -- Bắt và thông báo lỗi nếu có
        SELECT N'Lỗi khi cập nhật trạng thái đơn hàng: ' + ERROR_MESSAGE();
    END CATCH
END

--