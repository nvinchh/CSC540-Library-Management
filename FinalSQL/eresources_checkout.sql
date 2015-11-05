create or replace function isQueueBook(bISBN in VARCHAR2)
return BOOLEAN
is 
 qId NuMBER;
begin 
   SELECT count (E.RESOURCE_ID)
   INTO qId
   FROM QUEUE_BOOKS E
   where e.RESOURCE_ID=bISBN;
if(qId=0) then
return false;
else
return true;
end if;
end;

create or replace function alreadyIssuedEBook(patron_Id in VARCHAR2, eISBN in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(E.P_ID)
    INTO  pId
    FROM EBOOKS_CHECKOUT E
    WHERE E.P_ID=patron_Id
    AND E.RESOURCE_ID=eISBN
    AND E.RETURNDATE IS NULL;
if(pId>0) then
return true;
else
return false;
end if;
end;

Create or Replace PROCEDURE EbooksCheckout(eISBN VARCHAR2,patronId VARCHAR2,result OUT Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   result:=0;
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
          result:=1;
        --  DBMS_OUTPUT.put_line('here2');
        if(alreadyIssuedEBook(patronId,eISBN)=false) then
          result:=2;
        SELECT QUANTITY INTO  qty FROM EBOOKS WHERE (ISBN = eISBN);
         result:=3;
               if(qty>0) then
                  result:=4;
                  insert into EBOOKS_CHECKOUT values(eISBN,LOCALTIMESTAMP,NULL,patronId);
                  update EBOOKS set quantity=(qty-1) where( ISBN=eISBN);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;
/

--Ejournals
create or replace function isQueueJournal(eISSN in VARCHAR2)
return BOOLEAN
is
  qId NUMBER;
begin
    SELECT count(E.RESOURCE_ID)
    INTO  qId
    FROM QUEUE_JOURNALS E
    WHERE E.RESOURCE_ID=eISSN;
if(qId=0) then
return false;
else
return true;
end if;
end;

create or replace function alreadyIssuedEJournal(patron_Id in VARCHAR2, eISSN in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(E.P_ID)
    INTO  pId
    FROM EJOURNALS_CHECKOUT E
    WHERE E.P_ID=patron_Id
    AND E.RESOURCE_ID=eISSN
    AND E.RETURNDATE IS NULL;
if(pId>0) then
return true;
else
return false;
end if;
end;

Create or Replace PROCEDURE EjournalsCheckout(eISSN VARCHAR2,patronId VARCHAR2,result OUT Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   result:=0;
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
        if(alreadyIssuedEJournal(patronId,eISSN)=false) then
        SELECT QUANTITY INTO  qty FROM EJOURNALS WHERE (ISSN = eISSN);
               if(qty>0) then
                  result:=1;
                  insert into EJOURNALS_CHECKOUT values(eISSN,LOCALTIMESTAMP,NULL,patronId);
                  update EJOURNALS set quantity=(qty-1) where( ISSN=eISSN);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;
/

--ConferenceProceedings

create or replace function alreayIssuedEConfp(patron_Id in VARCHAR2, eCONFNUM in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(E.P_ID)
    INTO  pId
    FROM ECONFP_CHECKOUT E
    WHERE E.P_ID=patron_Id
    AND E.RESOURCE_ID=eCONFNUM
    AND E.RETURNDATE IS NULL;
if(pId>0) then
return true;
else
return false;
end if;
end;

create or replace function isQueueConfp(cCONFNUM in VARCHAR2)
return BOOLEAN
is 
 qId NUMBER;
begin 
   SELECT count (E.RESOURCE_ID)
   INTO qId
   FROM QUEUE_CONFPRO E
   where E.RESOURCE_ID=cCONFNUM;
if(qId=0) then
return false;
else
return true;
end if;
end;


Create or Replace PROCEDURE EconfpCheckout(eCONFNUM VARCHAR2,patronId VARCHAR2,result OUT Number)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
result:=0;
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
        if(alreayIssuedEconfp(patronId,eCONFNUM)=false) then
        SELECT QUANTITY INTO  qty FROM ECONFPROCEEDINGS WHERE (CONF_NUM=eCONFNUM);
               if(qty>0) then
                  result:=1;
                  insert into ECONFP_CHECKOUT values(eCONFNUM,LOCALTIMESTAMP,NULL,patronId);
                  update ECONFPROCEEDINGS set quantity=(qty-1) where( CONF_NUM=eCONFNUM);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;