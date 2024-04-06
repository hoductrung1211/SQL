-- To get info ofEmployee list or just a Customer

ALTER PROC SP_NHANVIEN
    @MANV INT = NULL
AS BEGIN 
    IF @MANV IS NULL
        SELECT 
            MANV 'Mã NV',
            HO + ' ' + TEN 'Họ & Tên',
            NGAYSINH 'Ngày sinh',
            GIOITINH 'Giới tính',
            DIACHI 'Địa chỉ',
            SDT 'SĐT',
            EMAIL 'Email',
            MATK 'Mã TK', 
            TRANGTHAI 'Trạng thái'
        FROM NHANVIEN;
    ELSE 
        SELECT 
            MANV 'Mã NV',
            HO + ' ' + TEN 'Họ & Tên',
            NGAYSINH 'Ngày sinh',
            GIOITINH 'Giới tính',
            DIACHI 'Địa chỉ',
            SDT 'SĐT',
            EMAIL 'Email',
            MATK 'Mã TK',
            TRANGTHAI 'Trạng thái'
        FROM NHANVIEN
        WHERE MANV = @MANV;
END;