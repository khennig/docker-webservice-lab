#!/bin/sh

# Usage: docker-run.sh [stage]
#
# stage is the correspondig part in the CLI customization script
# and script configuration files:
# src/config/wildfly/customization/wildfly-config-<stage>.cli,
# src/config/wildfly/customization/wildfly-config-<stage>.properties,
# the default value is "default".

STAGE=${1:-"default"}

mvn clean package
docker build -t de.erik.lab/docker-webservice-lab \
  --build-arg STAGE="$STAGE" .
docker rm -f docker-webservice-lab || true
docker run -d -p 8080:8080 -p 9990:9990 -p 8787:8787  \
  --name docker-webservice-lab \
  de.erik.lab/docker-webservice-lab
