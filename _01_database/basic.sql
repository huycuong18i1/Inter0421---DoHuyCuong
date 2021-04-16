use basic;
-- task2 
SELECT * FROM nhanvien where HoTen like 'H%' or HoTen like 'T%' or HoTen like 'K%' and length(HoTen) < 15;
-- task3
SELECT * FROM khachhang where ((2021 - year(NgaySinh)) > 18 and (2021 - year(NgaySinh)) < 50) and DiaChi in ('Đà Nẵng', 'Quảng Trị');
-- task4 
select khachhang.IDKhachHang, khachhang.HoTen, count(hopdong.IDHopDong) as solandat from khachhang inner join hopdong on khachhang.IDKhachHang = hopdong.IDKhachHang
inner join loaikhach on khachhang.IDLoaiKhach = loaikhach.IDLoaiKhach
where loaikhach.TenLoaiKhach = "Diamond"
group by khachhang.HoTen order by solandat;
-- task5
 select * from khachhang full join hopdong, loaikhach, loaidichvu;