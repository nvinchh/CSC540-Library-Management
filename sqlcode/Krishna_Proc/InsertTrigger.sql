create or replace trigger InsertCheck
BEFORE INSERT 
ON students
FOR EACH ROW
DECLARE
    s_id           VARCHAR2(20);
    first_name     VARCHAR2(15);
    last_name      VARCHAR2(15);
    sex            VARCHAR2(2);
    date_of_birth  DATE;
    nationality    VARCHAR2(20);
    main_phone     NUMBER(10);
    sec_phone      NUMBER(10);
    city           VARCHAR2(20);
    street         VARCHAR2(20);
    zipcode        VARCHAR2(5);
    degree_program VARCHAR2(3);
    classification VARCHAR2(20);
    s_category     VARCHAR2(15);
    s_credit       NUMBER(8,2);
    dept_code      NUMBER(5);
BEGIN
    classification:= :new.classification;
    degree_program:= :new.degree_program;
    if(classification='Undergraduate') then
        if((degree_program='MS')or(degree_program='PHD'))then
         raise_application_error( -20001, 'No insertion Incompatible Data.');
   -- DBMS_OUTPUT.PUT_LINE('here'||classification);
    end if;
    end if;
        if(classification='Postgraduate') then
        if(degree_program='BS')then
     raise_application_error( -20001, 'No insertion Incompatible Data.');
    end if;
    end if;
    DBMS_OUTPUT.PUT_LINE('here'||degree_program);
END;

create or replace trigger InsertInAll
AFTER INSERT 
ON students
FOR EACH ROW
DECLARE
    s_id           VARCHAR2(20);
    first_name     VARCHAR2(15);
    last_name      VARCHAR2(15);
    sex            VARCHAR2(2);
    date_of_birth  DATE;
    nationality    VARCHAR2(20);
    main_phone     NUMBER(10);
    sec_phone      NUMBER(10);
    city           VARCHAR2(20);
    street         VARCHAR2(20);
    zipcode        VARCHAR2(5);
    degree_program VARCHAR2(3);
    classification VARCHAR2(20);
    s_category     VARCHAR2(15);
    s_credit       NUMBER(8,2);
    dept_code      NUMBER(5);
BEGIN
 -- s_id := :new.s_id;
 -- first_name:= :new first_name;
  --last_name:= :new last_name;
  Insert into patrons values(:new.s_id,:new.first_name,:new.last_name,'S');
END;

create or replace trigger InsertFInAll
AFTER INSERT 
ON faculty
FOR EACH ROW
DECLARE
    f_id        VARCHAR2(20);
    first_name  VARCHAR2(15);
    last_name   VARCHAR2(15);
    sex         VARCHAR2(2);
    nationality VARCHAR2(20);
    f_category  VARCHAR2(20);
    f_credit    NUMBER(8,2);
    dept_code   NUMBER(5);
BEGIN
 -- s_id := :new.s_id;
 -- first_name:= :new first_name;
  --last_name:= :new last_name;
  Insert into patrons values(:new.f_id,:new.first_name,:new.last_name,'F');
END;