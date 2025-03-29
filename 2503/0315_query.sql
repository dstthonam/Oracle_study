SELECT CONCAT(E.EMPNO, E.ENAME),
        CONCAT(E.EMPNO, CONCAT(' : ', E.ENAME))
    FROM SCOTT.EMP E
    WHERE E.ENAME = 'KING'
;

SELECT E.EMPNO || E.ENAME,
        E.EMPNO || ' : ' || E.ENAME
    FROM SCOTT.EMP E
    WHERE E.ENAME = 'KING'
;

SELECT '[' || TRIM(' _ _Orale_ _ ') || ']' AS TRIM,
        '[' || TRIM(LEADING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_LEADING,
        '[' || TRIM(TRAILING FROM ' _ _Oracle_ _ ') || ']' AS TRIM_TRAILING,
        '[' || TRIM(BOTH FROM ' _ _Oracle_ _ ') || ']' AS TRIM_BOTH
    FROM DUAL
;

SELECT '[' || TRIM('_' FROM '_ _Orale_ _') || ']' AS TRIM,
        '[' || TRIM(LEADING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_LEADING,
        '[' || TRIM(TRAILING '_' FROM '_ _Oracle_ _') || ']' AS TRIM_TRAILING,
        '[' || TRIM(BOTH '_' FROM '_ _Oracle_ _') || ']' AS TRIM_BOTH
    FROM DUAL
;

SELECT '[' || TRIM(' _Orale_ ') || ']' AS TRIM,
        '[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
        '[' || LTRIM('<_Oracle_>', '_<') || ']' AS LTRIM_2,
        '[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,
        '[' || RTRIM('<_Oracle_>', '>_') || ']' AS RTRIM_2,
        '[' || LTRIM('<_O<_racle', '_<') || ']' AS LTRIM_3
    FROM DUAL
;

SELECT ROUND(12.567 , 0),
        ROUND(12.567 , 1),
        ROUND(12.567 , -1),
        ROUND(12.567 , -2)
    FROM DUAL
;

SELECT TRUNC(12.567 , 0),
        TRUNC(12.567 , 1),
        TRUNC(12.567 , -1),
        TRUNC(12.567 , -2)
    FROM DUAL
;

SELECT CEIL(3.14),
        FLOOR(3.14),
        CEIL(-3.14),
        FLOOR(-3.14)
    FROM DUAL
;

SELECT MOD(15, 6),
        MOD(10, 2),
        MOD(11, 2)
    FROM DUAL
;

SELECT SYSDATE AS NOW,
        SYSDATE - 1 AS YESTERDAY,
        SYSDATE + 1 AS TOMORROW
    FROM DUAL
;

SELECT SYSDATE,
        ADD_MONTHS(SYSDATE, 3)
    FROM DUAL
;

SELECT E.EMPNO, E.ENAME, E.HIREDATE,
        ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
    FROM EMP E
;

SELECT E.EMPNO, E.ENAME, E.HIREDATE, SYSDATE,
        MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
        MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
        TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
    FROM EMP E
;

SELECT SYSDATE,
        NEXT_DAY(SYSDATE, 'MON'),
        LAST_DAY(SYSDATE)
    FROM DUAL
;

SELECT SYSDATE,
        ROUND(SYSDATE, 'CC') AS FORMAT_CC,
        ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY,
        ROUND(SYSDATE, 'Q') AS FORMAT_Q,
        ROUND(SYSDATE, 'DDD') AS FORMAT_DDD,
        ROUND(SYSDATE, 'HH') AS FORMAT_HH
    FROM DUAL
;