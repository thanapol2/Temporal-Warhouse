CREATE TABLE SALE_VALID_DEP_DIM
(SALES_ID CHAR(4), 
 DEP CHAR(100), 
 START_DATE DATE not null, 
 END_DATE DATE not null); 

ALTER TABLE SALE_VALID_DEP_DIM  ADD PERIOD BUSINESS_TIME(START_DATE, END_DATE);


CREATE TABLE SALE_VALID_city_DIM
(SALES_ID CHAR(4), 
 city CHAR(100), 
 START_DATE DATE not null, 
 END_DATE DATE not null); 

ALTER TABLE SALE_VALID_city_DIM  ADD PERIOD BUSINESS_TIME(START_DATE, END_DATE);

CREATE TABLE SALE_DIM
(SALES_ID CHAR(4), 
 SALES_NAME CHAR(100)); 
 
 create table date_dim
 (date_id char(4),
 full_date date);
 
 
 
 create table service_sale_fact(sales_id char(4),
 item_id char(4),
 date_id char(4),
 qty int); 
 
 
 CREATE TABLE fact_sales_period
(sales_id char(4),
 item_id char(4),
 tran_date_id char(4),
 qty int, 
 START_DATE DATE not null, 
 END_DATE DATE not null); 

ALTER TABLE fact_sales_period ADD PERIOD BUSINESS_TIME(START_DATE, END_DATE);