customer = spark.read.options(header="true", inferSchema="true").csv("filepath")

ref_id = customer.select("name") \
                 .where((customer.referee_id.isNull()) | (customer.referee_id != 2))

ref_id.show()