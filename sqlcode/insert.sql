insert into library values(1,'Hunt');
insert into library values(2,'Hill');
insert into departments values(2,'Electronics')
insert into courses values(505,'Algorithms','FALL2015',1);  
insert into books values(200108613,'IntrotoAlgos','Cormen',4,2005,'CareerMonk',5,0,2,505,NULL);
insert into students values(27101991,'Vaibhav','Rajadhyaksha','M',TO_DATE('10/27/1991','MM/DD/YYYY'),'Indian',9193232234,NULL,'Rale','Avent',27606,'MS','Grad','FM',0.00,1,'rajadhva',0);
insert into patrons values(27101991,'Vaibhav','Rajadhyaksha','S');
insert into books_checkout values(200108613,LOCALTIMESTAMP,LOCALTIMESTAMP+14,27101991,2);
