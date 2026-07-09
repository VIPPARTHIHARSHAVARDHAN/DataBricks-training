#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

df = spark.read.format("csv") \
 .option("header", "true") \
 .load("/samples/customers.csv")


#)4. Clean data using dropna() or fillna()
clean_df = df.dropna()
clean_df.show()

#or
df.fillna("unknown")