SET SERVEROUTPUT ON;
BEGIN
    FOR i IN 0..10 LOOP
        CONTINUE WHEN MOD(i, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('현재 i의 값 : ' || i);
    END LOOP;
END;
/

SELECT * FROM DEPT;


SET SERVEROUTPUT ON;
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE;
    V_DNAME DEPT.DNAME%TYPE;
BEGIN
    V_DEPTNO := 10;
    
    SELECT DNAME
        INTO V_DNAME
        FROM DEPT D
        WHERE D.DEPTNO = V_DEPTNO
        ;

    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DNAME);
END;
/

SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 0;
    V_DNAME DEPT.DNAME%TYPE := NULL;
BEGIN
    LOOP
        V_DEPTNO := V_DEPTNO + 10;

        IF V_DEPTNO > 40 THEN
            DBMS_OUTPUT.PUT_LINE('DNAME : N/A');
            EXIT;
        END IF;

        SELECT DNAME 
            INTO V_DNAME
            FROM DEPT D
            WHERE D.DEPTNO = V_DEPTNO
            ;
        
        CASE V_DEPTNO
            WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DNAME);
            WHEN 20 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DNAME);
            WHEN 30 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DNAME);
            WHEN 40 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DNAME);
        END CASE;

    END LOOP;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 99;
    DEPT_REC.DNAME := 'DATABASE';
    DEPT_REC.LOC := 'SEOUL';
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || DEPT_REC.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || DEPT_REC.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || DEPT_REC.LOC);
END;
/

CREATE TABLE DEPT_RECORD
    AS SELECT * FROM DEPT;

DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 99;
    DEPT_REC.DNAME := 'DATABASE';
    DEPT_REC.LOC := 'SEOUL';

    INSERT INTO DEPT_RECORD 
        VALUES DEPT_REC;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO NUMBER(2) NOT NULL := 99,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );
    DEPT_REC REC_DEPT;
BEGIN
    DEPT_REC.DEPTNO := 50;
    DEPT_REC.DNAME := 'DB';
    DEPT_REC.LOC := 'SEOUL';

    UPDATE DEPT_RECORD
        SET ROW = DEPT_REC
        WHERE DEPTNO = 99
        ;
END;
/

DECLARE
    TYPE REC_DEPT IS RECORD(
        DEPTNO DEPT.DEPTNO%TYPE,
        DNAME DEPT.DNAME%TYPE,
        LOC DEPT.LOC%TYPE
    );

    TYPE REC_EMP IS RECORD (
        EMPNO EMP.EMPNO%TYPE,
        ENAME EMP.ENAME%TYPE,
        DINFO REC_DEPT
    );

    EMP_REC REC_EMP;
BEGIN
    SELECT E.EMPNO, E.ENAME,
            D.DEPTNO, D.DNAME, D.LOC
        INTO EMP_REC.EMPNO, EMP_REC.ENAME, 
            EMP_REC.DINFO.DEPTNO, EMP_REC.DINFO.DNAME, EMP_REC.DINFO.LOC
        FROM EMP E, DEPT D
        WHERE E.DEPTNO = D.DEPTNO
        AND E.EMPNO = 7839;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO : ' || EMP_REC.EMPNO);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || EMP_REC.ENAME);

    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || EMP_REC.DINFO.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || EMP_REC.DINFO.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || EMP_REC.DINFO.LOC);
END;
/

SELECT * FROM DEPT D
    INNER JOIN EMP E ON (D.DEPTNO = E.DEPTNO);

SELECT *
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;

SELECT * FROM DEPT_RECORD;
SELECT * FROM DBA_DIRECTORIES;

DECLARE
    TYPE ITAB_EX IS TABLE OF VARCHAR2(20)
INDEX BY PLS_INTEGER;
    TEXT_ARR ITAB_EX;

BEGIN
    TEXT_ARR(1) := '1ST DATA';
    TEXT_ARR(2) := '2ST DATA';
    TEXT_ARR(3) := '3ST DATA';
    TEXT_ARR(4) := '1ST DATA';

    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(1) : ' || TEXT_ARR(1));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(2) : ' || TEXT_ARR(2));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(3) : ' || TEXT_ARR(3));
    DBMS_OUTPUT.PUT_LINE('TEXT_ARR(4) : ' || TEXT_ARR(4));
END;
/

