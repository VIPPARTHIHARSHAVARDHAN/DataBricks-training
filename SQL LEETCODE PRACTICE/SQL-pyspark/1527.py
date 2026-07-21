from pyspark.sql.functions import col

Patients = spark.read.options(
    header="true",
    inferSchema="true"
).csv("LINK")
df = patients.filter(col("conditions").startswith("DIAB1") |col("conditions").contains(" DIAB1") )\
              .select(
    "patient_id", "patient_name", "conditions"
)

df.show()
