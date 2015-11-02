create or replace PROCEDURE ROOMAVAILABILITY 
(
  ICAPACITY IN NUMBER , PATRONID IN VARCHAR2 , INPUTDT IN DATE)
IS
  patronType CHAR;
	userinputdt DATE;
	tabledatadt DATE;
  dcapacity NUMBER(3);
  roomno VARCHAR2(10);
  libname VARCHAR(10);
  outtime TIMESTAMP;
  intime TIMESTAMP;
  CURSOR roomviewstudent IS SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
    FROM rooms R LEFT JOIN room_checkout RC ON R.ROOM_NO = RC.ROOM_NO JOIN library L ON R.L_ID = L.L_ID
		WHERE R.roomtype = 'Study'
		AND R.capacity >= icapacity
		AND trunc(RC.checkouttime) = inputdt
    UNION
    SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
    FROM rooms R LEFT JOIN room_checkout RC ON R.ROOM_NO = RC.ROOM_NO JOIN library L ON R.L_ID = L.L_ID
		WHERE R.roomtype = 'Study'
		AND R.capacity >= icapacity;
  CURSOR roomviewfaculty IS SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
    FROM rooms R LEFT JOIN room_checkout RC ON R.ROOM_NO = RC.ROOM_NO JOIN library L ON R.L_ID = L.L_ID
		WHERE R.roomtype IN ('Study','Conference')
		AND R.capacity >= icapacity
		AND trunc(RC.checkouttime) = inputdt
    UNION
    SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
    FROM rooms R LEFT JOIN room_checkout RC ON R.ROOM_NO = RC.ROOM_NO JOIN library L ON R.L_ID = L.L_ID
		WHERE R.roomtype IN ('Study','Conference')
		AND R.capacity >= icapacity;
BEGIN
  SELECT P.type INTO patronType FROM patrons P
	WHERE P.p_id = patronId;
	userinputdt := trunc(inputdt);
  IF (patronType='S') THEN
    OPEN roomviewstudent;
    LOOP
      FETCH roomviewstudent INTO roomno, dcapacity, libname, outtime, intime;
      EXIT WHEN roomviewstudent%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Room No:'||roomno);
      DBMS_OUTPUT.PUT_LINE('Capacity: '||dcapacity);
      DBMS_OUTPUT.PUT_LINE('Library: '||libname);
      DBMS_OUTPUT.PUT_LINE('Checkout Time: '||outtime);
      DBMS_OUTPUT.PUT_LINE('Check-in Time: '||intime);
    END LOOP;
	END IF;
	IF (patronType='F') THEN
		OPEN roomviewfaculty;
    LOOP
      FETCH roomviewfaculty INTO roomno, dcapacity, libname, outtime, intime;
      EXIT WHEN roomviewfaculty%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Room No:'||roomno);
      DBMS_OUTPUT.PUT_LINE('Capacity: '||dcapacity);
      DBMS_OUTPUT.PUT_LINE('Library: '||libname);
    END LOOP;
	END IF;
END ROOMAVAILABILITY;