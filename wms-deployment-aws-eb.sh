#!/bin/bash
set -v
#------------------------------ Setting variable for S3 Bucket
WMS_S3_BUCKET=wms-$(cat /proc/sys/kernel/random/uuid)
WMS_S3_PARAM=" "
WMS_S3_REGION="--region ap-southeast-1"
echo  $WMS_S3_BUCKET
echo  $WMS_S3_PARAM
echo  $WMS_S3_REGION
#------------------------------ Create S3 Bucket
echo aws s3 mb s3://$WMS_S3_BUCKET$WMS_S3_PARAM$WMS_S3_REGION
aws s3 mb s3://$WMS_S3_BUCKET$WMS_S3_PARAM$WMS_S3_REGION
echo "Make S3 Bucket s3://"
echo  $WMS_S3_BUCKET$WMS
aws s3 ls $WMS_S3_BUCKET
#------------------------------ Clean up existing wms.zip & Download Source Installer wms.zip
#aws s3 rm s3://$WMS_S3_BUCKET/wms/ --recursive
sudo rm -f ~/wms.zip
sudo wget https://archive.org/download/wms-frontend-v1.0.0/wms.zip
sudo unzip wms.zip
#------------------------------ SYNC Installer wms folder into S3 Bucket
aws s3 sync ~/wms s3://$WMS_S3_BUCKET/wms/
sudo rm -rf ~/wms
#------------------------------ Download source installer wms-frontend-v1.0.0.zip
sudo wget https://archive.org/download/wms-frontend-v1.0.0/wms-frontend-v1.0.0.zip
sudo unzip wms-frontend-v1.0.0.zip
sudo rm -f ~/wms-frontend-v1.0.0.zip
sudo rm -f ~/wms-frontend-v1.0.0/.ebextensions/101-option.setting
#------------------------------ Download source installer wms-backend-v1.0.0.zip
sudo sudo wget https://archive.org/download/wms-frontend-v1.0.0/wms-backend-v1.0.0.zip
sudo unzip wms-backend-v1.0.0.zip
sudo rm -f ~/wms-backend-v1.0.0.zip
sudo rm -f ~/wms-backend-v1.0.0/.ebextensions/101-option.setting
#------------------------------ Setup variable EB Option environment for 101-option.setting
## parameter for others   "
configFiles_location_root="/data/fluxwms-configs/"
default_client_encoding="UTF-8"
file_encoding="UTF-8"
logFiles_location_root="/data/business-logs/"
spring_profiles_active="env3001,hessian"
user_timezone="Asia/Manila"
## parameter for S3  ""
## WMS_S3_BUCKET=elasticbeanstalk-ap-southeast-1-222132558461
## parameter for WMS URL  ""
WMS_BACKEND_URL="Wms-application-backend-prod.eba-tipp73xa.ap-southeast-1.elasticbeanstalk.com"
WMS_FRONTEND_URL="Wms-application-frontend-prod.eba-tipp73xa.ap-southeast-1.elasticbeanstalk.com"
## parameter for MYSQL""
WMS_MYSQL_DBNAME="wms_prod"
WMS_MYSQL_PWD="Password.1"
WMS_MYSQL_URL="wms-mhs-prod.cwlqsx0cn77x.ap-southeast-1.rds.amazonaws.com"
WMS_MYSQL_USER="admin"
DMS_MYSQL_DBNAME="dms_prod"
DMS_MYSQL_PWD="Password.1"
DMS_MYSQL_USER="admin"
## parameter for REDIS   ""
REDIS_AUTH="QQE124dfg738DsWv"
REDIS_MASTER_URL="master.redis-wms-mhs-prod.h4irck.apse1.cache.amazonaws.com"
REDIS_REPLICA_URL="replica.redis-wms-mhs-prod.h4irck.apse1.cache.amazonaws.com"
## parameter for KAFKA & ZOOKEEPER   ""
WMS_KAFKA_BROKER1="b-1.kafkawmsmhs.pemmkc.c5.kafka.ap-southeast-1.amazonaws.com"
WMS_KAFKA_BROKER2="b-2.kafkawmsmhs.pemmkc.c5.kafka.ap-southeast-1.amazonaws.com"
WMS_ZK1="z-1.kafkawmsmhs.pemmkc.c5.kafka.ap-southeast-1.amazonaws.com"
WMS_ZK2="z-2.kafkawmsmhs.pemmkc.c5.kafka.ap-southeast-1.amazonaws.com"
WMS_ZK3="z-3.kafkawmsmhs.pemmkc.c5.kafka.ap-southeast-1.amazonaws.com"
## parameter for MONGODB   ""
WMS_MONGODB_DH_AUTHSRC="datahubmongo"
WMS_MONGODB_DH_PWD="da242wtahub!@#456"
WMS_MONGODB_DH_USER="datahubmongo"
WMS_MONGODB_LOG_AUTHSRC="mongodbforlog"
WMS_MONGODB_LOG_PWD="mongoforlog$#@123432"
WMS_MONGODB_LOG_USER="mongodbforlog"
WMS_MONGODB_URL="mongodb-wms-mhs-prod.cluster-cwlqsx0cn77x.ap-southeast-1.docdb.amazonaws.com"
#------------------------------ Delete existing and create new file for 101-option.config
sudo rm -f ~/101-option.config
printf "###############################################################################\n">> 101-option.config
printf "## After you launch your environment, set unique values for these properties\n">> 101-option.config
printf "## console. Settings using these methods will override the values set in this\n">> 101-option.config
printf "## file, and will not be visible in your source code.\n">> 101-option.config
printf "###############################################################################\n">> 101-option.config
printf "option_settings:\n" >> 101-option.config
printf "  aws:elasticbeanstalk:application:environment:\n" >> 101-option.config
printf "## parameter for others\n" >> 101-option.config
printf "   configFiles.location.root=$configFiles_location_root\n" >> 101-option.config
printf "   default.client.encoding=$default_client_encoding\n" >> 101-option.config
printf "   file.encoding=$file_encoding\n" >> 101-option.config
printf "   logFiles.location.root=$logFiles_location_root\n" >> 101-option.config
printf "   spring.profiles.active=$spring_profiles_active\n" >> 101-option.config
printf "   user.timezone=$user_timezone\n" >> 101-option.config
printf "## parameter for S3\n" >> 101-option.config
printf "   WMS_S3_BUCKET=$WMS_S3_BUCKET\n" >> 101-option.config
printf "## parameter for WMS URL\n" >> 101-option.config
printf "   WMS_BACKEND_URL=$WMS_BACKEND_URL\n" >> 101-option.config
printf "   WMS_FRONTEND_URL=$WMS_FRONTEND_URL\n" >> 101-option.config
printf "## parameter for MYSQL\n" >> 101-option.config
printf "   WMS_MYSQL_DBNAME=$WMS_MYSQL_DBNAME\n" >> 101-option.config
printf "   WMS_MYSQL_PWD=$WMS_MYSQL_PWD\n" >> 101-option.config
printf "   WMS_MYSQL_URL=$WMS_MYSQL_URL\n" >> 101-option.config
printf "   WMS_MYSQL_USER=$WMS_MYSQL_USER\n" >> 101-option.config
printf "   DMS_MYSQL_DBNAME=$DMS_MYSQL_DBNAME\n" >> 101-option.config
printf "   DMS_MYSQL_PWD=$DMS_MYSQL_PWD\n" >> 101-option.config
printf "   DMS_MYSQL_USER=$DMS_MYSQL_USER\n" >> 101-option.config
printf "## parameter for REDIS" >> 101-option.config
printf "   REDIS_AUTH=$REDIS_AUTH\n" >> 101-option.config
printf "   REDIS_MASTER_URL=$REDIS_MASTER_URL\n" >> 101-option.config
printf "   REDIS_REPLICA_URL=$REDIS_REPLICA_URL\n" >> 101-option.config
printf "## parameter for KAFKA & ZOOKEEPER\n" >> 101-option.config
printf "   WMS_KAFKA_BROKER1=$WMS_KAFKA_BROKER1\n" >> 101-option.config
printf "   WMS_KAFKA_BROKER2=$WMS_KAFKA_BROKER2\n" >> 101-option.config
printf "   WMS_ZK1=$WMS_ZK1\n" >> 101-option.config
printf "   WMS_ZK2=$WMS_ZK2\n" >> 101-option.config
printf "   WMS_ZK3=$WMS_ZK3\n" >> 101-option.config
printf "## parameter for MONGODB\n" >> 101-option.config
printf "   WMS_MONGODB_DH_AUTHSRC=$WMS_MONGODB_DH_AUTHSRC\n" >> 101-option.config
printf "   WMS_MONGODB_DH_PWD=$WMS_MONGODB_DH_PWD\n" >> 101-option.config
printf "   WMS_MONGODB_DH_USER=$WMS_MONGODB_DH_USER\n" >> 101-option.config
printf "   WMS_MONGODB_LOG_AUTHSRC=$WMS_MONGODB_LOG_AUTHSRC\n" >> 101-option.config
printf "   WMS_MONGODB_LOG_PWD=$WMS_MONGODB_LOG_PWD\n" >> 101-option.config
printf "   WMS_MONGODB_LOG_USER=$WMS_MONGODB_LOG_USER\n" >> 101-option.config
printf "   WMS_MONGODB_URL=$WMS_MONGODB_URL\n" >> 101-option.config
#------------------------------ Replace file 101-option.config into .ebextension folder
sudo cp ~/101-option.config ~/wms-frontend-v1.0.0/.ebextensions
sudo cp ~/101-option.config ~/wms-backend-v1.0.0/.ebextensions
sudo rm -f ~/101-option.config
#------------------------------ ZIP modify folder for wms-frontend-v1.0.0 and wms-backend-v1.0.0
sudo zip  ~/wms-frontend-v1.0.0.zip ~/wms-frontend-v1.0.0/ -r
sudo zip  ~/wms-backend-v1.0.0.zip ~/wms-backend-v1.0.0/ -r
sudo rm -rf ~/wms-frontend-v1.0.0
sudo rm -rf ~/wms-backend-v1.0.0
#------------------------------ Upload wms-frontend-v1.0.0.zip and wms-backend-v1.0.0.zip info S3 Bucket for Deployment
aws s3 cp ~/wms-frontend-v1.0.0.zip s3://$WMS_S3_BUCKET/
aws s3 cp ~/wms-backend-v1.0.0.zip s3://$WMS_S3_BUCKET/
#------------------------------ Delete to free-up the storage space
sudo rm -f ~/wms-frontend-v1.0.0.zip
sudo rm -f ~/wms-backend-v1.0.0.zip
#------------------------------ Create JSON for S3 Permission LifeCyle auto delete after 2 days
sudo rm -f lifecycle.json
printf "{\n" >> lifecycle.json
printf "    "Rules": [\n" >> lifecycle.json
printf "        {\n" >> lifecycle.json
printf "            "ID": "delete-after-2-days",\n" >> lifecycle.json
printf "            "Status": "Enabled",\n" >> lifecycle.json
printf "            "Prefix": "logs/",\n" >> lifecycle.json
printf "            "NoncurrentVersionExpiration": {\n" >> lifecycle.json
printf "                "NoncurrentDays": 2\n" >> lifecycle.json
printf "            }\n" >> lifecycle.json
printf "        }\n" >> lifecycle.json
printf "    ]\n" >> lifecycle.json
printf "}\n" >> lifecycle.json
aws s3api put-bucket-lifecycle --bucket $WMS_S3_BUCKET --lifecycle-configuration file://lifecycle.json

sudo rm -f ~/wms.zip
#------------------------------ S3 Bucket name information for user
echo  $WMS_S3_BUCKET
