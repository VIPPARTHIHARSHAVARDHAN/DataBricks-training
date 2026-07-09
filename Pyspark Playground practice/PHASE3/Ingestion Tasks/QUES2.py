#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()


#2. Inspect schema using show() and printSchema()
df = spark.read.format("csv") \
 .option("header", "true") \
 .load("/samples/customers.csv")
df.show()
df.printSchema()

