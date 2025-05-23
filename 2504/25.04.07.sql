
-- PARAMETER를 사용하지 않는 PROCEDURE 생성
CREATE OR REPLACE PROCEDURE PRO_NOPARAM 
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);

BEGIN 
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' || V_ENAME);

END;
/

-- PROCEDURE 실행
SET SERVEROUTPUT ON;
EXECUTE PRO_NOPARAM;

SET SERVEROUTPUT ON;
BEGIN
    PRO_NOPARAM;
END;
/

-- PACKAGE PROCEDURE ROW 확인
SELECT * FROM USER_SOURCE;

SELECT TEXT FROM USER_SOURCE;

DROP PROCEDURE PRO_NOPARAM;

SHOW ERRORS;

SHOW ERR PROCEDURE PRO_NOPARAM;

SELECT *
    FROM USER_ERRORS
    WHERE NAME = 'PRO_ERR'
    ;