CREATE TABLE ALL_BOOKS_TABLE
  (
    ISBN  VARCHAR2(20),
    title VARCHAR2(20),
    c_id  VARCHAR2(20),
    CONSTRAINT courses_fk_resv FOREIGN KEY (c_id) REFERENCES courses(c_id),
    CONSTRAINT books_pk_resv PRIMARY KEY (ISBN)
  );
CREATE TABLE Reserved
  (
    rsvd_id  VARCHAR2(20),
    f_id     VARCHAR2(20),
    rsv_s_dt TIMESTAMP(6),
    rsv_e_dt TIMESTAMP(6),
    c_id     VARCHAR2(20),
    CONSTRAINT rsvd_id_pk PRIMARY KEY (rsvd_id),
    CONSTRAINT rsv_allbooks_fk FOREIGN KEY(rsvd_id) REFERENCES ALL_BOOKS_TABLE(ISBN),
    CONSTRAINT rsv_teaches_fk FOREIGN KEY(f_id,c_id) REFERENCES TEACHES(f_id,c_id)
  );
INSERT INTO TEACHES VALUES
  ('F1','CH101'
  );
INSERT INTO ALL_BOOKS_TABLE VALUES
  ('B1','Intro to Chemistry','CH101'
  );
--SELECT TO_CHAR (LOCALTIMESTAMP) "NOW" FROM DUAL;
--SELECT TO_TIMESTAMP((ADD_MONTHS(LOCALTIMESTAMP, 4))) "NOW" FROM DUAL;
--SELECT TO_TIMESTAMP((LOCALTIMESTAMP + INTERVAL '12' HOUR)) "NOW" FROM DUAL;
INSERT
INTO RESERVED VALUES
  (
    'B1',
    'F1',
    LOCALTIMESTAMP,
    TO_TIMESTAMP((ADD_MONTHS(LOCALTIMESTAMP, 4))),
    'CH101'
  );
CREATE OR REPLACE PROCEDURE Fetchcourseid
  (
    faculty_id IN VARCHAR2,
    course_id OUT VARCHAR2
  )
IS
  --course_id VARCHAR2(20);
BEGIN
  SELECT c_id INTO course_id FROM TEACHES WHERE f_id LIKE faculty_id;
  --DBMS_OUTPUT.PUT_LINE('cid : '|| course_id);
END;
DECLARE
  course_id VARCHAR2(20);
BEGIN
  fetchcourseid('F1', course_id);
  DBMS_OUTPUT.PUT_LINE(course_id);
END;
CREATE OR REPLACE PROCEDURE ShowAllBooks(
    faculty_id VARCHAR2)
IS
  course_id VARCHAR2(20);
  isbn      VARCHAR2(20);
  title     VARCHAR2(20);
  author    VARCHAR2(20);
  b_edition VARCHAR2(20);
  p_year    VARCHAR(20);
  publisher VARCHAR2(20);
  r_status  VARCHAR(20);
  loopcount NUMBER(10);
  CURSOR show_books
  IS
    SELECT isbn,
      title,
      author,
      b_edition,
      p_year,
      publisher,
      c_id,
      r_status
    FROM Books
    WHERE c_id LIKE course_id;
BEGIN
  SELECT c_id INTO course_id FROM TEACHES WHERE f_id LIKE faculty_id;
  SELECT COUNT(*) INTO loopcount FROM BOOKS WHERE C_ID LIKE course_id;
  OPEN show_books;
  LOOP
    FETCH show_books
    INTO isbn,
      title,
      author,
      b_edition,
      p_year,
      publisher,
      course_id,
      r_status;
    EXIT
  WHEN show_books%notfound;
    DBMS_OUTPUT.PUT_LINE('ISBN :  '|| isbn);
    DBMS_OUTPUT.PUT_LINE('Title :  '|| title);
    DBMS_OUTPUT.PUT_LINE('Author :  '|| author);
    DBMS_OUTPUT.PUT_LINE('Book Edition :  '|| b_edition);
    DBMS_OUTPUT.PUT_LINE('Published Year :  '|| p_year);
    DBMS_OUTPUT.PUT_LINE('Course id is ' || course_id );
    DBMS_OUTPUT.PUT_LINE('Loop count is ' || loopcount );
    EXIT
  WHEN show_books%ROWCOUNT=0;
  END LOOP;
END;
EXEC ShowAllBooks('F1');
INSERT INTO ALL_BOOKS_TABLE VALUES
  ('B2', 'Intro to Meth Making', 'CH101'
  );
INSERT
INTO BOOKS VALUES
  (
    'B2',
    'Intro to Meth Making',
    'Walt',
    '2',
    '2011',
    'ABC' ,
    '2',
    '0',
    '1',
    'CH101',
    'unreserved'
  );
CREATE OR REPLACE PROCEDURE ReserveByFaculty
  (
    book_isbn  IN RESERVED.RSVD_ID%TYPE,
    faculty_id IN RESERVED.F_ID%TYPE
  )
IS
  r_status  VARCHAR2(20);
  title     VARCHAR2(20);
  course_id VARCHAR2(20);
BEGIN
  SELECT r_status INTO r_status FROM Books WHERE isbn LIKE book_isbn;
  SELECT title INTO title FROM books WHERE isbn LIKE book_isbn;
  SELECT c_id INTO course_id FROM books WHERE isbn LIKE book_isbn;
  IF(r_status = 'reserved') THEN
    DBMS_OUTPUT.PUT_LINE('Book ' || title || ' is already reserved');
  elsif (r_status = 'unreserved') THEN
    INSERT
    INTO reserved VALUES
      (
        book_isbn,
        faculty_id,
        LOCALTIMESTAMP,
        TO_TIMESTAMP(ADD_MONTHS(LOCALTIMESTAMP, 4)),
        course_id
      );
    UPDATE books SET r_status = 'reserved' WHERE isbn LIKE book_isbn;
    DBMS_OUTPUT.PUT_LINE('Book ' || title || ' has been reserved');
  END IF;
END;
EXEC ReserveByFaculty('B2','F1');
ALTER TABLE books ADD r_status VARCHAR2(10);
/*FOR i in 1..loopcount loop
SELECT isbn into isbn  FROM ALL_BOOKS_TABLE WHERE c_id like course_id;
--SELECT isbn,title, author, b_edition, p_year, publisher, c_id, r_status INTO isbn,title, author, b_edition, p_year, publisher, course_id, r_status FROM BOOKS B WHERE B.C_ID like course_id;
DBMS_OUTPUT.PUT_LINE('ISBN :  '|| isbn);
--DBMS_OUTPUT.PUT_LINE('Title :  '|| title);
--DBMS_OUTPUT.PUT_LINE('Author :  '|| author);
--DBMS_OUTPUT.PUT_LINE('Book Edition :  '|| b_edition);
--DBMS_OUTPUT.PUT_LINE('Published Year :  '|| p_year);
DBMS_OUTPUT.PUT_LINE('Course id is ' || course_id );
DBMS_OUTPUT.PUT_LINE('Loop count is ' || loopcount );
--||'ISBN of book is '|| isbn_no);
-- i:=i+1;
END loop;
*/
--UPDATE BOOKS set r_status = 'reserved' where isbn like'B1';
--select count( 