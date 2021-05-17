-- Database: Departmental_Store

-- DROP DATABASE "Departmental_Store";

CREATE DATABASE "Departmental_Store"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
-- staff table	
create table Staff(
	Stf_Id Serial Primary Key,
	first_name varchar(20) not nULL,
	last_name varchar(20) not null,
	Title varchar(30) not nULL,
	Birth_Date Date not null,
	Phone_number int not null,
	Address varchar(50) not null,
	City varchar(15) not null,
	Salary float not null
);
alter table Staff alter column Phone_number Type varchar(15);
select * from Staff;
insert into Staff(first_name,last_name,Title,Birth_Date,Phone_number,Address,City,Salary)
values('Sandeep','Kumawat','Manager','1996-07-07','9887729448','A-471','Sikar',25000),
('Pradeep','Kumawat','Cashier','1998-09-15','1232344456','B-40','Jaipur',20000),
('Ritik','Sharma','Cashier','1999-05-05','1234543210','c-4','Alwar',20000),
('Palak','Madan','CSR','1997-06-06','9876543210','D-2','Noida',15000),
('Divya','Talvar','ICS','1995-01-01','2345467808','E-9','Delhi',18000);

-- customer table
create table customers(
	Customer_Id Serial primary Key,
	Customer_name varchar(40) not null,
	Address varchar(50) not null,
	City varchar(15) not null
);
insert into customers(Customer_name,Address,City)
values('Rahul','A-14','Sikar'),
('Nikhil','C-7','Jaipur'),
('Harsh','D-10','Noida'),
('Sachin','S-1','Delhi'),
('Deep','I-7','Delhi');

-- Category Table
create table categories(
	category_Id Serial Primary Key,
	category_name varchar(15) not null
	
);
alter table categories alter column category_name Type varchar(25);

insert into categories(category_name) values('Shopping Goods'),
('Convenience Goods'),('Specialty Goods'),('Unsought Goods'),('Luxury Goods'),
('Technical Goods');

select * from categories;
--suppliers table

create table suppliers(
	Supplier_Id Serial primary key,
	Supplier_name varchar(30) not null,
	Address varchar(50) not null,
	Phone varchar(10) not null,
	City varchar(15) not null,
	Email varchar(20) not null
);
insert into suppliers(Supplier_name,Address,Phone,City,Email)
values ('Rohan','D-10','122345565','jalandhar','rohan@gmail.com'),
('Vikas','R-8','23243456','Faridabad','vikas@gmail.com'),
('Gopal','T-3','9999877644','Noida','gopal@gmail.com'),
('Gaurav','S-1','564757458','Patna','gaurav@gmail.com'),
('Abhi','B-4','9876544334','Chandigarh','abhi@gmail.com');

-- product table
create table products(
	Product_Id Serial Primary key,
	Product_name varchar(30) not null,
	Supplier_Id int references suppliers(Supplier_Id),
	category_Id int references categories(category_Id),
	Product_code varchar(5) not null
	
 );
 select * from products;
insert into products(Product_name,Supplier_Id,category_Id,Product_code)
values('Laptop',1,5,'lap'),
('Mobile',3,5,'Pho'),
('Pen',4,2,'Pen'),
('Bottle',2,1,'Bot'),
('Watch',5,3,'Wat'),
('Shoes',2,2,'Sho'),
('Ball',5,6,'Bal');

select * from products;
-- product details table
create table product_details(
	product_id int not null references products(Product_Id) ,
	cost_price decimal(10,2)not null,
	selling_price decimal(10,2) not null,
	date_of_price date	
);
insert into product_details(product_id,cost_price,selling_price,date_of_price)
values(1,15000,18000,'2021-05-15'),
(2,10000,12500,'2020-05-12'),
(2,10000,12500,'2019-05-05'),
(2,10000,12500,'2017-03-12'),
(3,20,30,'2020-01-01'),
(4,100,130,'2019-12-12'),
(5,2500,3000,'2020-07-07'),
(6,3000,35000,'2021-04-04'),
(7,50,70,'2020-10-10');

--inventory table
create table inventory(
	inventory_id int not null unique references products(Product_Id),
	quantity int not null,
	instocks boolean
);
select * from inventory;
insert into inventory(inventory_id,quantity,instocks)
values(1,10,'true'),
(2,30,'true'),(3,100,'true'),(4,0,'false'),(5,3,'true'),(6,0,'false'),(7,10,'true');

--order table
create table orders(
	order_id serial primary key,
	supplier_id int not null references suppliers(supplier_id),
    Order_date date not null
	
);
select * from suppliers;
insert into orders(supplier_id,Order_date)
values(1,'2021-05-05'),(2,'2020-05-10'),(3,'2021-01-01'),(4,'2020-10-10'),
(5,'2020-12-12'),(2,'2021-05-15');
-- order details table
create table Order_Details(
    order_id int references orders(order_id),
	Product_Id int references products(Product_Id),
	UnitPrice decimal(10,2),
	quantity int not null,
	discount decimal(8,2) not null,
	primary key(order_id,Product_Id)
);
insert into Order_Details(order_id,Product_Id,UnitPrice,quantity,discount)
values(1,1,18000,1,10),(2,3,30,10,2),(3,5,3000,1,2),(4,6,3000,3,1),
(5,7,70,1,1),(1,6,4000,1,1);
select * from Order_details;



-- Assignment 2 Query for Filter data

--Q1-> query staff using name or phone number
select * from Staff where first_name='Sandeep';
select * from Staff where phone_number='9887729448';
select * from Staff where first_name ='Sandeep' or phone_number='1232344456';

--Q2-> Staff using their Role
select * from Staff where Title='Manager';

--Q3-> Query Product based on->
--name
select * from products where product_name='Laptop'; 

--Category->
select * from products where category_id=1; 

--InStock->
select p.* from products p inner join 
inventory i on p.product_Id =i.inventory_id
where i.instocks = 'true';
-- Outstocks
select p.* from products p inner join 
inventory i on p.product_Id =i.inventory_id
where i.instocks = 'false';

-- selling price grater than
select p.*,pd.selling_price from products p inner join 
product_details pd on p.product_Id =pd.product_id
where pd.selling_price>50 order by pd.selling_price desc;

--less than

select p.*,pd.selling_price from products p inner join 
product_details pd on p.product_Id =pd.product_id
where pd.selling_price < 10000 order by pd.selling_price desc;

-- Q4 no. of products  out of stocks
select Count(p.product_name) as OutStocks_Product from products p inner join 
inventory i on p.product_Id =i.inventory_id
where i.instocks = 'false';

--Q5->No. of products in a category
select * from products;

select  category_id, Count(product_name) as product_Count from products
group by category_id order by category_Id;

--Q6-> Product Count with desc order
select  category_id, Count(product_name) as product_Count from products
group by category_id order by product_count desc;

--Q7->List of Suppliers
select * from suppliers;
--Name->
select * from suppliers where supplier_name='Rohan';

--Phone->
select * from suppliers where phone='122345565';
-->Email->
select * from suppliers where Email='abhi@gmail.com';

-->City
select * from suppliers where City='Noida';

--Q8 ->List of Products with different supplier

select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id;

--> search with product name
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
where p.product_name='Laptop';

-->Search with supplier name
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
where s.supplier_name='Abhi';

-- Search with product Code
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
where p.product_code='Pen';

--supplier after a perticular date
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
where o.order_date>'2000-01-01';

-- before a perticular date
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
where o.order_date < '2021-01-01';

-- product inventory greater than a quantity
select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
inner join inventory i on i.inventory_id =p.product_id 
where od.quantity>i.quantity;

-- product inventory less than a quantity

select p.product_name,s.supplier_name,p.product_code,od.quantity,o.Order_date from
products p inner join order_details od on
p.product_id = od.product_id
inner join orders o on o.order_id = od.order_id
inner join suppliers s on s.supplier_id = p.supplier_id
inner join inventory i on i.inventory_id =p.product_id 
where od.quantity<i.quantity;







