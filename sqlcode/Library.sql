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
--Library
CREATE TABLE library
  (
    l_id   NUMBER(2),
    l_name VARCHAR2(10),
    CONSTRAINT library_pk PRIMARY KEY(l_id)
  );
  
  
--Books
CREATE TABLE books
  (
    isbn      NUMBER(12),
    title     VARCHAR2(15),
    author    VARCHAR2(40),
    b_edition   NUMBER(5),
    p_year      NUMBER(4),
    Publisher  VARCHAR2(10),
    b_Quantity  Number(3),
    b_Queue     Number(3),
    l_id      NUMBER(2),
    c_id      NUMBER(5), 
    CONSTRAINT books_pk PRIMARY KEY(isbn,l_id),
    CONSTRAINT books_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id),
    CONSTRAINT books_courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
    );
    
---create tabel journals
 create table journals
 (
    issn      NUMBER(12),
    title     VARCHAR2(15),
    author    VARCHAR2(10),
    p_year    NUMBER(4),
    quantity  Number(3),
    j_queue   Number(3),
    l_id      Number(2),
    CONSTRAINT journals_pk PRIMARY KEY(issn,l_id),
    CONSTRAINT journals_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
    );

--conf_proceedings    
 create table confproceedings
(
    conf_num   NUMBER(12),
    title      VARCHAR2(15),
    author     VARCHAR2(10),
    cp_year    NUMBER(4),
    conf_name  VARCHAR2(7),
    quantity   Number(3),
    cp_queue   varchar2(7),
    l_id       NUMBER(2),
    CONSTRAINT confp_pk PRIMARY KEY(conf_num,l_id),
    CONSTRAINT confp_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);     

drop table confproceedings;
 
--creating ebooks table
CREATE TABLE ebooks
  (
    isbn      NUMBER(12),
    title     VARCHAR2(15),
    author    VARCHAR2(10),
    eb_edition   NUMBER(5),
    p_year      NUMBER(4),
    Publisher VARCHAR2(10),
    Quantity     Number(3),
    CONSTRAINT ebooks_pk PRIMARY KEY(isbn)
  )

--creating e-journals
CREATE TABLE ejournals
    (
    issn      NUMBER(12),
    title     VARCHAR2(15),
    author    VARCHAR2(10),
    p_year    NUMBER(4),
    Quantity  Number(3),
    CONSTRAINT ejournals_pk PRIMARY KEY(issn)
    )
 
--creating econf_proceedings    

create table econfproceedings
   (
    conf_num   NUMBER(12),
    title      VARCHAR2(15),
    author     VARCHAR2(10),
    cp_year    NUMBER(4),
    conf_name  VARCHAR2(7),
    Quantity   Number(3),
    CONSTRAINT econfproceedings_pk PRIMARY KEY(conf_num)
    )