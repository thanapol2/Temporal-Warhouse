EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2018', 'DD/MM/YYYY'),TO_DATE('31/12/9999', 'DD/MM/YYYY'));
SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MM/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd/MM/yyyy') end_date
FROM sales_dimension sd;

SELECT s.*,
  d.*
FROM sum_sales s
INNER JOIN TIME_DIMENSION d
ON s.date_key = d.date_key
order by full_date
