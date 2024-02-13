create table  person(
     PERSONID  int primary key,
	 FÝRSTNAME nvarchar(50),
	 SURNAME nvarchar(50),
	 
)

create table  CATEGORÝES(
     CATEGORYID  int primary key,
	 category nvarchar(50),
)
create table Platforms(
     PLATFORMSID int primary key,
	 PERSONID int foreign key references person(PERSONID),
	 platformdate datetime,
)

create table fILMLER(
     FILMID int primary key,
	 FILMNAME nvarchar(50),
	 PRICE decimal(10,2),
	 filmquantity int,
	 CATEGORYID int foreign key references CATEGORÝES(CATEGORYID), 
)

create table PLATFORMDETAILS(
    PLATFORMDETAILID int primary key,
	CATEGORYID int foreign key references   CATEGORÝES(CATEGORYID),
	PERSONID int foreign key references person(PERSONID),
	FILMID int foreign key references  FILMLER(FILMID),
	Quantity int,
	TotalPrice decimal(10,2),
)

declare @counter int
declare @CATEGORYID int
declare @FILMID int
declare @PLATFORMDETAILID int

set @counter=0 

while @counter < 80000
begin


--kiþi ekle--
INSERT INTO PERSON (PERSONID, FÝRSTNAME, SURNAME)
values(@counter + 1 , 'suleyman'+ CAST(@counter + 1 as nvarchar), 'keskin'+ CAST(@counter + 1 as nvarchar)


--kategori--

insert into CATEGORÝES (CATEGORYID, category)
values(@counter + 1, 'category'+ CAST(@counter + 1 as varchar))


INSERT INTO fILMLER (FILMID, FILMNAME, PRICE, filmquantity, CATEGORYID)
values(@counter +1, 'FILM'+ CAST(@counter + 1 as varchar),RAND() * 200,RAND() * 150, @counter %11 + 1)


INSERT INTO  Platforms (PLATFORMSID, PERSONID, platformdate)
values(@counter + 1, @counter %50 +1, GETDATE())

set @PLATFORMDETAILID = @counter %50 + 1
set @CATEGORYID = @counter %10 + 1
INSERT INTO PLATFORMDETAILS (PLATFORMDETAILID, CATEGORYID, PERSONID, FILMID, Quantity, TotalPrice)
values (@counter +1, @CATEGORYID, @FILMID, RAND()*20, RAND()* 100)
set @counter = @counter +1,


select COUNT(*) from CATEGORÝES
select COUNT(*) from fILMLER
select COUNT(*) from PLATFORMDETAILS
select COUNT(*) from Platforms
select COUNT(*) from person 

alter table person add proviousPlatformsCount int
create procedure updateplatformdetailinformation
  @CATEGORYID int,
  @fILMID int
as
begin
     Update PLATFORMDETAILS
	 set TotalPrice =(select SUM( p.PRÝCE * Quantity) 
	 from PLATFORMDETAILS where PLATFORMDETAILID = @PLATFORMDETAILID)
	 where PLATFORMDETAILID = @PLATFORMDETAILID)

	 update person
	 set proviousPlatformsCount = proviousPlatformsCount +1
	 where PERSONID = @PERSONID
