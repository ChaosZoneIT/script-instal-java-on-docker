FROM ubuntu:22.04
ENV APP_HOME=/home/start
WORKDIR $APP_HOME
ADD upgradeUbuntu.sh .
ADD installJava.sh .
RUN ./upgradeUbuntu.sh
RUN ./installJava.sh

ENV JAVA_HOME=/opt/java/openjdk-21.0.2
ENV PATH=$PATH:$JAVA_HOME/bin