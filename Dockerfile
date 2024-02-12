FROM openjdk:8-jre

LABEL image.maintainer="Yannis Marketakis" \
	image.organization="FORTH-ICS" \
	image.version="1.5.1" \
	image.lastupdate="2019-06-25" \
	image.description="Mapping Memory Manager (3M) platform"

ENV CATALINA_HOME /opt/apache-tomcat-8.0.53
ENV PATH $CATALINA_HOME/bin:$PATH

RUN apt-get update; apt-get -y install ant ant-optional supervisor; apt-get clean 

# First we want to install eXist-DB and configure it to listen on port 8081
RUN wget -q -O '/opt/exist.jar' 'https://github.com/eXist-db/exist/releases/download/eXist-2.2/eXist-db-setup-2.2.jar' && \
    echo 'INSTALL_PATH=/opt/exist' > '/opt/options.txt' && \
    java -jar '/opt/exist.jar' -options '/opt/options.txt' && \
    rm -f '/opt/exist.jar' '/opt/options' 

ENV MAX_MEMORY 512
RUN sed -i "s/Xmx%{MAX_MEMORY}m/Xmx\${MAX_MEMORY}m/g" /opt/exist/bin/functions.d/eXist-settings.sh
RUN sed -i 's/^\"${JAVA_RUN/exec \"${JAVA_RUN/'  /opt/exist/bin/startup.sh

RUN sed -i 's/8080/8081/g' /opt/exist/tools/jetty/etc/jetty.xml \
	&& sed -i 's/8080/8081/g' /opt/exist/client.properties \
	&& sed -i 's/8080/8081/g' /opt/exist/backup.properties \
	&& sed -i 's/8080/8081/g' /opt/exist/index.html

COPY data/3M /opt/3M

RUN chmod -R 0777 /opt/3M

COPY data/exiist /opt/exist/webapp/WEB-INF/data

ADD Resources/SW/apache-tomcat-8.0.53.tar.gz /opt/

ADD Resources/WARs/*.tar.gz /opt/apache-tomcat-8.0.53/webapps/
ADD Resources/3MEditor /opt/apache-tomcat-8.0.53/webapps/3MEditor

ADD entrypoint.sh /entrypoint.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x ./entrypoint.sh 

VOLUME ["/opt/exist/webapp/WEB-INF/data/", "/opt/3M"]

EXPOSE 8080 8081

ENTRYPOINT ["/entrypoint.sh"]
