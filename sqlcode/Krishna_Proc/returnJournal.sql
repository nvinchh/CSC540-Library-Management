create or replace procedure returnJournal(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
BEGIN
 SELECT count(*)
 INTO qCount
 FROM queue_journals
 WHERE l_id = bLid AND resource_id = bISBN;
   update journals_checkout set status='N' where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL AND 
 localtimestamp > duedate;
 update journals_checkout set RETURNDATE=localtimestamp where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL;
 update journals set QUANTITY=QUANTITY+1 where ISSN=bISBN AND L_ID=bLid;
  if(qCount>0) then
  SELECT P_ID
 INTO pId
 FROM queue_journals
 WHERE l_id = bLid AND resource_id = bISBN AND QUEUE_NO_J=1;
 JCheckout(bISBN,bLid,pId);
 delete from queue_journals where resource_id=bISBN and P_ID=pId;
 update queue_journals set queue_no_j = (SELECT queue_no_j-1
                                       FROM queue_journals 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;