-- Procedure to checkout journals
CREATE OR REPLACE PROCEDURE JCheckout (jISSN VARCHAR2,jLid NUMBER,patronId VARCHAR2)
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
       if(alreayIssuedJournal(patronId,jISSN,jLid)=false) then
               SELECT QUANTITY INTO  qty FROM JOURNALS WHERE (ISSN = jISSN AND L_ID = jLid);
               if(qty>0) then
                  insert into JOURNALS_CHECKOUT values(jISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronID,jLid);
                  update journals set quantity=(qty-1) where( ISSN=jISSN AND L_ID=jLid);
               -- else
                  --if(varType='s') then
                  
                  --end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;

END;