CREATE OR REPLACE PROCEDURE CAMERAFINE
IS 
  cursor cam_fine is select resource_id, p_id, fine ,returndate from camera_checkout
  where duedate < localtimestamp;
  patronId VARCHAR2(20);
  cresource_id VARCHAR2(20);
  cfine Number(5);
  creturndate timestamp;
BEGIN
  Open cam_fine;
    LOOP
      fetch cam_fine into cresource_id, patronId, cfine, creturndate;
      exit when cam_fine%notfound;
      if(creturndate is null) then
        DBMS_OUTPUT.PUT_LINE('here2');
        DBMS_OUTPUT.PUT_LINE('PATRON ID: '||patronId);
        DBMS_OUTPUT.PUT_LINE('resource ID: '||cresource_id);
        update camera_checkout set fine=(select fine from camera_checkout where resource_id=cresource_id AND p_id=patronId)+1 where resource_id=cresource_id AND p_id=patronId;
      end if;     
    END LOOP;
    commit;
END CAMERAFINE;
