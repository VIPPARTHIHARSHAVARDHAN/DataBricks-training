from pyspark.sql.functions import  col,count

Orders = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")
df=Orders.groupby(col("customer_number"))\
         .agg(count("order_number").alias("cnt"))\
         .orderBy(col("cnt"),ascending=False).limit(1)
         
df.show()