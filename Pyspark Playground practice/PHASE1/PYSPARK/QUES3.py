from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


#3. Customers with no orders
no_orders = customers.join(
    sales,
    on="customer_id",
    how="left"
).filter(sales.customer_id.isNull())

no_orders.show()          