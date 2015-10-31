
SELECT *
FROM PATRONS;

DELETE FROM QUEUE_JOURNALS WHERE P_ID = 3;
insert into faculty values(4,'Vv','Raja','M','Germany','Grad',0.00,1,'algorithms',0);
insert into faculty values(3,'Vav','Ogan','F','African','Grad',0.00,1,'dbms',0);

insert into faculty values(4,'Vv','Raja','M','Germany','Grad',0.00,1,'algorithms',0);
insert into faculty values(3,'Vav','Ogan','F','African','Grad',0.00,1,'dbms',0);
SELECT *
FROM FACULTY;
SELECT *
FROM PATRONS;

insert into students values(6,'V','Rajadhyaksha','M',TO_DATE('10/27/1991','MM/DD/YYYY'),'Indian',9193232234,NULL,'Rale','Avent',27606,'MS','Grad','FM',0.00,1,'rajadhva',0);


SELECT QUEUE_NO_J
FROM queue_journals 
WHERE ptype = 's' and RESOURCE_ID = 300 and L_ID = 1;

insert into patrons values(4,'Vv','Rajadhyaksha','f');
insert into patrons values(3,'Vav','Rajadhyaksha','f');
insert into patrons values(5,'Vaiav','Rajadhyaksha','s');
insert into patrons values(6,'Vaiav','Rajadhyaksha','s');
insert into JOURNALS values(300,'fhhsk', 'dsdsad',2002,1,0,1);

select *
from QUEUE_JOURNALS;

select
from QUEUE_JOURNALS;

exec JCHECKOUT(300,1,6);