create or replace procedure queueConf(patron_Id in VARCHAR2, cp_confnum in VARCHAR2,cpLid in NUMBER, pty in CHAR) 
IS
 tcount NUMBER;
 countst NUMBER;
BEGIN 
 SELECT count(*)
 INTO tcount
 FROM queue_confpro
 WHERE l_id = cpLid AND resource_id = cp_confnum;
 if(pty = 'S')
  then INSERT into queue_confpro values(cp_confnum,tcount+1,patron_Id,pty,cpLid);
 ELSE 
 SELECT count(*)
 INTO countst
 FROM queue_confpro
 WHERE l_id = cpLid AND resource_id = cp_confnum AND ptype = 'S';
 update queue_confpro set queue_no_cp = (SELECT queue_no_cp+1
                                       FROM queue_confpro 
                                       WHERE ptype = 'S' and RESOURCE_ID = cp_confnum and L_ID = cpLid) where( RESOURCE_ID = cp_confnum AND L_id = cpLid AND ptype = 'S');
  INSERT into queue_confpro values(cp_confnum,(tcount-countst)+1,patron_Id,pty,cpLid);
end if;
end;