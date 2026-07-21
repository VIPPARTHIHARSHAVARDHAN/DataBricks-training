from pyspark.sql.functions import min, col

Activity = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Activity.groupBy(col("player_id")) \
             .agg(min(col("event_date")).alias("first_login"))

df.show()