create database QL_ChuyenBay
go
use QL_ChuyenBay

-- Tạo bảng KHACHHANG
create table KHACHHANG
(
 MAKH nvarchar(15) not null,
 TEN nvarchar(15) not null unique,
 DCHI nvarchar(50),
 DTHOAI nvarchar(12),
 primary key (MAKH)
)

-- Tạo bảng NHANVIEN
create table NHANVIEN
(
 MANV nvarchar(15)not null,
 TEN nvarchar(15)not null unique,
 DCHI nvarchar(50),
 DTHOAI nvarchar(12),
 LUONG float CHECK(LUONG >0),
 LOAINV bit,
 primary key (MANV)
)

-- Tạo bảng LOAIMB
create table LOAIMB
(
 MALOAI nvarchar(15) not null,
 HANGSX nvarchar(15)not null,
 primary key (MALOAI)
)
-- Tạo bảng MAYBAY
create table MAYBAY
( 
 SOHIEU int not null,
 MALOAI nvarchar(15) not null,
 primary key (SOHIEU, MALOAI)
)

-- Tạo bảng chuyến bay
create table CHUYENBAY
(
 MACB nvarchar(4) not null,
 SBDI nvarchar(3),
 SBDEN nvarchar(3),
 GIODI time,
 GIODEN time,
 primary key (MACB)
)

-- Tạo bảng LICHBAY
create table LICHBAY
(
 NGAYDI datetime NOT NULL,
 MACB nvarchar(4) NOT NULL,
 SOHIEU int,
 MALOAI nvarchar(15),
 primary key (NGAYDI, MACB)
)

-- Tạo bảng DATCHO
create table DATCHO
( 
 MAKH nvarchar(15) not null,
 NGAYDI datetime NOT NULL,
 MACB nvarchar(4),
 primary key(MAKH, NGAYDI, MACB)
)

-- Tạo bảng PHANCONG
create table PHANCONG
(
 MANV nvarchar(15)not null,
 NGAYDI datetime NOT NULL,
 MACB nvarchar(4) NOT NULL,
 primary key (MANV, NGAYDI, MACB)
)


-- Tạo khóa ngoại cho bảng MAYBAY tham chiếu khóa chính của các table khác
 -- tham chiếu đến table LOAIMB
 alter table MAYBAY
 add constraint THUOC
 foreign key(MALOAI)
 references LOAIMB(MALOAI) 

-- Tạo khóa ngoại cho bảng LICHBAY tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MACB của table CHUYENBAY
 alter table LICHBAY
 add constraint BAY
 foreign key (MACB)
 references CHUYENBAY(MACB)
 -- Tham chiếu SOHIEU, MALOAI của table MAYBAY
 alter table LICHBAY
 add constraint DINHDANH
 foreign key(SOHIEU, MALOAI)
 references MAYBAY(SOHIEU, MALOAI)

-- Tạo khóa ngoại cho table DATCHO tham chiếu đến khóa chính của các table khác
 -- Tham chiếu MAKH của table KHACHHANG
 alter table DATCHO
 add constraint DOITUONG
 foreign key (MAKH)
 references KHACHHANG(MAKH)

 -- Tham chiếu NGAYDI VÀ MACB của table LICHBAY
 alter table DATCHO
 add constraint PHUONGTIEN1
 foreign key (NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)
-- Tạo khóa ngoại cho table PHANCONG
 -- Tham chiếu MANV đến table NHANVIEN
 alter table PHANCONG
 add constraint NV
 foreign key (MANV)
 references NHANVIEN(MANV)
 --  Tham chiếu NGAYDI và MACB đến table LICHBAY
 alter table PHANCONG
 add constraint NV2
 foreign key( NGAYDI, MACB)
 references LICHBAY(NGAYDI, MACB)

 
 -- Nhập dữ liệu cho tablE KHACHHANG
 insert into KHACHHANG values ('0009',  'Nga', '223 Nguyen Trai', '8932220')
 insert into KHACHHANG values ('0101',  'Anh', '567 Tran Phu', '8826729')
 insert into KHACHHANG values ('0045',  'Thu', '285 Le Loi', '8932203')
 insert into KHACHHANG values ('0012',  'Ha', '435 Quang Trung', '8933232')
 insert into KHACHHANG values ('0238',  'Hung', '456 Pasteur', '9812101')
 insert into KHACHHANG values ('0397',  'Thanh', '234 Le Van Sy', '8952943')
 insert into KHACHHANG values ('0582',  'Mai', '789 Nguyen Du', null)
 insert into KHACHHANG values ('0934',  'Minh', '678 Le Lai', null)
 insert into KHACHHANG values ('0091',  'Hai', '345 Hung Vuong', '8893223')
 insert into KHACHHANG values ('0314',  'Phuong', '385 Vo Van Tuan', '8232320')
 insert into KHACHHANG values ('0613',  'Vu', '348 CMT8', '8343232')
 insert into KHACHHANG values ('0586',  'Son', '123 Bach Dang', '8556223')
 insert into KHACHHANG values ('0422',  'Tien', '75 Nguyen Thong', '8332222')


 --Nhập dữ liệu cho table CHUYENBAY
 insert into CHUYENBAY values ('100', 'SLC', 'BOS', '08:00','17:59' )
 insert into CHUYENBAY values ('112', 'DCA', 'DEN', '14:00','18:07' )
 insert into CHUYENBAY values ('121', 'STL', 'SLC', '07:00','9:13' )
 insert into CHUYENBAY values ('122', 'STL', 'YYV', '08:30','10:19' )
 insert into CHUYENBAY values ('206', 'DFW', 'STL', '09:00','11:40' )
 insert into CHUYENBAY values ('330', 'JFK', 'YYV', '16:00','18:53' )
 insert into CHUYENBAY values ('334', 'ORD', 'MIA', '12:00','14:14' )
 insert into CHUYENBAY values ('335', 'MIA', 'ORD', '15:00','17:14' )
 insert into CHUYENBAY values ('336', 'ORD', 'MIA', '18:00','20:14' )
 insert into CHUYENBAY values ('337', 'MIA', 'ORD', '20:30','23:53' )
 insert into CHUYENBAY values ('394', 'DFW', 'MIA', '19:00','21:30' )
 insert into CHUYENBAY values ('395', 'MIA', 'DFW', '21:00','23:43' )
 insert into CHUYENBAY values ('449', 'CDG', 'DEN', '10:00','19:29' )
 insert into CHUYENBAY values ('930', 'YYV', 'DCA', '13:00','16:10' )
 insert into CHUYENBAY values ('931', 'DCA', 'YYV', '17:00','18:10' )
 insert into CHUYENBAY values ('932', 'DCA', 'YYV', '18:00','19:10' )
 insert into CHUYENBAY values ('991', 'BOS', 'ORD', '17:00','18:22' )


 -- Nhập dữ liệu cho table LOAIMB
 insert into LOAIMB values  ('A310','Airbus')
 insert into LOAIMB values ('A320', 'Airbus')
 insert into LOAIMB values ('A330', 'Airbus')
 insert into LOAIMB values ('A340', 'Airbus')
 insert into LOAIMB values ('B727', 'Boeing')
 insert into LOAIMB values ('B747', 'Boeing')
 insert into LOAIMB values ('B757', 'Boeing')
 insert into LOAIMB values ('DC10', 'MD')
 insert into LOAIMB values ('DC9', 'MD')
 -- Nhập dữ liệu cho table NHANVIEN

 insert into NHANVIEN values ('1006', 'Chi', '12/6  Nguyen Kiem', '8120022', 150000, 0)
 insert into NHANVIEN values ('1005', 'Giao', '65 Nguyen Thai Son', '8324467', 500000, 0)
 insert into NHANVIEN values ('1001', 'Huong', '8 Dien Bien Phu', '8330733', 500000, 1)
 insert into NHANVIEN values ('1002', 'Phong', '1 Ly Thuong Kiet', '8308117', 150000, 1)
 insert into NHANVIEN values ('1004', 'Phuong', '351 Lac Long Quan', '8308155', 250000, 0)
 insert into NHANVIEN values ('1003', 'Quang', '78 Truong Dinh', '8324461', 350000, 1)
 insert into NHANVIEN values ('1007', 'Tam', '36 Nguyen Van Cu', '8458188', 500000, 0)


 -- Nhập dữ liệu cho table MAYBAY
 insert into MAYBAY VALUES (10, 'B747')
 insert into MAYBAY VALUES (11, 'B727')
 insert into MAYBAY VALUES (13, 'B727')
 insert into MAYBAY VALUES (13, 'B747')
 insert into MAYBAY VALUES (21, 'DC10')
 insert into MAYBAY VALUES (21, 'DC9')
 insert into MAYBAY VALUES (22, 'B757')
 insert into MAYBAY VALUES (22, 'DC9')
 insert into MAYBAY VALUES (23, 'DC9')
 insert into MAYBAY VALUES (24, 'DC9')
 insert into MAYBAY VALUES (70, 'A310')
 insert into MAYBAY VALUES (80, 'A310')
 insert into MAYBAY VALUES (93, 'B757')
 

 -- Nhập dữ liệu cho table LICHBAY 

 insert into LICHBAY values ('11/01/2000', '100', 80, 'A310')
 insert into LICHBAY values ('11/01/2000', '112', 21, 'DC10')
 insert into LICHBAY values ('11/01/2000', '206', 22, 'DC9')
 insert into LICHBAY values ('11/01/2000', '334', 10, 'B747')
 insert into LICHBAY values ('11/01/2000', '395', 23, 'DC9')
 insert into LICHBAY values ('11/01/2000', '991', 22, 'B757')
 insert into LICHBAY values ('11/01/2000', '337', 10, 'B747')
 insert into LICHBAY values ('10/31/2000', '100', 11, 'B727')
 insert into LICHBAY values ('10/31/2000', '112', 11, 'B727')
 insert into LICHBAY values ('10/31/2000', '206', 13, 'B727')
 insert into LICHBAY values ('10/31/2000', '334', 10, 'B747')
 insert into LICHBAY values ('10/31/2000', '335', 10, 'B747')
 insert into LICHBAY values ('10/31/2000', '337', 24, 'DC9')
 insert into LICHBAY values ('10/31/2000', '449', 70, 'A310')


 -- Nhập dữ liệu cho table DATCHO
 insert  into DATCHO values ('0009', '11/01/2000', 100)
 insert  into DATCHO values ('0009', '10/31/2000', 449)
 insert  into DATCHO values ('0045', '11/01/2000', 991)
 insert  into DATCHO values ('0012', '10/31/2000', 206)
 insert  into DATCHO values ('0238', '10/31/2000', 334)
 insert  into DATCHO values ('0582', '11/01/2000', 991)
 insert  into DATCHO values ('0091', '11/01/2000', 100)
 insert  into DATCHO values ('0314', '10/31/2000', 449)
 insert  into DATCHO values ('0613', '11/01/2000', 100)
 insert  into DATCHO values ('0586', '11/01/2000', 991)
 insert  into DATCHO values ('0586', '10/31/2000', 100)
 insert  into DATCHO values ('0422', '10/31/2000', 449)
 
 
 -- Nhập dữ liệu cho table PHANCONG
 insert into PHANCONG  values ('1001', '11/01/2000', '100')
 insert into PHANCONG  values ('1001', '10/31/2000', '100')
 insert into PHANCONG  values ('1002', '11/01/2000', '100')
 insert into PHANCONG  values ('1002', '10/31/2000', '100')
 insert into PHANCONG  values ('1003', '10/31/2000', '100')
 insert into PHANCONG  values ('1003', '10/31/2000', '337')
 insert into PHANCONG  values ('1004', '10/31/2000', '100')
 insert into PHANCONG  values ('1004', '10/31/2000', '337')
 insert into PHANCONG  values ('1005', '10/31/2000', '337')
 insert into PHANCONG  values ('1006', '11/01/2000', '991')
 insert into PHANCONG  values ('1006', '10/31/2000', '337')
 insert into PHANCONG  values ('1007', '11/01/2000', '112')
 insert into PHANCONG  values ('1007', '11/01/2000', '991')
 insert into PHANCONG  values ('1007', '10/31/2000', '206')
---------------------------------------------------
-------PROC------------
-- 1. In ra danh sách tất cả các nhân viên là phi công 
create proc sp_dsnv
as
begin
	select * from NHANVIEN
	where LOAINV = 1
end
exec sp_dsnv
-- 2. In ra danh sách tất cả các chuyến bay đã bay và sân bay đến đến với tham số truyền vào là ngày đi
create proc sp_lichBay @ngaydi datetime
as
begin
	select lb.MACB,SOHIEU,MALOAI, sbden
	from CHUYENBAY cb, LICHBAY lb
	where lb.MACB=cb.MACB and NGAYDI = @ngaydi
end
exec sp_lichBay '2000-10-31'
-- 3. Viết thủ tục xóa 1 nhân viên 
-- "Khong phai la phi cong" chưa được phân công lịch bay có tham số truyền vào là mã nhân viên
create proc sp_xoaNV0 @manv varchar(10)
as
if exists ( select * from NHANVIEN where MANV = @manv and LOAINV=0)
begin
	if exists ( select distinct nhanvien.MANV from NHANVIEN, PHANCONG where NHANVIEN.MANV=PHANCONG.MANV 
													and LOAINV = 0 and nhanvien.MANV = @manv)
		begin
	Print N'Không thể xóa vì tồn tại ràng buộc khóa ngoại' return 0
		end
	else
		delete from NHANVIEN where  LOAINV=0 and MANV=@manv
		Print N'Đã xóa nhân viên có mã' + @manv	
	end
else 
	begin
		Print N'Không có nhân viên có mã ' +@manv +N' hoặc nhân viên này là phi công'return 0
	end
exec sp_xoaNV0 '1001'
-- 4 Thủ tục nhập sđt cho khách hàng đã mua vé
create proc sp_sdt_muaVe @Makh varchar(10), @ten nvarchar(50), @Dt varchar(12)
as
if not exists ( select kh.Makh from KHACHHANG kh,DATCHO dc where kh.MAKH=dc.MAKH and kh.MAKH = @Makh )
	begin
		Print N' Không có khách hàng này  ' + @makh
	end
if exists ( select * from KHACHHANG kh, DATCHO dc where kh.MAKH=dc.MAKH and DTHOAI is not null  )
	begin 
		Print N' Khách hàng này đã có đầy đủ thông tin'
	end
else
	begin
		insert into KHACHHANG(MAKH,TEN,DTHOAI)
		Values(@Makh,@ten,@Dt)
		Print N'Đã nhập thành công'
	end
exec sp_sdt_muaVe '0009','Nga','232323'
-- 5 nhập vào mã loại xuất ra hãng sản xuất máy bay đã bay
create proc sp_hsxmb @maloai varchar(10)
as
begin
if (@maloai = 'A310' or  @maloai= 'A320' or @maloai = 'A330' or @maloai = 'A340')
	begin
		select * from LOAIMB where MALOAI=@maloai
	end
if (@maloai = 'B727' or @maloai = 'B747' or @maloai = 'B757')
	begin
		select * from LOAIMB where MALOAI=@maloai		
	end
if (@maloai = 'DC9' or @maloai = 'DC10')
	begin
		select * from LOAIMB where MALOAI=@maloai	
	end
else
	begin
		Print N'Không máy bay nào có mã này  ' +@maloai
	end
end
exec sp_hsxmb 'B747'
---------------------------------------------------------------------------------
--------------FUNCTION------------------------------------------------------------
--1 Viết hàm hiển thị sân bay mà chuyến bay đó bay đến
create function f_ttcb(@macb varchar(10))
returns nvarchar(50)
as
begin
	declare @sbden nvarchar(50)
	select @sbden = SBDEN from CHUYENBAY
	where MACB=@macb
	return @sbden
end
select dbo.f_dskh('100')
select * from CHUYENBAY
-- 2 Viết hàm hiển thị tất cả thông tin của chuyến bay
create function f_tatCaCb()
returns table
as
	return (select * from CHUYENBAY)
select * from dbo.f_tatCaCb()
--3 Viết hàm tính lương + Thưởng nv công thức: tổng lương *(10/ số chuyến đã bay)
create function f_luongThuong_nv(@manv varchar(10))
returns int
as
begin
	return (select (sum(luong)*(10/COUNT(PHANCONG.MACB))) N'Thực Lãnh' from PHANCONG, NHANVIEN, LICHBAY 
where LICHBAY.MACB=PHANCONG.MACB and  PHANCONG.MANV=NHANVIEN.MANV and nhanvien.manv = @manv and PHANCONG.NGAYDI=LICHBAY.ngaydi)
end
select dbo.f_luongThuong_nv('1004')
-- 4 Dùng hàm vừa viết để tính lương thực lãnh của nhân viên (multil table) đã bay
alter function f_multilLuong(@manv varchar(10))
returns @luong table(manv varchar(10),ten varchar(20), dchi varchar(50), luongthuong int)
as
begin
	Insert into @luong
	select distinct nv.MANV,TEN,DCHI,dbo.f_luongThuong_nv(@manv) from nhanvien nv, PHANCONG pc,LICHBAY lb
	where nv.MANV=pc.MANV and pc.MACB=lb.MACB and pc.NGAYDI=lb.NGAYDI and nv.MANV=@manv
	return
end
select * from dbo.f_multilLuong('1004')
-- 5 viết hàm xếp loại lương nhân viên
alter function f_xepLuong(@luong int)
returns nvarchar(50)
as
begin
	declare @tinhluong nvarchar(50)
	select @tinhluong = case 
		when @luong <= 500000 then N'Cao'
		when @luong < 500000 and @luong >150000 then N'Trung Bình'
		else N'Thấp'
		end
	return @tinhluong
end
select dbo.f_xepLuong(100000)
----------------------------------------------------------------------------------------------------
------------------View-----------------------------------
select * from LOAIMB
--1 cho biết thông tin của chuyến bay
create view v_ttCb
as
	select * from CHUYENBAY
select * from v_ttCb
--2 Cho biết sân bay nào đã có tất cả các loại máy bay của hãng “Boeing” xuất phát.
create view v_sbBoeing
as
	select count(l.MALOAI) N'Loai mb của hãng Boeing',HANGSX,SBDI from LOAIMB l, MAYBAY m, CHUYENBAY c, LICHBAY lb
	where l.MALOAI=m.MALOAI and m.SOHIEU=lb.SOHIEU and lb.MACB=c.MACB and HANGSX = 'Boeing'
	group by SBDI, HANGSX
	having count(l.maloai) = (select count(MALOAI) from LOAIMB where HANGSX = 'Boeing')
select * from v_sbBoeing	
--3 Cho biết lương cơ bản của nhân viên cao thứ 3
create view v_luong3
as
	select max(luong) N'Lương cao thứ 3'
	from NHANVIEN
	where luong < (select max(luong) from NHANVIEN where luong < (select max(luong) from NHANVIEN))
	select * from v_luong3
--4 Cho biết tên nhân viên (không phải là phi công) 
--được phân công bay vào tất cả các chuyến bay có mã 100.
create view v_cb100
as
	select ten, count(MACB) N'Nhân viên bay tất cả chuyến bay mã 100' from NHANVIEN nv, PHANCONG pc 
	where nv.MANV=pc.MANV and LOAINV = 0 
	group by TEN
	having count(macb) = (select distinct count(MACB) from PHANCONG where MACB = '100')
	select * from v_cb100
-- 5. Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng “Boeing”.\
create view v_tatcaCB
as
	select lb.MACB, count(distinct lmb.maloai) as N'Chuyến bay tất cả mb của Boeing'
	from MAYBAY mb,LICHBAY lb, LOAIMB lmb
	where lmb.MALOAI=mb.MALOAI and mb.SOHIEU=lb.SOHIEU and HANGSX='Boeing'
	group by lb.MACB
	having count(distinct lmb.maloai) = (select count(distinct maloai)
												from LOAIMB where HANGSX='Boeing')
select * from v_tatcaCB
-------------------------------------------------------------------------------
----------------Trigger-----------------------------------------------------
--1 Update sdt khách hàng (số cũ + số mới)
create trigger tg_up_sdt
on khachhang
after update
as
	begin
		select i.makh, d.DTHOAI as N'Số cũ', i.DTHOAI as N'Số mới' from deleted d, inserted i
	end
update KHACHHANG set DTHOAI = 97979797 where MAKH ='0009'
--2 Mỗi chuyến bay phải có ít nhất 3 nhân viên
create trigger tg_3nv
on lichbay
after insert
as
	begin
		declare @nv int
		set @nv = (select count(manv) from PHANCONG p, inserted i where p.MACB=i.MACB)
		if @nv < 3
		rollback tran
		else
		Print N'OK'
	end
--3 khi thêm mới nhân viên kiểm tra tên có trùng không rồi mới được thêm
create trigger tg_chkName
on nhanvien
instead of insert
as
	begin
		if exists (select * from inserted i, NHANVIEN nv where i.ten=nv.TEN)
			Print N'Đã tồn tại'
		else
		insert into NHANVIEN select * from inserted
	end
--4 Xóa 1 loại máy bay thì xóa luôn thông tin liên quan đến máy bay đó
create trigger tg_delete_mb
on loaimb
after delete
as
	begin
		delete from MAYBAY where SOHIEU in (select sohieu from deleted d, MAYBAY m where m.MALOAI=d.MALOAI)
	end
--5 Cập nhật số lượng khách hàng khi có sửa đổi
create trigger tg_count_kh
on khachhang
after update
as
	begin
		select count(makh) N'Số lượng khách hàng hiện tại' from KHACHHANG
	end
