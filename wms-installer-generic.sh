#!/bin/bash
set -v
#------------------------- set vairable
WMS_JAVA_VERSION="jdk1.8.0_181"
WMS_TOMCAT_VERSION="apache-tomcat-9.0.14"
rm -rf /data
rm -f jdk-8u181-linux-x64.tar.gz
rm -f apache-tomcat-9.0.14.tar.gz 
rm -f configure_environment.cfg
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
source /etc/profile
#------------------------- installing TOMCAT apache-tomcat-9.0.14
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz
tar -zxvf apache-tomcat-9.0.14.tar.gz 
mkdir /data/software/tomcat
cp -R  apache-tomcat-9.0.14/ /data/software/tomcat
cd /data/software/tomcat/apache-tomcat-9.0.14/webapps/
rm docs/examples/ -rf
#------------------------- upload library for tomcat

