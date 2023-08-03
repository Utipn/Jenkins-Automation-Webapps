FROM tomcat:9.0
RUN git clone https://github.com/LandmakTechnology/maven-web-app.git
RUN mvn install
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/gr26.war
