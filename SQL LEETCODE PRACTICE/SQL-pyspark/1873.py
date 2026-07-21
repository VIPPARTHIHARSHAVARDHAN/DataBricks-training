from pyspark.sql.functions import col, when

Employees = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")

df = Employees.select(
    "employee_id",
    when(
        (col("employee_id")%2!=0) & (col("name").startswith("M")),col(salary)).otherwise(0).alias("bonus")
).orderBy("employee_id")
df.show()