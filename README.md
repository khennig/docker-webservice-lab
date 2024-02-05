Test project setup for Container Virtualisation (Docker), WildFly
Application Server & Configuration, Java EE and Maven

## Troubleshooting
On Windows, running src/.../customization/execute.sh inside the container comes up with "... execute.sh: /bin/sh^M: bad interpreter: No such file or directory".
Fix this by converting Line Separators in execute.sh to LF (Unix style).

Accessing WildFly Web Console on Windows via http://localhost:9990/console/ does nothing.
Try using http://127.0.0.1/console/.

## Reference
- Project - WildFly Docker Images - https://github.com/jboss-dockerfiles/wildfly/blob/master/Dockerfile
- Sample - WildFly Docker Configuration - https://goldmann.pl/blog/2014/07/23/customizing-the-configuration-of-the-wildfly-docker-image/
- Doc - Docker Compose Develop - https://docs.docker.com/compose/compose-file/develop/
- Article - Podman Compose vs Docker Compose - https://www.redhat.com/sysadmin/podman-compose-docker-compose
- Tutorial - Using Compose Files with Podman - https://docs.oracle.com/en/learn/podman-compose/index.html
- Article - Running an Embedded WildFly Host Controller in the CLI - https://www.wildfly.org/news/2015/03/14/Offline-CLI/
- Article - Running an Embedded WildFly 9 Server in the CLI - https://www.wildfly.org/news/2017/10/10/Embedded-Host-Controller/
- Doc - IntelliJ sync changes to application servers - https://www.jetbrains.com/help/idea/updating-applications-on-application-servers.html
- Doc - IntelliJ example: remote staging for a mounted folder - https://www.jetbrains.com/help/idea/run-debug-configuration-jboss-server.html#remote-staging
- Article - Docker Compose - https://www.heise.de/ratgeber/Docker-Container-mit-Docker-Compose-einrichten-4255739.html?seite=all
- Sources - Oracle Database Docker Images - https://github.com/oracle/docker-images