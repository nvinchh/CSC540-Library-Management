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
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
       if(alreayIssuedJournal(patronId,jISSN,jLid)=false) then
                 --DBMS_OUTPUT.put_line('here2');
               SELECT QUANTITY INTO  qty FROM JOURNALS WHERE (ISSN = jISSN AND L_ID = jLid);
               if(qty>0) then
                  insert into JOURNALS_CHECKOUT values(jISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronId,jLid,null);
                  update journals set quantity=(qty-1) where( ISSN=jISSN AND L_ID=jLid);
               ELSE
               if(alreadyQueuedJournal(patronId,jISSN,jLid)=false)then 
               queueJournal(patronId, jISSN,jLid, varType);
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;

END;

-- Procedure to checkout books
CREATE OR REPLACE PROCEDURE BCheckout(bISBN VARCHAR2,jLid NUMBER,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--DBMS_OUTPUT.PUT_LINE('here1');
--Determinw whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;

-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
 --DBMS_OUTPUT.PUT_LINE('here2');
    if(bookReserved(bISBN)=false) then
    --DBMS_OUTPUT.PUT_LINE('here3');
       if(alreayIssuedBook(patronId,bISBN,jLid)=false) then
               SELECT B_QUANTITY INTO  qty FROM BOOKS WHERE (ISBN = bISBN AND L_ID = jLid);
               if(qty>0) then
                  insert into BOOKS_CHECKOUT values(bISBN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronId,jLid,null);
                  update BOOKS set B_QUANTITY=(qty-1) where( ISBN=bISBN AND L_ID=jLid);
               ELSE
                if(alreayQueuedbooks(patronId,bISBN,jLid)= false) then
                queueBook(patronId, bISBN, jLid, varType); 
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
    else
    --DBMS_OUTPUT.PUT_LINE('here44');
       if(checkPatronCourse(bISBN,patronId)) then
       --DBMS_OUTPUT.PUT_LINE('here5');
               if(alreayIssuedBook(patronId,bISBN,jLid)=false) then
               SELECT B_QUANTITY INTO  qty FROM BOOKS WHERE (ISBN = bISBN AND L_ID = jLid);
               if(qty>0) then
                  insert into BOOKS_CHECKOUT values(bISBN,LOCALTIMESTAMP,LOCALTIMESTAMP+12,patronID,jLid,null);
                  update BOOKS set B_QUANTITY=(qty-1) where( ISBN=bISBN AND L_ID=jLid);
               if(alreayQueuedbooks(patronId,bISBN,jLid)= false) then
                queueBook(patronId, bISBN, jLid, varType);
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
       end if;
    end if;
 end if;

END;