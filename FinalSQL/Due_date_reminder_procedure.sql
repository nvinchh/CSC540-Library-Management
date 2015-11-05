CREATE OR REPLACE PROCEDURE ThreeDayR(
    p_id IN VARCHAR,
    threeday OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN threeday FOR SELECT title FROM books WHERE isbn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM books_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '3' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '4' DAY )-localtimestamp)
    )
  );
 commit;
 end;



CREATE OR REPLACE PROCEDURE ThreeDayJR(
    p_id IN VARCHAR,
    threedayj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN threedayj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '3' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '4' DAY )-localtimestamp)
    )
  );
commit;end;




CREATE OR REPLACE PROCEDURE OneDayJR(
    p_id IN VARCHAR,
    onedayj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN onedayj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '1' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '2' DAY )-localtimestamp)
    ));
commit;end;




CREATE OR REPLACE PROCEDURE OneDayR(
    p_id IN VARCHAR,
    oneday OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN oneday FOR SELECT title FROM books WHERE isbn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM books_checkout b
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '1' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '2' DAY )-localtimestamp)
    ));
commit;end;

CREATE OR REPLACE PROCEDURE ThreeDayJR(
    p_id IN VARCHAR,
    threedayj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN threedayj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '3' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '4' DAY )-localtimestamp)
    )
  );
commit;end;







CREATE OR REPLACE PROCEDURE ThreeDayCR(
    p_id IN VARCHAR,
    threedayc OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN threedayc FOR SELECT title FROM CONFPROCEEDINGS WHERE conf_num IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM confp_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '3' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '4' DAY )-localtimestamp)
    )
  );
commit;end;





CREATE OR REPLACE PROCEDURE OneDayCR(
    p_id IN VARCHAR,
    onedayc OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN onedayc FOR SELECT title FROM CONFPROCEEDINGS WHERE CONF_NUM IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM confp_checkout
    WHERE returndate IS NULL
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '1' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '2' DAY )-localtimestamp)
    ));
commit;end;