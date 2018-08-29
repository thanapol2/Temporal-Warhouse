EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2003', 'DD/MM/YYYY'), TO_DATE('31/12/9999', 'DD/MM/YYYY'));
SELECT F.FDYD_ID,
  f.HD_CNT,
  TO_CHAR(f.wm_valid.validFrom,'dd/mm/yyyy') start_date ,
  TO_CHAR(f.wm_valid.validTill,'dd/mm/yyyy') end_date
FROM FDYD F
order by FDYD_ID,f.wm_valid.validFrom;

-- INSERT CASE
INSERT INTO FDYD VALUES(
  204,
  100,
  WMSYS.WM_PERIOD(TO_DATE('01/12/2018', 'DD/MM/YYYY'),
                  TO_DATE('01/12/2020', 'DD/MM/YYYY'))
);

-- Delete Case
EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2010', 'DD/MM/YYYY')
,TO_DATE('01/01/2022', 'DD/MM/YYYY'));

delete FDYD where FDYD_id = '204';

-- Update Case
EXECUTE DBMS_WM.SetValidTime(TO_DATE('01/01/2010', 'DD/MM/YYYY')
,TO_DATE('31/12/2022', 'DD/MM/YYYY'));
update FDYD set HD_CNT = 41 where FDYD_ID = '204'