--1. Liệt kê danh sách nhân viên làm Sales Manager. Thông tin hiển thị gồm:
--TenNV, MaPhong, trong đó tên nhân viên được sắp xếp theo thứ tự alphabe.
SELECT nv.HO, nv.TEN, nv.MAPHONG
FROM NHANVIEN nv
INNER JOIN CONGVIEC cv
	ON cv.MACV = nv.MACV
WHERE cv.TENCV = 'Sales Manager'
ORDER BY nv.TEN ASC;


--2. Liệt kê tên và lương của những nhân viên có lương thấp hơn 5000 hoặc lớn
--hơn 12000.
SELECT nv.HO, nv.TEN, nv.MUCLUONG
FROM NHANVIEN nv
WHERE nv.MUCLUONG < 5000 OR nv.MUCLUONG> 12000;


--3. Cho biết thông tin tên nhân viên (TenNV), mã công việc (MaCV), ngày
--thuê (NgayVaoLam) của những nhân viên được thuê từ ngày 20/02/1998
--đến ngày 1/05/1998.
SELECT nv.TEN AS 'TEN NHAN VIEN', nv.MACV AS 'MA CONG VIEC', nv.NGAY_KY_HD AS 'NGAY VAO LAM'
FROM NHANVIEN nv
WHERE nv.NGAY_KY_HD BETWEEN '1998-02-20 00:00:00' AND '1998-05-01 23:59:59' 


--4. Liệt kê danh sách nhân viên được thuê năm 1994.

SELECT *
FROM NHANVIEN nv
WHERE YEAR(nv.NGAY_KY_HD) = 1994


--5. Liệt kê tên nhân viên (TenNV), mã công việc (MaCV) của những nhân viên
--không có người quản lý.
SELECT nv.TEN AS 'TEN NHAN VIEN', nv.MACV AS 'MA CONG VIEC'
FROM NHANVIEN nv
WHERE nv.MAQUANLY IS NULL;


--6. Cho biết thông tin tất cả nhân viên được hưởng hoa hồng (MucHoaHong).
SELECT *
FROM NHANVIEN nv
WHERE nv.MUCHOAHONG IS NOT NULL;


--7. Liệt kê danh sách nhân viên mà có kí tự thứ 3 trong tên là “a”.
SELECT *
FROM NHANVIEN nv
WHERE nv.TEN LIKE '__a%';



--8. Liệt kê danh sách nhân viên mà trong tên có chứa một chữ “a” và một chữ “e”.
SELECT *
FROM NHANVIEN nv
WHERE nv.TEN LIKE '%a%' AND  nv.TEN LIKE '%e%';


--9. Liệt kê danh sách các nhân viên với 4 thuộc tính sau:
--Mã nhân viên Tên Nhân Viên Mã phòng Nhóm 1
--Trong đó, những nhân viên nào được thuê trước năm 1994 thì thuộc nhóm 1, còn lại thuộc nhóm 2.
SELECT nv.MANV AS 'MA NHAN VIEN', nv.TEN AS 'TEN NHAN VIEN', nv.MAPHONG AS 'MA PHONG', nv.NGAY_KY_HD,
	CASE
		WHEN YEAR(nv.NGAY_KY_HD) < 1994 
			THEN 'NHOM 1'
		ELSE 'NHOM 2'
	END AS 'NHOM'
FROM NHANVIEN nv;



--10. Liệt kê 5 nhân viên vào làm lâu năm nhất trong công ty. Thông tin thể hiện:
--Mã nhân viên, Họ và Tên Nhân Viên, Năm vào làm, Số năm kinh nghiệm
SELECT TOP 5 
	nv.MANV AS 'Mã nhân viên', nv.HO + ' ' + nv.TEN AS 'Họ và Tên',
	YEAR(nv.NGAY_KY_HD) AS 'Năm vào làm' , 
	YEAR(GETDATE()) - YEAR(nv.NGAY_KY_HD) AS 'Số năm kinh nghiệm'
FROM NHANVIEN nv
ORDER BY nv.NGAY_KY_HD ASC;


--11. Liệt kê danh sách nhân viên được thuê sau nhân viên King.
SELECT *
FROM NHANVIEN NV
WHERE NV.NGAY_KY_HD > (
	SELECT NGAY_KY_HD
	FROM NHANVIEN N
	WHERE N.TEN = 'KING'
);

--12. Liệt kê tên và mức lương của những nhân viên làm cùng phòng với nhân viên King.
SELECT NV.TEN, NV.MUCLUONG, NV.MACV
FROM NHANVIEN NV
WHERE NV.MAPHONG = (
			SELECT N.MAPHONG
			FROM NHANVIEN N
			WHERE N.TEN = 'KING'
		);


--13. Liệt kê danh sách nhân viên có người quản lý tên King.
SELECT NV.*
FROM NHANVIEN NV
WHERE NV.MAQUANLY = (
			SELECT MANV
			FROM NHANVIEN N
			WHERE N.TEN = 'KING'
		);



--14. Tính mức lương trung bình của các nhân viên làm cho phòng IT.
SELECT  AVG(nv.MUCLUONG) AS 'Lương trung bình'
FROM NHANVIEN nv
INNER JOIN PHONGBAN P
	ON P.MAPHONG = nv.MAPHONG
WHERE P.TENPHONG LIKE 'IT';

--15. Tính mức lương trung bình của từng phòng.
SELECT P.TENPHONG , AVG(nv.MUCLUONG) AS 'Lương trung bình'
FROM NHANVIEN nv
INNER JOIN PHONGBAN P
	ON P.MAPHONG = nv.MAPHONG
GROUP BY P.TENPHONG;

--16. Tìm nhân viên có mức lương cao nhất phòng IT
SELECT TOP 1 nv.*, P.TENPHONG
FROM NHANVIEN nv
INNER JOIN PHONGBAN P
	ON P.MAPHONG = nv.MAPHONG
WHERE P.TENPHONG LIKE 'IT'
ORDER BY nv.MUCLUONG;


--17. Liệt kê danh sách mã phòng ban, tên phòng ban có ít hơn 3 nhân viên.
SELECT COUNT(NV.MANV) as SOLUONGNV, PB.MAPHONG,  PB.TENPHONG
FROM NHANVIEN NV, PHONGBAN PB 
WHERE  NV.MAPHONG = PB.MAPHONG
GROUP BY PB.MAPHONG, PB.TENPHONG
HAVING COUNT(NV.MANV)< 3
		

--18. Cho biết phòng nào có đông nhân viên nhất, phòng nào có ít nhân viên nhất.

SELECT * 
	FROM (
		SELECT TOP 1 COUNT(NV.MANV) AS SOLUONGNV, NV.MAPHONG
		FROM NHANVIEN NV
		GROUP BY NV.MAPHONG
		ORDER BY COUNT(NV.MANV)
	) A
	UNION
	SELECT * 
	FROM (
		SELECT TOP 1 COUNT(NV.MANV) AS SOLUONGNV, NV.MAPHONG
		FROM NHANVIEN NV
		GROUP BY NV.MAPHONG
		ORDER BY COUNT(NV.MANV)	DESC
	) B
	
SELECT * 
FROM (
	SELECT TOP 1 COUNT(NV.MANV) AS SOLUONGNVMIN, NV.MAPHONG AS MAPHONGMIN
	FROM NHANVIEN NV
	GROUP BY NV.MAPHONG
	ORDER BY COUNT(NV.MANV) 
) A,
(
	SELECT TOP 1 COUNT(NV.MANV) AS SOLUONGNVMAX, NV.MAPHONG AS MAPHONGMAX
	FROM NHANVIEN NV
	GROUP BY NV.MAPHONG
	ORDER BY COUNT(NV.MANV)	DESC
) B

--19. Liệt kê danh sách nhân viên có mức lương thấp hơn mức lương trung bình của phòng ban mà nhân viên đó làm việc.
SELECT NV.*, A.MUCLUONGTB
FROM NHANVIEN NV
INNER JOIN (
				SELECT AVG(MUCLUONG) AS MUCLUONGTB,  N.MAPHONG
				FROM NHANVIEN N
				GROUP BY N.MAPHONG
			) A 
ON A.MAPHONG = NV.MAPHONG
WHERE NV.MUCLUONG <A.MUCLUONGTB;

--20. Liệt kê thông tin 3 nhân viên có lương cao nhất.
SELECT TOP 3 *
FROM NHANVIEN nv
ORDER BY nv.MUCLUONG;


--21. Tìm những phòng ban có mức lương trung bình lớn hơn phòng IT.
SELECT P.TENPHONG, AVG(nv.MUCLUONG) AS  'Lương trung bình'
FROM NHANVIEN nv
INNER JOIN PHONGBAN P
	ON P.MAPHONG = nv.MAPHONG
GROUP BY P.TENPHONG
HAVING 'Lương trung bình'  > (
	SELECT AVG(nv.MUCLUONG) AS  'Lương trung bình'
	FROM NHANVIEN nv
	INNER JOIN PHONGBAN P
		ON P.MAPHONG = nv.MAPHONG
	WHERE P.TENPHONG LIKE 'IT'
	GROUP BY P.TENPHONG
);
--22. Liệt kê danh sách những nhân viên được thuê vào làm trước người quản lý của họ
SELECT NV.TEN AS TENNV, NV.NGAY_KY_HD, QL.MANV AS MAQUANLY, QL.TEN AS TENQUANLY, QL.NGAY_KY_HD AS NGAY_KY_HD_QL
FROM NHANVIEN NV
INNER JOIN (
			SELECT *
			FROM NHANVIEN N
		) QL  
ON NV.MAQUANLY = QL.MANV
WHERE NV.NGAY_KY_HD < QL.NGAY_KY_HD;


--2. Viết khối lệnh hiển thị số nhân viên của phòng IT, nếu số nhân viên nhiều hơn 15 nhân viên thì hiện thông báo “số lượng nhân viên quá đông”
DECLARE @SONV INT 

SELECT @SONV = COUNT(MANV) 
FROM NHANVIEN NV
WHERE MAPHONG = (
	SELECT P.MAPHONG
	FROM PHONGBAN P
	WHERE P.TENPHONG = 'IT'
)
IF @SONV > 15
	PRINT N'Số lượng nhân viên quá đông'
ELSE  PRINT N'Số lượng nhân viên là ' + CAST(@SONV AS VARCHAR) -- EP KIEU DU LIEU INT => VARCHAR

--3. Viết khối lệnh, kiểm tra xem nhân viên Kelvin đã làm việc cho đề án nào chưa, 
-- nếu chưa thì phân công cho Kelvin đề án: Xây dựng cầu 4002. Thông báo tình trạng thêm thành công hay thất bại.

CREATE PROCEDURE PHANCONGNHANVIEN @TENNV VARCHAR
AS
	DECLARE @CHECK CHAR(6), @MANV CHAR(6), @SODA CHAR(4)= '4002'
	SET @MANV = (SELECT MANV
		FROM NHANVIEN NV
		WHERE HO = 'KEVIN');

	--PRINT @MANV	
		
	SET @CHECK = (SELECT MANV 
		FROM PHANCONG 
		WHERE MANV = (
			SELECT MANV
			FROM NHANVIEN NV
			WHERE HO = 'KEVIN'
		)
	)
	--PRINT @CHECK

	IF @CHECK IS NULL
		BEGIN
			INSERT INTO DUAN (MADUAN,TENDUAN,DIADIEM,PHONG)
			VALUES ('4002', N'Xây dựng cầu','Japan', '60');
			INSERT INTO PHANCONG (MANV, SODA, THOIGIANBD, THOIGIANKT)
			VALUES (@MANV, @SODA, GETDATE(), GETDATE());
		END;
	IF @@ROWCOUNT = 1	
		PRINT N'Thêm thành công'
	ELSE  PRINT  N'Thêm thất bại'


EXEC PHANCONGNHANVIEN  'KELVIN'


--4. Tạo thủ tục lấy tên của một công việc theo một mã công việc cho trước. Xử
--lý ngoại lệ khi không tìm thấy mã công việc.
CREATE PROC LAYTENCONGVIEC @MACV CHAR(10)
AS
IF EXISTS (SELECT TENCV FROM CONGVIEC WHERE MACV = @MACV)
	SELECT TENCV 
	FROM CONGVIEC 
	WHERE MACV = @MACV
ELSE
	PRINT('KHONG TIM THAY CONG VIEC');



EXEC LAYTENCONGVIEC @MACV = 'AD_ACCOUNT'

--5. Tạo thủ tục tìm kiếm những nhân viên đã làm trên 10 năm 
-- mà có số lượng đề án tham gia thấp hơn 1/3 số đề án của công ty. Xử lý ngoại lệ cho các TH lỗi xảy ra.
CREATE PROC XEMTHOIGIANLAMVIECNV
AS
	DECLARE @SOLUONGDEAN INT
	SET @SOLUONGDEAN = SELECT COUNT(MADUAN) FROM DUAN;
	
	DECLARE @DSNHANVIEN TABLE( MANV CHAR(6), TENNV CHAR(20))
	
	
	SELECT N.* FROM GHINHOCONGVIEC G
	INNER JOIN NHANVIEN N
	ON G.MANV = N.MANV
	WHERE YEAR(GETDATE()) - YEAR(G.NGAYBD) + 1 > 10
		AND 
		SELECT MANV, COUNT(MANV)
			FROM PHANCONG P
			INNER JOIN DUAN D ON P.SODA = D.MADUAN
			GROUP BY MANV
			HAVING COUNT(MANV) < (SELECT COUNT(MADUAN) FROM DUAN)
			
			
			
if object_ID ('TimKiemNV') is not null
	DROP PROC TimKiemNV
	
CREATE  PROC TimKiemNV 
AS
	declare @dSNV TABLE(MaNV char(6), TenNV varchar(20));
	declare	@slda int;

begin
	Set @slda = (select COUNT (*) from dbo.DeAn)
	insert @dSNV 
		select n.MANV, TenNV 
		from dbo.NHANVIEN n join dbo.PhanCong p on n.MaNV=p.MaNV
		group by n.MANV, TenNV
		having COUNT(*)<(@slda)
		
	select * from @dSNV
	
end

--6. Viết khối lệnh xử lý sau: Thêm đề án vào bảng Đề án với nội dung: 1102,
--Update server sixth, Administration, IT, 2. Và phân công cho 2 nhân viên
--có mã nhân viên là 144 và 205, với thời gian là ngày hiện tại. Xử lý tình
--huống khi gặp sự cố trong quá trình thực hiện.
if object_ID ('ThemDA') is not null
	DROP PROC ThemDA
	
CREATE  PROC ThemDA 
	 @vMaDA char(6), 
     @vTenDA varchar(20), 
     @vDiaDiem varchar (20), 
     @vPhong char(4)
     --2 bien ma NV
AS
begin
	if Not Exists (select * from dbo.DeAn where MaDA=@vMaDA)
	begin
		insert into DeAn
		values (@vMaDA,@vTenDA,@vDiaDiem,@vPhong)
		if (dbo.KiemTraNV6('144') = 0 and dbo.KiemTraNV6('205')=0)
		begin
			insert into PhanCong(SoDA,MaNV,ThoiGianBD)
			values ('1102', '144', GETDATE()),
					('1102', '205', GETDATE())
		end
	end
	else
		print 'loi'
end

EXEC ThemDA '1102', 'Update server sixth', 'Japan','20'

select maphong
from PhongBan


if object_ID ('KiemTraNV6') is not null
	DROP function KiemTraNV6
--Kiem tra NV
create Function KiemTraNV6(@vMaNV6 char(6)) returns bit -- bit: boolean return 0|1
as	
begin
	declare @vsl bit;
	if (Exists (select COUNT(*) from NHANVIEN where MANV=@vMaNV6))
		set @vsl=0;
	else set @vsl=1;
	return @vsl
end



--7. Viết hàm kiểm tra nhân viên làm việc cho dự án được nhập vào từ người
--yêu cầu. Trả về giá trị True nếu có nhiều hơn 2 NV, ngược lại trả về False.


--8. Viết hàm tìm các đề án do phòng ban phụ trách, tên phòng ban do người
--dùng nhập vào. Danh sách hiển thị tên phòng, tên dự án, và số nhân viên
--làm việc cho từng dự án.


if object_ID ('HamBai8') is not null
	DROP function HamBai8
	
create Function HamBai8(@tenPhong varchar(10)) returns table
as
	return (select p.MaPhong, TenPhong, COUNT(n.MaPhong) as 'SLNV' 
			from dbo.PhongBan p, dbo.NHANVIEN n 
			where n.MaPhong = p.MaPhong and  TenPhong = @tenPhong
			group by p.MaPhong, TenPhong)


select * from HamBai8( 'IT')

--9. Viết hàm hiển thị lương của các nhân viên của phòng ban được nhập vào từ
--ngươi dùng, những nhân viên nào có lương thấp hơn 13000 thì tăng lương lên 10%.

if object_ID ('HamBai9') is not null
	DROP function HamBai9
	
create Function HamBai9(@tenPhong varchar(10)) returns table
as
	return (select MANV,
			CASE 
				WHEN MUCLUONG < 13000 THEN  MUCLUONG*1.1
			ELSE MUCLUONG
				END AS MUCLUONG
			from PHONGBAN p, NHANVIEN n 
			where n.MAPHONG = p.MAPHONG and TENPHONG =@tenPhong
			)


select * from HamBai9( 'IT')

if object_ID ('TangLuong') is not null
	DROP PROC TangLuong
	
CREATE  PROC TangLuong 
AS
begin
	update NHANVIEN
	set MUCLUONG = MUCLUONG*1.1 
	WHERE MANV IN (select MANV from dbo.HamBai9('IT'))
end

exec TangLuong

--10. Viết hàm trả về tên nhân viên, số năm làm việc, số dự án tham gia của
--những nhân viên tham gia cho dự án được nhập vào từ người dùng

if object_ID ('HamBai10') is not null
	DROP function HamBai10
	
create Function HamBai10(@tenDuAn varchar(20)) returns table
as
	return (SELECT TEN, YEAR(GETDATE()) - YEAR(NGAY_KY_HD) AS 'Số năm làm việc', COUNT(N.MANV) AS 'Số dự án tham gia'
			FROM NHANVIEN N
				INNER JOIN PHANCONG P ON P.MANV = P.MANV
				INNER JOIN DUAN D ON D.MADUAN = P.SODA
			WHERE   TENDUAN = @tenDuAn
			GROUP BY TEN, YEAR(GETDATE()) - YEAR(NGAY_KY_HD)
			)


select * from HamBai10( 'cloud 2015')                                                                                                                                                                                                                              





--Lấy tên các ràng buộc
Select  SysObjects.[Name] As [Constraint Name] ,
        Tab.[Name] as [Table Name],
        Col.[Name] As [Column Name]
From SysObjects Inner Join 
	(Select [Name],[ID] From SysObjects) As Tab
	On Tab.[ID] = Sysobjects.[Parent_Obj] 
	Inner Join sysconstraints On sysconstraints.Constid = Sysobjects.[ID] 
	Inner Join SysColumns Col On Col.[ColID] = sysconstraints.[ColID] And Col.[ID] = Tab.[ID]
order by [Tab].[Name]
 
--Lấy tên các Proceduce
SELECT name, 
       type
  FROM dbo.sysobjects
 WHERE (type = 'P')
   
-- ================================================================

--Ràng buộc:
--a. Trong bảng nhân viên, rang buộc mức hoa hồng phải  <1
ALTER TABLE NHANVIEN
ADD CONSTRAINT CHCK_MUCHOAHONG 
CHECK ( MUCHOAHONG < 1)


--b. Trong bảng Công việc, mức lương tối đa phải nhỏ hơn mức lương tối thiểu
ALTER TABLE CONGVIEC
ADD CONSTRAINT CHK_MUCLUONGTOIDA
CHECK (MUCLUONGTOIDA < MUCLUONGTOITHIEU)


--c. Trong bảng Ghi nhớ công việc, NgayBD bé hơn NgayKT
--2. Cập nhật lại mức lương của nhân viên MaNV = 102 là 20000.
--3. Tăng lương cho tất cả nhân viên lên 10% theo mức lương của họ. 


--A. View
--1. Tạo view chứa danh sách phòng ban chưa có nhân viên.
CREATE VIEW PHONGBAN_RONG
AS
	SELECT *
	FROM PHONGBAN P
	WHERE P.MAPHONG NOT IN (SELECT DISTINCT MAPHONG FROM NHANVIEN);
	
SELECT * FROM PHONGBAN_RONG
	
--2. Tạo view chứa mã nhân viên, tên nhân viên, tên phòng, mã công việc, số
--năm làm việc, lương của những nhân viên có mức lương lớn hơn mức
--lương trung bình của công ty.
CREATE VIEW DS_NV
AS
	SELECT N.MANV, N.HO + ' ' + N.TEN AS 'Tên nhân viên', P.TENPHONG, C.MACV,  YEAR(GETDATE()) - YEAR(NGAY_KY_HD) AS 'Số năm làm việc', MUCLUONG
	FROM NHANVIEN N
	INNER JOIN PHONGBAN P ON N.MAPHONG = P.MAPHONG
	INNER JOIN GHINHOCONGVIEC G ON G.MANV = N.MANV
	INNER JOIN CONGVIEC C ON C.MACV = G.MANGHE
	WHERE MUCLUONG > (
		SELECT AVG(MUCLUONG)
		FROM NHANVIEN 
	)

SELECT * FROM DS_NV

--3. Tạo view hiển thi danh sách các nhân viên làm việc cho từng đề án cụ thể,
-- và tình trạng tham gia đề án (đã kết thúc hay đang tham gia), group by theo tên đề án.

CREATE VIEW DS_NV_DEAN
AS
	SELECT D.TENDUAN, N.TEN,
		CASE
			 WHEN NGAY_KY_HD < GETDATE() THEN N'đã kết thúc'
		ELSE N'đang tham gia'
		END AS 'TINHTRANG'
	FROM NHANVIEN N
	INNER JOIN PHANCONG P ON N.MANV = P.MANV
	INNER JOIN DUAN D ON D.MADUAN = P.SODA
	GROUP BY D.TENDUAN, N.TEN, NGAY_KY_HD

SELECT * FROM DS_NV_DEAN