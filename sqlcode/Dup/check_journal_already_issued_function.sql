create or replace function alreayIssuedJournal(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM JOURNALS_CHECKOUT J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=jISSN
    AND J.RETURNDATE IS NULL
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;

 create or replace function alreayIssuedBook(patron_Id in VARCHAR2, bISBN in VARCHAR2,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM BOOKS_CHECKOUT J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=bISBN
    AND J.RETURNDATE IS NULL
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;


 create or replace function bookReserved(bISBN in VARCHAR2)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.RSVD_ID)
    INTO  pId
    FROM Reserved J
    WHERE J.RSVD_ID=bISBN;
if(pId=1) then
return true;
else
return false;
end if;
end;


create or replace function checkPatronCourse(bISBN in VARCHAR2,patron_Id in VARCHAR2)
return BOOLEAN
is
  cId VARCHAR2(20);
  pId NUMBER;
  varType CHAR;
begin
--DBMS_OUTPUT.PUT_LINE('here45');
    SELECT J.C_ID
    INTO  cId
    FROM BOOKS J
    WHERE J.ISBN=bISBN;
    --DBMS_OUTPUT.PUT_LINE('here49');
    SELECT P.TYPE
    INTO varType
    FROM PATRONS P
    WHERE P.P_ID=patron_Id;
    --DBMS_OUTPUT.PUT_LINE('here47');
    if(varType='S') then
    --DBMS_OUTPUT.PUT_LINE('here46');
          SELECT count(S_ID)
          INTO pId
          FROM ENROLS
          WHERE S_ID=patron_Id
          AND C_ID=cId;
          if(pId=1) then
          return true;
          else
          return false;
          end if;
    else
        --DBMS_OUTPUT.PUT_LINE('here74');
          SELECT count(F_ID)
          INTO pId
          FROM TEACHES
          WHERE F_ID=patron_Id
          AND C_ID=cId;
          if(pId=1) then
          return true;
          else
          return false;
          end if;
end if;
end;

create or replace function alreayQueuedJournal(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM queue_journals J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=jISSN
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;

create or replace function alreayQueuedconfproceedings(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM queue_confpro J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=jISSN
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;

create or replace function alreayQueuedbooks(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM queue_books J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=jISSN
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;