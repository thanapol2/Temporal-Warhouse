---- select with valid time
SELECT s.sales_id,
  department ,
  to_char(sd.wm_valid.validFrom,'dd-mon-yyyy') start_date,
  to_char(sd.wm_valid.validTill,'dd-mon-yyyy') end_date,
  d.full_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID = sd.sales_id
AND  WM_CONTAINS  (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
order by full_date;



-- with surrgate key
SELECT s.sales_id,
  department ,
  sd.start_date,
  sd.end_date,
  d.full_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN (select ss.*, st.FULL_DATE as start_date ,ed.FULL_DATE as end_date
from SALES_DIMENSION_SUR ss
inner join TIME_DIMENSION st
on ss.START_KEY = st.DATE_KEY
inner join  TIME_DIMENSION ed
on ss.end_KEY = ed.DATE_KEY) sd
ON s.SALES_ID = sd.sales_id
AND  d.full_date >= sd.start_date
and d.full_date < sd.end_date
order by full_date;

--- sales dimension join time dimension
select ss.*, st.FULL_DATE as start_date ,ed.FULL_DATE as end_date
from SALES_DIMENSION_SUR ss
inner join TIME_DIMENSION st
on ss.START_KEY = st.DATE_KEY
inner join  TIME_DIMENSION ed
on ss.end_KEY = ed.DATE_KEY;
