FROM openjdk:8-jre

RUN apt-get update; apt-get -y install ant ant-optional supervisor; apt-get clean 

RUN wget -q -O '/opt/exist.jar' 'https://github.com/eXist-db/exist/releases/download/eXist-2.2/eXist-db-setup-2.2.jar' && \
    echo 'INSTALL_PATH=/opt/exist' > '/opt/options.txt' && \
    java -jar '/opt/exist.jar' -options '/opt/options.txt' && \
    rm -f '/opt/exist.jar' '/opt/options' 

ENV MAX_MEMORY 512
RUN sed -i "s/Xmx%{MAX_MEMORY}m/Xmx\${MAX_MEMORY}m/g" /opt/exist/bin/functions.d/eXist-settings.sh
RUN sed -i 's/^\"${JAVA_RUN/exec \"${JAVA_RUN/'  /opt/exist/bin/startup.sh

VOLUME ["/opt/exist/webapp/WEB-INF/data/","/opt/apache-tomcat-8.0.53/"]

ADD resources/data.tar.gz /opt/exist/webapp/WEB-INF/
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["supervisord", "-n"]