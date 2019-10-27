select fs.sales_id,s.sales_name,city,dep,full_date,fs.item_id,item_name,qty,
CASE when sc.start_date <= fs.start_date then fs.start_date
else sc.start_date
end start_date,
CASE when sc.end_date >= fs.end_date then fs.end_date
else sc.end_date
end end_date
from fact_sales_period fs
inner join date_dim d
on fs.tran_date_id = d.date_id
inner join item_dim id
on fs.item_id = id.item_id
inner join sale_valid_city_dim sc
on fs.sales_id = sc.sales_id
and (fs.start_date,(fs.end_date-1)) OVERLAPS (sc.start_date ,(sc.end_date-1))
inner join sale_valid_dep_dim sd
on fs.sales_id = sd.sales_id
and (fs.start_date,(fs.end_date-1)) OVERLAPS (sd.start_date ,(sd.end_date-1))
inner join sale_dim s
on fs.sales_id = s.sales_id;

select *
from sale_valid_city_dim
order by sales_id,start_date;