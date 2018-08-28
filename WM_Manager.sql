CREATE TABLE FDYD (
  FDYD_ID VARCHAR2(20) PRIMARY KEY,
  HD_CNT NUMBER
);
EXECUTE DBMS_WM.EnableVersioning ('FDYD', 'VIEW_WO_OVERWRITE', FALSE, TRUE);

select *
from FDYD;


select F.FDYD_ID,f.HD_CNT,to_char(f.wm_valid.validFrom,'dd/mm/yyyy') start_date
,to_char(f.wm_valid.validTill,'dd/mm/yyyy') end_date from FDYD_LT f; 
--where f.wm_valid.validFrom >=DBMS_WM.MIN_TIME and f.wm_valid.validTill <=DBMS_WM.MAX_TIME ;

INSERT INTO FDYD VALUES(
  201,
  20,
  WMSYS.WM_PERIOD(TO_DATE('01/01/2015', 'DD/MM/YYYY'), 
                  TO_DATE('01/01/2018', 'DD/MM/YYYY'))
);
INSERT INTO FDYD VALUES(
  201,
  25,
  WMSYS.WM_PERIOD(TO_DATE('01/01/2018', 'DD/MM/YYYY'), 
                  TO_DATE('31/12/9999', 'DD/MM/YYYY'))
);
INSERT INTO FDYD VALUES(
  202,
  40,
  WMSYS.WM_PERIOD(TO_DATE('07/02/2016', 'DD/MM/YYYY'),DBMS_WM.MAX_TIME)
);
INSERT INTO FDYD VALUES(
  203,
  50,
  WMSYS.WM_PERIOD(TO_DATE('01/08/2017', 'DD/MM/YYYY'), 
                  TO_DATE('31/12/9999', 'DD/MM/YYYY'))
);

INSERT INTO FDYD VALUES(
  202,
  45,
  WMSYS.WM_PERIOD(TO_DATE('01/02/2017', 'DD/MM/YYYY'), DBMS_WM.UNTIL_CHANGED)
);

