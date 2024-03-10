FROM quay.io/wildfly/wildfly:26.1.2.Final-jdk11
ENV JBOSS_DEPLOYMENTS=${JBOSS_HOME}/standalone/deployments
RUN ${JBOSS_HOME}/bin/add-user.sh admin admin --silent
CMD ${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --debug *:8787

COPY --chown=jboss:jboss \
	src/main/config/wildfly/customization \
	${JBOSS_HOME}/customization/
COPY src/main/config/wildfly/modules \
	${JBOSS_HOME}/modules/

# Configure WildFly in online mode, only recommended if offline mode is subject to restrictions
# RUN chmod +x ${JBOSS_HOME}/customization/execute.sh
# RUN ${JBOSS_HOME}/customization/execute.sh

# Configure WildFly in offline (embedded server) mode, recommended
RUN echo -e "embed-server\n\
	$(cat ${JBOSS_HOME}/customization/wildfly-config.cli)\n\
	stop-embedded-server" > \
	${JBOSS_HOME}/customization/wildfly-config-embedded.cli && \
	${JBOSS_HOME}/bin/jboss-cli.sh \
	--file=${JBOSS_HOME}/customization/wildfly-config-embedded.cli \
	--properties=${JBOSS_HOME}/customization/wildfly-config.properties

COPY ./target/*.war ${JBOSS_DEPLOYMENTS}/ROOT.war