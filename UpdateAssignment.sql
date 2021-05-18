-- Database: DepartmentStore

-- DROP DATABASE "DepartmentStore";

CREATE DATABASE "DepartmentStore"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	
create table Address(
	AddressId serial primary key,
	AddressLine1 varchar(50) not null,
	AddressLine2 varchar(50),
	PostalCode varchar(8) not null,
	City varchar(20) not null,
	Country varchar(30) not null
	
);
insert into Address(AddressLine1,AddressLine2,PostalCode,City,Country)
values('Khetan Colony','A-1','332025','Sikar','India'),
('Adani Colony','B-1','312121','Jaipur','India'),
('Ambani Colony','C-1','3302020','Alwar','India'),
('Shanti Vihar','RN-49','111421','Noida','India'),
('Gandhi','RN-09','203947','Delhi','India');

create table StaffRole(
	StaffRoleId serial Primary Key,
	RoleName varchar(20) not null,
	Description varchar(100) not null
);

insert into StaffRole(RoleName,Description)
values('Manager','manage store'),
('Cashier','Cash Counter'),
('CSR','Representative'),
('ICS','Inventory Mange'),
('Cashier','Bill Counter');

create table Staff(
	StffId Serial Primary Key,
	FirstName varchar(20) not nULL,
	LastName varchar(20) not null,
	StaffRoleId int not null unique references StaffRole(StaffRoleId),
	BirthDate Date not null,
	PhoneNumber varchar(10) not null,
	AddressId int not null unique references Address(AddressId),
	Salary numeric(8,2) not null
);
insert into Staff(FirstName,LastName,StaffRoleId,BirthDate,PhoneNumber,AddressId,Salary)
values('Sandeep','Kumawat',1,'1996-07-07','9887729448',1,30000),
('Pradeep','Kumawat',2,'1998-09-15','1232344456',2,20000),
('Ritik','Sharma',3,'1999-05-05','1234543210',3,20000),
('Palak','Madan',4,'1997-06-06','9876543210',4,15000),
('Divya','Talvar',5,'1995-01-01','2345467808',5,18000);

create table Category(
	CategoryId Serial Primary Key,
	CategoryName varchar(30) not null,
	CategoryCode varchar(5) not null,
	Description varchar(100)
);

insert into Category(CategoryName,CategoryCode,Description)
values('Shopping Goods','Shop','Shopping Goods'),
('Convenience Goods','Conv','Convenience Goods'),('Specialty Goods','Spec','Specialty Goods'),
('Unsought Goods','Unso','Unsought Goods'),('Luxury Goods','Luxu','Luxury Goods'),
('Technical Goods','Tech','Technical Goods');


create table Supplier(
	SupplierId Serial primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	AddressId int not null unique references Address(AddressId),
	Phone varchar(10) not null,
	Email varchar(20) not null
);
insert into supplier(FirstName,LastName,AddressId,Phone,Email)
values ('Rohan','Gupta',1,'122345565','rohan@gmail.com'),
('Vikas','Kumar',2,'23243456','vikas@gmail.com'),
('Gopal','Sharma',3,'9999877644','gopal@gmail.com'),
('Gaurav','Pandey',4,'564757458','gaurav@gmail.com'),
('Abhi','Khurana',5,'9876544334','abhi@gmail.com');

create table Product(
	ProductId Serial Primary key,
	ProductName varchar(30) not null,
	SupplierId int references Supplier(SupplierId),
	CategoryId int references Category(CategoryId),
	ProductCode varchar(5) not null,
	CurrentQuantity int not null
);
insert into product(ProductName,SupplierId,CategoryId,ProductCode,CurrentQuantity)
values('Laptop',1,5,'lap',2),
('Mobile',3,5,'Pho',10),
('Pen',4,2,'Pen',30),
('Bottle',2,1,'Bot',15),
('Watch',5,3,'Wat',5),
('Shoes',2,2,'Sho',3),
('Ball',5,6,'Bal',10);

 create table ProductCategory(
	 ProductId int references Product(ProductId),
	 CategoryId int references Category(CategoryId),
	 primary key(CategoryId,ProductId)
 );
 insert into ProductCategory(ProductId,CategoryId)
 values(1,1),(1,2),(2,4),(2,5),(3,4),(4,1),(5,3),(5,5);
 
 
create table Inventory(
	InventoryId int not null unique references Product(ProductId),
	Quantity int not null,
	instocks boolean
);
insert into inventory(InventoryId,Quantity,instocks)
values(1,10,'true'),
(2,30,'true'),(3,100,'true'),(4,0,'false'),(5,3,'true'),(6,0,'false'),(7,10,'true');


create table ProductDetail(
	ProductId int not null references Product(ProductId),
	CostPrice decimal(10,2)not null,
	SellingPrice decimal(10,2) not null,
	DateOfPrice date	
);
insert into ProductDetail(ProductId,CostPrice,SellingPrice,dateOfPrice)
values(1,15000,18000,'2021-05-15'),
(2,10000,12500,'2020-05-12'),
(2,10000,12500,'2019-05-05'),
(2,10000,12500,'2017-03-12'),
(3,20,30,'2020-01-01'),
(4,100,130,'2019-12-12'),
(5,2500,3000,'2020-07-07'),
(6,3000,35000,'2021-04-04'),
(7,50,70,'2020-10-10');

create table Orders(
	OrderId serial primary key,
	SupplierId int not null references Supplier(SupplierId),
    OrderDate date not null
);
insert into Orders(SupplierId,OrderDate)
values(1,'2021-05-05'),(2,'2020-05-10'),(3,'2021-01-01'),(4,'2020-10-10'),
(5,'2020-12-12'),(2,'2021-05-15');

create table OrderDetail(
    OrderId int references Orders(OrderId),
	ProductId int references Product(ProductId),
	UnitPrice decimal(10,2),
	Quantity int not null,
	Discount decimal(6,2) not null,
	primary key(OrderId,ProductId)
);

insert into OrderDetail(OrderId,ProductId,UnitPrice,Quantity,Discount)
values(1,1,18000,1,10),(2,3,30,10,2),(3,5,3000,1,2),(4,6,3000,3,1),
(5,7,70,1,1),(1,6,4000,1,1);

-- Assignment 2 Query for Filter data

--Q1-> query staff using name or phone number
select * from Staff where FirstName='Sandeep';
select * from Staff where PhoneNumber='9887729448';
select * from Staff where FirstName ='Sandeep' or PhoneNumber='1232344456';

--Q2-> Staff using their Role
select * from Staff;

select s.* from Staff s inner join
StaffRole sr on s.StaffRoleId = sr.StaffRoleId
where RoleName='Manager';

--Q3-> Query Product based on->
--name
select * from Product where ProductName='Laptop'; 

--Category->
select * from Product where CategoryId=1; 

--InStock->
select p.* from Product p inner join 
Inventory i on p.ProductId =i.InventoryId
where i.instocks = 'true';
-- Outstocks
select p.* from Product p inner join 
Inventory i on p.ProductId =i.InventoryId
where i.instocks = 'false';

-- selling price grater than
select p.*,pd.SellingPrice from Product p inner join 
ProductDetail pd on p.ProductId =pd.ProductId
where pd.SellingPrice>50 order by pd.SellingPrice desc;

--less than
select p.*,pd.SellingPrice from Product p inner join 
ProductDetail pd on p.ProductId =pd.ProductId
where pd.SellingPrice>10000 order by pd.SellingPrice desc;

-- Q4 no. of products  out of stocks
select Count(p.ProductName) as OutStocksProduct from Product p inner join 
Inventory i on p.ProductId =i.InventoryId
where i.instocks = 'false';

--Q5->No. of products in a category
select * from Product;

select  CategoryId, Count(ProductName) as ProductCountInCategory from Product
group by CategoryId order by CategoryId;

--Q6-> Product Count with desc order
select  CategoryId, Count(ProductName) as ProductCount from Product
group by CategoryId order by ProductCount desc;

--Q7->List of Suppliers
select * from Supplier;
--Name->
select * from Supplier where FirstName='Rohan';

--Phone->
select * from Supplier where Phone='122345565';
-->Email->
select * from Supplier where Email='abhi@gmail.com';

-->City
select s.* from Supplier s inner join Address a
on s.AddressId = a.AddressId
where a.City='Noida';

--Q8 ->List of Products with different supplier

select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId;

--> search with product name
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
where p.ProductName='Laptop';

-->Search with supplier name
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
where s.FirstName='Abhi';

-- Search with product Code
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
where p.ProductCode='Pen';

--supplier after a perticular date
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
where o.OrderDate>'2000-01-01';

-- before a perticular date
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
where o.OrderDate < '2021-01-01';

-- product inventory greater than a quantity
select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
inner join Inventory i on i.InventoryId =p.ProductId 
where od.Quantity>i.Quantity;

-- product inventory less than a quantity

select p.ProductName,s.FirstName,s.LastName,p.ProductCode,od.Quantity,o.OrderDate from
Product p inner join OrderDetail od on
p.ProductId = od.ProductId
inner join Orders o on o.OrderId = od.OrderId
inner join Supplier s on s.SupplierId = p.SupplierId
inner join Inventory i on i.InventoryId =p.ProductId 
where od.Quantity<i.Quantity;













