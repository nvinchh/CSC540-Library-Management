-- Procedure to checkout journals
CREATE OR REPLACE PROCEDURE JCheckout(jISSN VARCHAR2,jLid NUMBER,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN

--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;
DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
 DBMS_OUTPUT.put_line('here2');
       if(alreayIssuedJournal(patronId,jISSN,jLid)=false) then
        DBMS_OUTPUT.put_line('here3');
               SELECT QUANTITY INTO  qty FROM JOURNALS WHERE (ISSN = jISSN AND L_ID = jLid);
               if(qty>0) then
                DBMS_OUTPUT.put_line('here4');
                  insert into JOURNALS_CHECKOUT values(jISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronID,jLid);
                  update journals set quantity=(qty-1) where( ISSN=jISSN AND L_ID=jLid);
               ELSE
                DBMS_OUTPUT.put_line('here5');
               queueJournal(patronId,jISSN,jLid,varType);
               end if;
               --need to add into queue if qty<1
       end if;
 end if;

END;