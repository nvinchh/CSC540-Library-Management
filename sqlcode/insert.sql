--------- insert into tables
select * from students;
insert into library values(1,'Hunt');
insert into library values(2,'Hill');
insert into departments values(3,'Chemistry');
insert into courses values('CH101','Intro to Chemistry','FALL2015',3);  
insert into books values('B1','Intro to Chemistry','S K Goyal',1,2005,'Pub1',2,0,2,'CH101');
insert into books values('B2','Intro to Chemistry','S K Goyal',1,2005,'Pub1',2,0,2,'CH101');
insert into students values('S1','Jesse','Pinkman','M',TO_DATE('10/03/1988','MM/DD/YYYY'),'American',123456789,123456787,'Raleigh','Graduate Lane',27606,'BS','Undergraduate','First Year',0.00,3,'jpink',0);
insert into patrons values('S1','Jesse','Pinkman','S');
insert into faculty values('F1','Walter','White','M','American','Professor',0.00,3,'wwhite',0);
insert into patrons values('F1','Walter','White','F');
insert into ebooks values('B1','Introduction to Chemistry','SK Goyal',1,2005,'Pub1',5);

INSERT INTO TEACHES VALUES
  ('F1','CH101'
  );
INSERT INTO ALL_BOOKS_TABLE VALUES
  ('B1','Intro to Chemistry','CH101'
  );
INSERT
INTO RESERVED VALUES
  (
    'B1',
    'F1',
    LOCALTIMESTAMP,
    TO_TIMESTAMP((ADD_MONTHS(LOCALTIMESTAMP, 4))),
    'CH101'
  );  
  


INSERT INTO camera values ('CA1','Olympus','E-620','16GB','14-42mm',1);
INSERT INTO camera values ('CA2','Cannon','EOS-Rebel T4i','32GB','18-135MM EF-S ISTM',1);
INSERT INTO camera values ('CA3','Cannon','EOS-Rebel T4i','32GB','18-135MM EF-S ISTM',1);

INSERT INTO patrons values ('S3','Gale','Beotticher','S');
INSERT INTO patrons values ('F1','Walter','White','F');
INSERT INTO patrons values ('F2','Gustavo','Fring','F');


INSERT INTO camera_checkout values ('CA1','12-NOV-2015 09.00.00 AM','18-NOV-2015 06.00.00 PM','','S1',1,'NO','NO');
INSERT INTO camera_checkout values ('CA2','12-NOV-2015 09.00.00 AM','18-NOV-2015 06.00.00 PM','','F2',1,'NO','NO');
INSERT INTO camera_checkout values ('CA1','19-NOV-2015 09.00.00 AM','25-NOV-2015 06.00.00 PM','','S3',1,'NO','NO');

select * from journals_checkout;


create or replace PROCEDURE CAMERAENQUEUE 
(
  RESOURCE_ID IN VARCHAR2 
, PATRONID IN VARCHAR2 
, REQUESTEDDT IN DATE )
IS 
  QPOS NUMBER(3);
BEGIN
  SELECT MAX(queuepos) INTO QPos FROM camera_queue CQ
	WHERE CQ.resource_id = resource_id
	AND trunc(CQ.requestdate) = requesteddt;
	QPos := QPos + 1;
  --DBMS_OUTPUT.PUT_LINE('Queue Position: '||QPos);
	INSERT INTO camera_queue values (resource_id, QPos, patronId, requesteddt);
END CAMERAENQUEUE;

create or replace PROCEDURE CAMBOOKPROC 
(
  CAMERAID IN VARCHAR2 
, PATRONID IN VARCHAR2 
, REQUESTEDDT IN DATE)
IS
  checkoutdt TIMESTAMP;
  duedt TIMESTAMP;
  libId NUMBER;
BEGIN
  checkoutdt := requesteddt + interval '9' hour;
  duedt := requesteddt + 6;
  duedt := duedt + interval '18' hour;
  --DBMS_OUTPUT.PUT_LINE('Due date: '||duedt);
	SELECT l_id INTO libId FROM camera C WHERE C.cam_id = cameraId;
	INSERT INTO camera_checkout(resource_id, checkoutdate, duedate, p_id, l_id, claimed)
	VALUES (cameraId, checkoutdt, duedt, patronId, libId, 'NO');
END CAMBOOKPROC;

select * from camera_queue;


