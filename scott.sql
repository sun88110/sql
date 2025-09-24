SELECT * from student;


--표현식 사용.
select empno as "사원번호" -- 별칭(alias)
     , ename as "사원명" -- 
     , 'Good Morning !! ' || ename as "wecome 메시지" -- 메시지.
     , ename || '''s 급여' || sal as "급여"
from emp;

select empno
    ,  hiredate as "hd"
from emp;

-- dsitinct
select distinct job, deptno
from emp
order by job desc; -- job을 기준으로 정렬 


select NAME || ''', ID: ' || ID || ',' || 'WEIGHT is ' || WEIGHT || 'Kg' as "ID AND WEIGHT"
from Student;

SELECT ENAME || '('|| JOB || '), ' || ENAME || '''' || JOB || '''' as "NAME AND JOB" 
from emp;

SELECT ENAME || '''s sal is $' || sal as "Name And Sal"
FROM EMP;

select empno
    ,  ename
    ,  job
    ,  mgr
    ,  hiredate
    ,  sal
    ,  comm
    ,  deptno
from emp
where empno in (7934, 7844, 7499)
or  comm is not null;


select empno
    ,  ename
    ,  job
    ,  mgr
    ,  hiredate
    ,  sal
    ,  comm
    ,  deptno
from emp
where ename like 'M%';

select empno
    ,  ename
    ,  job
    ,  mgr
    ,  hiredate
    ,  sal + comm as "Salary"
--   ,  comm
    ,  deptno
from emp
where empno >= 7900 and empno < 8000 and hiredate >= '82/01/01';
-- hiredate > '80/12/17' and hiredate < '82/01/01';

select *
from professor
where pay + bonus >= 300 or pay >= 300 or bonus is not null;
--where pay + nvl(bonus, 0) >= 300;

select profno
      ,lower(name) as "low_name" -- 소문자로 바꿈
      ,upper(id) as "upp_id" -- 대문자로 바꿈
      ,initcap(position) as "pos" -- 단어의 첫번째 글자만 대문자로 바꿔줌
      ,pay
      ,concat(concat(NAME, '-'), id) as "name_id"
from professor
where length(name) < 10; --문자열 크기가 10이 안넘는 이름

select name
    ,length(name) as "length"
    ,lengthb('홍길동') as "lengthb"
    ,substr(name, 1, 5) as "substr"
    ,instr(name, 'a') as "instr"
    ,pay 
    ,bonus
    ,ltrim(lpad(id, 10, '*'), '*') as "lpad"
    ,trim('    Hello, World     ') as "str"
    ,replace('Hello', 'H', 'h') as "rep"
from professor
where instr(upper(name), 'A') > 0 ;
-- 12000 00780
commit;

select name, tel, instr(tel, ')')
from student
WHERE DEPTNO1 = 201;

select name, tel, instr(tel, '3')
from student
WHERE DEPTNO1 = 101;

select name, tel,substr(tel, 1, instr(tel, ')')-1) as "AREA CODE"
from student
WHERE DEPTNO1 = 201;

select name, jumin
from student;

select name , tel, 
replace(tel, substr(tel, instr(tel, ')')+1, 3), '***') AS "REPLACE"
from student
where deptno1 = 102;

select name , tel, 
replace(tel, substr(tel, instr(tel, '-')+1, 4), '****') AS "REPLACE"
from student
where deptno1 = 101;

SELECT name,
       tel,
       REPLACE(tel, 
               SUBSTR(tel, INSTR(tel, ')') + 1, 
                      CASE WHEN INSTR(tel, ')') + 3 <= LENGTH(tel) THEN 3 ELSE 4 END), 
               '***') AS "REPLACE"
FROM student;

select empno
      ,ename
      ,job
      ,round(sal / 12, 1) as "month"
      ,trunc(sal / 12) as "trunc"
      ,mod(sal, 12) as "mod"
      ,ceil(sal / 12) as "ceil"
      ,floor(sal / 12) as "floor"
      ,power(4, 2) as "pwo"
from emp;

select months_between('15/01/01', '10/01/01')
from dual;

SELECT add_months(sysdate, 2),next_day(sysdate, '월') as "next_day"
        ,last_day(add_months(sysdate, 1)) as "last"
FROM dual;

select sysdate, to_char(sysdate, 'rrrr/mm/dd hh24:mi:ss') as "today"
from dual
where 1 = 1;

select to_date('2025-05-05 13', 'rrrr/mm/dd hh24') as "date"
from dual;