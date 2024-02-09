#!/bin/bash

# catch missing password
if [ -z "$DB_NAME" ]; then
echo "The parameter for setting the db container is missing (DB_NAME)"
echo "Setting the name to db"
DB_NAME="db"
fi

# inject ip address for 3m
echo "injecting the IP adress $IP_ADDRESS"
IP_ADDRESS=0.0.0.0
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/3M/WEB-INF/web.xml
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/3MEditor/WEB-INF/web.xml
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/index.html
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/errorpage.html
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/multmappings.html
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/singlemapping.html
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/WEB-INF/config.properties
sed -i s/255.255.255.255:8080/$IP_ADDRESS/g $CATALINA_HOME/webapps/Maze/app/js/Controller.js

# injecting the db name
echo "injecting the db name $DB_NAME"
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/3M/WEB-INF/web.xml
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/3MEditor/WEB-INF/web.xml
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/index.html
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/errorpage.html
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/multmappings.html
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/singlemapping.html
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/WEB-INF/config.properties
sed -i s/255.255.255.255:8081/$DB_NAME/g $CATALINA_HOME/webapps/Maze/app/js/Controller.js

# start eXist-db and Apache Tomcat
exec supervisord -n
