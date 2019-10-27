-- roll up year
select city,dep,item_name,to_char(trunc(full_date,'year'),'yyyy') as year,sum(qty)
from temp1
group by trunc(full_date,'year'),city,dep,item_name
order by year;

-- Slice Bangkok
select city,dep,item_name,to_char(trunc(full_date,'mon'),'MON/yyyy') as month_year,sum(qty)
from temp1
where CITY = 'BANGKOK'
group by trunc(full_date,'mon'),city,dep,item_name
order by month_year;

-- drill across


select city,dep,to_char(trunc(full_date,'year'),'yyyy') as year,sum(qty) qty
from (select *
from temp1
union
select *
from temp2) s
group by trunc(full_date,'year'),city,dep
order by year;