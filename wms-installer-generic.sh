#!/bin/bash
set -v
#------------------------- set vairable
WMS_JAVA_VERSION="jdk1.8.0_181"
WMS_TOMCAT_VERSION="apache-tomcat-9.0.14"
rm -rf /data
rm -f jdk-8u181-linux-x64.tar.gz
rm -f apache-tomcat-9.0.14.tar.gz 
rm -f configure_environment.cfg
rm -f shared-libs.zip
#------------------------- restore JAVA configuration on /etc/profile
sed -i '/JAVA_HOME=/d' /etc/profile
sed -i '/JAVA_BIN=/d' /etc/profile
sed -i '/PATH=/d' /etc/profile
sed -i '/CLASSPATH=.:/data/jdk1.8.0_181/lib/dt.jar:/data/jdk1.8.0_181/lib/tools.jar=/d' /etc/profile
sed -i '/export JAVA_HOME JAVA_BIN PATH CLASSPATH/d' /etc/profile
------- installing JAVA  jdk1.8.0_181
wget https://repo.huaweicloud.com/java/jdk/8u181-b13/jdk-8u181-linux-x64.tar.gz
tar -zxvf jdk-8u181-linux-x64.tar.gz
mkdir /data
mkdir /data/bussines-logs/
mkdir /data/fluxwms-config/
cp -R  jdk1.8.0_181/ /data
#------------------------- configure JAVA grep -c 'URIEncoding="UTF-8"' /usr/share/tomcat/conf/server.xml`
printf "JAVA_HOME=/data/jdk1.8.0_181\n" >> configure_environment.cfg
printf "JAVA_BIN=/data/jdk1.8.0_181/bin\n" >> configure_environment.cfg
printf "PATH=/data/jdk1.8.0_181/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin\n" >> configure_environment.cfg
printf "CLASSPATH=.:/data/jdk1.8.0_181/lib/dt.jar:/data/jdk1.8.0_181/lib/tools.jar\n" >> configure_environment.cfg
printf "export JAVA_HOME JAVA_BIN PATH CLASSPATH\n" >> configure_environment.cfg
cat configure_environment.cfg >> /etc/profile
#------------------------- installing TOMCAT apache-tomcat-9.0.14
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz
tar -zxvf apache-tomcat-9.0.14.tar.gz
wget https://archive.org/download/wms-hls-installer/shared-libs.zip
unzip shared-libs.zip 
mkdir /data/software
mkdir /data/software/tomcat
mkdir /data/software/tomcat/shared-libs
mv apache-tomcat-9.0.14/* /data/software/tomcat
mv shared-libs/* /data/software/tomcat/shared-libs
#-- updating TOMCAT configuration
sed -i 's/Connector port="8080"/Connector port="8080" URIEncoding="UTF-8"/' /data/software/tomcat/conf/server.xml
sed -i 's+shared.loader=+shared.loader="/data/software/tomcat/shared-libs","/data/software/tomcat/shared-libs/*.jar"+' /data/software/tomcat/conf/catalina.properties
cd /data/software/tomcat/webapps/
wget https://archive.org/download/wms-hls-installer/birt.war
#-- rm docs/examples/ -rf
source /etc/profile
sleep 30
lynx http://localhost:8080/birt
#------------------------- upload library for tomcat

