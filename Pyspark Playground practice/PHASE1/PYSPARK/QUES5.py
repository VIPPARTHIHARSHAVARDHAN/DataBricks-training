#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")


# . Average order amount per customer
from pyspark.sql.functions import avg
avg_amount=sales.groupBy("customer_id")\
                .agg(avg("total_amount").alias("average_amount"))
avg_amount.show()