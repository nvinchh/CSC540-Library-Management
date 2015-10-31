 create or replace function checkHold (patron_Id in VARCHAR2, var_Type in CHAR)
return BOOLEAN
is
  on_Hold NUMBER;
begin
DBMS_OUTPUT.put_line('here67');
if(var_Type='s') then
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
DBMS_OUTPUT.put_line('heref');
return false;
else
DBMS_OUTPUT.put_line('heret');
return true;
end if;
end;