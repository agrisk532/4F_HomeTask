DROP DATABASE IF EXISTS HomeTask_AK;
CREATE DATABASE HomeTask_AK;
USE HomeTask_AK;

DROP TABLE IF EXISTS table_1;
CREATE TABLE table_1(
	ID INT NOT NULL,
	NAME CHAR(7) NOT NULL,
	VALUE CHAR(7) NOT NULL
	);
INSERT INTO table_1 VALUES(1,'attr_1', '5');
INSERT INTO table_1 VALUES(1,'attr_2', 'GOOD');
INSERT INTO table_1 VALUES(1,'attr_3', '15');
INSERT INTO table_1 VALUES(1,'attr_4', '4');
INSERT INTO table_1 VALUES(1,'attr_5', '50');
INSERT INTO table_1 VALUES(1,'attr_6', '60');
INSERT INTO table_1 VALUES(1,'attr_7', 'ABC');
INSERT INTO table_1 VALUES(1,'attr_8', '13');
INSERT INTO table_1 VALUES(1,'attr_9', '11');
INSERT INTO table_1 VALUES(1,'attr_10', 'OK');
INSERT INTO table_1 VALUES(2,'attr_1', '3');
INSERT INTO table_1 VALUES(2,'attr_2', 'BAD');
INSERT INTO table_1 VALUES(2,'attr_3', '25');
INSERT INTO table_1 VALUES(2,'attr_4', '04');
INSERT INTO table_1 VALUES(2,'attr_5', '52');
INSERT INTO table_1 VALUES(2,'attr_6', '62');
INSERT INTO table_1 VALUES(2,'attr_7', 'CBA');
INSERT INTO table_1 VALUES(2,'attr_8', '25');
INSERT INTO table_1 VALUES(2,'attr_9', '31');
INSERT INTO table_1 VALUES(2,'attr_10', 'FISH');

DROP TABLE IF EXISTS cash_flows;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (id_customer INT NOT NULL AUTO_INCREMENT, name VARCHAR(255) NOT NULL, age INT NOT NULL, PRIMARY KEY (id_customer));
CREATE TABLE cash_flows (id INT NOT NULL AUTO_INCREMENT, id_customer INT NOT NULL, balance FLOAT NOT NULL, balance_date DATETIME NOT NULL, PRIMARY KEY (id), FOREIGN KEY (id_customer) REFERENCES customers(id_customer));

INSERT INTO customers (name, age ) VALUES ('Uldis', 40);
INSERT INTO customers (name, age ) VALUES ('Artis', 25);
INSERT INTO customers (name, age ) VALUES ('Rolands', 27);

INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, -100, '2023-05-12 12:23:25');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, -200, '2023-05-13 13:05:45');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, 25, '2023-05-13 18:05:45');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, -25, '2023-05-13 19:05:45');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, 200, '2023-05-14 00:00:00');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, -120, '2023-05-15 12:23:25');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, -210, '2023-05-15 13:05:45');
INSERT INTO cash_flows (id_customer, balance, balance_date) VALUES (1, 15, '2023-05-16 18:05:45');

DROP TABLE IF EXISTS result_table;
CREATE TABLE result_table (NAME VARCHAR(255), age INT, cnt_negative INT, cnt_days INT, max_days INT);