FROM openjdk:11
EXPOSE 8089
COPY target/ExamThourayaS2-1.0.jar ExamThourayaS2.jar
ENTRYPOINT ["java","-jar","/ExamThourayaS2.jar"]