-- Procedure for camera booking/reservation
CREATE OR REPLACE PROCEDURE camBookProc (cameraId VARCHAR2, patronId VARCHAR2, requesteddt TIMESTAMP)
IS
	duedt TIMESTAMP;
	libId NUMBER;
BEGIN
	duedt := requesteddt + 7;
	SELECT l_id INTO libId FROM camera C WHERE C.cam_id = cameraId;
	INSERT INTO camera_checkout(resource_id, checkoutdate, duedate, p_id, l_id, claimed)
	VALUES (cameraId, requesteddt, duedt, patronId, libId, 'NO');
END;