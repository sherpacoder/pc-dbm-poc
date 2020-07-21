FROM adoptopenjdk/openjdk8-openj9:alpine-slim

RUN mkdir /root/.postgresql/

RUN curl -o /root/.postgresql https://github.com/Sherpa99/pearlchain-poc/blob/master/root.crt 

RUN curl -o / us.icr.io/gs_dev_ns/pearlchaindbm:v1.1

ENTRYPOINT ["java","-jar", "pearlchaindbm.jar" ]
