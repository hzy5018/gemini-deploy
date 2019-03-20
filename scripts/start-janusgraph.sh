#!/bin/bash
JANUSGRAPH_HOME=/janusgraph-0.2.2-hadoop2
cd $JANUSGRAPH_HOME
nohup bin/gremlin-server.sh conf/gremlin-server/socket-gremlin-server.yaml > gremlin-server.log 2>&1 &
