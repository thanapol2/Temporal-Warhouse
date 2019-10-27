
   
   
INSERT INTO sale_valid_DEP_dim VALUES('S1','MARKETING','2010-01-01','9999-12-31');

UPDATE sale_valid_dep_dim
   FOR PORTION OF BUSINESS_TIME FROM '2016-01-01' TO '9999-12-31'
   SET DEP = 'IT'
   WHERE sales_id = 'S1';

INSERT INTO sale_valid_DEP_dim VALUES('S2','ENGINEER','2010-01-01','9999-12-31');

UPDATE sale_valid_dep_dim
   FOR PORTION OF BUSINESS_TIME FROM '2015-01-01' TO '2019-01-01'
   SET DEP = 'IT'
   WHERE sales_id = 'S2';
   
update sale_valid_dep_dim
   FOR PORTION OF BUSINESS_TIME FROM '2019-01-01' TO '2020-01-01'
   SET DEP = 'MARKETING'
   WHERE sales_id = 'S2';
   
   
INSERT INTO sale_dim VALUES('S1','TIM');
INSERT INTO sale_dim VALUES('S2','SMITH');

--delete sale_valid_dep_dim where sales_id = 'S1';

select *
from sale_valid_CITY_dim
order by sales_id , start_date;

-- CITY
INSERT INTO sale_valid_city_dim VALUES('S1','BANGKOK','2010-01-01','9999-12-31');
update sale_valid_city_dim
   FOR PORTION OF BUSINESS_TIME FROM '2011-01-01' TO '2011-07-01'
   SET CITY = 'TOKYO'
   WHERE sales_id = 'S1';

INSERT INTO sale_valid_city_dim VALUES('S2','BANGKOK','2010-01-01','9999-12-31');
update sale_valid_city_dim
   FOR PORTION OF BUSINESS_TIME FROM '2014-01-01' TO '2018-07-01'
   SET CITY = 'TOKYO'
   WHERE sales_id = 'S2';   

update sale_valid_city_dim
   FOR PORTION OF BUSINESS_TIME FROM '2019-07-02' TO '2019-12-31'
   SET CITY = 'SYDNEY'
   WHERE sales_id = 'S2';   
   

--   ITEM_DIM
INSERT INTO item_dim VALUES('IM01','COMPONENT');
INSERT INTO item_dim VALUES('IM02','ADVERTISING');
INSERT INTO item_dim VALUES('IM03','BEVERAGES');
INSERT INTO item_dim VALUES('IM04','SOFTWARE');
INSERT INTO item_dim VALUES('IM05','COMPUTER');

-- date dim
insert into date_dim values('0012','2011-01-01')


-- fact
--insert into fact_sales values ('S1','IM01','0112',20);
--insert into fact_sales values ('S1','IM02','0112',100);
--insert into fact_sales values ('S1','IM02','0114',100);
--insert into fact_sales values ('S2','IM05','0114',200);

--insert into fact_sales values ('S1','IM04','0500',50);
--insert into fact_sales values ('S1','IM04','0888',100);
--insert into fact_sales values ('S1','IM05','0888',200);
--insert into fact_sales values ('S1','IM05','1020',400);
--insert into fact_sales values ('S1','IM05','1021',100);

insert into fact_sales values ('S2','IM04','0500',200);
insert into fact_sales values ('S2','IM04','0888',500);
insert into fact_sales values ('S2','IM02','0890',200);
insert into fact_sales values ('S2','IM02','1024',400);
insert into fact_sales values ('S2','IM03','1024',10);
