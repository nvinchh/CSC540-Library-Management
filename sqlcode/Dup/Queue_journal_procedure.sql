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