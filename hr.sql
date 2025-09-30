select * from tab;

select * from employees; -- 사원 정보 EMPLOYEE_ID,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID

select * from departments; --locations에 대한 정보  DEPARTMENT_ID,DEPARTMENT_NAME, MANAGER_ID,LOCATION_ID

select * from locations; -- countries에 대한 정보 LOCATION_ID,STREET_ADDRESS,POSTAL__CODE,CITY,STATE_PROVINCE,COUNTRY_ID

select * from countries; -- employees에 대한 정보 COUNTRY_ID,REGION_ID

select * from jobs; -- 직업정보

select * from job_history;

select * from regions;
--
select distinct l.street_address
from employees e 
join departments d 
on d.department_id= e.department_id
join locations l
on l.location_id = d.location_id
join jobs j
on j.job_id = e.job_id
where job_title = 'Programmer';

--DEPARTMENT + EMPLOYESS 팀장급 

select e.*
from employees e 
join departments d 
on d.department_id= e.department_id
where employee_id = 103;

update employees
set SALARY = 20000
where employee_id = 103;

-- 직업테이블에 급여범위를 벗어난 사람 출력
-- jobs 테이블의 min_salary, max_salary.
select /*+INDEX(e EMP_EMP_ID_PK) */ e.*
from employees e
where not exists (select 1
                  from  jobs j 
                  where e.job_id = j.job_id
                  and e.salary between j.min_salary and j.max_salary);
                  
    
    
--1
select employee_id as 사원번호, last_name as 이름, salary as 급여, department_id as 부서번호
from employees
where salary between 7000 and 12000 
and last_name like 'H%';
--2
select 
employee_id as 사원번호
            , first_name || ' ' || last_name as 이름
            , job_id as 업무
            , salary as 급여
            , department_id as 부서번호
from employees
where department_id = 50 or department_id = 60;
--3
select 
  e.employee_id as 사원번호,
  e.first_name || ' ' || e.last_name AS 이름,
  e.salary as 현재급여,
  case 
    when e.salary <= 5000 then (e.salary * 1.20)
    when e.salary <= 10000 then (e.salary * 1.15)
    when e.salary <= 15000 then (e.salary * 1.10)
    when e.salary >= 15001 then (e.salary * 1)
  end as "인상 급여"
from employees e
where e.employee_id = :emp_id;
--4
select d.department_id as 부서번호 ,d.department_name as 부서이름 , j.city as 도시
from departments d
join locations j
on d.location_id = j.location_id;
--5
select employee_id as 사원번호, last_name as 이름, job_id as 업무
from employees
where department_ID =(select department_ID
                        from departments
                        where department_name = 'IT');
--6
select employee_id, first_name, last_name, email, phone_number, hire_date, job_id
from employees
where hire_date < to_date('2004/01/01', 'rrrr/mm/dd')
and job_id = 'ST_CLERK';
--7
select first_name || ' ' || last_name as 이름, job_id as 업무, salary as 급여, commission_pct as 커미션
from employees
where commission_pct is not null
order by commission_pct desc;
--8
create table prof(
    profno number(4),
    name varchar2(15) not null,
    id varchar2(15) not null,
    hiredate date,
    pay number(4));
--9 - 1
INSERT INTO prof VALUES
	(1001,'Mark','m1001', to_date('07/03/01', 'rr/mm/dd'), 800);
INSERT INTO prof (profno, name, id, hiredate)
VALUES (1003,'Adam','a1003', '11/03/02');
--9 - 2
update prof set pay = 1200 where profno = 1001;
--9 - 3
delete from prof where profno = 1003;
--10 - 1
select *
from prof
where profno is not null;
alter table prof add constraint pk_prof primary key (profno);
--10 - 2
alter table prof add gender char(3);
--10 - 3
alter table prof
modify name varchar2(20);