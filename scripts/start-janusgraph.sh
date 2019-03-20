#!/bin/bash
JANUSGRAPH_HOME=/root/janusgraph-0.2.2-hadoop2
nohup $JANUSGRAPH_HOME/bin/gremlin-server.sh $JANUSGRAPH_HOME/conf/gremlin-server/socket-gremlin-server.yaml > $JANUSGRAPH_HOME/gremlin-server.log 2>&1 &
