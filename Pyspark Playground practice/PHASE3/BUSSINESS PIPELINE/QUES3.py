#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

#)3. Find repeat customers (>2 orders)
from pyspark.sql.functions import count, col

sales = spark.read.option("header", "true").csv("/samples/sales.csv")

rep_cust = sales.groupBy("customer_id") \
    .agg(count("customer_id").alias("order_count")) \
    .filter(col("order_count") > 2)

rep_cust.show()