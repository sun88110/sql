select 'purge table "'|| tname ||'";' from tab;

purge table "BIN$v/Sss+ZiTeORTXhXe7vb/Q==$0";

select * from tab; -- 모든 테이블조회

select * from user_recyclebin; -- 죽은 테이블 조회

FLASHBACK table new_table to before drop; -- 죽은 테이블 예토전생

DROP TABLE new_table purge; -- 그냥 죽어!!

create table new_emp(
  no number(4) constraint emp_pk primary key,
  name varchar2(20) constraint emp_name_nn not null,
  jumin varchar2(13) constraint emp_jumin_nn not null
                     constraint emp_jumin unique,
  loc_code number(1) constraint emp_area_ck check (loc_code < 5),
  deptno number(2) constraint emp_deptno_fk references dept(deptno)
);

create table new_table (
 no number(3) primary key, --회원번호 1 ~ 999 primary key에 중복제거 탑재되어있음
 name varchar2(100) not null, -- 이름 baejinwook 널이면 안된다
 birth date default sysdate-- 생년월일 --- to_date('2020-01-01' , 'rrrr-mm-dd')
);
alter table new_table add phone varchar2(20); --테이블수정

select * from new_table;

insert into new_table (no, name)
values(1, '배진욱');
insert into new_table (no, name, birth)
values(2, '김현태', '2001-01-01');
insert into new_table (no, name, birth) -- 리드온리라서 안들어가는거 테스트용
values(3, '도우서', '2001-01-01');

update new_table
set phone = '010-2222-2222',
    birth = to_date('2001-02-02', 'rrrr-mm-dd')
where no = 2;

ALTER table new_table RENAME COLUMN phone to tel;
alter table new_table modify tel varchar2(30);
alter table new_table drop colum tel; -- 칼럼 지우기
desc new_table; -- 칼럼 조회 

truncate table new_table; -- 데이터값 지우기
drop table new_table; -- 테이블 지우기

delete from new_table
where no = 1; -- 조건 지정안하고 delete쓰면 데이터 다 뒤져버림 하고나면 커밋해야됨 취소할려면 롤백

commit; --저장

rollback; --롤백

alter table new_table read only; -- 읽기전용
alter table new_table read write; -- 읽기전용 해제
alter table new_table add info generated always as (no || '-' || name); --가상컬럼


-------------------------------------DML
select * from dept2
order by dcode;
desc dept2;

insert into dept2 (dcode, dname, pdept, area)
values('9000','temp_1','1006','temp area');

create table professor3
as
select * from professor
where 1 = 2; -- ctas

insert into professor3
select * from professor; -- itas

create table prof_1 (
profon number,
name varchar2(25));

create table prof_2 (
profon number,
name varchar2(25));

insert all
when profno between 1000 and 1999 then 
into prof_1 values (profno, name)
when profno between 1000 and 1999 then 
into prof_2 values (profno, name)
 select profno, name
 from professor;
 
 select * from prof_1;
 select * from prof_2;
 
 insert all
into prof_1 values (profno, name)
into prof_2 values (profno, name)
 select profno, name
 from professor;
 
 select * from professor;
 
 update professor
 set bonus = decode(bonus, null, 100, bonus),
    pay = pay + (pay * 0.1),
    hpage = DECODE(hpage, null,'https://www.' || SUBSTR(email, INSTR(email, '@') + 1))
    --hpage를 이메일의 회사의 홈페이지로 변경
 where 1= 1;
 
 delete from professor
 where hpage is not null;
 
 --dept 삭제.
 select * from dept;
 
 delete from dept
 where deptno = 30;
 
 delete emp
 where deptno = 30;
 
 update emp
 set deptno = 50
 where deptno = 20;
 
 select * from emp e, dept d
 where e.deptno = d.deptno;
 
 select * from dept;
 
update emp e 
 set    sal = sal + 100
 where exists (select 1
               from dept d
               where e.deptno = d.deptno
               and d.loc = 'DALLAS');
 
 select *
 from emp e 
 where exists (select 1
               from dept d
               where e.deptno = d.deptno
               and d.loc = 'DALLAS');
 -- 게시판, 회원관리, 상품관리 ->
 -- 오라클 서버-- 웹서버(노드) -- 클라이언트(fetch)
 select *
 from emp;
  
desc emp;
  
insert into emp(empno, ename, job, hiredate, deptno)
values (9999, 'Hong', 'SALESMAN', to_date('1982-03-01','rrrr-mm-dd'), 30);

update emp
set ename = 'Hong',
    job = 'SALESMAN',
    hiredate = to_date('1982-03-01','rrrr-mm-dd'),
    deptno = 30
where empno = 9999;
 
-- sal => 1000 변경.
update emp
set sal = 1000
where sal < 1000;

-- sale직무 -> comm 500미만인 사원 comm을 -> 500주기

UPDATE emp
SET comm = 500
WHERE NVL(comm, 0) < 500;;

-- 1981년 전반기에 입사한 사람들(1~6월) => 급여 10% 인상

UPDATE emp
set sal = sal * 1.10
where hiredate >= '1981/01/01' and hiredate < '1981/07/01';

--
select * from professor;

select * from student;

select * from department;
-- Rene 'Russo 학생의 담당교수 번호,이름,position, 확인.

SELECT p.profno, p.name, position
FROM student s
JOIN professor p
ON s.profno = p.profno
where s.name='Rene Russo';

-- 전공: 'Computer Engineering' => 학생들의 학번, 이름을 확인
-- 전공1, 전공2도 같이 
-- 학생 전공1 중에 'Computer Engineering' 학생들의 담당교수번호,이름,직책을 확인

SELECT DISTINCT p.profno, p.name, position
FROM student s
JOIN department d
  ON s.deptno1 = d.deptno -- 학과가 101 인데
-- OR s.deptno2 = d.deptno
JOIN professor p
  ON d.deptno = p.deptno  
WHERE d.deptno = 101;

--어시스트 교사 출력
SELECT DISTINCT p.profno, p.name, position
FROM student s
JOIN professor p
ON s.profno = p.profno
WHERE position = 'assistant professor';

--학생전공 'Computer Engineering' 중 몸무게의 평균, 그보다 더 큰 학생들
select *
from student ss
where ss.weight > (SELECT avg(weight)
                   FROM student s
                   join department d
                   on s.deptno1 = d.deptno
                   where d.dname = 'Computer Engineering');

-- 전공이 : Electronic Engineering 학생들의 담당교수.
select *
from professor pp
where pp.position in (SELECT p.position
                    FROM professor p
                    JOIN student s
                    on p.profno = s.profno
                    join department d
                    on s.deptno1 = d.deptno
                    where d.dname = 'Electronic Engineering');
                    
-- 담당교수 급여(pay)의 평균이상을 교수번호, 이름 확인.

select name
from professor pp
where pp.pay >= (select avg(pay)
                from professor );
                
-- 보너스가 없는사람들 중에 입사 일자가 가장 빠른사람 이전에 입사한 사람들 출력

select name
from professor pp
where pp.hiredate < (SELECT hiredate
                    FROM professor
                    WHERE bonus IS NULL
                    AND hiredate = (
                    SELECT MIN(hiredate)
                    FROM professor
                    WHERE bonus IS NULL
  ));


-- 보너스 안받는 사람들 중에 월급 > 보너스가 있는 사람들 중에 월급 => 월급 10% 인상
update professor
set pay = pay  * 1.1
where bonus is not null and  bonus < (SELECT pay 
                    FROM professor
                    WHERE bonus IS NULL
                    AND pay =(SELECT MAX(pay)
                    FROM professor
                    WHERE bonus IS NULL));
-- view
create or replace view emp_dept_v
as
select empno, ename, job, sal, e.deptno, dname, comm
from emp e
join dept d
on e.deptno = d.deptno;

select *
from emp_dept_v;

create or replace view emp_v
as
select empno,ename, job, deptno
from emp;

update emp_v
set ename = '',
    deptno = ''
where empno = '9999';

select * from tab;

select position, count(*) --v.*, d.dname
from stud_prof_v v
join department d
on v.deptno = d.deptno
--where position = 'a full professor'
group by position;

-- 학생, 담당교수 뷰
create or replace view stud_prof_v as
select studno
    , s.name
    , s.birthday
    , s.tel
    , s.deptno1 deptno
    , p.profno
    , p.name profname
    , p.position
    , p.email
from student s
left outer join professor p
on s.profno = p.profno;

select profno, name, position, email
from professor;



SELECT e.*, d.dname FROM emp e
        join dept d
        on e.deptno = d.deptno
        where ename = DECODE ('ALL', 'ALL', ename, 'ALL')
        and   job = DECODE ('ANALYST', 'ALL', job, 'ANALYST')
        and   e.deptno = DECODE (-1, -1, e.deptno, -1);


create table board_t(
    board_no number(5) constraint PK_board_t primary key,
    title varchar2(100) not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    write_date date default sysdate,
    likes number(3));

-- 1. 게시판글연습, 게시판이잘되는지 연습, 홍길동
-- 2. 두더지게시판, 두더지는 무섭습니다, 김길동
-- 3. sql재밌네, sql중에 join은 어렵지만 재밌네요., 박석민
-- 4. 삭제는 어떻게 해요, delete from 테이블 where 조건절, 홍길동
insert into board_t (board_no, title, content, writer) 
values(1, '게시판글연습', '게시판이잘되는지 연습', '홍길동');
insert into board_t (board_no, title, content, writer) 
values(2, '두더지게시판', '두더지는 무섭습니다', '김길동');
insert into board_t (board_no, title, content, writer) 
values(3, 'sql재밌네', 'sql 중 join은 어렵지만 재밌네요', '박석민');
insert into board_t (board_no, title, content, writer) 
values(4, '삭제는 어떻게 해요', 'delete from 테이블 where 조건절', '홍길동');

insert into board_t (board_no, title, content, writer)
values ((select max(board_no)+1 from board_t), '게시판글연습', '게시판이 잘되는지 연습합니다', '홍길동');

--시퀀스 사용.
delete from board_t;

create sequence board_t_seq
increment by 1          --1씩증가
start with 1            -- 1부터시작
maxvalue 120            --120이 끝
minvalue 80             -- 80부터 시작
cycle                   --121부터 0으로감
;

drop sequence board_t_seq; -- 시퀀스 삭제
create sequence board_t_seq; -- 시퀀스 생성 
maxvalue 9999999999 ;
 
select board_t_seq.nextval from dual; --하나씩증가

select max(board_no)+1 from board_t;  --현재 최대값에 +1해서 확인

select count(*) from board_t; -- 현재 행 확인

insert into board_t (board_no, title, content, writer) 
select board_t_seq.nextval, title, content, writer
from board_t;

alter table board_t
modify board_no number(10); --보더 넘버 크기 증가하게 갱신
  

-- 1page : 1 ~ 10, 2 page : 11 ~ 20,
select b.*
from (select /*+ INDEX_DESC(PK_BOARD_T) */ rownum rn, a.*
      from board_t a ) b
where b.rn > (:page - 1) * 10
and   b.rn <= (:page * 10);

create index board write _date_idx
on board_t(writer_date);

delete from board_t where board_no = 6;

select /*+ INDEX_DESC(PK_BOARD_T) */ b.*
from board_t b;

rollback;
commit;