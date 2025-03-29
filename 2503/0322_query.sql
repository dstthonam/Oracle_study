SELECT E.SAL
    FROM EMP E
    WHERE E.ENAME = 'JONES'
    ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL > 2975
    ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL > (SELECT T.SAL
                        FROM EMP T
                         WHERE T.ENAME = 'JONES')
                        ;

SELECT E.*
    FROM EMP E
    WHERE E.HIREDATE < (SELECT T.HIREDATE
                            FROM EMP T
                            WHERE T.ENAME = 'JONES')
                            ;

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(T.SAL)
                    FROM EMP T)
                    ;

SELECT E.*
    FROM EMP E
    WHERE E.DEPTNO IN (20, 30)
    ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL IN (SELECT MAX(T.SAL)
                        FROM EMP T
                        GROUP BY T.DEPTNO)
                        ;

SELECT MAX(E.SAL)
    FROM EMP E
    GROUP BY E.DEPTNO
    ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL = ANY (SELECT MAX(T.SAL)
                            FROM EMP T
                            GROUP BY T.DEPTNO)
                            ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL = SOME (SELECT MAX(T.SAL)
                            FROM EMP T
                            GROUP BY T.DEPTNO)
                            ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL < ANY (SELECT T.SAL
                            FROM EMP T
                            WHERE T.DEPTNO = 30)
    ORDER BY E.SAL, E.EMPNO
    ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL < ALL (SELECT T.SAL
                            FROM EMP T
                            WHERE T.DEPTNO = 30)
                            ;

SELECT E.*
    FROM EMP E
    WHERE E.SAL > ALL (SELECT T.SAL
                            FROM EMP T
                            WHERE T.DEPTNO = 30)
                            ;

SELECT E.*
    FROM EMP E
    WHERE EXISTS (SELECT T.SAL
                    FROM EMP T
                    WHERE T.DEPTNO = 10)
                    ;

SELECT E.*
    FROM EMP E
    WHERE EXISTS (SELECT T.SAL
                    FROM EMP T
                    WHERE T.DEPTNO = 50)
                    ;

SELECT E.*
    FROM EMP E 
    WHERE (E.DEPTNO, E.SAL) IN (SELECT T.DEPTNO, MAX(T.SAL)
                                    FROM EMP T
                                    GROUP BY T.DEPTNO)
                                    ;

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
            (SELECT * FROM DEPT) D
    WHERE E10.DEPTNO = D.DEPTNO
    ;

WITH
    E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
    D   AS (SELECT * FROM DEPT)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM E10, D
    WHERE E10.DEPTNO = D.DEPTNO
    ;

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL,
        (SELECT GRADE
            FROM SALGRADE
            WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
        E.DEPTNO,
        (SELECT DNAME 
            FROM DEPT
            WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
    FROM EMP E
    ;

SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL,
        D.DEPTNO, D.DNAME
    FROM EMP E
    INNER JOIN DEPT D ON (E.DEPTNO = D.DEPTNO)
    WHERE E.JOB = (SELECT JOB FROM EMP WHERE ENAME = 'ALLEN')
    ;



SELECT E.* 
    FROM EMP E 
    WHERE 1=1 
    --AND E.ENAME = 'SCOTT'
    ;

