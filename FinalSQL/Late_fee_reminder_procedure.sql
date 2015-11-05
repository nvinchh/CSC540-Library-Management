CREATE OR REPLACE PROCEDURE ThirtyR(
    p_id IN VARCHAR,
    thirty OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN thirty FOR SELECT title FROM books WHERE isbn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM books_checkout
    WHERE p_date IS NULL
    AND fine>0
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '30' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '31' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE ThityJR(
    p_id IN VARCHAR,
    thirtyj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN thirtyj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '30' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '31' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE ThityCR(
    p_id IN VARCHAR,
    thirtyc OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN thirtyc FOR SELECT title FROM CONFPROCEEDINGS WHERE CONF_NUM IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM CONFP_CHECKOUT
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '30' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '31' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE SixtyR(
    p_id IN VARCHAR,
    sixty OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN sixty FOR SELECT title FROM books WHERE isbn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM books_checkout
    WHERE p_date IS NULL
    AND fine>0
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '60' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '61' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE SixtyJR(
    p_id IN VARCHAR,
    sixtyj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN sixtyj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '60' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '61' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE SixtyCR(
    p_id IN VARCHAR,
    sixtyc OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN sixtyc FOR SELECT title FROM CONFPROCEEDINGS WHERE CONF_NUM IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM CONFP_CHECKOUT
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '60' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '61' DAY )-localtimestamp)
    )
  );
commit;end;




CREATE OR REPLACE PROCEDURE NinetyR(
    p_id IN VARCHAR,
    ninety OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN ninety FOR SELECT title FROM books WHERE isbn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM books_checkout
    WHERE p_date IS NULL
    AND fine>0
    AND p_id LIKE p_id
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '90' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '91' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE NinetyJR(
    p_id IN VARCHAR,
    ninetyj OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN ninetyj FOR SELECT title FROM journals WHERE issn IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM journals_checkout
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '90' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '91' DAY )-localtimestamp)
    )
  );
commit;end;



CREATE OR REPLACE PROCEDURE NinetyCR(
    p_id IN VARCHAR,
    ninetyc OUT SYS_REFCURSOR )
IS
  resource_id VARCHAR2(20);
  title       VARCHAR2(20);
BEGIN
  OPEN ninetyc FOR SELECT title FROM CONFPROCEEDINGS WHERE CONF_NUM IN
  (SELECT resource_id
  FROM
    (SELECT *
    FROM CONFP_CHECKOUT
    WHERE p_date IS NULL
    AND p_id LIKE p_id
    AND fine>0
    AND ((localtimestamp- duedate)>=(localtimestamp +interval '90' DAY )-localtimestamp)
    AND ((localtimestamp- duedate) <(localtimestamp +interval '91' DAY )-localtimestamp)
    )
  );
commit;end;