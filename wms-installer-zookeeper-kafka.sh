#!/bin/bash
sudo mkdir /data
sudo mkdir /data/software
sudo mkdir /data/zk-dataLogDir
sudo mkdir /data/zk-dataDir
#---------------------- ZOOKEEPER installation
sudo wget https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz -O /data/software/apache-zookeeper-3.7.1-bin.tar.gz
sudo tar -zxvf /data/software/apache-zookeeper-3.7.1-bin.tar.gz -C /data
sudo cp /data/apache-zookeeper-3.7.1-bin/conf/zoo_sample.cfg /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
#---------------------- ZOOKEEPER configuration
sudo sed -i '$a tickTime=2000' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a initLimit=10' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a syncLimit=5' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a dataDir=/data/zk-dataDir' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a dataLogDir=/data/zk-dataLogDir' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a clientPort=62181' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a maxClientCnxns=200' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a autopurge.snapRetainCount=3' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
sudo sed -i '$a autopurge.purgeInterval=2' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
#---------------------- add Log directory into ZOOKEEPER zkEnv.sh
sudo sed -i 's/\$ZOOKEEPER_PREFIX\/logs/\/data\/zk-dataLogDir/g' /data/apache-zookeeper-3.7.1-bin/bin/zkEnv.sh
#---------------------- KAFKA Installation
sudo mkdir /data/kafka-logs
sudo wget https://archive.apache.org/dist/kafka/2.2.1/kafka_2.11-2.2.1.tgz -O /data/software/kafka_2.11-2.2.1.tgz
sudo tar -zxvf /data/software/kafka_2.11-2.2.1.tgz -C /data
#---------------------- KAFKA configuration server.properties
WMS_KAFKA=127.0.0.1:9092
WMS_KAFKA_LOG=/data/kafka-logs
WMS_KAFKA_LOG="${WMS_KAFKA_LOG//\//\\/}"
WMS_KAFKA_ZOOKEEPER=127.0.0.1:62181
sudo sed -i 's/\(#advertised.listeners=\)/advertised.listeners=PLAINTEXT:\/\/'$WMS_KAFKA'\n\1/g' /data/kafka_2.11-2.2.1/config/server.properties
sudo sed -i 's/\(log.dirs=\)/log.dirs='$WMS_KAFKA_LOG' \n\#\1/g' /data/kafka_2.11-2.2.1/config/server.properties 
sudo sed -i 's/\(zookeeper.connect=\)/zookeeper.connect='$WMS_KAFKA_ZOOKEEPER' \n\#\1/g' /data/kafka_2.11-2.2.1/config/server.properties
#---------------------- Start ZOOKEEPER and KAFKA 
sudo /data/apache-zookeeper-3.7.1-bin/bin/zkServer.sh start
sudo /data/kafka_2.11-2.2.1/bin/kafka-server-start.sh /data/kafka_2.11-2.2.1/config/server.properties
