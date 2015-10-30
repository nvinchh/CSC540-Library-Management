CREATE TABLE ALL_BOOKS_TABLE
  (
    ISBN VARCHAR2(20),
    title VARCHAR2(20),
    c_id VARCHAR2(20),
    CONSTRAINT courses_fk_resv FOREIGN KEY (c_id) REFERENCES courses(c_id),
    constraint books_pk_resv PRIMARY key (ISBN)
  );
  
  CREATE TABLE Reserved
    (
      rsvd_id VARCHAR2(20),
      f_id VARCHAR2(20),
      rsv_s_dt TIMESTAMP(6),
      rsv_e_dt TIMESTAMP(6),
      c_id VARCHAR2(20),
      constraint rsvd_id_pk PRIMARY KEY (rsvd_id),
      CONSTRAINT rsv_allbooks_fk FOREIGN KEY(rsvd_id) REFERENCES ALL_BOOKS_TABLE(ISBN),
      constraint rsv_teaches_fk FOREIGN KEY(f_id,c_id) REFERENCES TEACHES(f_id,c_id) 
    );
    
  INSERT INTO TEACHES VALUES ('F1','CH101'); 
  INSERT INTO ALL_BOOKS_TABLE VALUES ('B1','Intro to Chemistry','CH101');
  --SELECT TO_CHAR (LOCALTIMESTAMP) "NOW" FROM DUAL;
  --SELECT TO_TIMESTAMP((ADD_MONTHS(LOCALTIMESTAMP, 4))) "NOW" FROM DUAL;
  INSERT INTO RESERVED VALUES ('B1','F1',LOCALTIMESTAMP,TO_TIMESTAMP((ADD_MONTHS(LOCALTIMESTAMP, 4))),'CH101' );
      