
-- adding necessary fields
alter table students
add (pswd varchar2(15),
     onhold  number(1)
     );

-- adding necessary fields     
alter table faculty
add (pswd varchar2(15),
     onhold  number(1)
     );
     
--deleting books table
drop table books;

-- adding r_id constraint to books
ALTER TABLE books 
add r_id NUMBER(5);

ALTER TABLE BOOKS
add CONSTRAINT books_reserved_fk FOREIGN KEY(r_id) REFERENCES reserved(r_id);

