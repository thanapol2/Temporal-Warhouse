---- select with valid time
EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2018', 'DD/MM/YYYY'),TO_DATE('31/12/2018', 'DD/MM/YYYY'));
SELECT s.sales_id,
  department ,
  TO_CHAR(sd.wm_valid.validFrom,'dd-mon-yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd-mon-yyyy') end_date,
  d.full_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
ORDER BY full_date;

--- Query Type 1 Find out all the products sold on 01/05/2018
SELECT s.sales_id,
  department ,
  TO_CHAR(sd.wm_valid.validFrom,'dd-MON-yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd-MON-yyyy') end_date,
  d.date_key,
  d.full_date,
  i.item_cd,
  i.item_name,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID  = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
where full_date = to_date('01/05/2018','dd/mm/yyyy')
ORDER BY full_date;

--- Query Type 2 What was the average sales during Q2 in 2018 per department per items
SELECT i.ITEM_NAME,
  department,
  AVG(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
where d.fiscal_quarter                                               = '2018/2'
GROUP BY department, i.ITEM_name;

--- Query Type 3 What was the summary of sales when department of sales does not change for at most 4 month
SELECT s.sales_id,
  department,
  SUM(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
WHERE MONTHS_BETWEEN(sd.wm_valid.validTill,sd.wm_valid.validFrom) <= 4
GROUP BY s.sales_id,
  department;
  
--- Query Type 4 When were the number of product sold for the department IT at a maximum
SELECT s.sales_id,
  department ,
  TO_CHAR(sd.wm_valid.validFrom,'dd-MON-yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd-MON-yyyy') end_date,
  d.date_key,
  d.full_date,
  s.item_cd,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN sales_dimension sd
ON s.SALES_ID  = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
where amount = (
SELECT max(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN sales_dimension sd
ON s.SALES_ID                                                      = sd.sales_id
AND WM_CONTAINS (sd.wm_valid,wm_period(d.full_date,d.full_date+1)) = 1
WHERE department = 'IT'
group by department)
and department = 'IT';