SELECT F.FDYD_ID,
  f.HD_CNT,
  TO_CHAR(f.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f.wm_valid.validTill,'dd/mm/yyyy') end_date
FROM FDYD_LT F
WHERE WM_OVERLAPS(f.wm_valid, wm_period(TO_DATE('01-01-2014', 'MM-DD-YYYY'), TO_DATE('01-01-2019', 'MM-DD-YYYY'))) = 1;
SELECT F.FDYD_ID,
  f.HD_CNT,
  TO_CHAR(f.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f.wm_valid.validTill,'dd/mm/yyyy') end_date
FROM FDYD f;
SELECT F.FDYD_ID,
  f.HD_CNT,
  TO_CHAR(f.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f.wm_valid.validTill,'dd/mm/yyyy') end_date
FROM FDYD_LT f;


SELECT F1.FDYD_ID,
  f1.HD_CNT,
  TO_CHAR(f1.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f1.wm_valid.validTill,'dd/mm/yyyy') end_date,
  F2.FDYD_ID,
  f2.HD_CNT,
  TO_CHAR(f2.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f2.wm_valid.validTill,'dd/mm/yyyy') end_date
FROM
  ( SELECT F.FDYD_ID, f.HD_CNT, f.wm_valid FROM FDYD_LT f
  ) f1
INNER JOIN
  (SELECT F.FDYD_ID, f.HD_CNT, f.wm_valid FROM FDYD_LT f
  ) f2
ON WM_OVERLAPS(f1.wm_valid, f2.wm_valid) = 1
AND f1.FDYD_ID                          != F2.FDYD_ID;

select WM_LDIFF(
   WM_PERIOD(
      TO_DATE('01-01-1980', 'MM-DD-YYYY'), 
      TO_DATE('01-01-1990', 'MM-DD-YYYY')),
   WM_PERIOD(
      TO_DATE('01-01-1985', 'MM-DD-YYYY'), 
      TO_DATE('01-01-1988', 'MM-DD-YYYY')))
      from dual