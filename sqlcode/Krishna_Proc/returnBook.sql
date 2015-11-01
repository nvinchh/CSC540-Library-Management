create or replace procedure returnBook(bISBN IN VARCHAR2,patron_Id in VARCHAR2,bLid in NUMBER)
IS
qCount NUMBER;
pId VARCHAR2(20);
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
 BCheckout(bISBN,bLid,pId);
  delete from queue_books where resource_id=bISBN and P_ID=pId;
 update queue_books set queue_no_b = (SELECT queue_no_b-1
                                       FROM queue_books 
                                       WHERE  RESOURCE_ID = bISBN and L_ID = bLid) where( RESOURCE_ID =bISBN AND L_id = bLid);
 end if;
END;