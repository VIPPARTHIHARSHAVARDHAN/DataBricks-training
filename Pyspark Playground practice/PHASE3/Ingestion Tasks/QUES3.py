
#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

df = spark.read.format("csv") \
 .option("header", "true") \
 .load("/samples/customers.csv")


#3. Identify missing values
from pyspark.sql.functions import col,when,count

Missing_val=df.select([count(when(col(c).isNull(),c)).alias(c)
                      for c in df.columns])
Missing_val.show()