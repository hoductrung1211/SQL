CREATE PROC SP_DANGNHAP
    @MATK INT,
    @MATKHAU NVARCHAR(100)
AS BEGIN
    -- 1. VALIDATE THE ACCOUNT IF IT REALLY EXISTS
    DECLARE @MAVT INT = NULL;

    SELECT @MAVT = MAVT 
    FROM TAIKHOAN
    WHERE @MATK = MATK

    IF @MAVT IS NULL 
    BEGIN
        RAISERROR(N'Tài khoản không tồn tại', 16, 1);
        RETURN;
    END;

    SET @MAVT = NULL;
    SELECT @MAVT = MAVT 
    FROM TAIKHOAN
    WHERE @MATK = MATK
        AND @MATKHAU = MATKHAU

    IF @MAVT IS NULL
    BEGIN 
        RAISERROR(N'Sai mật khẩu', 16, 1);
        RETURN;
    END;


    -- 2. GET INFO
    DECLARE @TRANGTHAI BIT = NULL;
    DECLARE @VAITRO NVARCHAR(100) = NULL;

    IF @MAVT < 3
    BEGIN
        SELECT @TRANGTHAI = TRANGTHAI
        FROM NHANVIEN
        WHERE MATK = @MATK

        IF @TRANGTHAI = 0 -- THIS EMPLOYEE IS OFF
        BEGIN 
            RAISERROR(N'Tài khoản bị tắt kích hoạt!', 16, 1);
            RETURN;
        END

        IF @MAVT = 1
            SET @VAITRO = N'Nhân viên'
        ELSE SET @VAITRO = N'Quản lý'
        
        SELECT 
            MANV 'Mã NV',
            HO + ' ' + TEN 'Họ & Tên',
            NGAYSINH 'Ngày sinh',
            GIOITINH 'Giới tính',
            DIACHI 'Địa chỉ',
            SDT 'SĐT',
            EMAIL 'Email',
            @VAITRO 'Vai trò'
        FROM NHANVIEN
        WHERE MATK = @MATK
    END
    ELSE
    BEGIN
        SELECT @TRANGTHAI = TRANGTHAI
        FROM KHACHHANG
        WHERE MATK = @MATK

        IF @TRANGTHAI = 0 -- THIS EMPLOYEE IS OFF
        BEGIN 
            RAISERROR(N'Tài khoản bị tắt kích hoạt!', 16, 1);
        END

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
        WHERE MATK = @MATK
    END
END;