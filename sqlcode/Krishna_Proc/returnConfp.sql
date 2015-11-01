create or replace procedure returnConfp(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
BEGIN
 SELECT count(*)
 INTO qCount
 FROM QUEUE_CONFPRO
 WHERE l_id = bLid AND resource_id = bISBN;
 update CONFP_CHECKOUT set RETURNDATE=localtimestamp where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL;
 update CONFPROCEEDINGS set QUANTITY=QUANTITY+1 where CONF_NUM=bISBN AND L_ID=bLid;
  if(qCount>0) then
  SELECT P_ID
 INTO pId
 FROM QUEUE_CONFPRO
 WHERE l_id = bLid AND resource_id = bISBN AND QUEUE_NO_CP=1;
 CONFCHECKOUT(bISBN,bLid,pId);
 delete from QUEUE_CONFPRO where resource_id=bISBN and P_ID=pId;
 update QUEUE_CONFPRO set queue_no_cp = (SELECT queue_no_cp-1
                                       FROM QUEUE_CONFPRO 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;