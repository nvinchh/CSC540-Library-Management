create or replace function alreayIssuedEBook(patron_Id in VARCHAR2, eISBN in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(E.P_ID)
    INTO  pId
    FROM EBOOKS_CHECKOUT E
    WHERE E.P_ID=patron_Id
    AND E.RESOURCE_ID=eISBN
    AND E.RETURNDATE=NULL;
if(pId=1) then
return true;
else
return false;
end if;
end;

create or replace function checkHold (patron_Id in VARCHAR2, var_Type in CHAR)
return BOOLEAN
is
  on_Hold NUMBER;
begin
--DBMS_OUTPUT.put_line('here67');
if(var_Type='S') then
        SELECT ONHOLD
        INTO  on_Hold
        FROM STUDENTS S
        WHERE S.S_ID= patron_Id;
else
        SELECT ONHOLD
        INTO  on_Hold
        FROM FACULTY F
        WHERE F.F_ID= patron_Id;
end if;
if(on_Hold=1)then
--DBMS_OUTPUT.put_line('heref');
return false;
else
--DBMS_OUTPUT.put_line('heret');
return true;
end if;
end;

create or replace function alreayIssuedEJournal(patron_Id in VARCHAR2, eISSN in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(E.P_ID)
    INTO  pId
    FROM EJOURNALS_CHECKOUT E
    WHERE E.P_ID=patron_Id
    AND E.RESOURCE_ID=eISSN
    AND E.RETURNDATE=NULL;
if(pId=1) then
return true;
else
return false;
end if;
end;


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
    AND E.RETURNDATE=NULL;
if(pId=1) then
return true;
else
return false;
end if;
end;

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