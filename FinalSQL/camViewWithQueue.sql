create or replace PROCEDURE CAMVIEWWITHQUEUE 
(PATRONID IN VARCHAR2, REQUESTEDDT IN DATE, camview OUT SYS_REFCURSOR)
IS
  camId VARCHAR2(15);
  cammake VARCHAR2(15);
  cammodel VARCHAR2(20);
  cammemory VARCHAR2(10);
  camlens VARCHAR2(20);
  libname VARCHAR2(20);
  
BEGIN
  OPEN camview FOR SELECT C.cam_id, C.make, C.model, C.memory, C.lens, L.l_name
	FROM camera C, library L
  WHERE C.l_id = L.l_id
	AND C.cam_id IN (SELECT resource_id from camera_checkout WHERE trunc(checkoutdate) = requesteddt);
  --Open camview;
  --LOOP
  --  fetch camview INTO camId, cammake, cammodel, cammemory, camlens;
    --exit when camview%notfound;
--    DBMS_OUTPUT.PUT_LINE('CamID: '||camId);
  --  DBMS_OUTPUT.PUT_LINE('CamMake: '||cammake);
    --DBMS_OUTPUT.PUT_LINE('CamModel: '||cammodel);
    --DBMS_OUTPUT.PUT_LINE('Library Name: '||libname);
    
 -- END LOOP;
END CAMVIEWWITHQUEUE;