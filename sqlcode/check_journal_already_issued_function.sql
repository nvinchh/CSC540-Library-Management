 create or replace function alreayIssuedJournal(patron_Id in NUMBER, jISSN in VARCHAR,jLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM JOURNALS_CHECKOUT J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=jISSN
    AND J.L_ID=jLid;
if(pId=1) then
return true;
else
return false;
end if;
end;