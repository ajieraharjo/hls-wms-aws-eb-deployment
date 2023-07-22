sudo mkdir /data
sudo mkdir /data/software
sudo wget https://dlcdn.apache.org/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz -O /data/software
sudo tar -zxvf /data/software/apache-zookeeper-3.7.1-bin.tar.gz -C /data
sudo cp /data/apache-zookeeper-3.7.1-bin/conf/zoo_sample.cfg zoo.cfg
sudo sed -i '$a tickTime=2000' /data/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
