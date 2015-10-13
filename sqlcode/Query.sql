--log
alter table ebooks drop constraint ebooks_lib_fk;

drop table ebooks;

alter table books add type varchar(7);

--Entities
select * from students;
select * from departments;
select * from faculty;
select * from courses;
select * from library;
select * from books;
select * from journals;
select * from confproceedings;
select * from cameras;
select * from books;

--Relationships
select * from enrols;
select * from teaches;

