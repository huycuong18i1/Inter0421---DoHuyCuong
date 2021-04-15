use design01;
create table HopDong (
	IDHopDong int primary key auto_increment,
    IDNhanVien int,
    IDKhachHang int,
    IDDichVu int,
    NgayLamHopDong date,
    NgayKetThuc date,
    TienDatCoc int,
    TongTien int
);
create table NhanVien (
	IDNhanVien int primary key auto_increment,
    `HoTen` varchar(45),
    IDViTri int,
    IDTrinhDo int,
    IDBoPhan int,
    NgaySinh date,
    `CMND` char(10),
    Luong int,
    `SDT` char(10),
    `Email` varchar(45),
    `DiaChi` varchar(45)
);
create table ViTri (
	IDViTri int primary key auto_increment,
    `TenViTri` varchar(45)
);
create table TrinhDo(
	IDTrinhDo int primary key auto_increment,
    `TrinhDo` varchar(45)
);
create table BoPhan(
	IDBoPhan int primary key auto_increment,
    `TenBoPhan` varchar(45)
);
create table HopDongChiTiet(
	IDHopDongChiTiet int primary key auto_increment,
    IDHopDong int,
    IDDichVuDiKem int,
    SoLuong int
);
create table DichVuDiKem(
	IDDichVuDiKem int primary key auto_increment,
    `TenDichVuDiKem` varchar(45),
    Gia int,
    `DonVi` varchar(45),
    `TrangThaiKhaDung` varchar(45)
);
create table KhachHang(
	IDKhachHang int primary key auto_increment,
    IDLoaiKhach int,
    `HoTen` varchar(45),
    `CMND` char(10),
    `SDT` char(15),
    `Email` varchar(45),
    `DiaChi` varchar(45)
);
create table LoaiKhach(
	IDLoaiKhach int primary key auto_increment,
    `TenLoaiKhach` varchar(45)
);
create table DichVu(
	IDDichVu int primary key auto_increment,
    `TenDichVu` varchar(45),
    DienTich int,
    SoTang int,
    SoNguoiToiDa int,
    ChiPhiThue int,
    IDKieuThue int,
    IDLoaiDichVu int,
    `TrangThai` varchar(45)
);
create table KieuThue(
	IDKieuThue int primary key auto_increment,
    `TenKieuThue` varchar(45)
);
create table LoaiDichVu(
	IDLoaiDichVu int primary key auto_increment,
    `TenLoaiDichVu` varchar(45)
);

