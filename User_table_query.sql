create table tblusers(
Uid int identity(1,1) primary key not null,
Email nvarchar(100) not null,
Name nvarchar(100) not null,
Password nvarchar(100) not null,
Phoneno nvarchar(10) not null,
DOB date not null,
reg_date timestamp not null
)

create table ForgotPass
(
Id nvarchar(500) not null,
uid int null,
RequestDateTime datetime null,
Constraint [FK_ForgotPass_tblusers] FOREIGN KEY (uid) REFERENCES tblusers (Uid)
);



CREATE TABLE tblBrands(
	BrandID int IDENTITY(1,1) NOT NULL primary key,
	Name nvarchar(500) NULL,
)

CREATE TABLE tblCategory(
	CatID int IDENTITY(1,1) NOT NULL primary key,
	CatName nvarchar(max) NULL,
)

CREATE TABLE tblSubCategory(
	SubCatID int IDENTITY(1,1) NOT NULL primary key,
	SubCatName nvarchar(max) NULL,
	MainCatID int NULL,
CONSTRAINT [FK_tblSubCategory_tblCategory] FOREIGN KEY([MainCatID]) REFERENCES tblCategory ([CatID])
)

create table tblSizes
(
SizeID int identity(1,1) primary key,
SizeName   nvarchar(500),
BrandID int,
CategoryID int,
SubCategoryID int,
Constraint [FK_tblSizes_ToBrand] FOREIGN KEY ([BrandID]) REFERENCES [tblBrands] ([BrandID]),
Constraint [FK_tblSizes_ToCat] FOREIGN KEY ([CategoryID]) REFERENCES [tblCategory] ([CatID]),
Constraint [FK_tblSizes_SubCat] FOREIGN KEY ([SubCategoryID]) REFERENCES [tblSubCategory] ([SubCatID]),
)

create table tblProducts
(
PID int identity(1,1) primary key ,
PName   nvarchar(MAX),
RetailPrice money,
RentPrice money,
SecurityPrice money,
PBrandID int,
PCategoryID int,
PSubCatID int,

PDescription nvarchar(MAX),
PProductDetails nvarchar(MAX),
PMaterialCare  nvarchar(MAX),
FreeDelivery int,
[Availability]  int,
COD int,
Constraint [FK_tblProducts_ToTable] FOREIGN KEY ([PBrandID]) REFERENCES [tblBrands] ([BrandID]),
Constraint [FK_tblProducts_ToTable1] FOREIGN KEY ([PCategoryID]) REFERENCES [tblCategory] ([CatID]),
Constraint [FK_tblProducts_ToTable2] FOREIGN KEY ([PSubCatID]) REFERENCES [tblSubCategory] ([SubCatID]),
)

CREATE TABLE tblProductImages(
	[PIMGID] [int] IDENTITY(1,1) primary key,
	[PID] [int] NULL,
	[Name] [nvarchar](max) NULL,
	[Extention] [nvarchar](500) NULL,
	Constraint [FK_tblProductImages_ToTable] FOREIGN KEY ([PID]) REFERENCES [tblProducts] ([PID])
)

create table tblProductSizeQuantity
(
PrdSizeQuantID int identity(1,1) primary key,
PID int,
SizeID int,
Quantity int,
Constraint [FK_tblProductSizeQuantity_ToTable] FOREIGN KEY ([PID]) REFERENCES [tblProducts] ([PID]),
Constraint [FK_tblProductSizeQuantity_ToTable1] FOREIGN KEY ([SizeID]) REFERENCES [tblSizes] ([SizeID])
)


Create procedure sp_InsertProduct
(
@PName nvarchar(MAX),
@PBrandID int,
@PCategoryID int,
@PSubCatID int,
@PDescription nvarchar(MAX),
@PProductDetails nvarchar(MAX),
@PMaterialCare nvarchar(MAX),
@FreeDelivery int,
@Availability int,
@COD int,
@RetailPrice money,
@RentPrice money,
@SecurityPrice money
)
AS
insert into tblProducts values(@PName,@PBrandID,@PCategoryID,
@PSubCatID,@PDescription,@PProductDetails,@PMaterialCare,@FreeDelivery,
@Availability,@COD,@RetailPrice,@RentPrice,@SecurityPrice) 
select SCOPE_IDENTITY()
Return 0

create procedure procBindAllProducts
AS
select A.*,B.*,C.Name,B.Name as ImageName, C.Name as BrandName from tblProducts A
inner join tblBrands C on C.BrandID =A.PBrandID
cross apply(
select top 1 * from tblProductImages B where B.PID= A.PID order by B.PID desc
)B
order by A.PID desc

Return 0

CREATE TABLE tblCart(
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[UID] [int] NULL,
	[PID] [int] NULL,
	[PName] [nvarchar](max) NULL,
	[RentPrice] [money] NULL,
	[SecurityPrice] [money] NULL,
	[SubPAmount]  AS ([RentPrice]*[Qty]),
	[SubSAmount]  AS ([RentPrice]*[Qty]*Totaldays),
	[SubTAmount]  AS (([RentPrice]*[Qty]*Totaldays)+([SecurityPrice]*[Qty])),
	[Qty] [int] NULL,
	DeliveryDate date Null,
	ReturnDate date Null,
	Totaldays int NULL
)

ALTER TABLE tblOrders
add SecurityAmount money;

create PROCEDURE SP_BindCartNumberz
(
@UserID int
)
AS
SELECT * FROM tblCart D CROSS APPLY ( SELECT TOP 1 E.Name,Extention FROM tblProductImages E WHERE E.PID = D.PID) Name where D.UID = @UserID

CREATE PROCEDURE SP_BindProductDetails
(
@PID int
)
AS
SELECT * FROM tblProducts where PID = @PID

CREATE PROCEDURE SP_InsertCart
(
@UID int,
@PID int,
@PName nvarchar(MAX),
@RentPrice money,
@SecurityPrice money,
@Qty int,
@DeliveryDate date,
@ReturnDate date,
@Totaldays int
)
AS
INSERT INTO tblCart VALUES(@UID,@PID,@PName,@RentPrice,@SecurityPrice,@Qty,@DeliveryDate,@ReturnDate,@Totaldays)
SELECT SCOPE_IDENTITY()

CREATE PROCEDURE SP_IsProductExistInCart
(
@PID int,
@UserID int
)
AS
SELECT * FROM tblCart where PID = @PID and UID = @UserID

CREATE PROCEDURE SP_UpdateCart
(
@UserID int,
@CartPID int,
@Quantity int,
@DeliveryDate date,
@ReturnDate date,
@Totaldays int
)
AS
BEGIN
SET NOCOUNT ON;
UPDATE tblCart SET Qty = @Quantity,DeliveryDate = @DeliveryDate,ReturnDate = @ReturnDate,
Totaldays=@Totaldays  WHERE PID = @CartPID AND UID = @UserID
END

go

CREATE PROCEDURE SP_InsertCart
(
@UID int,
@PID int,
@PName nvarchar(MAX),
@RentPrice money,
@SecurityPrice money,
@Qty int,
@DeliveryDate date,
@ReturnDate date,
@Totaldays int
)
AS
INSERT INTO tblCart VALUES(@UID,@PID,@PName,@RentPrice,@SecurityPrice,@Qty,@DeliveryDate,@ReturnDate,@Totaldays)
SELECT SCOPE_IDENTITY()

create PROCEDURE SP_BindUserCart
(
@UserID int
)
AS
SELECT * FROM tblCart D CROSS APPLY ( SELECT TOP 1 E.Name,Extention FROM tblProductImages E WHERE E.PID = D.PID) Name WHERE D.UID = @UserID


CREATE PROCEDURE SP_getUserCartItem
(
@PID int,
@UserID int
)
AS
SELECT * FROM tblCart WHERE PID = @PID AND UID = @UserID

CREATE PROCEDURE SP_DeleteThisCartItem
@CartID int
AS
BEGIN
DELETE FROM tblCart WHERE CartID = @CartID
END

CREATE TABLE tblOrderProducts(
	[OrderProID] [int] IDENTITY(1,1) NOT NULL primary key,
	[OrderID] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[PID] [int] NULL,
	[Products] [nvarchar](max) NULL,
	[Quantity] [int] NULL,
	[OrderDate] [datetime] NULL,
	[Status] [nvarchar](100) NULL,
Constraint [FK_tblOrderProducts_ToTable] FOREIGN KEY ([UserID]) REFERENCES [tblUsers] ([uid])
)

CREATE TABLE tblOrders(
	[OrderID] [int] IDENTITY(1,1) NOT NULL primary key,
	[UserID] [int] NULL,
	[EMail] [nvarchar](max) NULL,
	[CartAmount] [money] NULL,
	[CartDiscount] [money] NULL,
	[TotalPaid] [money] NULL,
	[PaymentType] [nvarchar](50) NULL,
	[PaymentStatus] [nvarchar](50) NULL,
	[DateOfPurchase] [datetime] NULL,
	[Name] [nvarchar](200) NULL,
	[Address] [nvarchar](max) NULL,
	[MobileNumber] [nvarchar](50) NULL,
	[OrderStatus] [nvarchar](50) NULL,
	[OrderNumber] [nvarchar](50) NULL,
	Constraint [FK_tblOrders_ToTable] FOREIGN KEY ([UserID]) REFERENCES [tblUsers] ([uid])
)

create table tblPurchase
(
PurchaseID int identity(1,1) primary key,
UserID int,
PIDSizeID nvarchar(MAX),
CartAmount money,
CartDiscount money,
TotalPayed money,
PaymentType nvarchar(50),
PaymentStatus nvarchar(50),
DateOfPurchase datetime,
Name nvarchar(200),
Address nvarchar(MAX),
PinCode nvarchar(10),
MobileNumber nvarchar(50),
CONSTRAINT [FK_tblPurchase_ToUser] FOREIGN KEY ([UserID]) REFERENCES [tblUsers]([UID])

)

CREATE PROCEDURE SP_UpdateCart1
(
@UserID int,
@CartPID int,
@Quantity int
)
AS
BEGIN
SET NOCOUNT ON;
UPDATE tblCart SET Qty = @Quantity WHERE PID = @CartPID AND UID = @UserID
END

go

CREATE PROCEDURE SP_BindPriceData
(
@UserID int
)
AS
SELECT * FROM tblCart D CROSS APPLY ( SELECT TOP 1 E.Name,Extention FROM tblProductImages E WHERE E.PID = D.PID) Name where D.UID = @UserID


CREATE PROCEDURE SP_FindOrderNumber 
@FindOrderNumber nvarchar(100)
AS
SELECT * FROM tblOrders WHERE OrderNumber = @FindOrderNumber

create PROCEDURE SP_BindCartProducts
(
@UID int
)
AS
SELECT PID FROM tblCart WHERE UID = @UID

create PROCEDURE SP_BindCartProducts
(
@UID int
)
AS
SELECT PID FROM tblCart WHERE UID = @UID

CREATE PROCEDURE SP_InsertOrder
(
@UserID int,
@Email nvarchar(MAX),
@CartAmount money,
@TotalPaid money,
@PaymentType nvarchar(50),
@PaymentStatus nvarchar(50),
@DateOfPurchase datetime,
@Name nvarchar(200),
@Address nvarchar(MAX),
@MobileNumber nvarchar(50),
@OrderStatus nvarchar(50),
@OrderNumber nvarchar(50),
@SecurityAmount money
)
AS
INSERT INTO tblOrders VALUES(@UserID,@Email,@CartAmount,@TotalPaid,@PaymentType,@PaymentStatus,@DateOfPurchase,@Name,@Address,@MobileNumber,@OrderStatus,@OrderNumber,@SecurityAmount)
SELECT SCOPE_IDENTITY()

CREATE PROCEDURE SP_InsertOrderProducts
(
@OrderID nvarchar(50),
@UserID int,
@PID int,
@Products nvarchar(MAX),
@Quantity int,
@OrderDate datetime,
@Status nvarchar(100)
)
AS
INSERT INTO tblOrderProducts VALUES (@OrderID,@UserID,@PID,@Products,@Quantity,@OrderDate,@Status)
SELECT SCOPE_IDENTITY()

CREATE PROCEDURE SP_EmptyCart
@UserID int
AS
BEGIN
DELETE FROM tblCart WHERE UID = @UserID
END


use RetroRentalsDB;
select t1.OrderDate,t1.OrderID,t3.Name,t2.PName,t1.Quantity as QtySell,t4.Quantity as StockOpening,t4.Quantity-t1.Quantity as Available  from tblOrderProducts as t1 inner join tblProducts as t2 on t2.PID=t1.PID inner join tblUsers as t3 on t3.Uid=t1.UserID inner join tblProductSizeQuantity as t4 on t4.PID=t1.PID where t1.Status = 'Placed' order by t1.OrderDate;
update tblProducts set Availability=0 where PID=1;