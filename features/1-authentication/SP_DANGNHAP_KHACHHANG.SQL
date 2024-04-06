-- 1. Check this phone number exists & is 'Customer'
-- 2. Check password
-- 3. Check status
-- 4. Get info

ALTER PROC SP_DANGNHAP_KHACHHANG
    @SDT VARCHAR(11),
    @MATKHAU NVARCHAR(100)
AS BEGIN
    -- 1. Check this phone number exists
    DECLARE @MATK INT = NULL;
    DECLARE @TRANGTHAI BIT;

    SELECT 
        @MATK = MATK,
        @TRANGTHAI = TRANGTHAI
    FROM KHACHHANG
    WHERE SDT = @SDT
    
    IF @MATK IS NULL
    BEGIN
        RAISERROR(N'Số điện thoại không đúng hoặc Khách hàng chưa có tài khoản', 16, 1);
        RETURN;
    END;

    -- 2. Check password
    DECLARE @MATKHAU_TK NVARCHAR(100) = NULL;

    SELECT 
        @MATKHAU_TK = MATKHAU
    FROM TAIKHOAN
    WHERE MATK = @MATK

    IF @MATKHAU <> @MATKHAU_TK
    BEGIN 
        RAISERROR(N'Sai mật khẩu!', 16, 1);
        RETURN;
    END;

    -- 3. Check status
    IF @TRANGTHAI = 0
    BEGIN
        RAISERROR(N'Trạng thái Khách hàng đã bị khóa!', 16, 1);
        RETURN;
    END; 

    -- 4. Get info
    SELECT 
        MAKH 'Mã KH',
        HO + ' ' + TEN 'Họ & Tên',
        NGAYSINH 'Ngày sinh',
        GIOITINH 'Giới tính',
        DIACHI 'Địa chỉ',
        SDT 'SĐT',
        EMAIL 'Email',
        N'Khách hàng' 'Vai trò'
    FROM KHACHHANG
    WHERE SDT = @SDT
END;