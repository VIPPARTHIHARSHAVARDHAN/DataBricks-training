from pyspark.sql.functions import sum,col

Employees = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")
df=Employees.groupBy(("emp_id"),("event_day"))\
             .agg(sum(col("out_time")-col("in_time")).alias("total_time"))\
            .select(col("event_day").alias("day"),col("emp_id"),col("total_time"))
             