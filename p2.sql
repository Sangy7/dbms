
create table salesman(
salesman_id number(4) primary key,
name varchar(20),
city varchar(20),
commission varchar(5)
);

create table customer(
customer_id number(4) primary key,
cust_name varchar(20),
city varchar(20),
grade number(5),
salesman_id number(4),
foreign key (salesman_id) references salesman(salesman_id) on delete set null
);

create table orders(
ord_no number(4),
purchase_amt number(6,2),
ord_date date,
customer_id number(4),
salesman_id number(4),
foreign key (salesman_id) references salesman(salesman_id) on delete cascade,
foreign key (customer_id) references customer(customer_id) on delete cascade
);

 
insert into salesman values (1000, 'Bhargav', 'Banglore', '25%')
insert into salesman values (2000, 'Bibek', 'Manglore', '35%')
insert into salesman values (3000, 'Amrit', 'Delhi', '30%')
insert into salesman values (4000, 'Kushal', 'Banglore', '22%')
insert into salesman values (1234, 'Bhargav', 'Mysore', '20%')
select * from salesman;


insert into customer values (11, 'Keshav', 'Banglore', 100, 1000)
insert into customer values (12, 'Akash', 'Banglore', 300, 1000)
insert into customer values (13, 'Samip', 'Manglore', 250, 2000)
insert into customer values (14, 'Navaraj', 'Mysore', 500, 2000)
insert into customer values (15, 'Bhatta', 'Delhi', 300, 3000)
insert into customer values (16, 'Suraj', 'Hydrabad', 400, 1234)
select * from customer;


insert into orders values (51, 1000, '17-may-21', 11, 1000)
insert into orders values (52, 500, '21-jun-21', 11, 2000)
insert into orders values (53, 750, '10-aug-21', 13, 2000)
insert into orders values (54, 800, '19-oct-21', 12, 3000)
insert into orders values (55, 340, '01-feb-21', 16, 1234)
select * from orders;

Q1). Count the customers with grades above Bangalore’s average.
select grade, count(distinct customer_id)
from customer
group by grade
having grade > ( select avg(grade) from customer where city = 'Banglore');

2. Find the name and numbers of all salesmen who had more than one customer. 

select salesman_id, name
from salesman
where salesman_id in (select salesman_id from customer group by salesman_id having count (*) > 1);

Q3)List all the salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)

select salesman.salesman_id, name, cust_name
from salesman, customer
where salesman.city = customer.city
UNION
select salesman_id, name, 'No Match'
from salesman
where city not in (select city from customer)
order by 2 desc;

Q4)Create a view that finds the salesman who has the customer with the highest order of a day. 

CREATE VIEW ELITSALESMAN AS
SELECT B.ORD_DATE, A.SALESMAN_ID, A.NAME
FROM SALESMAN A, ORDERS B
WHERE A.SALESMAN_ID = B.SALESMAN_ID
AND B.PURCHASE_AMT=(SELECT MAX (PURCHASE_AMT)

FROM ORDERS C
WHERE C.ORD_DATE = B.ORD_DATE);

SELECT * FROM ELITSALESMAN




5. Demonstrate the DELETE operation by removing salesman with id 12345. All his orders must also be deleted.

 delete from salesman where salesman_id = 1234; 
