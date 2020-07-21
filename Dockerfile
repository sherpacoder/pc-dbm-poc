FROM adoptopenjdk/openjdk8-openj9:alpine-slim

RUN mkdir /root/.postgresql/

CURL -o /root/.postgresql https://github.com/Sherpa99/pearlchain-poc/blob/master/root.crt 

COPY target/pearlchaindbm.jar /

ENTRYPOINT ["java","-jar", "pearlchaindbm.jar" ]
