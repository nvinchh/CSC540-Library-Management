
--Department Table
CREATE TABLE departments
  (
    dept_code NUMBER(5),
    dept_name VARCHAR2(25),
    CONSTRAINT dept_code_pk PRIMARY KEY(dept_code)
  );
  
--Student Table
CREATE TABLE students
  (
    s_id           VARCHAR2(20),
    first_name     VARCHAR2(15) NOT NULL,
    last_name      VARCHAR2(15) NOT NULL,
    sex            VARCHAR2(2),
    date_of_birth  DATE,
    nationality    VARCHAR2(20),
    main_phone     NUMBER(10)NOT NULL,
    sec_phone      NUMBER(10),
    city           VARCHAR2(20),
    street         VARCHAR2(20),
    zipcode        VARCHAR2(5),
    degree_program VARCHAR2(3),
    classification VARCHAR2(20),
    s_category     VARCHAR2(15),
    s_credit       NUMBER(8,2),
    dept_code      NUMBER(5),
    pswd           VARCHAR2(15),
    onhold         number(1),
    CONSTRAINT s_id_pk PRIMARY KEY(s_id),
    CONSTRAINT departments_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
  
--Faculty
CREATE TABLE faculty
  (
    f_id        VARCHAR2(20),
    first_name  VARCHAR2(15) NOT NULL,
    last_name   VARCHAR2(15) NOT NULL,
    sex         VARCHAR2(2),
    nationality VARCHAR2(20),
    f_category  VARCHAR2(20),
    f_credit    NUMBER(8,2),
    dept_code   NUMBER(5),
    pswd        VARCHAR2(15),
    onhold      NUMBER(1),
    CONSTRAINT f_id_pk PRIMARY KEY(f_id),
    CONSTRAINT departments_faculty_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
  );
  
--Courses
CREATE TABLE courses
  (
    c_id      VARCHAR2(20),
    c_name    VARCHAR2(30),
    term      VARCHAR2(10),
    dept_code NUMBER(5),
    CONSTRAINT c_id_pk PRIMARY KEY(c_id),
    CONSTRAINT departments_courses_fk FOREIGN KEY (dept_code) REFERENCES departments(dept_code)
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
    isbn      VARCHAR2(12),
    title     VARCHAR2(30),
    author    VARCHAR2(40),
    b_edition   NUMBER(5),
    p_year      NUMBER(4),
    Publisher  VARCHAR2(20),
    b_Quantity  Number(3),
    b_Queue     Number(3),
    l_id      NUMBER(2),
    c_id      VARCHAR2(20), 
    CONSTRAINT books_pk PRIMARY KEY(isbn,l_id),
    CONSTRAINT books_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id),
    CONSTRAINT books_courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
    );
--ALTER TABLE books add r_id NUMBER(5);   
    
---create table journals
 
 create table journals
 (
    issn      VARCHAR2(20),
    title     VARCHAR2(15),
    author    VARCHAR2(30),
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
    conf_num   VARCHAR2(20),
    title      VARCHAR2(15),
    author     VARCHAR2(30),
    cp_year    NUMBER(4),
    conf_name  VARCHAR2(30),
    quantity   Number(3),
    cp_queue   number(3),
    l_id       NUMBER(2),
    CONSTRAINT confp_pk PRIMARY KEY(conf_num,l_id),
    CONSTRAINT confp_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);     
 
--creating ebooks table
CREATE TABLE ebooks
  (
    isbn      VARCHAR2(20),
    title     VARCHAR2(15),
    author    VARCHAR2(30),
    eb_edition   NUMBER(5),
    p_year      NUMBER(4),
    Publisher VARCHAR2(10),
    Quantity     Number(3),
    CONSTRAINT ebooks_pk PRIMARY KEY(isbn)
  )

--creating e-journals
CREATE TABLE ejournals
    (
    issn      VARCHAR2(20),
    title     VARCHAR2(30),
    author    VARCHAR2(30),
    p_year    NUMBER(4),
    Quantity  Number(3),
    CONSTRAINT ejournals_pk PRIMARY KEY(issn)
    )
 
--creating econf_proceedings    

create table econfproceedings
   (
    conf_num   VARCHAR2(20),
    title      VARCHAR2(30),
    author     VARCHAR2(30),
    cp_year    NUMBER(4),
    conf_name  VARCHAR2(30),
    Quantity   Number(3),
    CONSTRAINT econfproceedings_pk PRIMARY KEY(conf_num)
    )
 
--creating table patrons 
create table patrons
   (
   p_id VARCHAR2(20),
   firstName VARCHAR2(15),
   lastName VARCHAR2(15),
   type CHAR(1),
   CONSTRAINT patrons_pk PRIMARY KEY(p_id)
   );

--books checkout

create table books_checkout
 (
  resource_id VARCHAR2(20),
  checkoutdate TIMESTAMP,
  duedate TIMESTAMP,
  p_id VARCHAR2(20),
  l_id NUMBER(2),
  CONSTRAINT bcheckout_checkout_pk PRIMARY KEY(resource_id,l_id,p_id),
  CONSTRAINT bcheckout_books_fk FOREIGN KEY (resource_id,l_id) REFERENCES books(isbn,l_id),
  CONSTRAINT bcheckout_patrons_fk FOREIGN KEY (p_id) references patrons(p_id)
  );
  
--checkout journals
create table journals_checkout
 (
  resource_id VARCHAR2(20),
  checkoutdate TIMESTAMP ,
  duedate TIMESTAMP,
  p_id VARCHAR(20),
  l_id NUMBER(2),
  CONSTRAINT journals_checkout_pk PRIMARY KEY(resource_id,l_id,p_id),
  CONSTRAINT jcheckout_journals_fk FOREIGN KEY (resource_id,l_id) REFERENCES journals(issn,l_id),
  CONSTRAINT jcheckout_patrons_fk FOREIGN KEY (p_id) references patrons(p_id)
  );

  
create table confp_checkout
(
  resource_id VARCHAR2(20),
  checkoutdate TIMESTAMP ,
  duedate TIMESTAMP,
  p_id VARCHAR2(20),
  l_id NUMBER(2),
  CONSTRAINT cpcheckout_checkout_pk PRIMARY KEY(resource_id,l_id,p_id),
  CONSTRAINT cp_checkout_fk FOREIGN KEY (resource_id,l_id) REFERENCES confproceedings(conf_num,l_id),
  CONSTRAINT cp_patrons_fk FOREIGN KEY (p_id) references patrons(p_id)
  );


   