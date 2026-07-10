#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


#1)Total order amount for each customer
from pyspark.sql.functions import sum

total_orders_df = sales.groupBy("customer_id") \
                       .agg(sum("total_amount").alias("total_order_amount"))

total_orders_df.show()
