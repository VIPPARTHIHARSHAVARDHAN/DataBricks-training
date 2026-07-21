from pyspark.sql.functions import col

Views = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Views.filter(
    col("author_id") == col("viewer_id")
).select(
    col("author_id").alias("id")
).distinct().orderBy("id")

df.show()