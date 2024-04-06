ALTER PROC SP_DONHANG_TG -- TODO
    @TG_BATDAU DATE = NULL,
    @TG_KETTHUC DATE = NULL,
    @MATT_DH INT = NULL
AS BEGIN
    IF @TG_BATDAU IS NULL 
        SET @TG_BATDAU = GETDATE();
    IF @TG_KETTHUC IS NULL 
        SET @TG_KETTHUC = GETDATE();

    CREATE TABLE #TMP_DONHANG (
        MADH INT,
        TG_DAT DATETIME,
        HOTEN NVARCHAR(100),
        DIACHI NVARCHAR(200),
        SDT VARCHAR(11),
        LUUY_GIAO NVARCHAR(200),
        TG_HENGIAO DATETIME,
        GIA INT,
        MANV INT,
        MATT_DH INT,
        TENTT_DH NVARCHAR(100),
        LIDO_HUY NVARCHAR(200)
    );

    INSERT INTO #TMP_DONHANG
    SELECT 
        DH.MADH, 
        DH.TG_DAT, 
        HOTEN, 
        DIACHI, 
        SDT, 
        LUUY_GIAO,
        TG_HENGIAO,
        SUM(CTDH.GIA) GIA,
        MANV,
        TTDH.MATT_DH,
        TTDH.TENTT_DH,
        LIDO_HUY
    FROM DONHANG DH
    INNER JOIN TRANGTHAIDONHANG TTDH 
        ON DH.TG_DAT > @TG_BATDAU
        AND DH.TG_DAT < @TG_KETTHUC
        AND DH.MATT_DH = TTDH.MATT_DH
    INNER JOIN CT_DONHANG CTDH 
        ON DH.MADH = CTDH.MADH
    GROUP BY
        DH.MADH, 
        DH.TG_DAT, 
        DH.HOTEN, 
        DH.DIACHI, 
        DH.SDT, 
        DH.LUUY_GIAO, 
        DH.TG_HENGIAO, 
        DH.MANV, 
        TTDH.MATT_DH, 
        TTDH.TENTT_DH, 
        DH.LIDO_HUY;

    IF @MATT_DH IS NOT NULL
        DELETE #TMP_DONHANG
        WHERE MATT_DH <> @MATT_DH

    SELECT 
        MADH 'Mã đơn hàng', 
        CONVERT(varchar(20), TG_DAT) 'T/g đặt', 
        HOTEN 'Họ & tên', 
        DIACHI 'Địa chỉ', 
        SDT 'SĐT', 
        LUUY_GIAO 'Lưu ý giao',
        CONVERT(varchar(20), TG_HENGIAO) 'T/g hẹn giao',
        GIA 'Tổng tiền',
        MANV 'Mã NV',
        TENTT_DH 'Trạng thái',
        LIDO_HUY 'Lí do hủy'
    FROM #TMP_DONHANG;
END;