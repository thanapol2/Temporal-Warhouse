EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2018', 'DD/MM/YYYY'),TO_DATE('31/12/9999', 'DD/MM/YYYY'));
SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MM/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd/MM/yyyy') end_date
FROM sales_dimension sd
ORDER BY start_date;

--- fact and time---
SELECT s.*,
  d.*
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
where s.date_key >= 240
ORDER BY full_date;

---- update department of sales dimension
EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/09/2018', 'DD/MM/YYYY'),TO_DATE('31/12/9999', 'DD/MM/YYYY'));

UPDATE sales_dimension SET department = 'MECHANIC' WHERE SALES_ID = 'S01';

-- insert fact sales on OCT / NOV / DEC

--- query Dice
SELECT department,
  d.fiscal_quarter,
  SUM(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
where s.sales_id = 'S01'
GROUP BY department,
  d.fiscal_quarter
order by fiscal_quarter,department;
  
  ----- roll up
SELECT 
  d.fiscal_quarter,
  SUM(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
where s.sales_id = 'S01'
GROUP BY  d.fiscal_quarter
order by fiscal_quarter;

