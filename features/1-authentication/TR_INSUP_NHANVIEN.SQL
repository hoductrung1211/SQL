-- 1. Check MAVT is NOT Khachhang
-- 2. Check if this MATK's already existed

ALTER TRIGGER TR_INSUP_NHANVIEN 
ON NHANVIEN FOR INSERT, UPDATE
AS BEGIN
    -- -- 1. CHECK ROLE
    DECLARE @VAITRO INT = NULL;

    SELECT @VAITRO = MAVT 
    FROM TAIKHOAN TK 
    INNER JOIN inserted I 
        ON TK.MATK = I.MATK
    
    IF @VAITRO IS NOT NULL AND @VAITRO >= 3
    BEGIN
        ROLLBACK;
        RAISERROR(N'Không thể gán Tài khoản vai trò "Khách hàng" cho nhân viên', 16, 1);
    END 

    -- 2. CHECK IF IT'S ALREADY BEEN IN NHANVIEN
    DECLARE @COUNT INT = 0;
    SELECT @COUNT = COUNT(*)
    FROM NHANVIEN NV 
    INNER JOIN inserted
        ON NV.MATK = inserted.MATK
    
    IF @COUNT > 1
    BEGIN 
        ROLLBACK;
        RAISERROR(N'Đã có nhân viên sử dụng tài khoản này!', 16, 1);
    END;
END;