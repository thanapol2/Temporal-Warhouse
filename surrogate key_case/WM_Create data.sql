--- create dimension table with PERIOD---
CREATE TABLE sales_dimension (
  sales_id  VARCHAR2(20) PRIMARY KEY,
  sales_name varchar2(20),
  department varchar2(20)
);
EXECUTE DBMS_WM.EnableVersioning ('sales_dimension', 'VIEW_WO_OVERWRITE', FALSE, TRUE);


INSERT INTO sales_dimension VALUES(
  'S01',
  'John',
  'IT',
  WMSYS.WM_PERIOD(TO_DATE('01/01/2015', 'DD/MM/YYYY'), 
                  TO_DATE('01/01/2018', 'DD/MM/YYYY'))
);
INSERT INTO sales_dimension VALUES(
  'S01',
  'John',
  'SALES',
  WMSYS.WM_PERIOD(TO_DATE('01/01/2018', 'DD/MM/YYYY'), 
                  TO_DATE('01/05/2018', 'DD/MM/YYYY'))
);
INSERT INTO sales_dimension VALUES(
  'S01',
  'John',
  'IT',
  WMSYS.WM_PERIOD(TO_DATE('01/05/2018', 'DD/MM/YYYY'), 
                  TO_DATE('31/12/2018', 'DD/MM/YYYY'))
);

EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2018', 'DD/MM/YYYY'),TO_DATE('31/12/2018', 'DD/MM/YYYY'));

update sales_dimension set department = 'RETAIL' where sales_id = 'S01';

select sales_id, sales_name,department,   TO_CHAR(s.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(s.wm_valid.validTill,'dd/mm/yyyy') end_date
from SALES_DIMENSION  s;

--- create time dimension table  in 2018---
CREATE
  TABLE time_dimension AS
SELECT
  n AS Date_key,
  TO_DATE('31/12/2017','DD/MM/YYYY')        + NUMTODSINTERVAL(n,'day') Full_Date,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DD')
  AS Days,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DAY')
  AS Days_NAME,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'), 'DY')
                                                                             AS DAYs_SHORT_NAME,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'D') AS
  Days_of_week,
  1 +TRUNC(last_day(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day')
  ))-TRUNC(TO_DATE( '31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),'MM')
  AS last_day_number_in_month,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,
      'DAY')                                      IN ('SUN','SAT')
    THEN 'Y'
    ELSE 'N'
  END AS weekend_flag,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Mon')
  AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'MM')
  AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Month'
  ) AS Month_Long,
  TO_CHAR(TO_DATE('31/12/2017','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'YYYY')
  AS YEAR
FROM
  (
    SELECT
      LEVEL n
    FROM
      dual
      CONNECT BY LEVEL <= 1000
  );
 
 
