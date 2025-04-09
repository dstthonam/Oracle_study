SELECT *
    FROM (SELECT E.JOB, E.DEPTNO, E.SAL
            FROM EMP E) T
    PIVOT (MAX(T.SAL)
        FOR JOB IN ('CLERK' AS CLERK,
                    'SALESMAN' AS SALESMAN,
                    'PRESIDENT' AS PRESIDENT,
                    'MANAGER' AS MANAGER,
                    'ANALYST' AS ANALYST)
        )
    ORDER BY DEPTNO
    ;

SELECT *
    FROM (SELECT *
        FROM (SELECT E.JOB, E.DEPTNO, E.SAL
                FROM EMP E) T
        PIVOT (MAX(T.SAL)
            FOR JOB IN ('CLERK' AS CLERK,
                        'SALESMAN' AS SALESMAN,
                        'PRESIDENT' AS PRESIDENT,
                        'MANAGER' AS MANAGER,
                        'ANALYST' AS ANALYST)
            )
        ORDER BY DEPTNO)
    UNPIVOT(SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
;

SELECT E.DEPTNO,
        TRUNC(AVG(E.SAL), 0) AS AVG_SAL,
        TRUNC(MAX(E.SAL), 0) AS MAX_SAL,
        MIN(E.SAL) AS MIN_SAL,
        COUNT(*)
    FROM EMP E
    GROUP BY E.DEPTNO
    ORDER BY E.DEPTNO DESC
    ;

SELECT E.JOB,
        COUNT(*)
    FROM EMP E
    GROUP BY E.JOB
    HAVING COUNT(*) >= 3
    ORDER BY E.JOB
    ;

SELECT TO_CHAR(E.HIREDATE, 'YYYY') AS HIRE_YEAR,
        E.DEPTNO,
        COUNT(E.DEPTNO) AS CNT
    FROM EMP E
    GROUP BY TO_CHAR(E.HIREDATE, 'YYYY'), E.DEPTNO
    ;

SELECT NVL2(E.COMM, 'O', 'X') AS EXIST_COMM,
        COUNT(NVL2(E.COMM, 'O', 'X')) AS CNT
    FROM EMP E
    GROUP BY NVL2(E.COMM, 'O', 'X')
    ;

SELECT NVL(5, '1'),
        NVL(NULL, '2'),
        NVL2(NULL, '3', 'A'),
        NVL2(10, '4', 'B'),
        NVL2(NULL, '5', '')
    FROM DUAL;

SELECT E.DEPTNO, 
        TO_CHAR(E.HIREDATE, 'YYYY') AS HIRE_YEAR,
        COUNT(*) AS CNT,
        MAX(E.SAL) AS MAX_SAL,
        SUM(E.SAL) AS SUM_SAL,
        AVG(E.SAL) AS AVG_SAL
    FROM EMP E
    GROUP BY ROLLUP(E.DEPTNO, TO_CHAR(E.HIREDATE, 'YYYY'))
    ;
