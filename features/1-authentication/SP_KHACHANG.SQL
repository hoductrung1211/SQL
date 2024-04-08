--==--== TEST CASES ==--==--
-- 1. Lấy danh sách khách hàng
EXEC SP_KHACHHANG;
-- 2. Lấy thông tin 1 khách hàng
EXEC SP_KHACHHANG @MAKH = 2;

GO;
ALTER PROC SP_KHACHHANG
    @MAKH INT = NULL
AS BEGIN 
    IF @MAKH IS NULL
        SELECT 
            MAKH 'Mã KH',
            HO + ' ' + TEN 'Họ & Tên',
            NGAYSINH 'Ngày sinh',
            GIOITINH 'Giới tính',
            DIACHI 'Địa chỉ',
            SDT 'SĐT',
            EMAIL 'Email',
            MATK 'Mã TK',
            TRANGTHAI 'Trạng thái'
        FROM KHACHHANG
    ELSE 
        SELECT 
            MAKH 'Mã KH',
            HO + ' ' + TEN 'Họ & Tên',
            NGAYSINH 'Ngày sinh',
            GIOITINH 'Giới tính',
            DIACHI 'Địa chỉ',
            SDT 'SĐT',
            EMAIL 'Email',
            MATK 'Mã TK',
            TRANGTHAI 'Trạng thái'
        FROM KHACHHANG
        WHERE @MAKH = MAKH
END;