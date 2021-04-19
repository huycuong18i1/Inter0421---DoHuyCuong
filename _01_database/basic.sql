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
;
-- task9 
-- Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi
-- tháng trong năm 2019 thì sẽ có bao nhiêu khách hàng thực hiện đặt
-- phòng.
SELECT *, count(*) as sokhachdattrongthang FROM hopdong
where (month(hopdong.NgayLamHopDong) in (1,2,3,4,5,6,7,8,9,10,11,12) and year(hopdong.NgayLamHopDong) = 2019)
group by month(hopdong.NgayLamHopDong)
having count(hopdong.NgayLamHopDong)
;
-- task10 
-- Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu
-- Dịch vụ đi kèm. Kết quả hiển thị bao gồm IDHopDong,
-- NgayLamHopDong, NgayKetthuc, TienDatCoc,
-- SoLuongDichVuDiKem (được tính dựa trên việc count các
-- IDHopDongChiTiet). 
SELECT hd.IDHopDong, hd.NgayLamHopDong, hd.NgayKetThuc, hd.TienDatCoc, count(*) as SoLuongDichVuDiKem FROM hopdong as hd
inner join hopdongchitiet on hd.IDHopDong = hopdongchitiet.IDHopDong
inner join dichvudikem on hopdongchitiet.IDDichVuDiKem = dichvudikem.IDDichVuDiKem
group by hd.IDHopDong
;
-- task11
-- Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách
-- hàng có TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh”
-- hoặc “Quảng Ngãi”. 
SELECT *, loaikhach.TenLoaiKhach, khachhang.DiaChi FROM dichvudikem
inner join hopdongchitiet on dichvudikem.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem
inner join hopdong on hopdongchitiet.IDHopDong = hopdong.IDHopDong
inner join khachhang on hopdong.IDKhachHang = khachhang.IDKhachHang
inner join loaikhach on khachhang.IDLoaiKhach = loaikhach.IDLoaiKhach
where loaikhach.TenLoaiKhach = 'Diamond' and khachhang.DiaChi in ('Vinh', 'Quảng Ngãi')
;
-- task 12
-- Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang,
-- SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được
-- tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ
-- đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa
-- từng được khách hàng đặt vào 6 tháng đầu năm 2019. 
SELECT hopdong.IDHopDong, hopdong.NgayLamHopDong , nhanvien.HoTen as TenNhanVien, khachhang.HoTen as TenKhachHang, khachhang.SDT as SDTKhachHang, dichvu.TenDichVu, hopdong.TienDatCoc FROM hopdong
inner join nhanvien on hopdong.IDNhanVien = nhanvien.IDNhanVien
inner join khachhang on hopdong.IDKhachHang = khachhang.IDKhachHang
inner join dichvu on hopdong.IDDichVu = dichvu.IDDichVu
inner join hopdongchitiet on hopdong.IDHopDong = hopdongchitiet.IDHopDong 
inner join dichvudikem on hopdongchitiet.IDHopDongChiTiet = hopdongchitiet.IDHopDongChiTiet
where (month(hopdong.NgayLamHopDong) in (10,11,12) and year(hopdong.NgayLamHopDong) = 2019)
group by hopdong.IDHopDong
;
-- task13
-- Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các
-- Khách hàng đã đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử
-- dụng nhiều như nhau).
SELECT *, count(*) as DichVuSDNhieuNhat FROM dichvudikem
inner join hopdongchitiet on dichvudikem.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem
group by hopdongchitiet.IDDichVuDiKem
order by DichVuSDNhieuNhat desc
;
-- task14
--  Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một
-- lần duy nhất. Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu,
-- TenDichVuDiKem, SoLanSuDung.
SELECT hopdong.IDHopDong, dvdk.TenDichVuDiKem, loaidichvu.TenLoaiDichVu, count(*) as solansd FROM dichvudikem as dvdk
inner join hopdongchitiet on dvdk.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem
inner join hopdong on hopdongchitiet.IDHopDong = hopdong.IDHopDong
inner join dichvu on hopdong.IDDichVu = dichvu.IDDichVu
inner join loaidichvu on dichvu.IDLoaiDichVu = loaidichvu.IDLoaiDichVu
group by hopdongchitiet.IDDichVuDiKem
having COUNT(*) = 1;
;
-- task15
-- Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen,
-- TrinhDo, TenBoPhan, SoDienThoai, DiaChi mới chỉ lập được tối đa 3
-- hợp đồng từ năm 2018 đến 2019.
 SELECT nhanvien.IDNhanVien, nhanvien.HoTen, trinhdo.TrinhDo, bophan.TenBoPhan,  nhanvien.SDT, nhanvien.DiaChi, count(*) as SoLuongHDdaLap FROM nhanvien
inner join trinhdo on nhanvien.IDTrinhDo = trinhdo.IDTrinhDo
inner join bophan on nhanvien.IDBoPhan = bophan.IDBoPhan
inner join hopdong on nhanvien.IDNhanVien = hopdong.IDNhanVien
where (year(hopdong.NgayLamHopDong) in (2018, 2019))
group by hopdong.IDNhanVien
having COUNT(*) <= 3
;
-- task 16 
-- Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2017
-- đến năm 2019. 
delete 
from nhanvien
where nhanvien.IDNhanVien in (
select hopdong.IDNhanVien
from hopdong
where 
(year(hopdong.NgayLamHopDong) not in (2017, 2018, 2019)) and hopdong.IDNhanVien = nhanvien.IDNhanVien
);
-- task 19
-- Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 10 lần trong
-- năm 2019 lên gấp đôi.
update dichvudikem
set dichvudikem.Gia = dichvudikem.Gia * 2 
where dichvudikem.IDDichVuDiKem in
(
SELECT *, count(*) as DichVuSDNhieuNhat FROM dichvudikem
inner join hopdongchitiet on dichvudikem.IDDichVuDiKem = hopdongchitiet.IDDichVuDiKem
group by hopdongchitiet.IDDichVuDiKem
having count(*) >= 10)
;
-- task20
-- Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ
-- thống, thông tin hiển thị bao gồm ID (IDNhanVien, IDKhachHang),
-- HoTen, Email, SoDienThoai, NgaySinh, DiaChi. 
SELECT nhanvien.IDNhanVien, nhanvien.HoTen, nhanvien.Email, nhanvien.SDT, nhanvien.NgaySinh, nhanvien.DiaChi, khachhang.IDKhachHang, khachhang.HoTen, khachhang.Email, khachhang.SDT, khachhang.NgaySinh, khachhang.DiaChi  FROM hopdong
inner join khachhang on hopdong.IDKhachHang = khachhang.IDKhachHang
inner join nhanvien on hopdong.IDNhanVien = nhanvien.IDNhanVien
;
-- bị lỗi phần update delete vì xóa file query sql table nên em skip task 17,18 và qua nâng cao




 