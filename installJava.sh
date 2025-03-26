#!/bin/bash
TMP_DIRECTORY="/tmp_instal_java"
TMP_EXIST=false
JAVA_DIRECTORY="/opt/java"

echo "Create dir"
if [ -d $TMP_DIRECTORY ]; then
    TMP_EXIST=true
else
    mkdir $TMP_DIRECTORY
fi

cd $TMP_DIRECTORY
echo "Download openjdk 17"
wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz
echo "Download openjdk 21"
wget https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz
echo "Download oracle jdk 21"
wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz

echo "Create directory with java"
if [ ! -d $JAVA_DIRECTORY ]; then
    mkdir $JAVA_DIRECTORY
fi


echo "Open JDK 17"
JAVA_DIR=$JAVA_DIRECTORY/openjdk-17.0.2
mkdir $JAVA_DIR
# tar nie tworzy nowych folderów a ostatni przełącznik spraia że jest wypakowane w tym miejscu bez tworzenia dodatkowego folderu - w tym wypadku jdk-17.0.2 króty jest 'domyslny'
tar -zxf openjdk-17.0.2_linux-x64_bin.tar.gz -C $JAVA_DIR --strip-components=1

update-alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 1
update-alternatives --install /usr/bin/javac javac $JAVA_DIR/bin/javac 1
update-alternatives --install /usr/bin/javadoc javadoc $JAVA_DIR/bin/javadoc 1
update-alternatives --install /usr/bin/javap javap $JAVA_DIR/bin/javap 1
update-alternatives --install /usr/bin/jar jar $JAVA_DIR/bin/jar 1

echo "Open JDK 21"
JAVA_DIR=$JAVA_DIRECTORY/openjdk-21.0.2
mkdir $JAVA_DIR
# tar nie tworzy nowych folderów a ostatni przełącznik spraia że jest wypakowane w tym miejscu bez tworzenia dodatkowego folderu - w tym wypadku jdk-17.0.2 króty jest 'domyslny'
tar -zxf openjdk-21.0.2_linux-x64_bin.tar.gz -C $JAVA_DIR --strip-components=1

update-alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 1
update-alternatives --install /usr/bin/javac javac $JAVA_DIR/bin/javac 1
update-alternatives --install /usr/bin/javadoc javadoc $JAVA_DIR/bin/javadoc 1
update-alternatives --install /usr/bin/javap javap $JAVA_DIR/bin/javap 1
update-alternatives --install /usr/bin/jar jar $JAVA_DIR/bin/jar 1

echo "Oracle JDK 21"
JAVA_DIR=$JAVA_DIRECTORY/jdk-21
mkdir $JAVA_DIR
# tar nie tworzy nowych folderów a ostatni przełącznik spraia że jest wypakowane w tym miejscu bez tworzenia dodatkowego folderu - w tym wypadku jdk-17.0.2 króty jest 'domyslny'
tar -zxf jdk-21_linux-x64_bin.tar.gz -C $JAVA_DIR --strip-components=1

update-alternatives --install /usr/bin/java java $JAVA_DIR/bin/java 1
update-alternatives --install /usr/bin/javac javac $JAVA_DIR/bin/javac 1
update-alternatives --install /usr/bin/javadoc javadoc $JAVA_DIR/bin/javadoc 1
update-alternatives --install /usr/bin/javap javap $JAVA_DIR/bin/javap 1
update-alternatives --install /usr/bin/jar jar $JAVA_DIR/bin/jar 1


echo "Set Default java: open jdk 21"
DEFAULT_JAVA=/opt/java/openjdk-21.0.2
update-alternatives --set java $DEFAULT_JAVA/bin/java
update-alternatives --set javac $DEFAULT_JAVA/bin/javac
update-alternatives --set javadoc $DEFAULT_JAVA/bin/javadoc
update-alternatives --set javap $DEFAULT_JAVA/bin/javap
update-alternatives --set jar $DEFAULT_JAVA/bin/jar


# to trzeba ustawiać w docker file ponieważ tu nie są widoczne po wejściu do kontenera
# echo JAVA_HOME=$DEFAULT_JAVA >> /etc/environment
# echo PATH=$PATH:$JAVA_HOME/bin >> /etc/environment
# source /etc/environment


if [ $TMP_EXIST == false ]; then
    echo "Remove $TMP_DIRECTORY"
    rm -R $TMP_DIRECTORY
else
    echo "Tmp $TMP_DIRECTORY exist befor run script, dont remove it"
fi

#/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin