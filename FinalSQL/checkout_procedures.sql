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
    AND J.RETURNDATE IS NULL;
if(pId=1) then
return true;
else
return false;
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

-- Procedure to checkout journals
CREATE OR REPLACE PROCEDURE JCheckout (jISSN VARCHAR2,jLid NUMBER,patronId VARCHAR2,result OUT NUMBER)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
result := 0;
--Determinw whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;
 -- DBMS_OUTPUT.put_line('here1');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
      --   DBMS_OUTPUT.put_line('here2');
        result:=1;
       if(alreayIssuedJournal(patronId,jISSN,jLid)=false) then
              --   DBMS_OUTPUT.put_line('here2');
                -- result:=2;
               SELECT QUANTITY INTO  qty FROM JOURNALS WHERE (ISSN = jISSN AND L_ID = jLid);
               if(qty>0) then
                  insert into JOURNALS_CHECKOUT values(jISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+interval '12' hour,patronId,jLid,null,0,null,default);
                  update journals set quantity=(qty-1) where( ISSN=jISSN AND L_ID=jLid);
                  result:=2;
               ELSE
               if(alreayQueuedJournal(patronId,jISSN,jLid)=false)then 
               queueJournal(patronId, jISSN,jLid, varType);
               result :=3;
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;
--DBMS_OUTPUT.PUT_LINE("result"||result);
commit;
END;



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
    AND J.RETURNDATE IS NULL;
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

-- Procedure to checkout books
CREATE OR REPLACE PROCEDURE BCheckout(bISBN VARCHAR2,jLid NUMBER,patronId VARCHAR2,result OUT Number)
IS
     varType CHAR;
     qty NUMBER;
     dueDate timestamp;
BEGIN
result:=0;
--DBMS_OUTPUT.PUT_LINE('here1');
--Determinw whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;
   if(varType='S') then
                  dueDate := LOCALTIMESTAMP + 14;
                  else
                  dueDate := LOCALTIMESTAMP + 30;
                  end if;
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
 --DBMS_OUTPUT.PUT_LINE('here2');
    if(bookReserved(bISBN)=false) then
    --DBMS_OUTPUT.PUT_LINE('here3');
       if(alreayIssuedBook(patronId,bISBN,jLid)=false) then
               SELECT B_QUANTITY INTO  qty FROM BOOKS WHERE (ISBN = bISBN AND L_ID = jLid);
               if(qty>0) then
                  result:=1;
                  insert into BOOKS_CHECKOUT values(bISBN,LOCALTIMESTAMP,dueDate,patronId,jLid,null,0,null,default);
                  update BOOKS set B_QUANTITY=(qty-1) where( ISBN=bISBN AND L_ID=jLid);
               ELSE
                if(alreayQueuedbooks(patronId,bISBN,jLid)= false) then
                queueBook(patronId, bISBN, jLid, varType); 
               result:=2;
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
    else
    --DBMS_OUTPUT.PUT_LINE('here44');
    dueDate := LOCALTIMESTAMP + interval '4' hour;
       if(checkPatronCourse(bISBN,patronId)) then
       --DBMS_OUTPUT.PUT_LINE('here5');
               if(alreayIssuedBook(patronId,bISBN,jLid)=false) then
               SELECT B_QUANTITY INTO  qty FROM BOOKS WHERE (ISBN = bISBN AND L_ID = jLid);
               if(qty>0) then
                  result:=1;
                  insert into BOOKS_CHECKOUT values(bISBN,LOCALTIMESTAMP,dueDate,patronID,jLid,null,0,null,default);
                  update BOOKS set B_QUANTITY=(qty-1) where( ISBN=bISBN AND L_ID=jLid);
               if(alreayQueuedbooks(patronId,bISBN,jLid)= false) then
                result:=2;
                queueBook(patronId, bISBN, jLid, varType);
               end if;
               end if;
               --need to add into queue if qty<1
       end if;
       end if;
    end if;
 end if;
commit;
END;


--Conference checkout Procedure

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
    AND J.RETURNDATE IS NULL;
if(pId=1) then
return true;
else
return false;
end if;
end;


CREATE OR REPLACE PROCEDURE ConfCheckout(cISSN VARCHAR2,cLid NUMBER,patronId VARCHAR2,result out NUMBER)
IS
     varType CHAR;
     qty NUMBER;
BEGIN
result:=0;
 --DBMS_OUTPUT.PUT_LINE('Here1');
--Determine whether faculty or student
   SELECT P.TYPE
   INTO  varType
    FROM PATRONS P
    WHERE P.P_ID = patronId;
 --DBMS_OUTPUT.PUT_LINE('Here2');
-- Check whether in hold or not
 if(checkHold(patronId,varType)) then
  --DBMS_OUTPUT.PUT_LINE('Here3');
       if(alreayIssuedConfp(patronId,cISSN,cLid)=false) then
        --DBMS_OUTPUT.PUT_LINE('Here4');
               SELECT QUANTITY INTO  qty FROM CONFPROCEEDINGS WHERE (CONF_NUM = cISSN AND L_ID = cLid);
               if(qty>0) then
                  result:=1;
                  insert into CONFP_CHECKOUT values(cISSN,LOCALTIMESTAMP,LOCALTIMESTAMP+ interval '12' hour,patronId,cLid,null,0,null,default);
                  update CONFPROCEEDINGS set quantity=(qty-1) where( CONF_NUM=cISSN AND L_ID=cLid);
               else
                  if(alreayQueuedconfproceedings(patronId,cISSN,cLid)=false)then 
                  queueConf(patronId,cISSN,cLid,varType);
                  result:=2;
                  end if;
               end if;
               --need to add into queue if qty<1
       end if;
 end if;
commit;
END;


create or replace procedure queueJournal(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER, pty in CHAR) 
IS
 tcount NUMBER;
 countst NUMBER;
BEGIN 
 SELECT count(*)
 INTO tcount
 FROM queue_journals
 WHERE l_id = jLid AND resource_id = jISSN;
 if(pty = 'S')
  then INSERT into queue_journals values(jISSN,tcount+1,patron_Id,pty,jLid);
 ELSE 
 SELECT count(*)
 INTO countst
 FROM queue_journals
 WHERE l_id = jLid AND resource_id = jISSN AND ptype = 'S';
 update queue_journals set queue_no_j = (SELECT queue_no_j+1
                                       FROM queue_journals 
                                       WHERE ptype = 'S' and RESOURCE_ID = jISSN and L_ID = jLid) where( RESOURCE_ID = jISSN AND L_id = jLid AND ptype = 'S');
  INSERT into queue_journals values(jISSN,(tcount-countst)+1,patron_Id,pty,jLid);
end if;
commit;
end;
 
 select * from queue_books;
create or replace procedure queueBook(patron_Id in VARCHAR2, jISSN in VARCHAR2,jLid in NUMBER, pty in CHAR) 
IS
 tcount NUMBER;
 countst NUMBER;
BEGIN 
 SELECT count(*)
 INTO tcount
 FROM queue_books
 WHERE l_id = jLid AND resource_id = jISSN;
 if(pty = 's')
  then INSERT into queue_books values(jISSN,tcount+1,patron_Id,pty,jLid);
 ELSE 
 SELECT count(*)
 INTO countst
 FROM queue_books
 WHERE l_id = jLid AND resource_id = jISSN AND ptype = 's';
 update queue_books set queue_no_b = (SELECT queue_no_b+1
                                       FROM queue_books 
                                       WHERE ptype = 's' and RESOURCE_ID = jISSN and L_ID = jLid) where( RESOURCE_ID = jISSN AND L_id = jLid AND ptype = 's');
  INSERT into queue_books values(jISSN,(tcount-countst)+1,patron_Id,pty,jLid);
end if;
end;

create or replace procedure queueConf(patron_Id in VARCHAR2, cp_confnum in VARCHAR2,cpLid in NUMBER, pty in CHAR) 
IS
 tcount NUMBER;
 countst NUMBER;
BEGIN 
 SELECT count(*)
 INTO tcount
 FROM queue_confpro
 WHERE l_id = cpLid AND resource_id = cp_confnum;
 if(pty = 'S')
  then INSERT into queue_confpro values(cp_confnum,tcount+1,patron_Id,pty,cpLid);
 ELSE 
 SELECT count(*)
 INTO countst
 FROM queue_confpro
 WHERE l_id = cpLid AND resource_id = cp_confnum AND ptype = 'S';
 update queue_confpro set queue_no_cp = (SELECT queue_no_cp+1
                                       FROM queue_confpro 
                                       WHERE ptype = 'S' and RESOURCE_ID = cp_confnum and L_ID = cpLid) where( RESOURCE_ID = cp_confnum AND L_id = cpLid AND ptype = 'S');
  INSERT into queue_confpro values(cp_confnum,(tcount-countst)+1,patron_Id,pty,cpLid);
end if;
commit;
end;
