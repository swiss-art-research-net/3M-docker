FROM openjdk:8-jre

ENV CATALINA_HOME /opt/apache-tomcat-8.0.53
ENV PATH $CATALINA_HOME/bin:$PATH

RUN apt-get update; apt-get -y install ant ant-optional supervisor; apt-get clean 

COPY resources/3M /opt/3M

RUN chmod -R 0777 /opt/3M

VOLUME ["/opt/exist/webapp/WEB-INF/data/","/opt/apache-tomcat-8.0.53/", "/opt/3M/"]

ADD resources/SW/apache-tomcat-8.0.53.tar.gz /opt/
ADD resources/WARs/*.tar.gz /opt/apache-tomcat-8.0.53/webapps/
ADD resources/x3mlMapper /opt/apache-tomcat-8.0.53/webapps/x3mlMapper

ADD entrypoint.sh /entrypoint.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x ./entrypoint.sh 

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
