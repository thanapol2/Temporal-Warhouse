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
-- with surrgate key
SELECT s.sales_id,
  department ,
  sd.*,
  d.date_key,
  d.full_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN
  (SELECT ss.*,
    st.FULL_DATE   AS start_date ,
    st.month_short AS st_mon_short,
    st.year        AS st_year,
    ed.FULL_DATE   AS end_date,
    ed.month_short AS ed_mon_short,
    ed.year        AS ed_year
  FROM SALES_DIMENSION_SUR ss
  INNER JOIN TIME_DIMENSION st
  ON ss.START_KEY = st.DATE_KEY
  INNER JOIN TIME_DIMENSION ed
  ON ss.end_KEY      = ed.DATE_KEY
  ) sd ON s.SALES_ID = sd.sales_id
AND d.full_date     >= sd.start_date
AND d.full_date      < sd.end_date
ORDER BY full_date;
--- sales dimension join time dimension
SELECT ss.*,
  st.FULL_DATE AS start_date ,
  ed.FULL_DATE AS end_date
FROM SALES_DIMENSION_SUR ss
INNER JOIN TIME_DIMENSION st
ON ss.START_KEY = st.DATE_KEY
INNER JOIN TIME_DIMENSION ed
ON ss.end_KEY = ed.DATE_KEY;
--- Query Type 1 Find out all the products sold on 01/05/2018
SELECT s.sales_id,
  department ,
  sd.start_date,
  sd.end_date,
  s.date_key,
  d.full_date AS sales_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN
  (SELECT ss.*,
    st.FULL_DATE      AS start_date ,
    st.FISCAL_QUARTER AS start_q,
    st.month_short    AS st_mon_short,
    st.year           AS st_year,
    ed.FULL_DATE      AS end_date,
    ed.FISCAL_QUARTER AS end_q,
    ed.month_short    AS ed_mon_short,
    ed.year           AS ed_year
  FROM SALES_DIMENSION_SUR ss
  INNER JOIN TIME_DIMENSION st
  ON ss.START_KEY = st.DATE_KEY
  INNER JOIN TIME_DIMENSION ed
  ON ss.end_KEY      = ed.DATE_KEY
  ) sd ON s.SALES_ID = sd.sales_id
AND d.full_date     >= sd.start_date
AND d.full_date      < sd.end_date
WHERE full_date      = to_date('01/05/2018','dd/mm/yyyy')
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
INNER JOIN
  (SELECT ss.*,
    st.FULL_DATE      AS start_date ,
    st.FISCAL_QUARTER AS start_q,
    st.month_short    AS st_mon_short,
    st.year           AS st_year,
    ed.FULL_DATE      AS end_date,
    ed.FISCAL_QUARTER AS end_q,
    ed.month_short    AS ed_mon_short,
    ed.year           AS ed_year
  FROM SALES_DIMENSION_SUR ss
  INNER JOIN TIME_DIMENSION st
  ON ss.START_KEY = st.DATE_KEY
  INNER JOIN TIME_DIMENSION ed
  ON ss.end_KEY        = ed.DATE_KEY
  ) sd ON s.SALES_ID   = sd.sales_id
AND d.full_date       >= sd.start_date
AND d.full_date        < sd.end_date
WHERE d.fiscal_quarter = '2018/2'
GROUP BY department,
  i.ITEM_name;
--- Query Type 3 What was the summary of sales when department of sales does not change for at most 4 month
SELECT s.sales_id,
  department,
  SUM(amount)
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN
  (SELECT ss.*,
    st.FULL_DATE      AS start_date ,
    st.FISCAL_QUARTER AS start_q,
    st.month_short    AS st_mon_short,
    st.year           AS st_year,
    ed.FULL_DATE      AS end_date,
    ed.FISCAL_QUARTER AS end_q,
    ed.month_short    AS ed_mon_short,
    ed.year           AS ed_year
  FROM SALES_DIMENSION_SUR ss
  INNER JOIN TIME_DIMENSION st
  ON ss.START_KEY = st.DATE_KEY
  INNER JOIN TIME_DIMENSION ed
  ON ss.end_KEY                            = ed.DATE_KEY
  ) sd ON s.SALES_ID                       = sd.sales_id
AND d.full_date                           >= sd.start_date
AND d.full_date                            < sd.end_date
WHERE MONTHS_BETWEEN(end_date,start_date) <= 4
GROUP BY s.sales_id,
  department;
--- Query Type 4 When were the number of product sold for the department IT at a maximum
SELECT s.sales_id,
  department ,
  sd.start_date,
  sd.end_date,
  s.date_key,
  d.full_date AS sales_date,
  i.*,
  s.amount
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
INNER JOIN ITEM_DIMENSION i
ON i.item_cd = s.item_cd
INNER JOIN
  (SELECT ss.*,
    st.FULL_DATE      AS start_date ,
    st.FISCAL_QUARTER AS start_q,
    st.month_short    AS st_mon_short,
    st.year           AS st_year,
    ed.FULL_DATE      AS end_date,
    ed.FISCAL_QUARTER AS end_q,
    ed.month_short    AS ed_mon_short,
    ed.year           AS ed_year
  FROM SALES_DIMENSION_SUR ss
  INNER JOIN TIME_DIMENSION st
  ON ss.START_KEY = st.DATE_KEY
  INNER JOIN TIME_DIMENSION ed
  ON ss.end_KEY      = ed.DATE_KEY
  ) sd ON s.SALES_ID = sd.sales_id
AND d.full_date     >= sd.start_date
AND d.full_date      < sd.end_date
WHERE amount         =
  ( SELECT MAX(amount) FROM sum_sales s
  )