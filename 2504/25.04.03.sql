
-- 연관 배열 자료형 레코드 사용
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    TYPE REC_DEPT IS RECORD (
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE
    );

    TYPE ITAB_DEPT IS TABLE OF REC_DEPT
    INDEX BY PLS_INTEGER;

    DEPT_ARR ITAB_DEPT;
    IDX PLS_INTEGER := 0;

BEGIN
    FOR i IN (SELECT DEPTNO, DNAME FROM DEPT) LOOP
        IDX := IDX + 1;
        DEPT_ARR(IDX).DEPTNO := i.DEPTNO;
        DEPT_ARR(IDX).DNAME := i.DNAME;

        DBMS_OUTPUT.PUT_LINE(
            DEPT_ARR(IDX).DEPTNO || ' : ' || DEPT_ARR(IDX).DNAME);
    END LOOP;
END;
/

