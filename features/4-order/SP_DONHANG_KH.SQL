CREATE PROC SP_DONHANG_KH
    @MAKH INT 
AS BEGIN 
    SELECT 
        DH.MADH 'Mã đơn hàng', 
        CONVERT(varchar(20), DH.TG_DAT) 'T/g đặt', 
        HOTEN 'Họ & tên', 
        DIACHI 'Địa chỉ', 
        SDT 'SĐT', 
        LUUY_GIAO 'Lưu ý giao',
        CONVERT(varchar(20), TG_HENGIAO) 'T/g hẹn giao',
        SUM(CTDH.GIA) 'Tổng tiền',
        MANV 'Mã NV',
        TTDH.TENTT_DH 'Trạng thái',
        LIDO_HUY 'Lí do hủy'
    FROM DONHANG DH
    INNER JOIN TRANGTHAIDONHANG TTDH 
        ON DH.MAKH = @MAKH
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
        TTDH.TENTT_DH, 
        DH.LIDO_HUY
    ORDER BY [T/g hẹn giao] DESC
END;