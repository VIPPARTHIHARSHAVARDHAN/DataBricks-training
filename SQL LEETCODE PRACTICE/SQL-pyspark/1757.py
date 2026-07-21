products = spark.read.options(header="true", inferSchema="true").csv("productsLINK")

lowfats_df = products.select("product_id") \
    .where((products.low_fats == "Y") & (products.recyclable == "Y"))

lowfats_df.show()

#or

lowfats_df = products.filter(
    (products.low_fats == "Y") &
    (products.recyclable == "Y")
).select("product_id")

lowfats_df.show()