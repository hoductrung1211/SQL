-- TRA CỨU THÔNG TIN CÁC SỰ KIỆN KHUYẾN MÃI TẠI 1 THỜI ĐIỂM (INPUT)
-- DEFAULT: THỜI ĐIỂM HIỆN TẠI

ALTER PROC SP_KHUYENMAI_TG
    @TG DATE = NULL
AS BEGIN
    IF @TG IS NULL
        SET @TG = GETDATE();
    
    SELECT
        CONVERT(varchar(18), TG_BATDAU) 'Thời gian bắt đầu',
        CONVERT(varchar(10), MAKM) + ' - ' + TENKM 'Khuyến mãi',
        CONVERT(varchar(18), TG_KETTHUC) 'Thời gian kết thúc',
        CONVERT(varchar(18), TG_TAO) 'Thời gian tạo',
        MAQL 'Mã quản lý tạo',
        TRANGTHAI 'Trạng thái'
    FROM KHUYENMAI
    WHERE 
        TG_BATDAU <= @TG 
        AND @TG <= TG_KETTHUC 
END;