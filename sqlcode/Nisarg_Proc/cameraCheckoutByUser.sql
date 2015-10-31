CREATE OR REPLACE PROCEDURE cameraCheckoutByUser (resource_id IN VARCHAR2, patronId IN VARCHAR2, checkoutdt IN VARCHAR2)
IS
BEGIN
	UPDATE camera_checkout C
	SET claimed='YES'
	WHERE C.resource_id = resource_id
	AND C.p_id = patronId
	AND C.checkoutdate = checkoutdt;
END;