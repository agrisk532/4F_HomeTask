USE HomeTask_AK;

SELECT * FROM table_1;
DROP TABLE IF EXISTS table_2;

SET @sql = NULL;
SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT('MAX(CASE WHEN `NAME` = ''', `NAME`, ''' THEN `VALUE` END) AS `', `NAME`, '`')
  ) INTO @sql
FROM
  table_1;

SET @sql = CONCAT('CREATE TABLE `table_2` AS SELECT `ID`, ', @sql, ' FROM `table_1` GROUP BY `ID`');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SELECT * FROM table_2;

