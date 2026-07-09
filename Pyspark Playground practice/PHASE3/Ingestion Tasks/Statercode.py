#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase2") \
    .getOrCreate()


# Sample starter code
df = spark.read.format("csv") \
 .option("header", "true") \
 .load("/samples/customers.csv")
df.show()
df.printSchema()
