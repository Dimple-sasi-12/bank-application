FROM maven As build
WORKDIR /app
COPY -r . /app
RUN mvn clean install -DTests

FROM Tomcat
COPY --from=build /test/target/bankapp-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
CMD ["catalina.sh" "run"]
EXPOSE 8081