Create or Replace procedure books_fine     --duedate IN TIMESTAMP
IS
cursor b_fine is select resource_id,fine,returndate from books_checkout
where duedate< localtimestamp; 
bresource_id VARCHAR2(20);
bfine Number;
breturndate timestamp;
Begin
            Open b_fine;
            LOOP
            fetch b_fine into bresource_id,bfine,breturndate;
            exit when b_fine%notfound;
            if(breturndate is null) then
            --DBMS_OUTPUT.PUT_LINE('here2');
                 update books_checkout set fine=(select fine from books_checkout where resource_id=bresource_id)+2 where resource_id=bresource_id;
            end if;     
            END LOOP;
            commit;
END;



Begin            
DBMS_SCHEDULER.CREATE_JOB(job_name=>'bfinecalculation',
                          job_type=>'Stored_Procedure',
                          JOB_ACTION=>'SYS.BOOKS_FINE',
                          start_date=>'01-NOV-2015 12:05:00 AM',
                          repeat_interval=>'freq=Daily',
                          end_date=>NULL,
                          enabled=>TRUE,
                          comments=>'Calls fine procedure to calculate fines for books table');
End;
/