--create a table using create command
create table house_rent (Posted_On date, BHK int, Size int, Floor int, Area_Type varchar(255),
									Area_Locality varchar(255), City varchar(255), Furnishing_Status varchar(255),
									Tenant_Preferred varchar(255), Bathroom int, Point_of_Contact varchar(255), Rent int
);
--select the all columns using select command
select * from house_rent;
--copy command used for copying the csv file
copy house_rent from 'D:\Automobile\House_Rent_Dataset.csv' delimiter',' csv header;
--rename the column using alter command
alter table house_rent rename BHK_Rent to BHK;
--add the column using alter command
alter table house_rent add Rent int;
--change the data type using alter command(Type casting)modify
alter table house_rent alter column Floor type varchar(255);
alter table house_rent alter column Posted_On type datetime;
--insert the column using insert command
insert into house_rent (Posted_On, BHK, Size, Floor, Area_Type, Area_Locality, City, Furnishing_Status, Tenant_Preferred, 
						Bathroom, Point_of_Contact, Rent) 
						values 
	(05-05-2022,2,1120,'1 out of 3','Super Area','Bandel','Kolkata','Unfurnished','Bachelors',1,'Contact Owner',12000);
--Update command used for change the column values
update windows set orders=3 where customer='C-1'; 
--drop the column using alter command
alter table house_rent drop point_of_contact;
--delete a column value using delete command
delete from house_rent where size=1100;
--drop command using for drop the table;
--select commands where, order by, group by, having clauses
select count('bhk'),city from house_rent group by city having max(bhk)>=6 order by count desc;
select count('bhk'),city from house_rent group by city having max(bhk)>=5;
select count('bhk'),city from house_rent group by city order by count desc;
select city,count('bhk') from house_rent where bhk=2 group by city;
select count('Chennai') from house_rent;
--i want print 1bhk & 2bhk  upto 6bhk?
select *
from(select count('bhk')as BHK_1 from house_rent where bhk=1)
cross join(select count('bhk')as BHK_2 from house_rent where bhk=2)
cross join(select count('bhk')as BHK_3 from house_rent where bhk=3)
cross join(select count('bhk')as BHK_4 from house_rent where bhk=4)
cross join(select count('bhk')as BHK_5 from house_rent where bhk=5)
cross join(select count('bhk')as BHK_6 from house_rent where bhk=6);
--with city name
select bhk,count('bhk') from house_rent where city='Chennai'group by bhk order by bhk asc                           
--logical operator like AND, OR, NOT
select city,bhk,size,area_type from house_rent where area_type='Super Area' and area_type='Carpet Area';
select city,bhk,size,area_type from house_rent where area_type='Super Area' or area_type='Carpet Area';
select city,bhk,size,area_type from house_rent where not area_type='Carpet Area';
--selection command for filtering(IN,BETWEEN,LIKE-WILDCARD(%,_))
select * from house_rent where city='kolkata' or area_locality='Dumdum Park';
select * from house_rent where area_locality in('Dumdum Park');
select * from house_rent where rent between 1000 and 5000;
select * from house_rent where rent not between 1000 and 5000;
select * from house_rent where city like 'chennai';
--Limit and As for filtering the column
select * from house_rent where rent between 1000 and 5000 limit 5;
select rent as rent_amount from house_rent where rent between 1000 and 5000 order by rent asc limit 5;
--aggregate funtion
select count(bhk)from house_rent where bhk=2;
select Max(bhk)from house_rent;
select Min(bhk)from house_rent;
select Avg(rent)from house_rent where bhk=3;
select sum(rent)from house_rent where bhk=2;
--condition statement for multiple conditions usign CASE WHEN
select rent,case when rent<10000 then 'Ordinary peoples' when rent<20000 then 'Well setteled peoples' else 'VIP peoples'
end as category  from house_rent order by rent asc ;
--Joins(joines are used to combine related rows in two tables)
select * from table_a inner join table_b on table_a.name=table_b.name;
select * from table_a left join table_b on table_a.name=table_b.name;
select * from table_a right join table_b on table_a.name=table_b.name;
select * from table_a full outer join table_b on table_a.name=table_b.name;/* it's allowing duplicate rows*/
--cross join
select table_a.id,table_b.age from table_a,table_b;
--combining Queries(Com Queries are used to compare to tables and show the data is the same of different between to tables)
select id,name,age from table_a intersect select id,name,age from table_b order by id;
select id,name,age from table_a intersect all select id,name,age from table_b order by id;
select id,name,age from table_a except select id,name,age from table_b order by id;
select id,name,age from table_a union select id,name,age from table_b order by id;/* doesn't allow duplicate rows*/
/*sub queries*/
select * from house_rent where rent in (select rent from house_rent where rent not between 1000 and 5000);
--views and indexes
create view cities as select city,bhk,size,area_type from house_rent where area_type='Super Area' or area_type='Carpet Area';
select * from cities;/* or replace is used for if table doesn't present in that case use or replace*/
drop view cities;
create index mon_idx on month_values(MM);
drop index mon_idx;
--String Functions
select sname,mark,length(sname)as characters from student where mark>90;
select upper('nithish')as name;
select lower('NITHISH')as name;
select ltrim('           im nithish');
select rtrim('im nithish          ');
select trim('           im nithish          ');
select trim(leading ' ' from'           im nithish          ');
select trim(trailing ' ' from'           im nithish          ');
select trim(both' ' from'           im nithish          ');
select rent,area_type||','||area_locality||','||city as address from house_rent;-- where as concatenation add the multiple column valus in a single row
--substring is used to extract the portion of a string
select order_id,customer_name,substring(order_id for 2)as cust_group from order_details where substring(order_id for 2)='CA';--for 2 means first 2 char
select posted_on,area_type from house_rent where substring(area_type for 1)='S'; 
select posted_on,area_type,substring(area_type from 7 for 8)as area from house_rent where substring(area_type for 1)='S'; 
--string aggregator
select order_id,string_agg(product_id,',')from order_details group by order_id order by order_id;--it is used for concate the values in single column
--mathematical function(CEIL,FLOOR,RANDOM,SETSEED,ROUND,POWER)
select city,size,ceil(rent),floor(rent)from house_rent;
select price,ceil(price),floor(price)from customer_details;
select country,city,ceil(sales),floor(sales) from order_details;
select order_id,customer_id,ceil(sales),floor(sales)from order_details where profit>5;
select random(),random()*(50-10)+10,floor(random()*(50-10+1)+10);
select setseed(0.5);
select random();
select order_id,sales,round(sales) as amount from order_details;
select order_id,quantity,power(quantity,2)from order_details order by quantity;
--Date & Time Function
select current_date,current_time,current_timestamp,current_time(2);--(2)for print the first 2 char after upcoming values are 0
--Age Function
select age(current_date,'01-04-2002');
select age('27-06-2024','01-04-2002');
select order_id,ship_date,order_date,age(ship_date,order_date)as time_taken from order_details order by time_taken desc;
--Extract Function extracts parts from a date(DAY,DECADE,DOY,EPOCH,HOUR,MINUTE,MONTH,SECOND,YEAR)
select extract(day from current_date);
/* select extract(day from '2014-04-15');*/
select extract (month from current_date);
select extract (year from current_date);
select extract (hour from current_timestamp);
select extract (minute from current_timestamp);
select extract (second from current_timestamp);
select extract (decade from current_timestamp);
select extract (doy from current_timestamp);
select order_date,ship_date,extract(epoch from ship_date)-extract(epoch from order_date)as sec_taken from order_details;
--Pattern Matching(LIKE,SIMILAR TO,REGULAR EXPRESSION)/*Like is used to whole string where as regular expression is used for part of a string*?
select * from house_rent where city like '_hennai';
select * from house_rent where city like 'C%';
select * from house_rent where area_type ~*'^S+[a-z\s]+$' limit 5;--starting with S 
select * from house_rent where area_type ~*'^(s|c)+[a-z\s]+$' limit 10;--starting with s & c
select * from house_rent where area_type ~*'^(s|c)[a-z]{3}\s[a-z]{4}$';--{3}is used for that string contains 3 char where as {4} is contain 4 char after space
select * from house_rent where area_type ~*'[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}';--valid email id
--Windows Function
select customer,state,orders,row_number()over(partition by state order by orders desc)as row from windows;
select a.*,b.sales_tot,b.quantity_tot,b.profit_tot from customer_details as a 
left join(select customer_id,count(distinct order_id)as order_num,sum(sales)as sales_tot,sum(quantity)as quantity_tot,
		  sum(profit)as profit_tot from order_details group by customer_id) as b
		  on a.customer_id=b.customer_id;
--rank & dense rank
select customer,state,orders,rank()over(partition by state order by orders desc)as rows from windows;
select customer,state,orders,dense_rank()over(partition by state order by orders desc)as rows from windows;
--deff btw Row & Rank & Dense Rank
select customer_id,country,state,row_number()over(partition by state order by order_id desc)as row_n,
rank()over(partition by state order by order_id desc)as rank_n,
dense_rank()over(partition by state order by order_id desc)as d_rank_n
from order_details;
--Ntile here N is distance for number tile is number of tiles
select customer,state,orders,ntile(4)over(partition by state order by orders desc)as group from windows;--ntile(4) is partitoning the grp based on given value
select distinct a.customer,a.state,a.orders,a.group_1,b.customer,b.state,b.orders,b.group_2
from
(select distinct customer,state,orders,ntile(3)over(partition by state order by state asc)as group_1 from windows where state='A')a
full outer join(select distinct customer,state,orders,ntile(4)over(partition by state order by state asc)as group_2 from windows where state='B')b
on a.group_1=b.group_2;
--Windows average function
/*average value for rows within window frame*/
select customer_id,price,gender,avg(price)over(partition by gender)as avg_r from customer_details where gender='Female';
--Windows count function
select customer,state,orders,count(customer)over(partition by state)as count_cust from windows;
--Windows sum_total Function
select customer,date,revenue,state,orders,sum(revenue)over(partition by customer)as sum_total from windows;
select distinct gender,sum(price)over(partition by gender order by gender)as total_sum from customer_details;
--Windows Running Total
select customer,state,orders,sum(orders)over(partition by state order by customer asc)as running_tot from windows;
select customer,date,revenue,sum(revenue)over(partition by date desc)as total from <table_name>;
select order_id,customer_id,sales,state,order_date,sum(sales)over(partition by state order by order_date )as running_tot from order_details;
select sum(sales) from order_details where state='California';
--Windows Lag & Lead Function
select order_id,customer_id,sales,state,order_date,lag(sales)over(partition by state order by order_date )as last_r from order_details;
select order_id,customer_id,sales,state,order_date,lead(sales)over(partition by state order by order_date )as  lead_r from order_details;
--Coalesce Function
select sno,first_name,middle_name,last_name,coalesce(first_name,middle_name,last_name) as,
concat(first_name,middle_name,last_name)from <table_name>;--return the first non-null values in a list
--Converting Number/Date to string 
select sales,TO_CHAR(sales,'9999.99') from sales;
select sales,TO_CHAR(sales,'L9999.99') from sales;
select order_date,TO_CHAR(order_date,'MMDDYY') from sales;
select order_date,TO_CHAR(order_date,'Month DD,YYYY') from sales;
--conversion string
select sales,'Total sales value for this order is'||to_char(sales,'9999.9')as message from order_details;--999,00,00
select order_date,to_char(order_date,'DD-MM-YYYY')from order_details;
--conversion to date
select to_date('2019/01/15','YYYY/MM/DD');
select to_date('20052019','DDMMYYYY');
--conversion to number
select to_number('1210.73','9999.99');
select to_number ('$2,657.432','L9,999.999');
--Create User/*Access Control/
--creates a database account that allow you to login into the database
create user nithish with password'nithish2002';
create user nithish with password'nithish2002'valid until'july 2,2024';
create user nithish with password'nithish2002'valid until'infinity';
--GRANT&REVOKE
grant select,insert,update,delete on order_details to nithish;--Can see in table properties
revoke delete on order_details from nithish;
--Drop User
revoke all on order_details from nithish;--1st of all revoke the given revoke command after only can drop user
drop user nithish;
--Rename User
alter user nithish rename to swe;
--Find all users
select usename from pg_user;
select * from pg_user;
--Find logged-in users/*retrive information about logged-in users
select distinct usename from pg_stat_activity;
select distinct * from pg_stat_activity;
--Truncate/*delete only rows of the table not whole table instead use drop table*/
truncate table window;
--explain
explain select * from house_rent;
explain select distinct * from house_rent;
--vacuum/*compacts the table to free up the consumed space*/
vacuum house_rent;
--Schemas is a collection of database objects associated with one particular database
create schema testschema;
create table test.customer as select * from customer;    
--use the case statement instead of update statement, space consume lesser than update and quicker.
