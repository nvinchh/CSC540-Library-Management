--------- insert into tables
select * from students;
insert into library values(1,'Hunt');
insert into library values(2,'Hill');
insert into departments values(3,'Chemistry');
insert into courses values('CH101','Intro to Chemistry','FALL2015',3);  
insert into books values('B1','Intro to Chemistry','S K Goyal',1,2005,'Pub1',2,0,2,'CH101');
insert into students values('S1','Jesse','Pinkman','M',TO_DATE('10/03/1988','MM/DD/YYYY'),'American',123456789,123456787,'Raleigh','Graduate Lane',27606,'BS','Undergraduate','First Year',0.00,3,'jpink',0);
insert into patrons values('S1','Jesse','Pinkman','S');
insert into faculty values('F1','Walter','White','M','American','Professor',0.00,3,'wwhite',0);
insert into patrons values('F1','Walter','White','F');

insert into ebooks values('B1','Introduction to Chemistry','SK Goyal',1,2005,'Pub1',5);
