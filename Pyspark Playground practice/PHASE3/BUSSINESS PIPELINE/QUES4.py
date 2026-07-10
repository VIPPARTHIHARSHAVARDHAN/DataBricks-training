#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

#)4. Find highest spending customer in each city
from pyspark.sql.window import Window
from pyspark.sql.functions import sum,rank
customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")
cust=customers.join(sales,"customer_id")\
                      .groupBy("customer_id","city")\
                     .agg(sum("total_amount").alias("total_spent"))

window=Window.partitionBy("city").orderBy(cust.total_spent.desc())
result=cust.withColumn("rank",rank().over(window))\
            .filter("rank=1")
result.show()
