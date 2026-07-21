from pyspark.sql.functions import col, length

Tweets = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Tweets.filter(
    length(col("content")) > 15
).select("tweet_id")

df.show()