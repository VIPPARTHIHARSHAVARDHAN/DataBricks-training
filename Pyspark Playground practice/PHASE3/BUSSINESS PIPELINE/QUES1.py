#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()
#)1. Read sales data ->
sales=spark.read.option("header","true").csv("/samples/sales.csv")


# clean nulls -> 
sales=sales.dropna()


#calculate daily sales
from pyspark.sql.functions import sum
sales=sales.groupBy(sale_date)\
            .agg(sum("total_amount").alias("daily_sales"))
sales.show()