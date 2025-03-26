Build Image
docker build -t ubuntu-java .

Run image:
docker run -td ubuntu-java:latest

Exec to docker:
docker exec -it [CONTAINER_ID] bash

in container test:
java --version
javac --version

This set is in Dockerfile
echo $JAVA_HOME