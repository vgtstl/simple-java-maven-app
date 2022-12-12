FROM codenvy/jdk7:latest
COPY target/*.jar .
ENTRYPOINT ["java", "-cp", "my-app-2.0-SNAPSHOT.jar", "com.mycompany.app.App"]
