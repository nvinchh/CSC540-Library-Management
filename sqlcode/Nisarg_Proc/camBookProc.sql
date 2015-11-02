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
  DBMS_OUTPUT.PUT_LINE('Due date: '||duedt);
	SELECT l_id INTO libId FROM camera C WHERE C.cam_id = cameraId;
	INSERT INTO camera_checkout(resource_id, checkoutdate, duedate, p_id, l_id, claimed)
	VALUES (cameraId, checkoutdt, duedt, patronId, libId, 'NO');
END CAMBOOKPROC;