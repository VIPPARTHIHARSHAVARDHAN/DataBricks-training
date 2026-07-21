from pyspark.sql.functions import count, max

MyNumber = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df=MyNumber.group("num")\
            .agg(count("nums").alias("cnt"))\
            .filter("cnt=1")\
            .agg(max("num").alias("num"))
            
df.show()
                
                   