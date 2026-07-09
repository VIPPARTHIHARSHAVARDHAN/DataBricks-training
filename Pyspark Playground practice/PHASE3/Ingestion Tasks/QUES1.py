#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()

# 1. Read a CSV file from /samples/
df = spark.read.format("csv") \
 .option("header", "true") \
 .load("/samples/customers.csv")
df.show()

