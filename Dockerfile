FROM tomcat:9.0.84-jdk8-corretto-al2
COPY /var/lib/jenkins/workspace/test/target/mavendemo.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
