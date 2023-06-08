-- Copyright 2004-2023 H2 Group. Multiple-Licensed under the MPL 2.0,
-- and the EPL 1.0 (https://h2database.com/html/license.html).
-- Initial Developer: H2 Group
--

SELECT ANY_VALUE(X) FROM (VALUES NULL, NULL) T(X);
>> null

SELECT ANY_VALUE(X) FROM (VALUES NULL, 1) T(X);
>> 1

SELECT ANY_VALUE(DISTINCT X) FROM (VALUES NULL, 1) T(X);
>> 1

SELECT ANY_VALUE(X) BETWEEN 1 AND 300 FROM SYSTEM_RANGE(1, 300);
>> TRUE
