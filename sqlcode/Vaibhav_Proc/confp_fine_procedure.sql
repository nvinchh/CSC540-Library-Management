select * from confp_checkout;
select * from CONFPROCEEDINGS;

Create or Replace procedure confp_fine     
IS
cursor confp_fine is select resource_id,fine,returndate from confp_checkout
where duedate< localtimestamp; 
cresource_id VARCHAR2(20);
cfine Number;
creturndate timestamp;
Begin
            Open confp_fine;
            LOOP
            fetch confp_fine into cresource_id,cfine,creturndate;
            exit when confp_fine%notfound;
            if(creturndate is null) then
            DBMS_OUTPUT.PUT_LINE('here2');
               --if(pfine=0) then
               --DBMS_OUTPUT.PUT_LINE('here3');
                 update confp_checkout set fine=(select fine from confp_checkout where resource_id=cresource_id)+2 where resource_id=cresource_id;
            end if;     
            EXIT WHEN confp_fine%ROWCOUNT=0;
            END LOOP;
            commit;
END;     

Begin            
DBMS_SCHEDULER.CREATE_JOB(job_name=>'cpfinecalculation',
                          job_type=>'Stored_Procedure',
                          JOB_ACTION=>'SYS.CONFP_FINE',
                          start_date=>'01-NOV-2015 12:05:00 AM',
                          repeat_interval=>'freq=Daily',
                          end_date=>NULL,
                          enabled=>TRUE,
                          comments=>'Calls fine procedure to calculate fines for confp_checkout
                          table');
End;
/