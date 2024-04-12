FROM openjdk:8-jre

LABEL image.maintainer="Florian Kräutli" \
	image.organization="Swiss Art Research Infrastructure" \
	image.version="2.0.0" \
	image.lastupdate="2022-02-20" \
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

COPY Resources/3M /opt/3M

RUN chmod -R 0777 /opt/3M

ADD Resources/data.tar.gz /opt/exist/webapp/WEB-INF/

ADD Resources/SW/apache-tomcat-8.0.53.tar.gz /opt/

ADD Resources/WARs/*.tar.gz /opt/apache-tomcat-8.0.53/webapps/

# Add label to the RDFVisualizer configuration
RUN sed -i 's/http:\/\/www.w3.org\/2004\/02\/skos\/core#prefLabel/http:\/\/www.w3.org\/2004\/02\/skos\/core#prefLabel,http:\/\/www.cidoc-crm.org\/cidoc-crm\/P190_has_symbolic_content/g' ${CATALINA_HOME}/webapps/RDFVisualizer/WEB-INF/classes/config.properties

ADD entrypoint.sh /entrypoint.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Remove the default webapps
RUN rm -r "${CATALINA_HOME}/webapps/docs" "${CATALINA_HOME}/webapps/examples" "${CATALINA_HOME}/webapps/host-manager" "${CATALINA_HOME}/webapps/manager"

# Redirect root to 3M
RUN echo '<% response.sendRedirect("/3M"); %>' > "${CATALINA_HOME}/webapps/ROOT/index.jsp"

RUN chmod +x ./entrypoint.sh 

VOLUME ["/opt/exist/webapp/WEB-INF/data/", "/opt/3M"]

EXPOSE 8080 8081

ENTRYPOINT ["/entrypoint.sh"]
