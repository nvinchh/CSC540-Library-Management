--------- insert into tables
select * from students;
insert into library values(1,'Hunt');
insert into library values(2,'Hill');
insert into departments values(3,'Chemistry');
insert into courses values('CH101','Intro to Chemistry','FALL2015',3);  
insert into books values('B','Intro to Chemistry','S K Goyal',1,2005,'Pub1',2,0,2,'CH101');
insert into students values('S2','Jesse','Pinkman','M',TO_DATE('10/03/1988','MM/DD/YYYY'),'American',123456789,123456787,'Raleigh','Graduate Lane',27606,'BS','Undergraduate','First Year',0.00,3,'jpink',0);

insert into ENROLS values('S1','CH101');
insert into patrons values('S2','Jesse','Pinkman','S');
insert into faculty values('F1','Walter','White','M','American','Professor',0.00,3,'wwhite',0);
insert into patrons values('F1','Walter','White','F');
insert into journals values('7','fffff','dfdfd',2007,1,0,1);
update BOOKS set B_QUANTITY=1;
select * from enrols;
select * from students;
insert into teaches values('F1','CH101');
insert into ALL_BOOKS_TABLE values('B2','hjhj','CH101');
insert into RESERVED values('B2','F1',Localtimestamp,localtimestamp,'CH101');
BCheckout (bISBN VARCHAR2,jLid NUMBER,patronId VARCHAR2)
exec BCHECKOUT('B2',2,'F1');

    SELECT J.C_ID
    FROM BOOKS J
    WHERE J.ISBN='B2';
    
        SELECT P.TYPE
    FROM PATRONS P
    WHERE P.P_ID='S2';