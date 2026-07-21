from pyspark.sql.functions import col,countDistinct

Teacher = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")
df=Teacher.groupBy(col("teacher_id"))\
            .agg(countDistinct("subject_id").alias("cnt"))
df.show()