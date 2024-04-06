-- 1. Check MAVT is NOT Nhanvien
-- 2. Check if this MATK's already existed

CREATE TRIGGER TR_INSUP_KHACHHANG 
ON KHACHHANG FOR INSERT, UPDATE
AS BEGIN
    -- -- 1. CHECK ROLE
    DECLARE @VAITRO INT = NULL;

    SELECT @VAITRO = MAVT 
    FROM TAIKHOAN TK 
    INNER JOIN inserted I
        ON TK.MATK = I.MATK
    
    IF @VAITRO IS NOT NULL AND @VAITRO <> 3
    BEGIN
        ROLLBACK;
        RAISERROR(N'Không thể gán Tài khoản vai trò "Nhân viên" cho Khách hàng', 16, 1);
        RETURN;
    END 

    -- 2. CHECK IF IT'S ALREADY BEEN IN NHANVIEN
    DECLARE @COUNT INT = 0;
    SELECT @COUNT = COUNT(*)
    FROM KHACHHANG KH 
    INNER JOIN inserted
        ON KH.MATK = inserted.MATK
    
    IF @COUNT > 1
    BEGIN 
        ROLLBACK;
        RAISERROR(N'Đã có khách hàng khác sử dụng tài khoản này!', 16, 1);
    END;
END;