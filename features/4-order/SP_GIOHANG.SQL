ALTER PROC SP_GIOHANG
    @MAKH INT = NULL
    AS BEGIN 
        IF @MAKH IS NULL 
            BEGIN
            SELECT *
            FROM V_GIOHANG
            END 

        ELSE BEGIN 
            SELECT 
                KH.MAKH 'Mã khách hàng',
                KH.HO + ' ' + KH.TEN 'Họ & tên',
                KH.GIOITINH 'Giới tính',
                KH.DIACHI 'Địa chỉ'
            FROM 
                KHACHHANG KH
            WHERE KH.MAKH = @MAKH

            SELECT 
                GH.MAMH 'Mã mặt hàng',
                SP.TENSP 'Tên sản phẩm',
                DVT.TENDVT 'Đơn vị',
                CONVERT(varchar(10), GH.SOLUONG) + ' x ' + CONVERT(varchar(10), GB.GIABAN) 'Số lượng',
                GH.SOLUONG * GB.GIABAN 'Giá'
            FROM 
                GIOHANG GH 
                INNER JOIN
                    MATHANG MH
                    ON GH.MAKH = @MAKH AND
                        GH.MAMH = MH.MAMH
                INNER JOIN
                    SANPHAM SP 
                    ON MH.MASP = SP.MASP
                INNER JOIN
                    DONVITINH DVT
                    ON MH.MADVT = DVT.MADVT
                INNER JOIN 
                    V_GIABAN_HIENTAI GB
                    ON GB.MAMH = MH.MAMH;

            SELECT -- TODO
                SUM(
                    GH.SOLUONG * GB.GIABAN
                ) 'Tổng giá tiền'
            FROM GIOHANG GH 
                INNER JOIN 
                    MATHANG MH 
                    ON GH.MAKH = @MAKH
                    AND GH.MAMH = MH.MAMH
                INNER JOIN
                    V_GIABAN_HIENTAI GB
                ON GB.MAMH = GH.MAMH
                
        END;
    END;