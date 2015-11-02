create or replace PROCEDURE CAMVIEWNOQUEUE 
(
  PATRONID IN VARCHAR2 
, REQUESTEDDT IN DATE )
IS
  camid VARCHAR2(15);
  cammake VARCHAR2(15);
  cammodel VARCHAR2(20);
  cammemory VARCHAR2(10);
  camlens VARCHAR2(20);
  libname VARCHAR2(20);
  CURSOR camviewnoqueue IS SELECT C.cam_id, C.make, C.model, C.memory, C.lens, L.l_name
	FROM camera C, library L
	WHERE C.l_id = L.l_id
  AND C.cam_id NOT IN (SELECT resource_id from camera_checkout WHERE trunc(checkoutdate) = requesteddt);
BEGIN
  OPEN camviewnoqueue;
  LOOP
    fetch camviewnoqueue INTO camId, cammake, cammodel, cammemory, camlens, libname;
    exit when camviewnoqueue%notfound;
    DBMS_OUTPUT.PUT_LINE('CamID: '||camId);
    DBMS_OUTPUT.PUT_LINE('CamMake: '||cammake);
    DBMS_OUTPUT.PUT_LINE('CamModel: '||cammodel);
    DBMS_OUTPUT.PUT_LINE('Library Name: '||libname); 
  END LOOP;
END CAMVIEWNOQUEUE;