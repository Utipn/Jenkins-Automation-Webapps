FROM tomcat:8.0.20-jre8
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/Utipn/Jenkins-Automation-Webapps
# Download and install Maven
ARG MAVEN_VERSION=3.8.2
ARG USER_HOME_DIR="/root"
RUN wget -q "https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -O /tmp/apache-maven.tar.gz \
    && tar xzf /tmp/apache-maven.tar.gz -C /opt \
    && ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven \
    && ln -s /opt/maven/bin/mvn /usr/bin/mvn \
    && rm -f /tmp/apache-maven.tar.gz

# Set environment variables
ENV MAVEN_HOME /opt/maven
ENV MAVEN_CONFIG "${USER_HOME_DIR}/.m2"
RUN mvn package
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/gr26.war

