FROM maven:3.6.0-jdk-8-alpine  as maventools
RUN rm -rf /usr/share/maven/conf/settings.xml
COPY settings.xml /usr/share/maven/conf/



WORKDIR /root
COPY . /root
RUN cd /root && mvn clean install -Dmaven.test.skip=true -Dmaven.javadoc.skip=true






FROM tomcat 
LABEL maintainer www.ctnrs.com

EXPOSE 8080
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=maventools /root/target/*.war /usr/local/tomcat/webapps/ROOT.war 
