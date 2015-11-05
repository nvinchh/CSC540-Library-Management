CREATE OR REPLACE PROCEDURE VIEWCAMBOOKING
(
  PATRONID IN VARCHAR2,
  viewcam OUT SYS_REFCURSOR
)
IS 
BEGIN
  OPEN viewcam FOR SELECT C.cam_id, C.make, C.model, C.memory, C.lens, L.l_name, CC.checkoutdate
  FROM camera C, camera_checkout CC, library L
  WHERE C.L_ID = L.L_ID
  AND C.cam_ID = CC.RESOURCE_ID;
END VIEWCAMBOOKING;