# !/usr/bin/bash
# deploy-offline
# load image
docker image load postgres.tgz
docker image load cloudera.tgz
docker image load gemini-graph.tgz
