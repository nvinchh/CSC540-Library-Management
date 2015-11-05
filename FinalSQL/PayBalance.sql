Create or Replace Procedure Pay_Balance(pbs_id VARCHAR2,pbs_credit NUMBER,result out NUMBER)
is
varType CHAR;
Begin
if(pbs_credit<>0) then
   SELECT P.TYPE
   INTO  varType
   FROM PATRONS P
   WHERE P.P_ID=pbs_id;
   if(varType='S') then
   result:=1;
   update students set s_credit=0 where s_id=pbs_id;
   update students set ONHOLD=0 where s_id=pbs_id;
   update books_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update journals_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update confp_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update camera_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   else
   result:=1;
   update faculty set f_credit=0 where f_id=pbs_id;
   update faculty set ONHOLD=0 where f_id=pbs_id;
   update books_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update journals_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update confp_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   update camera_checkout set fine=0,P_DATE=localtimestamp where p_id=pbs_id and Status='N';
   end if;
else
result:=0;
end if;
end;
