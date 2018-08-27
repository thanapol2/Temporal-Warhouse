CREATE TABLE LOT (
  LOT_ID_NUM VARCHAR2(20) PRIMARY KEY,
  GNDR VARCHAR2(1)
);

EXECUTE DBMS_WM.EnableVersioning ('LOT', 'VIEW_WO_OVERWRITE', FALSE, TRUE);

INSERT INTO LOT VALUES(
  101,
  'C',
  WMSYS.WM_PERIOD(TO_DATE('01/01/2015', 'DD/MM/YYYY'), 
                  TO_DATE('01/01/2018', 'DD/MM/YYYY'))
);
INSERT INTO LOT VALUES(
  101,
  'S',
  WMSYS.WM_PERIOD(TO_DATE('01/01/2018', 'DD/MM/YYYY'), 
                  TO_DATE('31/12/9999', 'DD/MM/YYYY'))
);
INSERT INTO LOT VALUES(
  102,
  'C',
  WMSYS.WM_PERIOD(TO_DATE('07/02/2016', 'DD/MM/YYYY'))
);
INSERT INTO LOT VALUES(
  103,
  'S',
  WMSYS.WM_PERIOD(TO_DATE('01/08/2017', 'DD/MM/YYYY'), 
                  TO_DATE('31/12/9999', 'DD/MM/YYYY'))
);