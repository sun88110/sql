SELECT * FROM student;
insert into student (sno, sname) values (300, '배진욱');

UPDATE student
set score = 50
where sno = 300;
COMMIT;