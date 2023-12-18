#!/bin/sh

# Usage: execute.sh [stage]
#
# stage is the correspondig part in the CLI script wildfly-config-<stage>.cli
# and CLI script configuration wildfly-config-<stage>.properties
# Thanks to: https://github.com/goldmann/wildfly-docker-configuration/

STAGE=${1:?Unset parameter: Stage}
JBOSS_CLI=${JBOSS_HOME:?Unset env var: JBOSS_HOME}/bin/jboss-cli.sh
JBOSS_MODE="standalone"
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

echo "Executing the commands ..."
JBOSS_CLI_SCRIPT="$(dirname "$0")/wildfly-config-$STAGE.cli"
JBOSS_CLI_SCRIPT_PROPERTIES="$(dirname "$0")/wildfly-config-$STAGE.properties"
if [ ! -e "$JBOSS_CLI_SCRIPT" ]; then
  JBOSS_CLI_SCRIPT="$(dirname "$0")/wildfly-config.cli"
fi

$JBOSS_CLI -c --file="$JBOSS_CLI_SCRIPT" --properties="$JBOSS_CLI_SCRIPT_PROPERTIES"

echo "Shutting down WildFly ..."
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi