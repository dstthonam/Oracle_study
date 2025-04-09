
-- 작성해야함
SET SERVEROUTPUT ON SIZE UNLIMITED;  
DECLARE
    TYPE ITAB_EMP IS TABLE OF EMP%ROWTYPE
        INDEX BY PLS_INTEGER;

    EMP_ARR ITAB_EMP;
    IDX PLS_INTEGER := 0;
BEGIN
    FOR i IN (SELECT * FROM EMP) LOOP
        IDX := IDX + 1;
        EMP_ARR(IDX) := i;

        DBMS_OUTPUT.PUT_LINE(
            EMP_ARR(IDX).EMPNO || ' : ' || EMP_ARR(IDX).ENAME || ' : ' || 
            EMP_ARR(IDX).JOB || ' : ' || EMP_ARR(IDX).MGR || ' : ' ||
            EMP_ARR(IDX).HIREDATE || ' : ' || EMP_ARR(IDX).SAL || ' : ' ||
            EMP_ARR(IDX).COMM || ' : ' || EMP_ARR(IDX).DEPTNO
        );
    END LOOP;
END;
/

DESC EMP;


-- SELECT INTO를 사용한 SINGLE ROW DATA 조회
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC 
        INTO V_DEPT_ROW
        FROM DEPT
        WHERE DEPTNO = 40;
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;
/


-- SINGLE ROW DATA를 CUSOR에 저장
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
            WHERE DEPTNO = 40;

BEGIN
    OPEN C1;
    FETCH C1 INTO V_DEPT_ROW;

    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);

    CLOSE C1;
END;
/


-- 여러 ROWS DATA를 CURSOR에 저장 후 -> LOOP문 사용
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;

    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT;
BEGIN
    OPEN C1;

    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'DEPTNO : ' || V_DEPT_ROW.DEPTNO ||
            ', DNAME : ' || V_DEPT_ROW.DNAME ||
            ', LOC : ' || V_DEPT_ROW.LOC
            );
    END LOOP;

    CLOSE C1;
END;
/


-- FOR LOOP문으로 CURSOR 활용
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT;

BEGIN
    FOR C1_REC IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE(
            'DEPTNO : ' || C1_REC.DEPTNO ||
            ', DNAME : ' || C1_REC.DNAME ||
            ', LOC : ' || C1_REC.LOC
        );
    END LOOP;
END;
/


-- PARAMETER를 사용하는 CURSOR
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;

    CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
            WHERE DEPTNO = P_DEPTNO;
BEGIN
    OPEN C1(10);
        LOOP
            FETCH C1 INTO V_DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(
                '10번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO ||
                ', DNAME : ' || V_DEPT_ROW.DNAME ||
                ', LOC : ' || V_DEPT_ROW.LOC
            );
        END LOOP;
    CLOSE C1;

    OPEN C1(20);
        LOOP
            FETCH C1 INTO V_DEPT_ROW;
            EXIT WHEN C1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(
                '20번 부서 - DEPTNO : ' || V_DEPT_ROW.DEPTNO ||
                ', DNAME : ' || V_DEPT_ROW.DNAME ||
                ', LOC : ' || V_DEPT_ROW.LOC
            );
        END LOOP;
    CLOSE C1;

END;
/


-- CURSOR에 사용할 PARAMETER '&~'로 받기
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE 
    V_DEPTNO DEPT.DEPTNO%TYPE;

    CURSOR C1(P_DEPTNO DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
            FROM DEPT
            WHERE DEPTNO = P_DEPTNO;

BEGIN
    V_DEPTNO := &INPUT_DEPTNO;

    FOR C1_REC IN C1(V_DEPTNO) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'DEPTNO : ' || C1_REC.DEPTNO ||
            ', DNAME : ' || C1_REC.DNAME ||
            ', LOC : ' || C1_REC.LOC
        );
    END LOOP;
END;
/


-- 묵시적 CURSOR의 속성 사용하기
SET SERVEROUTPUT ON SIZE UNLIMITED;
BEGIN
    UPDATE DEPT 
        SET DNAME = 'DATABASE'
        WHERE DEPTNO = 50
        ;

    DBMS_OUTPUT.PUT_LINE('갱신된 행의 수 : ' || SQL%ROWCOUNT);

    IF (SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재 여부 : false');
    END IF;

    IF (SQL%ISOPEN) THEN
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('커서의 OPEN 여부 : false');
    END IF;
END;
/

SELECT * FROM DEPT;
ROLLBACK;

-- FOR UPDATE와 WHERE CURRENT OF 사용하여 현재 CURSOR에 사용된 로우 업데이트
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    CURSOR EMP_CUR IS
        SELECT EMPNO, SAL 
            FROM EMP
            WHERE DEPTNO = 10
            FOR UPDATE
            ;

BEGIN
    FOR EMP_REC IN EMP_CUR LOOP
    UPDATE EMP
        SET SAL = SAL * 1.1
        WHERE CURRENT OF EMP_CUR;
    END LOOP;
    COMMIT;
END;
/

SELECT * FROM DEPT;


-- 사전 정의된 예외 사용하기
SET SERVEROUTPUT ON SIZE UNLIMITED;
DECLARE
    V_WRONG NUMBER;
BEGIN
    SELECT DNAME
        INTO V_WRONG
        FROM DEPT
        WHERE DEPTNO IN 10;

    DBMS_OUTPUT.PUT_LINE('예외가 발생하면 다음 문장은 실행되지 않습니다');

    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('예외 처리 : 요구보다 많은 행 추출 오류 발생');
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('예외 처리 : 수치 또는 값 오류 발생');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외 처리 : 사전 정의 외 오류 발생');
END;
/






