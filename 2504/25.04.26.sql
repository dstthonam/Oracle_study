SET SERVEROUTPUT ON;  

SELECT * FROM ALL_USERS;

conn ora_dev/1234;
SELECT * FROM DBA_DIRECTORIES;

CREATE OR REPLACE DIRECTORY ORA_DEV_DIR AS 'X:\oracle\product\oradata\ORCL';
SELECT * FROM USER_TABLES;




CREATE TABLESPACE MYTS DATAFILE 'X:\oracle\product\oradata\ORCL\MYTS.DBF' SIZE 100M AUTOEXTEND ON NEXT 5M; -- TABLESPACE 생성

CREATE USER ORA_USER IDENTIFIED BY 1234
DEFAULT TABLESPACE MYTS; -- USER 생성

GRANT DBA TO ORA_USER; -- ROLE 부여
-- DB 문자열 세팅 확인
SELECT * FROM NLS_DATABASE_PARAMETERS WHERE PARAMETER = 'NLS_CHARACTERSET';




-- TABLE 생성
CREATE TABLE EX3_6
AS SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.SALARY, A.MANAGER_ID
    FROM EMPLOYEES A 
    WHERE 1=1
    AND A.MANAGER_ID = 124
    AND A.SALARY BETWEEN 2000 AND 3000
    ;

SELECT * FROM EX3_3;
SELECT * FROM SALES;
SELECT * 
    FROM EMPLOYEES E 
    --WHERE E.MANAGER_ID = 145
    --AND S.SALES_MONTH BETWEEN '200010' AND '200012'
    --GROUP BY E.EMPLOYEE_ID
    ;


INSERT INTO EX3_3 (EMPLOYEE_ID)
SELECT E.EMPLOYEE_ID
    FROM EMPLOYEES E, SALES S
    WHERE E.EMPLOYEE_ID = S.EMPLOYEE_ID
    AND S.SALES_MONTH BETWEEN '200010' AND '200012'
    GROUP BY E.EMPLOYEE_ID;

CREATE TABLE EX3_3(
    EMPLOYEE_ID NUMBER,
    BONUS_AMT NUMBER DEFAULT 0
);

MERGE INTO EX3_3 A
    USING EMPLOYEES B 
    ON (A.MANAGER_ID = 145 AND B.EMPLOYEE_ID = A.EMPLOYEE_ID)
    WHEN MATCHED THEN
        UPDATE SET
            A.BONUS_AMT = 0.1 * B.SALARY

    WHEN NOT MATCHED THEN
        INSERT (EMPLOYEE_ID, BONUS_AMT)
        VALUES (B.EMPLOYEE_ID, 0.05 * B.SALARY)
    ;

SELECT EMPLOYEE_ID, EMP_NAME
    FROM EMPLOYEES A
    WHERE 1=1
    AND COMMISSION_PCT IS NULL
    ;

SELECT A.EMPLOYEE_ID, A.SALARY
    FROM EMPLOYEES A
    WHERE A.SALARY > 2000 AND A.SALARY < 2500
    ORDER BY EMPLOYEE_ID
    ;