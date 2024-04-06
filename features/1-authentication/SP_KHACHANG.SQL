-- To get info of Customers or just a Customer

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