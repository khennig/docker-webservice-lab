#!/bin/sh

# Usage: execute.sh [stage]
#
# stage is the optional correspondig part in the CLI script wildfly-config-<stage>.cli
# and CLI script configuration wildfly-config-<stage>.properties. If *-<stage>.*
# does not exist the default (without stage part) will be used.
# Thanks to: https://github.com/goldmann/wildfly-docker-configuration/

STAGE=$1
JBOSS_CLI=${JBOSS_HOME:?"Missing env var: JBOSS_HOME"}/bin/jboss-cli.sh
JBOSS_MODE=standalone
JBOSS_CONFIG=$JBOSS_MODE.xml

wait_for_server() {
  until $($JBOSS_CLI -c "ls /deployment" &> /dev/null); do
    sleep 1
  done
}

echo "Starting WildFly server ..."
"$JBOSS_HOME"/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &

echo "Waiting for the server to boot ..."
wait_for_server

echo "Setup CLI and Properties ..."
CUSTOM_PREFIX=$(dirname "$0")/wildfly-config
CUSTOM_SCRIPT=$CUSTOM_PREFIX-$STAGE.cli
if [ ! -e "$CUSTOM_SCRIPT" ]; then
  CUSTOM_SCRIPT=$CUSTOM_PREFIX.cli
fi

CUSTOM_PROPERTIES=$CUSTOM_PREFIX-$STAGE.properties
if [ ! -e "$CUSTOM_PROPERTIES" ]; then
  CUSTOM_PROPERTIES=$CUSTOM_PREFIX.properties
fi

echo -e "Executing the commands in:\n $CUSTOM_SCRIPT\nwith:\n $CUSTOM_PROPERTIES ..."
$JBOSS_CLI -c --file="$CUSTOM_SCRIPT" --properties="$CUSTOM_PROPERTIES"

echo "Shutting down WildFly ..."
if [ $JBOSS_MODE = standalone ]; then
  $JBOSS_CLI -c :shutdown
else
  $JBOSS_CLI -c /host=*:shutdown
fi