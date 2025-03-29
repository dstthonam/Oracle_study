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
/

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

-- NLS_INSTANCE_PARAMETERS init.ora/spfile 설정
SELECT * FROM NLS_INSTANCE_PARAMETERS;
-- NLS_DATABASE_PARAMETERS init.ora/spfile 설정
SELECT * FROM NLS_DATABASE_PARAMETERS;
SELECT * FROM SYS.PROPS$;
-- 
SELECT * FROM DATABASE_PROPERTIES;

--

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
CREATE USER (USERNAME) IDENTIFIED BY (PASSWORD);

-- PASSWORD 변경
ALTER USER (USERNAME) IDENTIFIED BY (PASSWORD);

/**
USER 권한 부여

(권한 종류                                                     - 설명)
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

-- USER 권한 회수
REVOKE {GRANT TO ORDER} FROM {USERNAME};



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

DATA DUMP 
-- IMPDP, EXPDP
*/

-- BACKUP
expdp {USERNAME}/{USERPASSWORD} dumpfile={파일이름.dmp} schemas={스키마이름}

-- ROLLBACK
impdp [USERNAME]/[USERPASSWORD] dumpfile={파일이름.dmp} table_exists_action=replace






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
