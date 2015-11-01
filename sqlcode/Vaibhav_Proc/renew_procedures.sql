Create or Replace PROCEDURE booksRenew(bISBN VARCHAR2,patronId VARCHAR2,bLid Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
      if(isQueueBook(bISBN)=false) then
        update books_checkout set Status='N' where fine>0 and resource_id=bISBN and p_id=patronId and returndate is null;
        update journals_checkout set returndate=localtimestamp where resource_id=bISBN and p_id=patronId and returndate is null;
        insert into books_checkout values(bISBN,LOCALTIMESTAMP,LOCALTIMESTAMP + INTERVAL '14' DAY,patronId,bLid,null,0,null);
      end if;  
 end if;     
end; 

Create or Replace PROCEDURE journalsRenew(jISSN VARCHAR2,patronId VARCHAR2,jLid Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
      if(isQueueJournal(jISSN)=false) then
        update journals_checkout set Status='N' where fine>0 and resource_id=jISSN and p_id=patronId and returndate is null;
        update journals_checkout set returndate=localtimestamp where resource_id=jISSN and p_id=patronId and returndate is null;
        insert into journals_checkout values(jISSN,LOCALTIMESTAMP,LOCALTIMESTAMP + INTERVAL '12' HOUR,patronId,jLid,null,0,null);
      end if;  
 end if;     
end; 

--exec JOURNALSRENEW('J1','S1',1);
--update journals_checkout set returndate=localtimestamp where resource_id='J1' and p_id='S1' and returndate=null;
--select * from journals_checkout; 
--select * from journals_checkout where returndate is null

Create or Replace PROCEDURE confpRenew(cCONFNUM VARCHAR2,patronId VARCHAR2,cLid Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
      if(isQueueConfp(cCONFNUM)=false) then
        update confp_checkout set Status='N' where fine>0 and resource_id=cCONFNUM and p_id=patronId and returndate is null;
        update confp_checkout set returndate=localtimestamp where resource_id=cCONFNUM and p_id=patronId and returndate is null;
        insert into confp_checkout values(cCONFNUM,LOCALTIMESTAMP,LOCALTIMESTAMP + INTERVAL '12' HOUR,patronId,cLid,null,0,null);
      end if;  
 end if;     
end;