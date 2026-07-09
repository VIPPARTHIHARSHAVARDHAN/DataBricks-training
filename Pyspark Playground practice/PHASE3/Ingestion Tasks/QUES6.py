from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

# Read JSON file
json_df = spark.read.format("json") \
    .load("/samples/customers.json")

json_df.show()

# Read Parquet file
parquet_df = spark.read.format("parquet") \
    .load("/samples/customers.parquet")

parquet_df.show()