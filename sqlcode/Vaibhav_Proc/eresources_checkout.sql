Create or Replace PROCEDURE EbooksCheckout(eISBN VARCHAR2,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
        if(alreayIssuedEBook(patronId,eISBN)=false) then
        SELECT QUANTITY INTO  qty FROM EBOOKS WHERE (ISBN = eISBN);
               if(qty>0) then
                  insert into EBOOKS_CHECKOUT values(eISBN,LOCALTIMESTAMP,NULL,patronId);
                  update EBOOKS set quantity=(qty-1) where( ISBN=eISBN);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;
/

--exec EBOOKSCHECKOUT('B1','S1');

Create or Replace PROCEDURE EjournalsCheckout(eISSN VARCHAR2,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
        if(alreayIssuedEJournal(patronId,eISSN)=false) then
        SELECT QUANTITY INTO  qty FROM EJOURNALS WHERE (ISSN = eISSN);
               if(qty>0) then
                  insert into EJOURNALS_CHECKOUT values(eISSN,LOCALTIMESTAMP,NULL,patronId);
                  update EJOURNALS set quantity=(qty-1) where( ISSN=eISSN);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;
/

Create or Replace PROCEDURE EconfpCheckout(eCONFNUM VARCHAR2,patronId VARCHAR2)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
        --  DBMS_OUTPUT.put_line('here2');
        if(alreayIssuedEconfp(patronId,eCONFNUM)=false) then
        SELECT QUANTITY INTO  qty FROM ECONFPROCEEDINGS WHERE (CONF_NUM=eCONFNUM);
               if(qty>0) then
                  insert into ECONFP_CHECKOUT values(eCONFNUM,LOCALTIMESTAMP,NULL,patronId);
                  update ECONFPROCEEDINGS set quantity=(qty-1) where( CONF_NUM=eCONFNUM);
               ELSE
               DBMS_OUTPUT.PUT_LINE('Not enough Quantity');
               end if;
         end if;
end if;
end;
/

