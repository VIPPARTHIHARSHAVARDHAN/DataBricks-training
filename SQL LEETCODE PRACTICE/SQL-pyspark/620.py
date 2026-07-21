from pyspark.sql.functions import col

Cinema = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Cinema.filter(
    (col("id") % 2 != 0) &
    (col("description") != "boring")
).orderBy(
    col("rating").desc()
)

df.show()