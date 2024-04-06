CREATE VIEW V_KHUYENMAI
AS
    SELECT
        MAKM 'Mã khuyến mãi',
        TENKM 'Tên khuyến mãi',
        TG_BATDAU 'Thời gian bắt đầu',
        TG_KETTHUC 'Thời gian kết thúc',
        MAQL 'Mã quản lý tạo',
        TG_TAO 'Thời gian tạo',
        TRANGTHAI 'Trạng thái'
    FROM KHUYENMAI