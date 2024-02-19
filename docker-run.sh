#!/bin/sh

# Quick starter for running your app out of the box inside a container. It
# builds the app, builds the container image and runs it. Expecting the
# needed database already running, startet somewhere else (maybe using the
# database comming with the application server).
#
# Another way to run your app inside a container is using the docker-compose.yml
# file and $docker-compose up. It supplies all needed additional services
# like the database and allows you to connect all components.
#
# Usage: docker-run.sh [stage]
#
# stage is the optional correspondig part in the CLI customization script and
# script configuration files, see src/config/wildfly/customization/execute.sh

CLI=docker
STAGE=$1

mvn clean package
$CLI build -t de.erik.lab/docker-webservice-lab \
  --build-arg STAGE="$STAGE" .
$CLI rm -f docker-webservice-lab || true
$CLI run -d -p 8080:8080 -p 9990:9990 -p 8787:8787  \
  --name docker-webservice-lab \
  -e DATABASE_URL=jdbc:postgresql://kubernetes.docker.internal:5432/mydatabase \
  -e DATABASE_USERNAME=myuser \
  -e DATABASE_PASSWORD=mypass \
  de.erik.lab/docker-webservice-lab
