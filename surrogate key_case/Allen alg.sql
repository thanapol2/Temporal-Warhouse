EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2016', 'DD/MM/YYYY'),TO_DATE('31/12/2018', 'DD/MM/YYYY'));
INSERT
INTO sales_dimension VALUES
  (
    'S07',
    'Jim',
    'RETAIL',
    WMSYS.WM_PERIOD(TO_DATE('01/10/2017', 'DD/MM/YYYY'), TO_DATE('01/02/2018', 'DD/MM/YYYY'))
  );
INSERT
INTO sales_dimension VALUES
  (
    'S08',
    'Jo',
    'RETAIL',
    WMSYS.WM_PERIOD(TO_DATE('01/02/2018', 'DD/MM/YYYY'), TO_DATE('01/03/2018', 'DD/MM/YYYY'))
  );

INSERT
INTO sales_dimension VALUES
  (
    'S09',
    'Anna',
    'RETAIL',
    WMSYS.WM_PERIOD(TO_DATE('01/01/2017', 'DD/MM/YYYY'), TO_DATE('01/11/2018', 'DD/MM/YYYY'))
  );
INSERT
INTO sales_dimension VALUES
  (
    'S10',
    'Envy',
    'RETAIL',
    WMSYS.WM_PERIOD(TO_DATE('01/05/2018', 'DD/MM/YYYY'), TO_DATE('01/10/2018', 'DD/MM/YYYY'))
  );
INSERT
INTO sales_dimension VALUES
  (
    'S11',
    'Roy',
    'IT',
    WMSYS.WM_PERIOD(TO_DATE('01/01/2015', 'DD/MM/YYYY'), TO_DATE('01/10/2018', 'DD/MM/YYYY'))
  );


SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MON/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'dd/MON/yyyy') end_date
FROM sales_dimension sd
ORDER BY sales_id,sd.wm_valid.validFrom;


--- Join
SELECT p1.sales_id p1_sales_id,
  p1.sales_name p1_sales_name,
  p1.department p1_department,
  TO_CHAR(p1.wm_valid.validFrom,'DD/MON/yyyy') p1_start_date,
  TO_CHAR(p1.wm_valid.validTill,'DD/MON/yyyy') p1_end_date,
  p2.sales_id p2_sales_id,
  p2.sales_name p2_sales_name,
  p2.department p2_department,
  TO_CHAR(p2.wm_valid.validFrom,'DD/MON/yyyy') p2_start_date,
  TO_CHAR(p2.wm_valid.validTill,'DD/MON/yyyy') p2_end_date
FROM sales_dimension p1
INNER JOIN sales_dimension p2
ON (WM_CONTAINS (p1.wm_valid,p2.wm_valid) = 1
OR WM_CONTAINS (p2.wm_valid,p1.wm_valid)  = 1)
AND p1.sales_id                          != p2.sales_id
AND p1.department                         = p2.department
order by P1_Sales_id, p1.wm_valid.validFrom,P1_department;

---- Allen Overlap
SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MON/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'DD/MON/yyyy') end_date
FROM sales_dimension sd
WHERE WM_CONTAINS (sd.wm_valid,
  (SELECT wm_valid
  FROM sales_dimension
  WHERE Sales_id = 'S03'
  AND department = 'RETAIL'
  ))             =1
and department = 'RETAIL'
ORDER BY start_date;


---- Allen Meet
SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MON/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'DD/MON/yyyy') end_date
FROM sales_dimension sd
WHERE WM_Meets (sd.wm_valid,
  (SELECT wm_valid
  FROM sales_dimension
  WHERE Sales_id = 'S10'
  AND department = 'RETAIL'
  ))             =1
and department = 'RETAIL'
ORDER BY start_date;

---- Allen Contains
SELECT sd.sales_id,
  sd.sales_name,
  sd.department,
  TO_CHAR(sd.wm_valid.validFrom,'DD/MON/yyyy') start_date,
  TO_CHAR(sd.wm_valid.validTill,'DD/MON/yyyy') end_date
FROM sales_dimension sd
WHERE WM_Contains (sd.wm_valid,
  (SELECT wm_valid
  FROM sales_dimension
  WHERE Sales_id = 'S08'
  AND department = 'RETAIL'
  ))             =1
and department = 'RETAIL'
ORDER BY start_date;

