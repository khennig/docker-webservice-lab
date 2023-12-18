FROM quay.io/wildfly/wildfly:26.1.2.Final-jdk11
ENV DEPLOYMENT_DIR=${JBOSS_HOME}/standalone/deployments
RUN ${JBOSS_HOME}/bin/add-user.sh admin admin --silent
CMD ${JBOSS_HOME}/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 --debug *:8787

ADD src/main/config/wildfly/customization ${JBOSS_HOME}/customization/
ADD src/main/config/wildfly/modules ${JBOSS_HOME}/modules/
ARG STAGE
RUN ${JBOSS_HOME}/customization/execute.sh $STAGE

# COPY ./target/docker-webservice-lab-*.war ${DEPLOYMENT_DIR}/docker-webservice-lab.war