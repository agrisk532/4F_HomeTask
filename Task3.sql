USE HomeTask_AK;

DROP TEMPORARY TABLE IF EXISTS tmptable;
CREATE TEMPORARY TABLE tmpTable AS 
    (SELECT *,
           LAG(balance_date,1) OVER (ORDER BY balance_date) AS prev_balance_date,
           LAG(balance,1)  OVER (ORDER BY balance_date) AS prev_balance,
           DATE(balance_date) AS b_date,
           case
           	when LAG(balance_date,1) OVER (ORDER BY balance_date) IS NULL then NULL
			  	else TIMEDIFF(balance_date, LAG(balance_date,1) OVER (ORDER BY balance_date))
			  END time_diff_btw_records,
           case 
            when LAG(DATE(balance_date),1) OVER (ORDER BY balance_date) <> date(balance_date) then TIME(balance_date)
            ELSE TIMEDIFF(time(balance_date), LAG(time(balance_date),1) OVER (ORDER BY balance_date))
            END time_interval_for_current_date,
            case
            when LAG(balance_date,1) OVER (ORDER BY balance_date) IS NULL then SIGN(balance)
            when SIGN(balance) = -1 AND SIGN(LAG(balance,1) OVER (ORDER BY balance_date)) = 1 then  1
            when SIGN(balance) = -1 AND SIGN(LAG(balance,1) OVER (ORDER BY balance_date)) = -1 then -1
            when SIGN(balance) =  1 AND SIGN(LAG(balance,1) OVER (ORDER BY balance_date)) = -1 then -1
            ELSE 1
            END time_interval_sign
		FROM cash_flows);
            #SELECT * FROM tmptable;


	DROP TEMPORARY TABLE IF EXISTS tmpTable2;
	CREATE TEMPORARY TABLE tmpTable2 AS
    (SELECT *, TIMEDIFF(time_diff_btw_records, time_interval_for_current_date) AS r_time
    FROM tmptable
	 ORDER BY balance_date desc);
    #SELECT * FROM tmptable2;


	DROP TEMPORARY TABLE IF EXISTS tmptable3;
	CREATE TEMPORARY TABLE tmptable3 AS
    (SELECT *,
    TIME_TO_SEC(time_interval_for_current_date) * time_interval_sign AS ticurrent_date_secs,
    TIME_TO_SEC(r_time) * time_interval_sign AS r_time_secs
 	 FROM tmptable2
		ORDER BY balance_date desc);
    #SELECT * FROM tmptable3;
    
   
 	DROP TEMPORARY TABLE IF EXISTS tmptable4;
	CREATE TEMPORARY TABLE tmptable4 AS
    (SELECT *,  
	case
	 when LEAD(r_time,1) OVER (ORDER BY balance_date) IS NULL then 
	  case 
	   when ticurrent_date_secs >=0 then 0
	   ELSE ticurrent_date_secs
	  end
    when prev_balance_date IS NULL then 
	  case
	   when LEAD(r_time_secs,1) OVER (ORDER BY balance_date) >=0 then 0
	   ELSE LEAD(r_time_secs,1) OVER (ORDER BY balance_date)
	  end
    else 
	  case when ticurrent_date_secs >=0 then 0   
	  ELSE ticurrent_date_secs
	  END 
	  +
	  case
	   when LEAD(r_time_secs,1) OVER (ORDER BY balance_date) >=0 then 0
	   ELSE LEAD(r_time_secs,1) OVER (ORDER BY balance_date)
	  end
	 END res_sec
    FROM tmptable3
	 ORDER BY balance_date desc);
   #SELECT * FROM tmptable4; 

   
  	DROP TEMPORARY TABLE IF EXISTS tmptable5;
	CREATE TEMPORARY TABLE tmptable5 AS
    (SELECT *,  
	 SUM(res_sec) AS 'summary'
    FROM tmptable4
    GROUP BY id_customer, b_date
	 ORDER BY balance_date asc);
   #SELECT * FROM tmptable5; 

   
    SET @c = 0;
	 DROP TEMPORARY TABLE IF EXISTS tmptable6;
	CREATE TEMPORARY TABLE tmptable6 AS
	(SELECT *, 
    case
     when summary < 0 and abs(summary) > 43200 then @c := @c + 1	# negative for the most part of the day (>12h)
    ELSE @c := 0
    END m
    FROM tmptable5
    ORDER BY b_date asc);
    #SELECT * FROM tmptable6; 


INSERT INTO result_table (NAME, age, cnt_negative, cnt_days, max_days) VALUES(
# name, age
(SELECT distinct NAME FROM customers c INNER JOIN tmptable5 t5 ON c.id_customer = t5.id_customer),
# age
(SELECT distinct age FROM customers c INNER JOIN tmptable5 t5 ON c.id_customer = t5.id_customer),
# cnt_negative, 
(SELECT COUNT(*) 
FROM (
    SELECT *,
           LAG(balance,1) OVER (ORDER BY balance_date ASC) AS prev_balance
    FROM cash_flows 
) subquery
WHERE (prev_balance >= 0 AND balance < 0)),
# cnt_days
(SELECT COUNT(*) FROM tmptable5
   WHERE summary < 0),
# max_days
(SELECT MAX(m) FROM tmptable6));
SELECT * FROM result_table;






