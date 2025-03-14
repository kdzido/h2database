-- Copyright 2004-2025 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

CREATE TABLE TEST(A INT, B INT, C INT);
> ok

INSERT INTO TEST VALUES (1, 1, 1), (1, 1, 2), (1, 1, 3), (1, 2, 1), (1, 2, 2), (1, 2, 3),
    (2, 1, 1), (2, 1, 2), (2, 1, 3), (2, 2, 1), (2, 2, 2), (2, 2, 3);
> update count: 12

TABLE TEST ORDER BY A, B;
> A B C
> - - -
> 1 1 1
> 1 1 2
> 1 1 3
> 1 2 1
> 1 2 2
> 1 2 3
> 2 1 1
> 2 1 2
> 2 1 3
> 2 2 1
> 2 2 2
> 2 2 3
> rows (partially ordered): 12

TABLE TEST ORDER BY A, B, C FETCH FIRST 4 ROWS ONLY;
> A B C
> - - -
> 1 1 1
> 1 1 2
> 1 1 3
> 1 2 1
> rows (ordered): 4

SELECT * FROM (TABLE TEST) ORDER BY A, B, C FETCH FIRST ROW ONLY;
> A B C
> - - -
> 1 1 1
> rows (ordered): 1

SELECT (1, 2, 3) IN (TABLE TEST);
>> TRUE

SELECT (TABLE TEST FETCH FIRST ROW ONLY) "ROW";
> ROW
> -------------
> ROW (1, 1, 1)
> rows: 1

EXPLAIN TABLE TEST ORDER BY A;
>> TABLE "PUBLIC"."TEST" /* PUBLIC.TEST.tableScan */ ORDER BY 1

CREATE INDEX TEST_A_INDEX ON TEST(A);
> ok

EXPLAIN TABLE TEST ORDER BY A;
>> TABLE "PUBLIC"."TEST" /* PUBLIC.TEST_A_INDEX */ ORDER BY 1 /* index sorted */

DROP TABLE TEST;
> ok
