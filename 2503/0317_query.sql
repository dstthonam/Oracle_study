SELECT SUM(E.SAL)
    FROM EMP E;

SELECT SUM(DISTINCT E.SAL), SUM(ALL E.SAL), SUM(E.SAL)
    FROM EMP E
;


SELECT COUNT(*)
    FROM EMP E
;

SELECT COUNT(*)
    FROM EMP E
    WHERE E.DEPTNO = 30
;

SELECT COUNT(E.COMM)
    FROM EMP E
    ;

SELECT COUNT(E.COMM)
    FROM EMP E
    WHERE E.COMM IS NOT NULL
    ;

SELECT MAX(E.SAL)
    FROM EMP E
    WHERE E.DEPTNO = 10
;

SELECT MIN(E.SAL)
    FROM EMP E
    WHERE E.DEPTNO = 10
;

SELECT TO_CHAR(MAX(E.HIREDATE), 'YYYY/MM/DD')
    FROM EMP E
    WHERE E.DEPTNO = 20
;    

SELECT AVG(E.SAL)
    FROM EMP E
    WHERE E.DEPTNO = 30
    ;

SELECT AVG(DISTINCT E.SAL)
    FROM EMP E
    WHERE E.DEPTNO = 30
    ;

SELECT AVG(E.SAL), E.DEPTNO
    FROM EMP E
    GROUP BY E.DEPTNO
    ;

SELECT E.DEPTNO, E.JOB, AVG(E.SAL)
    FROM EMP E
    GROUP BY E.DEPTNO, E.JOB
    ;

SELECT E.DEPTNO, E.JOB, AVG(E.SAL)
    FROM EMP E
    GROUP BY E.DEPTNO, E.JOB
    HAVING AVG(E.SAL) >= 2000
    ORDER BY E.DEPTNO, E.JOB 
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*), MAX(E.SAL), SUM(E.SAL), AVG(E.SAL)
    FROM EMP E
    GROUP BY ROLLUP(E.DEPTNO, E.JOB)
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*), MAX(E.SAL), SUM(E.SAL), AVG(E.SAL)
    FROM EMP E
    GROUP BY CUBE(E.DEPTNO, E.JOB)
    ORDER BY E.DEPTNO, E.JOB
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*)
    FROM EMP E
    GROUP BY E.DEPTNO, ROLLUP(E.JOB)
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*)
    FROM EMP E
    GROUP BY E.JOB, ROLLUP(E.DEPTNO)
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*)
    FROM EMP E
    GROUP BY GROUPING SETS(E.JOB, E.DEPTNO)
    ORDER BY E.DEPTNO, E.JOB
    ;

SELECT E.DEPTNO, E.JOB, COUNT(*), MAX(E.SAL), SUM(E.SAL), AVG(E.SAL),
        GROUPING(E.DEPTNO),
        GROUPING(E.JOB)
    FROM EMP E
    GROUP BY CUBE(E.DEPTNO, E.JOB)
    ORDER BY E.DEPTNO, E.JOB
    ;

SELECT DECODE(GROUPING(E.DEPTNO), 1, 'ALL_DEPT', E.DEPTNO) AS DEPTNO,
        DECODE(GROUPING(E.JOB), 1, 'ALL_JOB', E.JOB) AS JOB,
        COUNT(*), MAX(E.SAL), SUM(E.SAL), AVG(E.SAL)
    FROM EMP E
    GROUP BY CUBE(E.DEPTNO, E.JOB)
    ORDER BY E.DEPTNO, E.JOB
    ;


SELECT E.DEPTNO, E.JOB, SUM(E.SAL),
        GROUPING(E.DEPTNO), GROUPING(E.JOB),
        GROUPING_ID(E.DEPTNO, E.JOB)
    FROM EMP E
    GROUP BY CUBE(E.DEPTNO, E.JOB)
    ORDER BY E.DEPTNO, E.JOB
    ;

SELECT E.ENAME
    FROM EMP E
    WHERE E.DEPTNO = 10
    ;

SELECT E.DEPTNO, E.ENAME
    FROM EMP E
    WHERE E.DEPTNO = 10
    ORDER BY E.SAL DESC
    ;

SELECT E.DEPTNO, E.ENAME
    FROM EMP E
    GROUP BY E.DEPTNO, E.ENAME
    ;

SELECT E.DEPTNO,
        LISTAGG(E.ENAME, ',')
        WITHIN GROUP(ORDER BY E.SAL DESC) AS ENAMES
    FROM EMP E
    GROUP BY E.DEPTNO
    ;

SELECT E.DEPTNO, E.JOB, MAX(E.SAL)
    FROM EMP E
    GROUP BY E.DEPTNO, E.JOB
    ORDER BY E.DEPTNO, E.JOB
    ;

SELECT *
    FROM (SELECT E.DEPTNO, E.JOB, E.SAL
            FROM EMP E) T
    PIVOT (MAX(T.SAL) 
        FOR DEPTNO IN (10, 20, 30)
    )
    ORDER BY JOB
    ;


