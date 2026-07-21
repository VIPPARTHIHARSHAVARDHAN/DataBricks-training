World = spark.read.options(header="true", inferSchema="true").csv("LINK")

df = World.select("name", "population", "area") \
          .where((World.population >= 25000000) | (World.area >= 3000000))

df.show()