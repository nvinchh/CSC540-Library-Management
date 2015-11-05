create or replace procedure Rrequested(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_books B where B.P_ID = patron_id;
END;

create or replace procedure Rrequested1(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_journals J where J.P_ID= patron_id;
END;

create or replace procedure Rrequested2(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_confpro CP where CP.P_ID= patron_id;
END;

create or replace procedure Rrequested3(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_ebooks EB where EB.P_ID = patron_id;
END;
create or replace procedure Rrequested4(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_econfpro ECP where ECP.P_ID= patron_id;
END;

create or replace procedure Rrequested5(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from queue_ejournals EJ where EJ.P_ID= patron_id;
END;
