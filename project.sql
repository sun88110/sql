CREATE TABLE member_table (
    user_id       VARCHAR2(16)   PRIMARY KEY,  -- PK 및 NOT NULL 설정
    nickname      VARCHAR2(16)   NOT NULL,
    password      VARCHAR2(16)   NOT NULL,     -- VARCHAR 타입으로 변경
    age           NUMBER(3)      NULL,
    gender        VARCHAR2(10)   NULL,
    tel           VARCHAR2(20)   NULL,
    create_time   TIMESTAMP      DEFAULT SYSTIMESTAMP NOT NULL,
    update_time   TIMESTAMP      NULL
);

CREATE TABLE user_table (
    trans_id      NUMBER         PRIMARY KEY,  -- PK
    user_id       VARCHAR2(16)   NOT NULL,
    trans_date    DATE           NOT NULL,
    category      VARCHAR2(20)   NOT NULL,
    description   VARCHAR2(100)  NOT NULL,
    amount        NUMBER         NOT NULL,    -- 금액은 NUMBER 타입 사용
    
    -- member_table과의 외래 키 (FK) 설정
    CONSTRAINT fk_user_member
        FOREIGN KEY (user_id)
        REFERENCES member_table (user_id)
);

CREATE TABLE bucket_table (
    user_id       VARCHAR2(16)   PRIMARY KEY, -- 1:1 관계를 위해 PK 겸 FK
    pay           NUMBER         NOT NULL,    -- 금액은 NUMBER 타입 사용
    update_time   TIMESTAMP      DEFAULT SYSTIMESTAMP NOT NULL,
    
    -- member_table과의 외래 키 (FK) 설정
    CONSTRAINT fk_bucket_member
        FOREIGN KEY (user_id)
        REFERENCES member_table (user_id)
);

-- 1. 시퀀스(Sequence) 생성
CREATE SEQUENCE user_table_seq
START WITH 1
INCREMENT BY 1;

-- 2. 트리거(Trigger) 생성 (데이터 삽입 시 trans_id에 시퀀스 값 자동 할당)
CREATE OR REPLACE TRIGGER trg_user_table_trans_id
BEFORE INSERT ON user_table
FOR EACH ROW
BEGIN
    IF :NEW.trans_id IS NULL THEN
        SELECT user_table_seq.NEXTVAL INTO :NEW.trans_id FROM DUAL;
    END IF;
END;
/
select * from bucket_table;