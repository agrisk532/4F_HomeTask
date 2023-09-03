# 4F_HomeTask
Software used:
MariaDB 11.1 (x64),
HeidiSQL 12.5.0.6677 (x64),
MySQL client (MariaDB 11.1)

Files:
Input_data.sql. Creates tables and fills with data. MUST BE RUN BEFORE OTHER SCRIPTS!
Task1.sql. Switches rows to cols.
Task2.sql. Removes duplicates.
Task3.sql. Fills the result_table.
Task3.sql current limitations:
1) Only one customer (in the 'customers' table)
2) The 'cash_flows' table must contain record(s) for every calendar day with no gaps.
For example,
Valid: 2023-05-12, 2023-05-13, 2023-05-14, 2023-05-15, 2023-05-16 (continuous dates)
Invalid: 2023-05-12, 2023-05-14, 2023-05-16 (missing data for 2023-05-13, 2023-05-15)
