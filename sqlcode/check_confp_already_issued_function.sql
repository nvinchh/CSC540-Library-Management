 create or replace function alreayIssuedConfp(patron_Id in VARCHAR2, cISSN in VARCHAR2,cLid in NUMBER)
return BOOLEAN
is
  pId NUMBER;
begin
    SELECT count(J.P_ID)
    INTO  pId
    FROM CONFP_CHECKOUT J
    WHERE J.P_ID = patron_Id
    AND J.RESOURCE_ID=cISSN
    AND J.L_ID=cLid;
if(pId=1) then
return true;
else
return false;
end if;
end;