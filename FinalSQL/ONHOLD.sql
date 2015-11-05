
create or replace procedure on_hold
is 
cursor p_hold is 
select distinct c.p_id
from (select j.p_id
from journals_checkout j
where trunc(cast(localtimestamp as date)- cast(duedate as date))> 90 and (STATUS is null or Status='N')
group by j.p_id 
Union
select b.p_id
from BOOKS_CHECKOUT b
where trunc(cast(localtimestamp as date)- cast(duedate as date))> 90 and (STATUS is null or Status='N')  
group by b.p_id
UNION
select cp.p_id
from CONFP_CHECKOUT cp
where trunc(cast(localtimestamp as date)- cast(duedate as date))> 90 and (STATUS is null or Status='N') 
group by cp.p_id
UNION
select cc.p_id
from CAMERA_CHECKOUT cc
where trunc(cast(localtimestamp as date)- cast(duedate as date))> 90 and (STATUS is null or Status='N') 
group by cc.p_id
)c;
tempp_id VARCHAR2(20);
Begin
 Open p_hold;
 Loop
 fetch p_hold into tempp_id;
 exit when p_hold%notfound;
 if(tempp_id like 'S%') then
  update students set ONHOLD=1 where s_id=tempp_id;
 else
  update faculty set ONHOLD=1 where f_id=tempp_id;
 end if;
 END LOOP
 commit;
 end;
 
 Begin            
DBMS_SCHEDULER.CREATE_JOB(job_name=>'onholdupdate',
                          job_type=>'Stored_Procedure',
                          JOB_ACTION=>'SYS.ON_HOLD',
                          start_date=>'02-NOV-2015 12:06:00 AM',
                          repeat_interval=>'freq=Daily',
                          end_date=>NULL,
                          enabled=>TRUE,
                          comments=>'Calculates people to put on-hold for not paying dues');
End;