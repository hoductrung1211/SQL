ALTER PROC SP_DONHANG 
    @MADH INT = NULL 
AS BEGIN 
    IF @MADH IS NULL -- List
    BEGIN
        SELECT 
            DH.MADH 'Mã đơn hàng', 
            DH.TG_DAT 'T/g đặt', 
            HOTEN 'Họ & tên', 
            DIACHI 'Địa chỉ', 
            SDT 'SĐT', 
            LUUY_GIAO 'Lưu ý giao',
            TG_HENGIAO 'T/g hẹn giao',
            CTDH.GIA 'Tổng tiền',
            MANV 'Mã NV',
            TTDH.TENTT_DH 'Trạng thái',
            LIDO_HUY 'Lí do hủy'
        FROM DONHANG DH
        INNER JOIN TRANGTHAIDONHANG TTDH 
            ON DH.MATT_DH = TTDH.MATT_DH 
        INNER JOIN (
            SELECT 
                MADH, 
                SUM(SOLUONG * GIA) GIA
            FROM CT_DONHANG 
            GROUP BY 
                MADH 
        ) CTDH
            ON DH.MADH = CTDH.MADH 
        ORDER BY [T/g đặt] DESC
    END
    ELSE BEGIN -- Individual
        SELECT 
            DH.MADH 'Mã đơn hàng', 
            CONVERT(varchar(12), DH.TG_DAT) 'T/g đặt', 
            HOTEN 'Họ & tên', 
            DIACHI 'Địa chỉ', 
            SDT 'SĐT', 
            LUUY_GIAO 'Lưu ý giao',
            CONVERT(varchar(12), TG_HENGIAO) 'T/g hẹn giao',
            CTDH.GIA 'Tổng tiền',
            MANV 'Mã NV',
            TTDH.TENTT_DH 'Trạng thái',
            LIDO_HUY 'Lí do hủy'
        FROM DONHANG DH
        INNER JOIN TRANGTHAIDONHANG TTDH 
            ON DH.MADH = @MADH
            AND DH.MATT_DH = TTDH.MATT_DH
        INNER JOIN (
            SELECT 
                MADH, 
                SUM(SOLUONG * GIA) GIA
            FROM CT_DONHANG 
            GROUP BY 
                MADH 
        ) CTDH
            ON DH.MADH = CTDH.MADH 
        
        SELECT 
            CONVERT(varchar(8), CTDH.MAMH) + ' - ' + SP.TENSP + ' ' + DVT.TENDVT 'Mặt hàng',
            CONVERT(varchar(8), CTDH.SOLUONG) + ' x ' + CONVERT(varchar(20), GIA) 'Số lượng',
            CTDH.SOLUONG * GIA 'Tạm tính',
            MAKM 'Khuyến mãi'
        FROM CT_DONHANG CTDH
        INNER JOIN MATHANG MH 
            ON MADH = @MADH
            AND CTDH.MAMH = MH.MAMH
        INNER JOIN SANPHAM SP 
            ON MH.MASP = SP.MASP
        INNER JOIN DONVITINH DVT
            ON MH.MADVT = DVT.MADVT
    END;
END;