USE HomeTask_AK;

# insert a duplicate row in table_2
alter table table_2 add column pk int(10) unsigned primary KEY AUTO_INCREMENT;
DROP TABLE IF EXISTS tmpT2;
CREATE TEMPORARY TABLE tmpT2 SELECT * FROM table_2 WHERE pk = 1;
UPDATE tmpT2 SET pk = 3 WHERE pk = 1;
INSERT INTO table_2 SELECT * FROM tmpT2 WHERE pk = 3;
SELECT * FROM table_2;

# Task 2.1. Delete complete duplicates
DROP TEMPORARY TABLE IF EXISTS table_21;
CREATE TEMPORARY TABLE table_21 AS SELECT * FROM table_2;
DELETE FROM table_21 WHERE ID IN 
(SELECT 
    ID
FROM
    table_2
GROUP BY 
    ID, 
    attr_1,
    attr_2,
    attr_3,
    attr_4,
    attr_5,
    attr_6,
    attr_7,
    attr_8,
    attr_9,
    attr_10
HAVING  COUNT(ID) > 1
    AND COUNT(attr_1) > 1
    AND COUNT(attr_2) > 1
    AND COUNT(attr_3) > 1
    AND COUNT(attr_4) > 1
    AND COUNT(attr_5) > 1
    AND COUNT(attr_6) > 1
    AND COUNT(attr_7) > 1
    AND COUNT(attr_8) > 1
    AND COUNT(attr_9) > 1
    AND COUNT(attr_10) > 1);
   
SELECT * FROM table_21;


# Task 2.2. Delete all duplicates but one with max ID
DROP TEMPORARY TABLE IF EXISTS table_22;
CREATE TEMPORARY TABLE table_22 AS SELECT * FROM table_2;
update table_22 set ID = 3 WHERE pk = 3;
SELECT * FROM table_22;

DELETE t1 FROM table_22 t1
INNER JOIN table_22 t2 
WHERE 
    t1.ID < t2.ID AND 
    t1.attr_1 = t2.attr_1 AND
    t1.attr_2 = t2.attr_2 AND
    t1.attr_3 = t2.attr_3 AND
    t1.attr_4 = t2.attr_4 AND
    t1.attr_5 = t2.attr_5 AND
    t1.attr_6 = t2.attr_6 AND
    t1.attr_7 = t2.attr_7 AND
    t1.attr_8 = t2.attr_8 AND
    t1.attr_9 = t2.attr_9 AND
    t1.attr_10 = t2.attr_10;
SELECT * FROM table_22;
