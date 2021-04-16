use basic;
-- task2 
-- Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là
-- một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
SELECT * FROM nhanvien where HoTen like 'H%' or HoTen like 'T%' or HoTen like 'K%' and length(HoTen) < 15;

-- task3
-- Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi và
-- có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT * FROM khachhang where ((2021 - year(NgaySinh)) > 18 and (2021 - year(NgaySinh)) < 50) and DiaChi in ('Đà Nẵng', 'Quảng Trị');

-- task4
-- Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu
-- lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của
-- khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là
-- “Diamond”.
select khachhang.IDKhachHang, khachhang.HoTen, count(hopdong.IDHopDong) as solandat from khachhang inner join hopdong on khachhang.IDKhachHang = hopdong.IDKhachHang
inner join loaikhach on khachhang.IDLoaiKhach = loaikhach.IDLoaiKhach
where loaikhach.TenLoaiKhach = "Diamond"
group by khachhang.HoTen order by solandat;

-- task5
-- Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong,
-- TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với
-- TongTien được tính theo công thức như sau: ChiPhiThue +
-- SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả
-- các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng
-- đặt phòng cũng phải hiển thị ra).
SELECT khachhang.IDKhachHang, khachhang.HoTen, loaikhach.TenLoaiKhach, hopdong.IDHopDong, hopdong.NgayLamHopDong, hopdong.NgayKetThuc, (dichvu.ChiPhiThue + (hopdongchitiet.SoLuong * dichvudikem.Gia)) as TongTien from khachhang 
left join loaikhach on khachhang.IDLoaiKhach = loaikhach.IDLoaiKhach
left join hopdong on khachhang.IDKhachHang = hopdong.IDKhachHang
left join dichvu on hopdong.IDDichVu = dichvu.IDDichVu
left join hopdongchitiet on hopdong.IDHopDong = hopdongchitiet.IDHopDong
left join dichvudikem on hopdongchitiet.IDDichVuDiKem = dichvudikem.IDDichVuDiKem;
;
-- task6
-- Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue,
-- TenLoaiDichVu của tất cả các loại Dịch vụ chưa từng được Khách hàng
-- thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).
SELECT dv.IDDichVu, dv.TenDichVu, dv.DienTich, dv.ChiPhiThue, hopdong.NgayKetThuc, loaidichvu.TenLoaiDichVu FROM dichvu as dv
inner join hopdong on dv.IDDichVu = hopdong.IDDichVu
inner join loaidichvu on dv.IDLoaiDichVu = loaidichvu.IDLoaiDichVu
where not (month(hopdong.NgayKetThuc) in (1,2,3) and year(hopdong.NgayKetThuc) = 2019)
;
-- task7 
-- Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa,
-- ChiPhiThue, TenLoaiDichVu của tất cả các loại dịch vụ đã từng được
-- Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách
-- hàng đặt phòng trong năm 2019
SELECT dv.IDDichVu, dv.TenDichVu, dv.DienTich, dv.SoNguoiToiDa, dv.ChiPhiThue, hopdong.NgayLamHopDong, hopdong.NgayKetThuc, loaidichvu.TenLoaiDichVu FROM dichvu as dv
inner join hopdong on dv.IDDichVu = hopdong.IDDichVu
inner join loaidichvu on dv.IDLoaiDichVu = loaidichvu.IDLoaiDichVu
where (year(hopdong.NgayLamHopDong) = 2018 and year(hopdong.NgayKetThuc) = 2018) and not (year(hopdong.NgayLamHopDong) = 2019 and year(hopdong.NgayKetThuc) = 2019)
;
-- task 8 
-- Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu
-- HoThenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên
-- 
-- cách 1: Sử dụng distinct ( loại bỏ dữ liệu trùng lặp )
select distinct HoTen as HoTenKhachHang from khachhang as kh;
-- cách 2: Sử dụng group by gom các tên trùng nhau lại 
select HoTen as HoTenKhachHang from khachhang as kh
group by kh.HoTen; 
-- cách 3: Sử dụng union để kết hợp các kết quả của hai hoặc nhiều câu lệnh SELECT mà không cần trả về bất kỳ hàng trùng lặp nào.
select khachhang.HoTen from khachhang
union 
select khachhang.HoTen from khachhang

 


 