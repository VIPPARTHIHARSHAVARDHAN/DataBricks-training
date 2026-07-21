select MAX(num) as num 
FROM (SELECT num FROM MyNumbers
      group by num
      having count(*)=1)as single_number