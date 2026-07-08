#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")

customers.show()
sales.show()
customers.printSchema()
sales.printSchema()
customers = customers.dropna(subset=["customer_id"])
customers.show()
sales = sales.dropna(subset=["customer_id"])
sales.show()


