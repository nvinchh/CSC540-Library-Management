--create or replace procedure CheckOutRes(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
--IS
--BEGIN
--OPEN cur FOR
--select * from BOOKS_CHECKOUT B where B.P_ID = patron_id and B.RETURNDATE IS NULL
--union
--select * from JOURNALS_CHECKOUT J where J.P_ID= patron_id and J.RETURNDATE IS NULL
--union
--select * from CONFP_CHECKOUT CP where CP.P_ID= patron_id and CP.RETURNDATE IS NULL 
--union
--select * from BOOKS_CHECKOUT B where B.P_ID = patron_id and B.RETURNDATE IS NULL
--union
--select * from JOURNALS_CHECKOUT J where J.P_ID= patron_id and J.RETURNDATE IS NULL
--union
--select * from CONFP_CHECKOUT CP where CP.P_ID= patron_id and CP.RETURNDATE IS NULL ;
--END;

create or replace procedure RCheckout(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from BOOKS_CHECKOUT B where B.P_ID = patron_id and B.RETURNDATE IS NULL;
END;

create or replace procedure RCheckout1(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from JOURNALS_CHECKOUT J where J.P_ID= patron_id and J.RETURNDATE IS NULL;
END;

create or replace procedure RCheckout2(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from CONFP_CHECKOUT CP where CP.P_ID= patron_id and CP.RETURNDATE IS NULL ;
END;

create or replace procedure RCheckout3(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from EBOOKS_CHECKOUT B where B.P_ID = patron_id and B.RETURNDATE IS NULL;
END;

create or replace procedure RCheckout4(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from EJOURNALS_CHECKOUT J where J.P_ID= patron_id and J.RETURNDATE IS NULL;
END;

create or replace procedure RCheckout5(patron_id VARCHAR2,cur OUT SYS_REFCURSOR)
IS
BEGIN
OPEN cur FOR
select * from ECONFP_CHECKOUT CP where CP.P_ID= patron_id and CP.RETURNDATE IS NULL ;
END;

select * from room_checkout;