--Department Table
CREATE TABLE departments
  (
    dept_code NUMBER(5),
    dept_name VARCHAR2(10),
    CONSTRAINT dept_code_pk PRIMARY KEY(dept_code)
  );
--Student Table
CREATE TABLE students
  (
    s_id           NUMBER(10),
    first_name     VARCHAR2(10) NOT NULL,
    last_name      VARCHAR2(15) NOT NULL,
    sex            VARCHAR2(2),
    date_of_birth  DATE,
    nationality    VARCHAR2(10),
    main_phone     NUMBER(10)NOT NULL,
    sec_phone      NUMBER(10),
    city           VARCHAR2(5),
    street         VARCHAR(10),
    zipcode        VARCHAR(5),
    degree_program VARCHAR(3),
    classification VARCHAR2(5),
    s_category     VARCHAR2(2),
    s_credit       NUMBER(8,2),
    dept_code      NUMBER(5),
    CONSTRAINT s_id_pk PRIMARY KEY(s_id),
    CONSTRAINT departments_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Faculty
CREATE TABLE faculty
  (
    f_id        NUMBER(10),
    first_name  VARCHAR2(10) NOT NULL,
    last_name   VARCHAR2(15) NOT NULL,
    sex         VARCHAR2(2),
    nationality VARCHAR2(10),
    f_category  VARCHAR2(10),
    f_credit    NUMBER(8,2),
    dept_code   NUMBER(5),
    CONSTRAINT f_id_pk PRIMARY KEY(f_id),
    CONSTRAINT departments_faculty_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Courses
CREATE TABLE courses
  (
    c_id      NUMBER(5),
    c_name    VARCHAR2(10),
    term      VARCHAR2(10),
    dept_code NUMBER(5),
    CONSTRAINT c_id_pk PRIMARY KEY(c_id),
    CONSTRAINT departments_courses_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
--Enrols
CREATE TABLE enrols
  (
    s_id NUMBER(5),
    c_id NUMBER(5),
    CONSTRAINT enrollss_pk PRIMARY KEY(s_id,c_id),
    CONSTRAINT students_fk FOREIGN KEY (s_id) REFERENCES students(s_id),
    CONSTRAINT courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );
--Teaches
CREATE TABLE teaches
  (
    f_id NUMBER(5),
    c_id NUMBER(5),
    CONSTRAINT teaches_pk PRIMARY KEY(f_id,c_id),
    CONSTRAINT faculty_fk FOREIGN KEY (f_id) REFERENCES faculty(f_id),
    CONSTRAINT courses1_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );

  