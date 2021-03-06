  CREATE TABLE "ITEM_ZONE_MASTER_T" 
   (	"ITEM_CD" VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	"ZONE_ID" VARCHAR2(3 BYTE) NOT NULL ENABLE, 
	"PURCHASE_ITEM" VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL ENABLE, 
	"SELL_ITEM" VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL ENABLE, 
	"UNIT_QTY" NUMBER(10,3) NOT NULL ENABLE, 
	"COST" NUMBER(10,3) NOT NULL ENABLE, 
	"PRICE" NUMBER(10,3) NOT NULL ENABLE, 
	"COST_PER_PACK" NUMBER(13,3) NOT NULL ENABLE, 
	"CREATE_DATE" DATE NOT NULL ENABLE, 
	"UPDATE_DATE" DATE NOT NULL ENABLE, 
	 CONSTRAINT "ITEM_ZONE_MASTER_T_PK" PRIMARY KEY ("ITEM_CD", "ZONE_ID")
   ) ;
  ALTER TABLE "ITEM_ZONE_MASTER_T" ADD PERIOD FOR VALID_TIME;