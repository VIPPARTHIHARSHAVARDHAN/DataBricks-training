#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


#6. Customers with more than one order

from pyspark.sql.functions import count, col

cust_morethan_one_order = sales.groupBy("customer_id") \
    .agg(count("customer_id").alias("no_of_orders")) \
    .filter(col("no_of_orders") >= 2)

cust_morethan_one_order.show()