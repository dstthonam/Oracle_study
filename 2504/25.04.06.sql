
-- ERROR CODE, ERROR MESSAGE 사용하기
SET SERVEROUTPUT ON SIZE UNLIMITED;  
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME 
        INTO V_WRONG
        FROM DEPT
        WHERE DEPTNO = 10;
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);

END;
/


-- 예외처리부 예제1-1 작성
SET SERVEROUTPUT ON;
DECLARE
    V_EMP EMP%ROWTYPE;

    CURSOR C1 IS
        SELECT *
            FROM EMP;

BEGIN
    OPEN C1;

    LOOP 
        FETCH C1 INTO V_EMP;
        EXIT WHEN C1%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ENPNO : ' || V_EMP.EMPNO ||
            ', ENAME : ' || V_EMP.ENAME ||
            ', JOB : ' || V_EMP.JOB ||
            ', SAL : ' || V_EMP.SAL ||
            ', DEPTNO : ' || V_EMP.DEPTNO    
        );
    END LOOP;

    CLOSE C1;
END;
/


-- 예외처리부 예제1-2 작성
SET SERVEROUTPUT ON;
DECLARE
    CURSOR C1 IS
        SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
            FROM EMP;

BEGIN
    FOR C1_EMP IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(
            'EMPNO : ' || C1_EMP.EMPNO ||
            ', ENAME : ' || C1_EMP.ENAME ||
            ', JOB : ' || C1_EMP.JOB ||
            ', SAL : ' || C1_EMP.SAL ||
            ', DEPTNO : ' || C1_EMP.DEPTNO
        );
    END LOOP;

END;
/


-- 예외처리부 예제2 작성
SET SERVEROUTPUT ON;
DECLARE
    V_WRONG DATE;
BEGIN
    /**
    SELECT ENAME 
        INTO V_WRONG
        FROM EMP
        WHERE EMPNO = 7369;
    */
    V_WRONG := TO_DATE('0000-12-15', 'YYYY-MM-DD');
    
    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다.[' || TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"') || ']');
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);

END;
/
