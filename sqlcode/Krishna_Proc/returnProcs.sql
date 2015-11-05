--Return Book

create or replace procedure returnBook(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
result Number;
BEGIN
 SELECT count(*)
 INTO qCount
 FROM queue_books
 WHERE l_id = bLid AND resource_id = bISBN;
 update books_checkout set status='N' where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL AND 
 localtimestamp > duedate;
 update books_checkout set RETURNDATE=localtimestamp where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL;
 update BOOKS set B_QUANTITY=B_QUANTITY+1 where ISBN=bISBN AND L_ID=bLid;
  if(qCount>0) then
  SELECT P_ID
 INTO pId
 FROM queue_books
 WHERE l_id = bLid AND resource_id = bISBN AND QUEUE_NO_B=1;
 BCheckout(bISBN,bLid,pId,result);
  delete from queue_books where resource_id=bISBN and P_ID=pId;
 update queue_books set queue_no_b = (SELECT queue_no_b-1
                                       FROM queue_books 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;

--return journal

create or replace procedure returnJournal(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
result NUMBER;
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
 JCheckout(bISBN,bLid,pId,result);
 delete from queue_journals where resource_id=bISBN and P_ID=pId;
 update queue_journals set queue_no_j = (SELECT queue_no_j-1
                                       FROM queue_journals 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;

--return confp

create or replace procedure returnConfp(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
result NUMBER;
BEGIN
 SELECT count(*)
 INTO qCount
 FROM QUEUE_CONFPRO
 WHERE l_id = bLid AND resource_id = bISBN;
  update CONFP_CHECKOUT set status='N' where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL AND 
 localtimestamp > duedate;
 update CONFP_CHECKOUT set RETURNDATE=localtimestamp where RESOURCE_ID=bISBN AND P_ID=patron_Id AND L_ID=bLid AND RETURNDATE IS NULL;
 update CONFPROCEEDINGS set QUANTITY=QUANTITY+1 where CONF_NUM=bISBN AND L_ID=bLid;
  if(qCount>0) then
  SELECT P_ID
 INTO pId
 FROM QUEUE_CONFPRO
 WHERE l_id = bLid AND resource_id = bISBN AND QUEUE_NO_CP=1;
 CONFCHECKOUT(bISBN,bLid,pId,result);
 delete from QUEUE_CONFPRO where resource_id=bISBN and P_ID=pId;
 update QUEUE_CONFPRO set queue_no_cp = (SELECT queue_no_cp-1
                                       FROM QUEUE_CONFPRO 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;