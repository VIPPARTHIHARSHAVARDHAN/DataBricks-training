#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


#4. City-wise total revenue
from pyspark.sql.functions import sum

# 4. City-wise total revenue
city_revenue = sales.join(customers, on="customer_id", how="inner") \
    .groupBy("city") \
    .agg(sum("total_amount").alias("total_city_revenue"))

city_revenue.show()