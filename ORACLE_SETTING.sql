-- ORACLE SCRIPT 수정 권한 부여
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

-- SQL*PLUS에서 SCHEMA 생성시 
@$ORCLE_HOME/DEMO/SCHEMA/{생성할 SCHEMA.sql}









/**

SQL*PLUS COMMAND

*/
-- 연결/연결해제 관련
(CONNECT/DISCONNECT) {ID}/{PW};
-- SQL*PLUS 중지
EXIT/QUIT;

-- SESSION 조회
SELECT * FROM V$SESSION WHERE SCHEMANAME = 'SCOTT';
-- SESSION KILLED
ALTER SYSTEM KILL SESSION {'SID,SERIAL#'}; -- SID와 SERIAL# 컬럼의 값을 입력, ''도 입력해야함.



/**

SYS_CONTEXT
- USERENV : 현재 세션의 환경 정보를 반환하는 NAMESPACE

*/

SELECT SYS_CONTEXT('USERENV','ISDBA') as dba권한사용자여부
     , SYS_CONTEXT('USERENV','IP_ADDRESS') as 연결된ip주소
     , SYS_CONTEXT('USERENV','SESSIONID') as 세션id
     , SYS_CONTEXT('USERENV','OS_USER') as os_user
     , SYS_CONTEXT('USERENV','SID') as sid 
     , SYS_CONTEXT('USERENV','DB_NAME') as dbname 
     , SYS_CONTEXT('USERENV','Bg_job_id') as db_job_id
     , SYS_CONTEXT('USERENV','current_sql') as current_sql
     , SYS_CONTEXT('USERENV','LANGUAGE') as 설정언어
     , SYS_CONTEXT('USERENV','TERMINAL') as 운영체제시스템
     , SYS_CONTEXT('USERENV','session_user') as 세션user   
     , SYS_CONTEXT('USERENV','MODULE')   as prg
  FROM dual;













/**

DD 정보 조회
ALL_(TABLES, INDEXES)
USER_(TABLES, INDEXES)
*/
-- DIRECTORY 조회
SELECT * FROM DBA_DIRECTORIES;
-- DIRECTORY DICTIONARY 조회 뷰
SELECT * FROM ALL_DIRECTORIES;
-- USER SYSTEM 권한 조회 뷰(sys가 준 권한 확인 가능)
SELECT * FROM DBA_SYS_PRIVS;
-- DIRECTORY(OBJECT) 권한 조회 뷰(sys가 준 권한 확인 가능)
SELECT * FROM DBA_TAB_PRIVS;
SELECT * FROM V$INSTANCE;
-- 
SELECT * FROM DBA_ROLE_PRIVS;

-- USER가 생성한 모든 OBJECTS 참조
SELECT * FROM USER_OBJECTS;

-- NLS_INSTANCE_PARAMETERS init.ora/spfile 설정
SELECT * FROM NLS_INSTANCE_PARAMETERS;
-- NLS_DATABASE_PARAMETERS init.ora/spfile 설정
SELECT * FROM NLS_DATABASE_PARAMETERS;
SELECT * FROM SYS.PROPS$;
-- 
SELECT * FROM DATABASE_PROPERTIES;

--???
SELECT * FROM USER_DEPENDENCIES;

--???
@X:\oracle\product\ver\19c\dbhome\WINDOWS.X64_193000_db_home\rdbms\admin\utldtree.sql
EXECUTE deptree_fill('TABLE', 'SCOTT', 'DEPT');
SELECT * FROM {DEPTREE/IDEPTREE VIEW};








/**

USER 설정 관련

*/
-- 현재 접속중인 USER 조회
SHOW USER;

-- 모든 계정에 대한 정보 확인
SELECT {USERNAME} FROM {ALL_USERS/DBA_USER};

-- USER 계정 잠금
ALTER USER {USERNAME} ACCOUNT (UNLOCK/LOCK);



/** 

USER 관련

*/
--USER 생성
CREATE USER {USERNAME} IDENTIFIED BY {PASSWORD};

CREATE USER USER_NAME IDENTIFIED BY PASSWORD
DEFAULT TABLESPACE TABLESPACE_NAME                -- 기본 TABLESPACE 지정
TEMPORARY TABLESPACE TEMP_TABLESPACE_NAME         -- 임시적으로 DATA를 저장할 TABLESPACE 지정
QUOTA TABLESPACE_SIZE ON TABLESPACE_NAME          -- 해당 USER가 TABLESAPCE에서 사용할 용량 이정
PROFILE PROFILE_NAME                              -- PROFILE 추가 설정
PASSWORD EXPIRE                                   -- USER가 접속했을 때 PASSWORD변경 여부 설정(강제 변경)
ACCOUNT LOCK/UNLOCK;

-- PASSWORD 변경
ALTER USER {USERNAME} IDENTIFIED BY {PASSWORD};

/**
USER 권한 부여

(권한 종류                                                     - 설명)
{CONNECT}                                                     - ALTER/CREATE SESSION
{RESOURCE}                                                    - CERATE CLUSTER, INDEXTYPE, OPERATOR, PROCEDURE, SEQUENCE, TABLE, TRIGGER, TYPE 권한 부여

{CREATE/ALTER/RESTRICTED/DROP/ALL} SESSION                    - DB 접속 권한
{CREATE/DROP/ALL} USER                                        - DB USER 생성/삭제 권한
{SYSDBA/SYSOPER}                                              - DB 관리하는 (최고/) 권한

{CREATE/DROP/ALTER/SELECT/UPDATE/DELETE/ALL} (ANY) TABLE      - (모든) USER TABLE 생성/삭제 권한
{SELECT/INSERT/UPDATE/DELETE/ALL} ON {USERNAME.TABLE_NAME}    - 다른 SCHEMA에서 생성된 테이블의 DML 권한

{CREATE/DROP/ALTER/RESTRICTED/ALL} INDEX                      - INDEX 생성/삭제 권한
{CREATE/DROP/ALL} VIEW                                        - VIEW 생성/삭제 권한
{CREATE/DROP/ALL} SEQUENCE                                    - SEQUENCE 생성/삭제 권한

{CREATE/DROP/ALL} PROCED USER                                 - PROCEDURE 생성/삭제 권한
{EXECUTE/DROP} ON {USERNAME.PROCEDURE}                        - PROCEDURE 실행 권한

{EXECUTE} ON {USERNAME.FUNCTION_NAME}                         - 함수 실행 권한
{CREATE/DROP} (ANY) PROCEDURE                                 - 함수 생성 권한

READ, WRITE ON DIRECTORY {DIRECTORY_NAME}                     - DIRECTORY 읽기/쓰기 권한 
{CREATE/ALTER/DROP/UNLIMITED} TABLESPACE                      - {모든} TABLESPACE 제한없이 사용 권한

~~{TO/FROM} PUBLIC                                            - 모든 사용자에게 권한 부여
*/
GRANT {GRANT TO ORDER} TO {USERNAME};
REVOKE {GRANT TO ORDER} FROM {USERNAME}; -- USER 권한 회수



/**

TABLESPACE 관련: 관리 계정에서만 가능

*/
-- 생성된 TABLESPACE 정보 조회
SELECT TABLESPACE_NAME, CONTENTS, STATUS FROM DBA_TABLESPACES;

-- TABLESPACE 생성
CREATE TABLESPACE {ORA_DEV_TEST} DATAFILE {'X:\oracle\product\oradata\ORCL\ORA_DEV_TEST.dbf'} SIZE {200M} (AUTOEXTEND) ON NEXT {50M} MAXSIZE {UNLIMITED};

-- TABLESPACE 제한용량 및 권한
ALTER USER {USERNAME} QUOTA {100M(제한용량)} ON {TABLESPACE_NAME};






/**

DIRECTORY 관련: 관리 계정에서만 가능

*/
-- DIRECTORY 생성
CREATE DIRECTORY {DIRECTORY_NAME} AS {'폴더 위치'};
/* DUMPFILE용도로 DIRECTORY 설치시 위치 : ~~/dumpfiles/ 폴더 생성 및 해당 위치 지정 */

-- DIRECTORY 변경(OS 위치 변경)
CREATE OR REPLACE DIRECTORY {DIRECTORY_NAME} AS {'바꿀 폴더 위치'}


-- 외부 TABLE로 특정 파일 읽기
CREATE TABLE employees_ext (
  id NUMBER,
  name VARCHAR2(100),
  salary NUMBER
)
ORGANIZATION EXTERNAL
(
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY CSV_DIR
  ACCESS PARAMETERS
  (
    RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
  )
  LOCATION ('employees.csv')
); 




/**

SYNONYM 설정 관련

*/
CREATE (OR REPLACE) (PUBLIC/PRIVATE) SYNONYM {(USERNAME).SYNONYM_NAME} FOR {USERNAME.OBJ_NAME};
DROP (PUBLIC) SYNONYM {OBJ_NAME};








/**

CONSTRAINT 설정 관련

*/
-- 제약 조건 추가
ALTER TABLE {TABLE_NAME} ADD CONSTRAINT {CONSTRAINT_NAME} {(UNIQUE/CHECK/FOREIGN/REFERENCES) (COLUMN지정)};

-- 제약 조건 삭제
ALTER TABLE {TABLE_NAME} DROP CONSTRAINT {CONSTRAINT_NAME};

-- 제약 조건 활성화/비활성화
ALTER TABLE {TABLE_NAME} (ENABLE/DISABLE) CONSTRAINT {CONSTRAINT_NAME};





/**

PACKAGE 설정 관련

*/









/**

TRIGGER 설정 관련



*/
-- TRIGGER 정보 조회회
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT, TABLE_NAME, STATUS
    FROM USER_TRIGGERS;
-- 해당 TABLE의 TRIGGER 비/활성화
ALTER TABLE {TABLE_NAME} (ENABLE/DISABLE) ALL TRIGGERS;
ALTER TRIGGER {TRIGGER_NAME} (ENABLE/DISABLE);
-- TRIGGER 삭제
DROP TRIGGER {TRIGGER_NAME};





/**

ORACLE 기본 제공 PACKAGE 관련

DBMS_OUTPUT : PL/SQL 블록 내의 변수 데이터를 화면에 출력
DBMS_SQL : PL/SQL에서 동적 SQL을 구현할 때 사용
DBMS_JOB : 특정 PL/SQL 블록을 스케쥴링 하여 실행할 때 사용
DBMS_DDL : DDL 문을 실행할 때 사용
DBMS_PIPE : DB에 접속된 다른 사용자에게 메시지를 전송할 때 사용
DBMS_AQ : DBMS_PIPE의 향상된 기능으로 DB에 접속된 다른 사용자에게 메시지를 전송할 때 사용
DBMS_SESSION : DB에 접속된 다른 사용자의 정보를 참조할 때 사용
UTL_FILE : O/S상의 텍스트 파일을 PL/SQL 내에서 읽을 때 사용

*/













/**

DATA DUMP 
-- IMPDP, EXPDP
*/

-- BACKUP
expdp {USERNAME}/{USERPASSWORD} dumpfile={파일이름.dmp} schemas={스키마이름}
-- EXAMPLE
expdp ORCLSTUDY/1234 DIRECTORY=DATA_PUMP_DIR dumpfile=expdp_ORCLSTUDY_20250526.dmp logfile=expdp_ORCLSTUDY_20250526.log SCHEMAS=ORCLSTUDY

-- ROLLBACK
impdp [USERNAME]/[USERPASSWORD] dumpfile={파일이름.dmp} table_exists_action=replace

-- PROCEDURE로 인해 DUMP_FILE이 생성되지 않을 때 프로시저 삭제
DROP PROCEDURE SCOTT.PRO_ERR;

expdp ORCLSTUDY/1234 DIRECTORY=ORA_DEV_DIR DUMPFILE=EXPDP_ORCLSTUDY_20250526.dmp LOGFILE=EXPDP_ORCLSTUDY_20250526.log FULL=Y







/**

PDBS 설정 관련

*/

-- Oracle CDB(Container Database)에서 PDB(Pluggable Database)의 상태를 조회
SELECT NAME, OPEN_MODE, RESTRICTED FROM V$PDBS;


ALTER PLUGGABLE DATABASE PDB1 {OPEN/CLOSE};









/** 

TNS(Transparent Network Substrate) 설정

*/













/** 추가 할 내용들 아래에 기록 */

-- DBF 경로와 상태확인
SELECT FILE_NAME, TABLESPACE_NAME, BYTES/1024/1024 AS SIZE_MB FROM DBA_DATA_FILES;

select * from dba_sys_privs where grantee='사용자명';


SELECT * FROM USER_SOURCE;

SELECT TEXT FROM USER_SOURCE;

DROP PROCEDURE PRO_NOPARAM;

SHOW ERRORS;

SHOW ERR PROCEDURE PRO_NOPARAM;

SELECT *
    FROM USER_ERRORS
    WHERE NAME = 'PRO_ERR'
    ;


SELECT REGEXP_REPLACE(LOC_DATE3, '([[:digit:]]{4})(\d{2})(\d{2})', '\1-\2-\3') AS POST_DATE FROM TEST_DATE;

SELECT ST_ASTEXT('09UE012')
    FROM DUAL;

SELECT * FROM USER_LIBRARIES;


SELECT REGEXP_REPLACE(LOC_DATE3, '([[:digit:]]{4})(\d{2})(\d{2})', '\1-\2-\3') AS POST_DATE FROM TEST_DATE;

INSERT INTO TEST_DATE VALUES ('20150201', 20150304, TO_DATE('2015-04-19', 'YYYY-MM-DD'));

SELECT ST_ASTEXT('09UE012')
    FROM DUAL;

SELECT * FROM USER_LIBRARIES;


select * from user_mviews;
select * from v$controlfile;
select * from v$parameter --where name='control_files'
;

SELECT * FROM V$SESSION WHERE SCHEMANAME = 'SCOTT';

SELECT * FROM USER_OBJECTS;

MERGE INTO EMP_TEMP T
    USING EMP E ON (T.EMPNO = E.EMPNO)
    WHEN MATCHED THEN 
        UPDATE SET T.SAL = 4000
        WHERE E.DEPTNO = 20
        ;

CREATE USER USER_NAME IDENTIFIED BY PASSWORD DEFAULT TABLESPACE TABLESPACE_NAME
TEMPORARY TABLESPACE TABLESPACE_NAME QUOTA TABLESPACE_SIZE ON TABLESPACE_NAME
PROFILE PROFILE_NAME PASSWORD EXPIRE ACCOUNT (LOCK/UNLOCK);

SELECT * FROM ALL_USERS;
SELECT * FROM DBA_USERS;

SELECT * FROM DBA_OBJECTS WHERE OWNER = 'SCOTT';

select * from user_mviews;
select * from v$controlfile;
select * from v$parameter --where name='control_files'
;

        