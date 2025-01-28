FROM maven As build
WORKDIR /app
COPY . /app
RUN mvn clean install -DskipTests

FROM tomcat
RUN sed -i 's/port="8080"/port="8081"/g' /usr/local/tomcat/conf/server.xml
COPY --from=build /app/target/bankapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
CMD [ "catalina.sh", "run" ]
EXPOSE 8081
