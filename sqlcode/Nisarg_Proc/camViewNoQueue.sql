CREATE OR REPLACE PROCEDURE camViewNoQueue (patronId IN VARCHAR2, requesteddt IN TIMESTAMP)
IS
BEGIN
	SELECT C.cam_id, C.make, C.model, C.memory, C.lens, L.l_name
	FROM camera C, library L
	WHERE C.l_id = L.l_id
	AND C.cam_id NOT IN (SELECT resource_id from camera_checkout WHERE checkoutdate = requesteddt);
END;