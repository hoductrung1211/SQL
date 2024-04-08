--==--== WORKFLOW ==--==--
-- 1. Kiểm tra số điện thoại tồn tại và đã có tài khoản.
-- 2. Kiểm tra mật khẩu
-- 3. Kiểm tra trạng thái khóa
-- 4. Lấy thông tin Khách hàng

--==--== TEST CASES ==--==--
-- 1. Login BUT Customer has been locked!
EXEC SP_DANGNHAP_KHACHHANG 
    @SDT = '0987654322',
    @MATKHAU = '123456';

-- 2. Login successfully BUT Customer has been locked!
EXEC SP_DANGNHAP_KHACHHANG 
    @SDT = '0987654321',
    @MATKHAU = '123456';

-- 3. Phone number's correct but password
EXEC SP_DANGNHAP_KHACHHANG 
    @SDT = '0987654321',
    @MATKHAU = '1234567';

-- 4. Phone number's incorrect
EXEC SP_DANGNHAP_KHACHHANG 
    @SDT = '098765432',
    @MATKHAU = '123456';

-- 4. Customer does NOT have an account
EXEC SP_DANGNHAP_KHACHHANG 
    @SDT = '0765432198',
    @MATKHAU = '123456';

GO;


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