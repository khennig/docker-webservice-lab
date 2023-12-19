#!/bin/sh

# Usage: docker-run.sh [stage]
#
# stage is the optional correspondig part in the CLI customization script and
# script configuration files, see src/config/wildfly/customization/execute.sh

STAGE=$1

mvn clean package
docker build -t de.erik.lab/docker-webservice-lab \
  --build-arg STAGE="$STAGE" .
docker rm -f docker-webservice-lab || true
docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787  \
  --name docker-webservice-lab \
  de.erik.lab/docker-webservice-lab
