CREATE OR REPLACE PROCEDURE roomAvailability (icapacity IN NUMBER, patronId IN VARCHAR2, inputdt TIMESTAMP)
IS
	patronType CHAR;
	userinputdt DATE;
	tabledatadt DATE;
BEGIN
	SELECT P.type INTO patronType FROM patrons P
	WHERE P.p_id = patronId;
	userinputdt := trunc(inputdt);
	IF (patronType='s') THEN
		SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
		FROM rooms R, room_checkout RC, library L
		WHERE R.l_id = L.l_id
		AND R.room_no = RC.room_no
		AND R.roomtype = 'Study'
		AND R.capacity >= icapacity;
		AND trunc(R.checkouttime) = userinputdt;
		
	END IF;
	IF (patronType='f') THEN
		SELECT R.room_no, R.capacity, L.l_name, RC.checkouttime, RC.returntime
		FROM rooms R, room_checkout RC, library L
		WHERE R.l_id = L.l_id
		AND R.room_no = RC.room_no
		AND R.roomtype IN ('Study','Conference')
		AND R.capacity >= icapacity;
		AND trunc(R.checkouttime) = userinputdt;
	END IF;
END;