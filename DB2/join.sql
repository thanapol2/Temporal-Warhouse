create view temp1 as 
select fs.sales_id,s.sales_name,city,dep,full_date,fs.item_id,item_name,qty
from fact_sales fs
inner join date_dim d
on fs.date_id = d.date_id
inner join item_dim id
on fs.item_id = id.item_id
inner join sale_valid_city_dim sc
on fs.sales_id = sc.sales_id
and d.full_date between sc.start_date and (sc.end_date-1)
inner join sale_valid_dep_dim sd
on fs.sales_id = sd.sales_id
and d.full_date between sd.start_date and (sd.end_date-1)
inner join sale_dim s
on fs.sales_id = s.sales_id;


select fs.sales_id,s.sales_name,city,dep,full_date,fs.item_id,item_name,qty
from service_sale_fact fs
inner join date_dim d
on fs.date_id = d.date_id
inner join item_dim id
on fs.item_id = id.item_id
inner join sale_valid_city_dim sc
on fs.sales_id = sc.sales_id
and d.full_date between sc.start_date and (sc.end_date-1)
inner join sale_valid_dep_dim sd
on fs.sales_id = sd.sales_id
and d.full_date between sd.start_date and (sd.end_date-1)
inner join sale_dim s
on fs.sales_id = s.sales_id;

select fs.sales_id,s.sales_name,city,dep,full_date,fs.item_id,item_name,qty,fs.start_date,fs.end_date
from fact_sales_period fs
inner join date_dim d
on fs.tran_date_id = d.date_id
inner join item_dim id
on fs.item_id = id.item_id
inner join sale_valid_city_dim sc
on fs.sales_id = sc.sales_id
and d.full_date between sc.start_date and (sc.end_date-1)
inner join sale_valid_dep_dim sd
on fs.sales_id = sd.sales_id
and d.full_date between sd.start_date and (sd.end_date-1)
inner join sale_dim s
on fs.sales_id = s.sales_id;