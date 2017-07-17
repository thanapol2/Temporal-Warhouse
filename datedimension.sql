CREATE
  TABLE d_date AS
SELECT
  n AS Date_id,
  TO_DATE('31/12/2007','DD/MM/YYYY')        + NUMTODSINTERVAL(n,'day') Full_Date,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DD')
  AS Days,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DAY')
  AS Days_NAME,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'), 'DY')
                                                                             AS DAYs_SHORT_NAME,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'D') AS
  Days_of_week,
  1 +TRUNC(last_day(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day')
  ))-TRUNC(TO_DATE( '31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),'MM')
  AS last_day_number_in_month,
  TO_CHAR(TO_DATE('30/09/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),'YYYY/Q'
  ) Fiscal_quarter,
  TO_CHAR(TO_DATE('30/09/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),
  'YYYY/MM') Year_month,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,
      'DAY')                                      IN ('SUN','SAT')
    THEN 'Y'
    ELSE 'N'
  END AS weekend_flag,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Mon')
  AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'MM')
  AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Month'
  ) AS Month_Long,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'YYYY')
  AS YEAR
FROM
  (
    SELECT
      LEVEL n
    FROM
      dual
      CONNECT BY LEVEL <= 1000
  );
  
insert into d_date SELECT
  n AS Date_id,
  TO_DATE('31/12/2007','DD/MM/YYYY')        + NUMTODSINTERVAL(n,'day') Full_Date,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DD')
  AS Days,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'DAY')
  AS Days_NAME,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'), 'DY')
                                                                             AS DAYs_SHORT_NAME,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'D') AS
  Days_of_week,
  1 +TRUNC(last_day(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day')
  ))-TRUNC(TO_DATE( '31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),'MM')
  AS last_day_number_in_month,
  TO_CHAR(TO_DATE('30/09/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),'YYYY/Q'
  ) Fiscal_quarter,
  TO_CHAR(TO_DATE('30/09/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day'),
  'YYYY/MM') Year_month,
  CASE
    WHEN TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,
      'DAY')                                      IN ('SUN','SAT')
    THEN 'Y'
    ELSE 'N'
  END AS weekend_flag,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Mon')
  AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'MM')
  AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'Month'
  ) AS Month_Long,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY')+ NUMTODSINTERVAL(n,'day') ,'YYYY')
  AS YEAR
FROM
  (
    SELECT
      LEVEL n
    FROM
      dual
      CONNECT BY LEVEL <= 1000
  );