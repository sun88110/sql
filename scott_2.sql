select *
from tab;

select sysdate, to_char(sysdate, 'rrrr/mm/dd') as "system"
     ,to_char(12345.6, '$099,999.99') as "num"
from dual;

select empno
      ,ename
      ,job
      ,to_char(sal, '999,999') as "salary"
from emp;

select *
from professor
where hiredate >= to_date('1990/01/01 09:00:00', 'rrrr/mm/dd hh24/mi/ss') and hiredate < to_date('2000/01/01 00:00:00', 'rrrr/mm/dd hh24/mi/ss');

select *
from emp
where sal + nvl(comm, 0) >= 2000;

select profno, name, nvl2(bonus, (pay*12) + bonus, (pay*12)) as "total"
from professor;

select empno, ename , nvl(comm, 0), nvl2(comm, 'Exist', 'Null') as "NVL2" 
from emp
where deptno = 30;

-- sal > 30 ? '값' : '값2'

select empno, ename
      ,decode(job, 'SALESMAN', '영업부서', decode(job, 'MANAGER', '관리부서', '기타부서' )) as "dept"
from emp;

select name,jumin, decode(substr(jumin, 7, 1), '1', 'MAN', 'WOMAN') AS "Gender"
from Student
where deptno1 = 101;

select name, tel, decode(substr(tel, 1, instr(tel, ')')-1), '02','seoul',
                                                            '055','GYEONGNAM') AS "log"
from student
where deptno1 = 101;

select name, tel,
                  case substr(tel, 1, instr(tel, ')')-1) when '02' then 'SEOUL'
                                                         when '031' then 'GYEONGI'
                                                         when '051' then 'BUSAN'
                                                         when '052' then 'ULSAN'
                                                         when '055' then 'GYEONGNAM'
                                                         else '기타'
      end as "LOC"                    
from student
where deptno1 = 101;

select profno, name, position, pay*12 as "pay"
      ,case when pay*12 > 5000 then 'High'
            when pay*12 > 4000 then 'Mid'
            when pay*12 > 3000 then 'Low'
            else 'Etc'
        end as "Sal"
from professor
where case when pay*12 > 5000 then 'High'
            when pay*12 > 4000 then 'Mid'
            when pay*12 > 3000 then 'Low'
            else 'Etc'
        end = 'High';
        
SELECT empno, ename, sal, 
       CASE 
         WHEN sal <= 1000 THEN 'LEVEL 1'
         WHEN sal <= 2000 THEN 'LEVEL 2'
         WHEN sal <= 3000 THEN 'LEVEL 3'
         WHEN sal <= 4000 THEN 'LEVEL 4'
         WHEN sal <= 5000 THEN 'LEVEL 5'
       END AS "level"
FROM emp
order by sal desc;

select profno, name, 'Professon'
from professor
where deptno = 101
union --행이 같으면 다른 테이블을 연결시켜서 조회해줌
select studno, name, 'Student'
from student
where deptno1 = 101;

select min(job), count(*) as "인원", sum(sal) as "직무 급여 합계", avg(sal) as "급여평균"
      ,stddev(sal) as "표준편차"
      ,variance(sal) as "분산"
from emp
group by job;

--표시하려면 그룹바이한 함수 타입이랑 같아야됨
select to_char(hiredate, 'rrrr') as "HD", count(*) as "인원"
from emp
group by to_char(hiredate, 'rrrr');

--학생, 학과별 인원.
select deptno1, count(*) as "학생 수"
from student
group by deptno1
having count(*) > 2;

--교수,position, pay합계, 최고급여, 최저급여
select position, sum(pay) as "pay합계", max(pay), min(pay)
from professor
group by position;

--직원,부서별 평균급여, 인원
select deptno, avg(sal), count(*)
from emp
group by deptno;
--직원, 부서, 직무별 평균급여, 인원
select deptno, job, avg(SAL), count(*)
from emp
group by deptno,job;
select avg(sal), count (*)
from emp;

--부서,직무,급여,인원
--부서     급여,인원
--부서,직무,급여,인원
--부서,    급여,인원
--        급여,인원
select deptno, null, round(avg(sal)), count(*), 'a'
from emp
group by deptno
union
select deptno, job, round(avg(sal)), count(*), 'b'
from emp
group by deptno,job
union
select null, null, round(avg(sal)), count (*), 'c'
from emp
order by 1, 2;

select decode(nvl(deptno, 999),999,'전체',deptno) as "부서"
, nvl(job, '합계') as "직무"
, round(avg(sal)) as "평균급여", count(*) as "사원수"
from emp
group by cube(deptno, job)
order by 1,2;

select dept.*, emp.*
from emp 
join dept
on emp.deptno = dept.deptno;

select count(*) from emp; --12 
select count(*) from dept; --4

select count(*)
from emp, dept;

select studno, student.name, grade, professor.name
from student
join professor
on student.profno = professor.profno;

select studno
, s.name as "학생이름"
, s.grade
, p.name as "교수이름"
, s.deptno1
, d.dname as "학과이름"
from student s
join professor p
on s.profno = p.profno
LEFT OUTER JOIN professor p
join department d
on s.deptno1 = d.deptno
;

select studno
, s.name as "학생이름"
, s.grade
, p.name as "교수이름"
, s.deptno1
, d.dname as "학과이름"
from student s
LEFT OUTER JOIN professor p
on s.profno = p.profno
join department d
on s.deptno1 = d.deptno
;
select p.profno, p.name, s.studno, s.name, s.profno as "담당교수"
from professor p 
left outer join student s
on p.profno = s.profno;

select p.profno, p.name, s.studno, s.name, s.profno as "담당교수"
from student s
right outer join professor p 
on p.profno = s.profno;

select *
from student;

select *
from salgrade;

select s.grade, e.*
from emp e
join salgrade s
on e.sal >= s.losal
and e.sal <= s.hisal
where s.grade = 2; -- e.sal 과 s.losal을 비교하고 e.sal s.hisal을 비교하여서 결과값에 해당되는것을 가져옴

select s.grade, e.*
from emp e
join salgrade s
on e.sal >= s.losal
and e.sal <= s.hisal
and s.grade = 2;

--orecle join.
select e.*, d.*
from emp e, dept d
where e.deptno = d.deptno;

select e1.empno as "사원번호"
      ,e1.ename as "사원명"
      ,e2.empno as "관리자번호"
      ,e2.ename as "관리자명"
from emp e1, emp e2
where e1.mgr = e2.empno(+);

--254-1
select s.name, s.deptno1, d.dname
from student s
join department d
on s.deptno1 = d.deptno;
--254-2
select name , e.position, TO_CHAR(pay, '99,999,999') as "pay", TO_CHAR(s_pay, '99,999,999') as "Low PAY", to_char(e_pay, '99,999,999') as "HIGH PAY"
from emp2 e
join p_grade p
on e.position = p.position
;
--255-1
select e.name,  trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 AS AGE, e.position, 
      case
            when trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 >= 41 then 'Director'
            when trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 >= 37 then 'Department head'
            when trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 >= 33 then 'Deputy department head'
            when trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 >= 29 then 'Section head'
            when trunc(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday, 'YYYY/MM/DD HH24:MI:SS')) / 12)-12 >= 25 then 'Deputy Section chief'
            end
from p_grade p
right outer join emp2 e
on e.position = p.position
order by age;
--255-2
select c.gname
, point 
, decode(g.gname,'Notebook','Notebook','Notebook') as "GIFT_NAME"
from customer c
join gift g
on c.point >= g.g_start
and c.point <= g.g_end
where point > 600001;
--256-1
select profno, name, to_char(hiredate, 'rrrr/mm/dd'),
from professor;
--order by count desc;

select *
from professor;