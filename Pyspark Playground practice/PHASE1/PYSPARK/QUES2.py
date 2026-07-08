from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


#Top 3 customers by total spend
from pyspark.sql.functions import sum

top_3 = sales.groupBy("customer_id") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy("total_spend", ascending=False) \
    .limit(3)

top_3.show()