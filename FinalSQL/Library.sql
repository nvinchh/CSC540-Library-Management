
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
    pswd varchar2(15),
    onhold  number(1),
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
    pswd varchar2(15),
    onhold  number(1),
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
    l_id      NUMBER(2),
    c_id      VARCHAR2(20),
    r_status  VARCHAR2(20),
    CONSTRAINT books_pk PRIMARY KEY(isbn,l_id),
    CONSTRAINT books_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id),
    CONSTRAINT books_courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
    );   
    
---create table journals
 
create table journals
 (
    issn      VARCHAR2(20),
    title     VARCHAR2(15),
    author    VARCHAR2(30),
    p_year    NUMBER(4),
    quantity  Number(3),
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
  returndate TIMESTAMP Default Null,
  fine NUMBER(5) Default 0,
  STATUS VARCHAR(2) Default Null,
  P_DATE TIMESTAMP Default Null,
  CONSTRAINT bcheckout_checkout_pk PRIMARY KEY(resource_id,checkoutdate,l_id,p_id),
  CONSTRAINT bcheckout_books_fk FOREIGN KEY (resource_id,l_id) REFERENCES books(isbn,l_id),
  CONSTRAINT bcheckout_patrons_fk FOREIGN KEY (p_id) references patrons(p_id)
  );
  
--checkout journals
create table journals_checkout
 (
  resource_id VARCHAR2(20),
  checkoutdate TIMESTAMP,
  duedate TIMESTAMP,
  p_id VARCHAR(20),
  l_id NUMBER(2),
  returndate TIMESTAMP DEfault Null,
  fine NUMBER(5) Default 0,
  STATUS VARCHAR(2) Default Null,
  P_DATE TIMESTAMP Default Null,
  CONSTRAINT journals_checkout_pk PRIMARY KEY(resource_id,checkoutdate,l_id,p_id),
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
  returndate TIMESTAMP DEfault Null,
  fine NUMBER(5) Default 0,
  STATUS VARCHAR(2) Default Null,
  P_DATE TIMESTAMP Default Null,
  CONSTRAINT confp_checkout_pk PRIMARY KEY(resource_id,checkoutdate,l_id,p_id),
  CONSTRAINT cp_checkoutt_fk FOREIGN KEY (resource_id,l_id) REFERENCES confproceedings(conf_num,l_id),
  CONSTRAINT cp_patron_fk FOREIGN KEY (p_id) references patrons);

create table ebooks_checkout
(
resource_id VARCHAR2(20),
checkoutdate TIMESTAMP ,
returndate TIMESTAMP,
p_id VARCHAR2(20),
CONSTRAINT ebooks_checkout_pk PRIMARY KEY(resource_id,p_id,checkoutdate),
CONSTRAINT ebooks_checkout_fk FOREIGN KEY (resource_id) REFERENCES ebooks(isbn),
CONSTRAINT ebooks_checkout_patron_fk FOREIGN KEY (p_id) references patrons(p_id)
);

create table ejournals_checkout
(
resource_id VARCHAR2(20),
checkoutdate TIMESTAMP ,
returndate TIMESTAMP,
p_id VARCHAR2(20),
CONSTRAINT ejournals_checkout_pk PRIMARY KEY(resource_id,p_id,checkoutdate),
CONSTRAINT ejournals_checkout_fk FOREIGN KEY (resource_id) REFERENCES ejournals(issn),
CONSTRAINT ejournals_checkout_patron_fk FOREIGN KEY (p_id) references patrons(p_id)
);


create table econfp_checkout
(
resource_id VARCHAR2(20),
checkoutdate TIMESTAMP ,
returndate TIMESTAMP,
p_id VARCHAR2(20),
CONSTRAINT econfp_checkout_pk PRIMARY KEY(resource_id,p_id,checkoutdate),
CONSTRAINT econfp_checkout_fk FOREIGN KEY (resource_id) REFERENCES econfproceedings(conf_num),
CONSTRAINT econfp_checkout_patron_fk FOREIGN KEY (p_id) references patrons(p_id)
);

--Enrols
CREATE TABLE enrols
  (
    s_id VARCHAR2(20),
    c_id VARCHAR2(20),
    CONSTRAINT enrollss_pk PRIMARY KEY(s_id,c_id),
    CONSTRAINT students_fk FOREIGN KEY (s_id) REFERENCES students(s_id),
    CONSTRAINT courses_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );

--Teaches
CREATE TABLE teaches
  (
    f_id VARCHAR2(20),
    c_id VARCHAR2(20),
    CONSTRAINT teaches_pk PRIMARY KEY(f_id,c_id),
    CONSTRAINT faculty_fk FOREIGN KEY (f_id) REFERENCES faculty(f_id),
    CONSTRAINT courses1_fk FOREIGN KEY (c_id) REFERENCES courses(c_id)
  );
  
   
  create table queue_books
(
 resource_id VARCHAR2(20),
 queue_no_b Number(2),
 p_id VARCHAR2(20),
 l_id NUMBER(2),
 ptype CHAR(1),
 CONSTRAINT queue_books_pk PRIMARY KEY(resource_id,l_id,p_id),
 CONSTRAINT b_queue_fk FOREIGN KEY (resource_id,l_id) REFERENCES books(isbn,l_id),
 CONSTRAINT b_patrons_fk FOREIGN KEY (p_id) references patrons 
);

create table queue_journals
(
 resource_id VARCHAR2(20),
 queue_no_j Number(2),
 p_id VARCHAR2(20),
 ptype CHAR(1),
 l_id NUMBER(2),
 CONSTRAINT queue_journals_pk PRIMARY KEY(resource_id,l_id,p_id),
 CONSTRAINT j_queue_fk FOREIGN KEY (resource_id,l_id) REFERENCES journals(issn,l_id),
 CONSTRAINT j_patrons_fk FOREIGN KEY (p_id) references patrons
);

create table queue_confpro
(
 resource_id VARCHAR2(20),
 queue_no_cp Number(2),
 p_id VARCHAR2(20),
 ptype CHAR(1),
 l_id NUMBER(2),
 CONSTRAINT queue_confpro_pk PRIMARY KEY(resource_id,l_id,p_id),
 CONSTRAINT cp_queuec_fk FOREIGN KEY (resource_id,l_id) REFERENCES confproceedings(conf_num,l_id),
 CONSTRAINT cp_patronsc_fk FOREIGN KEY (p_id) references patrons
);


create table queue_ebooks
(
 resource_id VARCHAR2(20),
 queue_no_eb Number(2),
 p_id VARCHAR2(20),
 CONSTRAINT queue_ebooks_pk PRIMARY KEY(resource_id,p_id),
 CONSTRAINT eb_queue_fk FOREIGN KEY (resource_id) REFERENCES ebooks(isbn),
 CONSTRAINT eb_patrons_fk FOREIGN KEY (p_id) references patrons 
); 
 
 create table queue_ejournals
(
 resource_id VARCHAR2(20),
 queue_no_ejournals Number(2),
 p_id VARCHAR2(20),
 CONSTRAINT queue_ejournals_pk PRIMARY KEY(resource_id,p_id),
 CONSTRAINT ej_queue_fk FOREIGN KEY (resource_id) REFERENCES ejournals(issn),
 CONSTRAINT ej_patrons_fk FOREIGN KEY (p_id) references patrons 
); 

create table queue_econfpro
(
 resource_id VARCHAR2(20),
 queue_no_econfpro Number(2),
 p_id VARCHAR2(20),
 CONSTRAINT queue_econfpro_pk PRIMARY KEY(resource_id,p_id),
 CONSTRAINT ec_queue_fk FOREIGN KEY (resource_id) REFERENCES econfproceedings(conf_num),
 CONSTRAINT ec_patrons_fk FOREIGN KEY (p_id) references patrons 
); 
 
   
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
    

CREATE TABLE camera
(cam_id VARCHAR2(15),
make VARCHAR2(30),
model VARCHAR2(30),
memory VARCHAR2(10),
lens VARCHAR2(30),
l_id NUMBER(2),
CONSTRAINT camera_pk PRIMARY KEY (cam_id),
CONSTRAINT cam_lib_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);


CREATE TABLE camera_checkout
(resource_id VARCHAR2(15),
checkoutdate TIMESTAMP,
duedate TIMESTAMP,
returndate TIMESTAMP,
p_id VARCHAR2(20),
l_id NUMBER(2),
claimed VARCHAR2(5),
returned VARCHAR2(5),
fine NUMBER(5),
p_date TIMESTAMP,
status VARCHAR2(10),
CONSTRAINT camera_checkout_pk PRIMARY KEY (resource_id, checkoutdate, p_id),
CONSTRAINT camcheckout_fk FOREIGN KEY (resource_id) REFERENCES camera(cam_id),
CONSTRAINT camcheckout_patron_fk FOREIGN KEY (p_id) REFERENCES patrons,
CONSTRAINT camcheckout_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);

CREATE TABLE camera_queue
(resource_id VARCHAR2(15),
queuepos NUMBER(5),
p_id VARCHAR2(20),
requestdate TIMESTAMP,
CONSTRAINT camera_queue_pk PRIMARY KEY (resource_id, p_id, requestdate),
CONSTRAINT camqueue_fk FOREIGN KEY (resource_id) REFERENCES camera(cam_id),
CONSTRAINT camqueue_patron_fk FOREIGN KEY (p_id) REFERENCES patrons
);

CREATE TABLE rooms
(room_no VARCHAR2(10),
l_id NUMBER(2),
floor VARCHAR2(10),
roomtype VARCHAR2(15),
capacity NUMBER(2),
CONSTRAINT rooms_pk PRIMARY KEY (room_no, l_id),
CONSTRAINT rooms_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
);

CREATE TABLE room_checkout
(room_no VARCHAR2(10),
l_id NUMBER(2),
checkouttime TIMESTAMP,
returntime TIMESTAMP,
roomclaimed VARCHAR2(5),
p_id VARCHAR2(20),
CONSTRAINT room_checkout_pk PRIMARY KEY (room_no, p_id, checkouttime)
CONSTRAINT rmcheckout_library_fk FOREIGN KEY (l_id) REFERENCES library(l_id)
CONSTRAINT rmcheckout_patron_fk FOREIGN KEY (p_id) REFERENCES patrons
);