// /Users/chiyuen_woo/git/scala/gemini-offline-backup/conf/hadoop-graphson.properties 配置文件位置
hadoopGraph = GraphFactory.open("/Users/chiyuen_woo/git/scala/gemini-offline-backup/conf/hadoop-graphson.properties") 
hadoopGraph.compute(SparkGraphComputer).program(BulkDumperVertexProgram.build().create()).submit().get()