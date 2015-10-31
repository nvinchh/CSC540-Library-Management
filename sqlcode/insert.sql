delete from patrons where Type='S';
--------- insert into tables
select * from students;
select * from library;
insert into library values(1,'Hunt');
insert into library values(2,'Hill');
insert into departments values(3,'Chemistry');
insert into courses values('CH101','Intro to Chemistry','FALL2015',3);  
insert into books values('B1','Intro to Chemistry','S K Goyal',1,2005,'Pub1',2,0,2,'CH101');
insert into students values('S1','Jesse','Pinkman','M',TO_DATE('10/03/1988','MM/DD/YYYY'),'American',123456789,123456787,'Raleigh','Graduate Lane',27606,'BS','Undergraduate','First Year',0.00,3,'jpink',0);

insert into patrons values('S1','Jesse','Pinkman','s');
insert into faculty values('F1','Walter','White','M','American','Professor',0.00,3,'wwhite',0);
insert into patrons values('F1','Walter','White','F');

select * from courses;

select * from books;
select * from students;

select * from patrons;
select * from CONFPROCEEDINGS;
select * from CONFP_CHECKOUT;
insert into confproceedings values('1','sdfdf','sdasffgsd',2004,'gfgdfmsjfklg',1,0,1);

exec ConfCheckout('1',1,'S1');

insert into JOURNALS values('7','gffdhgfhjhj','fgdgddh',2007,1,0,1);

select * from JOURNALS;

exec JCheckout('7',1,'S1');