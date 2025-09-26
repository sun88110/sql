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
 
rollback;
commit;