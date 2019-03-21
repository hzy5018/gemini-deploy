# !/usr/bin/bash
# build process
# pull postgresql
docker pull postgres

# pull cdh
docker pull cloudera/quickstart 

docker run --hostname=quickstart.cloudera --privileged=true -t -i  docker.io/cloudera/quickstart /usr/bin/docker-quickstart

docker run --name cdh --hostname=quickstart.cloudera --privileged=true -t -d -p 8020:8020 -p 8022:8022 -p 7180:7180 -p 21050:21050 -p 50070:50070 -p 50075:50075 -p 50010:50010 -p 50020:50020 -p 8890:8890 -p 60010:60010 -p 10002:10002 -p 25010:25010 -p 25020:25020 -p 18088:18088 -p 8088:8088 -p 19888:19888 -p 7187:7187 -p 11000:11000 -p 8182:8182 cloudera/quickstart /bin/bash -c /usr/bin/docker-quickstart

# start cloudera managerment
docker exec -d cdh /home/cloudera/cloudera-manager --express
docker exec -d cdh service ntpd start

# 启动 hdfs -> zk -> hbase

# es
docker pull docker.elastic.co/elasticsearch/elasticsearch:6.3.2
docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2

containerID=`docker inspect -f '{{.ID}}' sandbox-hdp`
docker cp software/janusgraph-0.2.2-hadoop2.zip ${containerID}:janusgraph-0.2.2-hadoop2.zip

docker exec -d sandbox-hdp unzip /root/janusgraph-0.2.2-hadoop2.zip

# cp config files
docker cp conf/gremlin-server/socket-gremlin-server.yaml ${containerID}:/janusgraph-0.2.2-hadoop2/conf/gremlin-server

docker cp conf/gremlin-server/socket-janusgraph-hbase-es.properties ${containerID}:/janusgraph-0.2.2-hadoop2/conf/gremlin-server

# cp bin scripts to docker 
docker cp scripts/start-janusgraph.sh ${containerID}:/root/
# pull gemini
docker pull 10.72.100.25:5000/gemini-graph:1.0

# 图

# save images

docker image save postgres postgres.tgz

docker image save cloudera/quickstart cloudera.tgz

docker image save gemini-graph gemini-graph.tgz


http://localhost:9014/graph/sub-graph/download?beginTime=&endTime=&layer=1&relateBlackList=true&queryValues=fingerprint_fingerprint_754322111
name = mgmt.getPropertyKey('name')
m.buildIndex('byNameComposite', Vertex.class).addKey(name).buildCompositeIndex()
m.awaitGraphIndexStatus(graph, 'byNameComposite').call()

name = mgmt.getPropertyKey('name')
idCard = mgmt.getVertexLabel('idCard')

mgmt.buildIndex('byNameAndLabelIdCard', Vertex.class).addKey(name).indexOnly(idCard).buildCompositeIndex()
mgmt.commit()


mgmt.buildIndex('label', Vertex.class).indexOnly('label').buildCompositeIndex()




g.V().hasLabel('idCard').group().by('name').by(__.both('id-home').dedup().by("name").count()).profile()

g.V().hasLabel('home').group().by('name').by(both('id-home').both('id-phone').dedup().by("name").count())


g.V().hasLabel('idCard').has("name", "515502")

curl -v -XPOST http://localhost:8187 -d '{"gremlin": "g.V().hasLabel('idCard').has('name', '901306').id()"}' -u ccidata:ccidata
