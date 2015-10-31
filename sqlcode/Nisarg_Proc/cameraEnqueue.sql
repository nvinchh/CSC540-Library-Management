CREATE OR REPLACE PROCEDURE cameraEnqueue (resource_id IN VARCHAR2, patronId IN VARCHAR2, requesteddt IN TIMESTAMP)
IS
	QPos NUMBER;
BEGIN
	SELECT MAX(queuepos) INTO QPos FROM camera_queue CQ
	WHERE CQ.resource_id = resource_id
	AND CQ.requestdate = requesteddt;
	QPos := QPos + 1;
	INSERT INTO camera_queue values (resource_id, patronId, QPos, requesteddt);
END;
