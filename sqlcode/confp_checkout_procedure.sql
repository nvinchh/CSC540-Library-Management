 -- Procedure to checkout journals
CREATE OR REPLACE PROCEDURE ConfCheckout(cISSN VARCHAR2,cLid NUMBER,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
 DBMS_OUTPUT.PUT_LINE('Here1');
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;
 DBMS_OUTPUT.PUT_LINE('Here2');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
  DBMS_OUTPUT.PUT_LINE('Here3');
       if(alreayIssuedConfp(patronId,cISSN,cLid)=false) then
        DBMS_OUTPUT.PUT_LINE('Here4');
               SELECT QUANTITY INTO  qty FROM CONFPROCEEDINGS WHERE (CONF_NUM = cISSN AND L_ID = cLid);
               if(qty>0) then
                  insert into CONFP_CHECKOUT values(cISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronID,cLid);
                  update CONFPROCEEDINGS set quantity=(qty-1) where( CONF_NUM=cISSN AND L_ID=cLid);
               else
                  --if(varType='s') then
                  queueConf(patronId,cISSN,cLid,varType);
                  --end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;

END;