--- Create Temporal Table
CREATE TABLE LOT_LOC
  (
    FDYD_ID    VARCHAR2(20) ,
    LOT_ID_NUM VARCHAR2(20) ,
    PEN_ID     VARCHAR2(20) ,
    HD_CNT     VARCHAR2(20) ,
    START_DATE DATE ,
    END_DATE   DATE ,
    PERIOD FOR lot_loc_valid_time (START_DATE, END_DATE)
  );
-- Select : Point of Time Case
SELECT *
FROM lot_loc AS OF period FOR lot_loc_valid_time sysdate;
-- Select : Valid Time Case
SELECT *
FROM lot_loc versions period FOR lot_loc_valid_time BETWEEN to_date('08/02/2012','dd/mm/yyyy') AND to_date('10/03/2012','dd/mm/yyyy');

-- Temporal Join
SELECT l1.lot_id_num,
  l2.lot_id_num,
  L1.Pen_id,
  L1.start_date ,
  l1.end_date,
  L2.start_date ,
  l2.end_date
FROM lot_loc VERSIONS PERIOD FOR lot_loc_valid_time BETWEEN to_date('25/02/2012','dd/mm/yyyy') AND sysdate l1
INNER JOIN lot_loc VERSIONS PERIOD FOR lot_loc_valid_time BETWEEN to_date('25/02/2012','dd/mm/yyyy') AND sysdate l2
ON L1.FDYD_ID     = L2.FDYD_ID
AND l1.pen_id     = l2.pen_id
AND l1.lot_id_num < l2.lot_id_num
AND (L1.start_date,L1.end_date) overlaps (L2.start_date,L2.end_date);
