 -- Procedure to checkout journals
CREATE OR REPLACE PROCEDURE ConfCheckout (cISSN NUMBER,cLid NUMBER,patronId NUMBER)
IS
     varType CHAR;
     qty NUMBER;
BEGIN

--Determinw whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;

-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
       if(alreayIssuedConfp(patronId,cISSN,cLid)=false) then
               SELECT QUANTITY INTO  qty FROM CONFPROCEEDINGS WHERE (CONF_NUM = cISSN AND L_ID = cLid);
               if(qty>0) then
                  insert into CONFP_CHECKOUT values(cISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronID,cLid);
                  update CONFPROCEEDINGS set quantity=(qty-1) where( CONF_NUM=cISSN AND L_ID=cLid);
               -- else
                  --if(varType='s') then
                  
                  --end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;

END;