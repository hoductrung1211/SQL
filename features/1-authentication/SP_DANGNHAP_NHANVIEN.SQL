-- 1. Kiểm tra mã tài khoản tồn tại và có vai trò là Nhân viên.
--      Có thể xảy ra trường hợp mã tài khoản tồn tại nhưng không phải vai trò Nhân viên
-- 2. Kiểm tra mật khẩu
-- 3. Kiểm tra trạng thái khóa
-- 4. Lấy thông tin Khách hàng

ALTER PROC SP_DANGNHAP_NHANVIEN
    @MATK INT,
    @MATKHAU NVARCHAR(100)
AS BEGIN
    -- 1. Check this account exists & is Employee 
    DECLARE @COUNT INT

    SELECT 
        @COUNT = COUNT(*)
    FROM TAIKHOAN TK 
    INNER JOIN VAITRO VT 
        ON TK.MATK = @MATK
            AND TK.MAVT IN (1, 2); -- CONSTRAINTS: NHANVIEN, QUANLY

    IF @COUNT = 0
    BEGIN
        RAISERROR(N'Tài khoản không tồn tại!', 16, 1);
        RETURN;
    END

    -- 2. Check password
    DECLARE @MATKHAU_TK NVARCHAR(100) = NULL;
    DECLARE @MAVT INT = NULL;

    SELECT 
        @MATKHAU_TK = MATKHAU,
        @MAVT = TK.MAVT
    FROM TAIKHOAN TK 
    INNER JOIN VAITRO VT 
        ON TK.MATK = @MATK

    IF @MATKHAU_TK <> @MATKHAU
    BEGIN
        RAISERROR(N'Sai mật khẩu!', 16, 1);
        RETURN;
    END
    -- 3. Check status
    DECLARE @TRANGTHAI BIT;
    
    SELECT 
        @TRANGTHAI = TRANGTHAI
    FROM NHANVIEN
    WHERE MATK = @MATK

    IF @TRANGTHAI = 0
    BEGIN
        RAISERROR(N'Trạng thái Nhân viên đã bị khóa!', 16, 1);
        RETURN;
    END; 

    -- 4. Get info
    DECLARE @VAITRO NVARCHAR(50);

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
END;