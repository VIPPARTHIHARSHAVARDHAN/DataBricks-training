from pyspark.sql.functions import col, avg, round, sum, when, count

Queries = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Queries.groupBy("query_name") \
    .agg(
        round(avg(col("rating") / col("position")), 2).alias("quality"),
        round(
            sum(when(col("rating") < 3, 1).otherwise(0)) * 100 / count("*"),
            2
        ).alias("poor_query_percentage")
    )

df.show()