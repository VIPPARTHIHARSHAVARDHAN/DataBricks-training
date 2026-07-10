#starter code
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Phase3") \
    .getOrCreate()

#)1. Read  customer data ->
cust=spark.read.option("header","true").csv("/samples/customers.csv")

#2.clean invalid rows ->
from pyspark.sql.functions import col,trim

#cleaning nulls
cust=cust.dropna()
#removing rows with empty values
cust=cust.filter(trim(col("first_name")) !="" )
# Remove duplicate customer IDs
cust=cust.dropDuplicates(["customer_id"])
cust.show()

#city-wise revenue
from pyspark.sql.functions import sum
sales=spark.read.option("header","true").csv("/samples/sales.csv")

city_revenue=cust.join(sales,how="inner", on="customer_id")\
         .groupBy("city")\
         .agg(sum("total_amount").alias("city_wise_revenue"))

city_revenue.show()