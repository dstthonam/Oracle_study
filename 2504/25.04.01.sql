
-- 홀수 판단
DECLARE
    V_NUMBER NUMBER := 13;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    END IF;
END;
/


-- 홀/짝수 판단
DECLARE
    V_NUMBER NUMBER := 14;

BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수입니다!');
    ELSE    
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수입니다!');
    END IF;
END;
/


-- 점수에 따른 학점 출력
DECLARE
    V_SCORE NUMBER := 87;

BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
/


-- 기본 LOOP문 사용
DECLARE
    V_NUM NUMBER := 0;

BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 4;
    END LOOP;
END;
/


-- WHILE LOOP문 사용
DECLARE
    V_NUM NUMBER := 0;

BEGIN
    WHILE V_NUM < 4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
    END LOOP;
END;
/


-- FOR LOOP문 사용
BEGIN
    FOR i IN 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || i);
    END LOOP;
END;
/


-- FOR ~ REVERSE ~ LOOP문 사용
BEGIN
    FOR i IN REVERSE 0..4 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || i);
    END LOOP;
END;
/


-- FOR LOOP 안에 CONTINUE WHEN문 사용
BEGIN
    FOR i IN 0..4 LOOP
        CONTINUE WHEN MOD(i, 2) = 1;
        DBMS_OUTPUT.PUT_LINE('현재 i : ' || i);
    END LOOP;
END;
/


