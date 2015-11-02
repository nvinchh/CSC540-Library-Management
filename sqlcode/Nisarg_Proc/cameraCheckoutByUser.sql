create or replace PROCEDURE CAMCHECKOUTBYUSER 
(
  RESOURCE_ID IN VARCHAR2 
, PATRONID IN VARCHAR2 
, CHECKOUTDT IN DATE 
) AS 
BEGIN
  UPDATE camera_checkout C
	SET claimed='YES'
	WHERE C.resource_id = resource_id
	AND C.p_id = patronId
	AND trunc(C.checkoutdate) = checkoutdt;
END CAMCHECKOUTBYUSER;