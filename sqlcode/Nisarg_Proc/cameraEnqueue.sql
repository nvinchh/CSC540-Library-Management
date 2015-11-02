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
  DBMS_OUTPUT.PUT_LINE('Queue Position: '||QPos);
	INSERT INTO camera_queue values (resource_id, QPos, patronId, requesteddt);
END CAMERAENQUEUE;