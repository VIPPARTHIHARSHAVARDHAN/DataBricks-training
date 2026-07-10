from pyspark.sql import SparkSession
from pyspark.sql.functions import sum, count

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()
#)5. Build final reporting table with customer, city, total spend, order count
customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")

report = customers.join(sales, on="customer_id") \
    .groupBy("customer_id", "city") \
    .agg(
        sum("total_amount").alias("total_spend"),
        count("customer_id").alias("order_count")
    )

report.show()