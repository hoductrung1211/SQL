USE Winmart_Shop;

---------------------------------------
-- === === 1. AUTHENTICATION === === --
---------------------------------------
INSERT INTO VAITRO (
    TENVT
)
VALUES 
    (N'Nhân viên'),
    (N'Quản lý'),
    (N'Khách hàng');

INSERT INTO TAIKHOAN (
    MATKHAU,
    MAVT
)
VALUES 
    ('123456', 2), 
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 1), -- NV
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3), -- KH
    ('123456', 3); -- KH


INSERT INTO KHACHHANG (
    TEN,
    HO,
    NGAYSINH,
    GIOITINH,
    DIACHI,
    SDT,
    EMAIL,
    TRANGTHAI, -- 1 is Active, 0 is Inactive
    MATK
)
VALUES
    (N'Vãng lai', N'Khách hàng', '', 1, '', '', '', 1, 9),
    (N'Nguyễn', N'Thị An', '1990-05-15', 0, N'123 Đường Láng, Hà Nội', '0987654321', 'nguyenthian@example.com', 1, 10),
    (N'Trần', N'Văn Bình', '1985-08-20', 1, N'456 Đường Hồ Tùng Mậu, Hồ Chí Minh', '0987654322', 'tranvanbinh@example.com', 1, 11),
    (N'Lê', N'Hồng Cẩm', '1992-11-10', 0, N'789 Đường Bạch Đằng, Đà Nẵng', '0987654323', 'lehongcam@example.com', 1, 12),
    (N'Phạm', N'Quốc Dũng', '1988-03-25', 1, N'101 Đường Lê Lợi, Hải Phòng', '0987654324', 'phamquocdung@example.com', 1, 13),
    (N'Nguyễn', N'Quốc Trung', '1990-05-15', 1, N'Ba Đình, Hà Nội', '0123456789', 'nguyenquoctrung@example.com', 1, 14),
    (N'Lê', N'Thị Vân', '1995-03-25', 1, N'Đà Nẵng', '0852147963', 'lethivan@example.com', 1, 15),
    (N'Phạm', N'Trấn Hùng', '1999-11-25', 1, N'Cần Thơ', '0765432198', 'phamtranhung@example.com', 1, 16);


INSERT INTO NHANVIEN (
    TEN,
    HO,
    NGAYSINH,
    GIOITINH,
    DIACHI,
    SDT,
    EMAIL,
    TRANGTHAI,
    MATK
)
VALUES 
    (N'Nguyễn', N'Văn A', '1992-06-10', 1, N'123 Đường Láng, Hà Nội', '0987654321', 'nguyenvana@example.com', 1, 1),
    (N'Trần', N'Thị B', '1988-03-20', 0, N'456 Đường Hồ Tùng Mậu, Hồ Chí Minh', '0987654322', 'tranthib@example.com', 1, 2),
    (N'Lê', N'Hồng C', '1995-11-05', 1, N'789 Đường Bạch Đằng, Đà Nẵng', '0987654323', 'lehongc@example.com', 1, 3),
    (N'Phạm', N'Trần D', '1980-09-15', 1, N'101 Đường Lê Lợi, Hải Phòng', '0987654324', 'phamtrand@example.com', 1, 4),
    (N'Lê', N'Thị Hồng', '1990-07-12', 0, N'123 Đường Nguyễn Văn Linh, Quận 7, TP.HCM', '0987654325', 'lethihong@example.com', 1, 5),
    (N'Nguyễn', N'Trần Quốc', '1985-04-18', 1, N'456 Đường Lê Văn Việt, Quận 9, TP.HCM', '0987654326', 'nguyentranquoc@example.com', 1, 6),
    (N'Trần', N'Thị Mỹ Linh', '1993-12-25', 0, N'789 Đường Lý Thường Kiệt, Biên Hòa, Đồng Nai', '0987654327', 'tranthimylinh@example.com', 1, 7),
    (N'Huỳnh', N'Tuấn Anh', '1982-10-30', 1, N'101 Đường Trần Hưng Đạo, Vũng Tàu, Bà Rịa - Vũng Tàu', '0987654328', 'huynhtuananh@example.com', 1, 8);


INSERT INTO QUANLY (
    MANV,
    TG_BATDAU,
    TG_BONHIEM,
    TG_KETTHUC,
    TRANGTHAI
)
VALUES 
    (1, '2023-10-10', '2023-10-01', NULL, 1)

-----------------------------
-- === === 2. ITEM === === --
-----------------------------

INSERT INTO DANHMUC (
    TENDM
)
VALUES 
    (N'Thịt'),
    (N'Rau lá'),
    (N'Củ, quả'),
    (N'Nước giặt'),
    (N'Nước rửa chén'),
    (N'Nước xả'),
    (N'Chăm sóc tóc'),
    (N'Chăm sóc răng miệng'),
    (N'Sữa tươi'),
    (N'Sữa hạt - sữa đậu'),
    (N'Bánh snack'),
    (N'Hạt - trái cây sấy khô'),
    (N'Bia'),
    (N'Nước suối'),
    (N'Nước ngọt'),
    (N'Trà'),
    (N'Mì'),
    (N'Dầu ăn'),
    (N'Nước mắm - nước chấm'),
    (N'Nước tương'),
    (N'Tương các loại');


INSERT INTO THUONGHIEU (
    TENTH
)
VALUES 
    (N'MEATDeli'),
    (N'WinEco'),
    (N'Omo'),
    (N'Comfort'),
    (N'Lix'),
    (N'Aba'),
    (N'Sunlight'),
    (N'Downy'),
    (N'Clear'),
    (N'Dove'),
    (N'Pantene'),
    (N'Head & Shouders'),
    (N'Sunsilk'),
    (N'Romano'),
    (N'X-men'),
    (N'Colgate'),
    (N'Closeup'),
    (N'Dutch Lady'),
    (N'TH True Milk'),
    (N'Dalat Milk'),
    (N'Vinamilk'),
    (N'Milo'),
    (N'Fami'),
    (N'Lays'),
    (N'Oishi'),
    (N'O Star'),
    (N'Heineken'),
    (N'Red Ruby'),
    (N'333'),
    (N'Strongbow'),
    (N'Tiger'),
    (N'Becks Ice'),
    (N'Vinacafe'),
    (N'Nescafe'),
    (N'Highlands Coffee'),
    (N'Aquafina'),
    (N'Dasani'),
    (N'LaVie'),
    (N'Monster'),
    (N'Coca Cola'),
    (N'Pepsi'),
    (N'Mirinda'),
    (N'Sting'),
    (N'Tea+'),
    (N'Redbull'),
    (N'Cozy'),
    (N'Cung Đình Micoem'),
    (N'Hảo Hảo'),
    (N'Omachi'),
    (N'Meizan'),
    (N'Tường An'),
    (N'Neptune'),
    (N'Chin-su'),
    (N'Nam Ngư'),
    (N'Maggi'),
    (N'Sempio'),
    (N'Heinz');


INSERT INTO DONVITINH (
    TENDVT
)
VALUES
    ('0.44KG'),
    ('0.3KG'),
    ('1KG'),
    ('0.5KG'),
    ('Gói'),
    ('1.7KG'),
    ('1.4KG');


INSERT INTO SANPHAM (
    TENSP,
    SKU,
    MATH,
    MADM,
    MOTA,
    XUATXU,
    THANHPHAN,
    HD_SUDUNG,
    HD_BAOQUAN,
    TRANGTHAI
)
VALUES
    (
        N'MEATDeli Sụn heo (S)', 
        '10281598', 
        1, 
        1, 
        N'Meat Deli thương hiệu thịt sạch áp dụng Công Nghệ Oxy Fresh 9 đến từ Châu Âu mang tới những sản phẩm đảm bảo an toàn chất lượng tới tận tay người tiêu dùng. Khép kín mọi công đoạn giúp nâng cao dinh dưỡng trong bữa ăn của mỗi gia đình.', 
        'Vietnam', 
        'Meat', 
        '', 
        N'Ngăn mát là khoảng 2°C và ngăn đá là âm 25°C.', 
        1
    ),
    (
        N'MEATDeli Thịt cốt lết heo (S)',
        '10638957',
        1,
        1,
        N'Meat Deli thương hiệu thịt sạch áp dụng Công Nghệ Oxy Fresh 9 đến từ Châu Âu mang tới những sản phẩm đảm bảo an toàn chất lượng tới tận tay người tiêu dùng. Khép kín mọi công đoạn giúp nâng cao dinh dưỡng trong bữa ăn của mỗi gia đình.', 
        'Vietnam', 
        'Meat', 
        N'Thịt cốt lết heo có thể sử dụng dùng làm nguyên liệu chế biến các món ăn tùy thích, đặc biệt dành cho món chiên hoặc làm ruốc.', 
        N'Bảo quản ở nhiệt độ 0 - 4 độ C', 
        1
    ),
    (
        N'MEATDeli Thịt nạc heo (S)', 
        '10183114', 
        1, 
        1, 
        N'', 
        'Vietnam', 
        'Meat', 
        N'', 
        N'Ngăn mát là khoảng 2°C và ngăn đá là âm 25°C.', 
        1
    ),
    (
        N'Cần tây lớn WinEco',
        '10054767',
        2,
        2,
        N'',
        'Vietnam',
        '',
        N'Thích hợp dùng làm gia vị trong một số món ăn.',
        N'',
        1
    ),
    (
        N'Xà lách iceberg WinEco',
        '10060570',
        2,
        2,
        N'',
        'Vietnam',
        '',
        N'Thích hợp dùng làm gia vị trong một số món ăn.',
        N'',
        1
    ),
    (
        N'Giá đỗ WinEco',
        '10281835',
        2,
        2,
        N'',
        'Vietnam',
        '',
        N'Giá giòn, ngọt thường được dùng làm rau ăn kèm cho các món có nước như bún, phở hoặc nấu canh chua, xào với thịt.',
        N'',
        1
    ),
    (
        N'Ớt ngọt xanh WinEco',
        '10308248',
        2,
        3,
        N'',
        'Vietnam',
        N'Loại ớt này còn chứa một số vitamin C, B6, A, E và K.',
        N'Thích hợp để làm các món nướng, xào, hay nấu súp.',
        N'Nơi khô ráo, thoáng mát',
        1
    ),
    (
        N'Cà chua đỏ WinEco',
        '10403303',
        2,
        3,
        N'',
        'Vietnam',
        N'Chứa một số khoáng chất khác như Canxi, sắt, magie, phốt pho, natri và kẽm và kali.',
        N'Thích hợp cho các món salad, xào, nấu, kẹp với bánh mỳ.',
        N'Nơi khô ráo, thoáng mát',
        1
    ),
    (
        N'Dưa hấu Nhật',
        '10053985',
        NULL,
        3,
        N'Dưa hấu là một loại trái cây nhiệt đới ngon ngọt, mát bổ, dưa hấu giúp giữ nước và làm dịu cơn khát cho cơ thể.',
        'Vietnam',
        N'Sản phẩm cũng rất giàu chất điện giải, kali và natri cung cấp các chất dinh dưỡng và vitamin khác nhau như vitamin A, B và C…',
        N'Sử dụng trực tiếp, ép, xay sinh tố...',
        N'Nơi khô ráo, thoáng mát',
        1
    ),
    (
        N'Xoài tứ quý',
        '10054897',
        NULL,
        3,
        N'Xoài tứ quý là một loại quả giàu dinh dưỡng rất được người tiêu dùng Việt Nam ưa chuộng.',
        'Vietnam',
        N'Chứa chất béo, chất xơ, đường, protein, vitamin A, canxi và một số dinh dưỡng khác.',
        N'Sử dụng trực tiếp, ép, xay sinh tố...',
        N'Nơi khô ráo, thoáng mát',
        1
    );


INSERT INTO MATHANG (
    MASP,
    MADVT,
    SOLUONG
)
VALUES 
    (1, 1, 100),
    (2, 1, 100),
    (3, 1, 100),
    (4, 3, 100), -- Cần tây lớn WinEco
    (4, 4, 100), -- Cần tây lớn WinEco
    (5, 3, 100), -- Xà lách
    (5, 4, 100), -- Xà lách
    (6, 5, 100), -- Giá đỗ
    (7, 3, 100), -- Ớt ngọt xanh
    (7, 4, 100), -- Ớt ngọt xanh
    (8, 3, 100), -- Cà chua đỏ
    (8, 4, 100), -- Cà chua đỏ
    (9, 6, 100), -- Dưa hấu Nhật
    (9, 7, 100), -- Dưa hấu Nhật
    (10, 3, 100), -- Xoài tứ quý
    (10, 4, 100); -- Xoài tứ quý


------------------------------
-- === === 3. PRICE === === --
------------------------------

INSERT INTO GIABAN (
    MAMH,
    TG_TAO,
    TG_APDUNG,
    GIABAN,
    MANV
)
VALUES 
    (1, '2024-01-01', '2024-01-01', 100285, 1),
    (1, '2024-02-02', '2024-02-02', 100000, 1),
    (2, '2024-01-01', '2024-01-01', 38777, 1),
    (2, '2024-02-02', '2024-02-02', 38000, 1),
    (3, '2024-01-01', '2024-01-01', 39741, 1),
    (3, '2024-02-02', '2024-02-02', 39000, 1),
    (4, '2024-01-01', '2024-01-01', 38800, 1), -- Cần tây lớn 
    (4, '2024-02-02', '2024-02-02', 38000, 1), -- Cần tây lớn 
    (5, '2024-01-01', '2024-01-01', 19400, 1), -- Cần tây lớn 
    (6, '2024-01-01', '2024-01-01', 41520, 1), -- Xà lách
    (7, '2024-01-01', '2024-01-01', 20760, 1), -- Xà lách
    (8, '2024-01-01', '2024-01-01', 7920, 1), -- Giá đỗ
    (9, '2024-01-01', '2024-01-01', 55920, 1), -- Ớt ngọt xanh
    (10, '2024-01-01', '2024-01-01', 27960, 1), -- Ớt ngọt xanh
    (11, '2024-01-01', '2024-01-01', 23920, 1), -- Cà chua đỏ
    (12, '2024-01-01', '2024-01-01', 11960, 1), -- Cà chua đỏ
    (13, '2024-01-01', '2024-01-01', 40630, 1), -- Dưa hấu Nhật
    (14, '2024-01-01', '2024-01-01', 33460, 1), -- Dưa hấu Nhật
    (15, '2024-01-01', '2024-01-01', 44900, 1), -- Xoài tứ quý
    (16, '2024-01-01', '2024-01-01', 22450, 1); -- Xoài tứ quý


INSERT INTO KHUYENMAI (
    TENKM,
    TG_BATDAU,
    TG_KETTHUC,
    MAQL,
    TG_TAO,
    TRANGTHAI
)
VALUES 
    ('Tết 2024', '2024-01-20', '2024-02-20', 1, '2024-01-10', 0),
    ('Hot Sale tháng 3', '2024-03-01', '2024-03-31', 1, '2024-02-24', 1),
    ('Ngày 8 tháng 3', '2024-03-03', '2024-03-10', 1, '2024-02-24', 0);


INSERT INTO CT_KHUYENMAI (
    MAKM,
    MAMH,
    GIAMGIA
)
VALUES 
    (1, 1, 20),
    (1, 2, 10),
    (1, 3, 20),
    (1, 4, 15),
    (2, 5, 10),
    (2, 6, 12),
    (2, 7, 15),
    (2, 8, 10),
    (3, 9, 12),
    (3, 10, 12);



------------------------------
-- === === 4. ORDER === === --
------------------------------
INSERT INTO GIOHANG (
    MAKH,
    MAMH,
    SOLUONG
)
VALUES
    (1, 1, 2),
    (1, 2, 3),
    (2, 3, 3);


INSERT INTO TRANGTHAIDONHANG (
    TENTT_DH
)
VALUES 
    (N'Chờ duyệt'),
    (N'Chuẩn bị đơn'),
    (N'Chờ lấy hàng'),
    (N'Đang giao'),
    (N'Giao thành công'),
    (N'Hủy');


INSERT INTO DONHANG (
    MAKH,
    HOTEN,
    SDT,
    DIACHI,
    LUUY_GIAO,
    LIDO_HUY,
    TG_HENGIAO,

    MANV,
    TG_DAT,
    MATT_DH
)
VALUES
    (2, N'Nguyễn Thị An', '0987654321', N'123 Đường Láng, Hà Nội', N'Giao trước 10h sáng', N'', '2024-03-16 09:30:00', 2, '2024-03-15 22:30:01', 5), -- ONLINE DONE
    (3, N'Trần Văn Bình', '0987654322', N'456 Đường Hồ Tùng Mậu, Hồ Chí Minh', '', N'Chọn sai số lượng', '2024-03-16 08:30:00', 2, '2024-03-15 22:33:41', 6), -- ONLINE CANCELLED
    (4, N'Lê Hồng Cẩm', '0987654323', N'789 Đường Bạch Đằng, Đà Nẵng', '', '', '2024-03-16 10:00:00', 3, '2024-03-16 08:30:18', 5), -- ONLINE DELIVERYING
    (5, N'Phạm Quốc Dũng', '0987654324', N'101 Đường Lê Lợi, Hải Phòng', '', '', '2024-03-16 10:30:00', 3, '2024-03-16 10:33:32', 3), -- ONLINE PACKAGING
    (1, N'Vãng lai', '', '', '', '', '', 3, '2024-03-16 11:22:33', 5),
    (1, N'Vãng lai', '', '', '', '', '', 3, '2024-03-16 11:30:01', 5),
    (2, N'Nguyễn Quốc Trung', '0123456789', N'Ba Đình, Hà Nội', N'', N'', '2024-03-16 16:30:00', NULL, '2024-03-16 9:49:22', 1);

INSERT INTO CT_DONHANG (
    MADH,
    MAMH,
    SOLUONG,
    GIA,
    MAKM
)
VALUES
    (1, 1, 1, 100285, NULL),
    (1, 5, 1, 19400, NULL),
    (2, 2, 2, 38777, NULL),
    (2, 8, 3, 7920, NULL),
    (3, 11, 1, 23920, NULL),
    (3, 16, 1, 22450, NULL),
    (4, 7, 1, 20760, NULL),
    (4, 9, 2, 55920, NULL),
    (5, 3, 1, 39741, NULL),
    (5, 4, 1, 38800, NULL),
    (6, 14, 2, 33460, NULL),
    (6, 11, 1, 23920, NULL),
    (7, 6, 1, 41520, NULL),
    (7, 1, 2, 100285, NULL);


INSERT INTO HOADON (
    MADH,
    MANV,
    TG_TAO
)
VALUES
    (2, 4, '2024-03-16 09:33:44'); -- first one of DONHANG

------------------------------------
-- === === 5. LIQUIDATION === === --
------------------------------------

INSERT INTO LIDO_THANHLY (
    TENLD_TL
)
VALUES 
    (N'Sắp hết hạn'),
    (N'Tồn kho');

INSERT INTO THANHLY (
    MANV,
    MAQL,
    TG_TAO
)
    VALUES 
    (2, NULL, '2024-02-02'),
    (3, 1, '2024-02-02'),
    (4, 1, '2024-02-02');

INSERT INTO CT_THANHLY (
    MATL,
    MAMH,
    MALD_TL,
    SOLUONG
)
    VALUES
    (1, 4, 1, 10),
    (1, 5, 2, 10),
    (2, 5, 1, 10),
    (3, 6, 2, 10);