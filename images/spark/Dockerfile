#specifying our base docker-image
FROM ubuntu:14.04
 
####installing [software-properties-common] so that we can use [apt-add-repository] to add the repository [ppa:webupd8team/java] form which we install Java8
RUN sudo apt-get update
RUN apt-get install software-properties-common -y
RUN apt-add-repository ppa:webupd8team/java -y
RUN apt-get update -y
  
####automatically agreeing on oracle license agreement that normally pops up while installing java8
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

####installing java
RUN apt-get install -y oracle-java8-installer
#####################################################################################
####downloading and unpacking Spark 1.6.1 [prebuilt for Hadoop 2.6+ and scala 2.10]
RUN wget http://apache.mirror.triple-it.nl/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar -xzf spark-1.6.1-bin-hadoop2.6.tgz

####moving the spark root folder to /opt/spark
RUN mv spark-1.6.1-bin-hadoop2.6 /opt/spark
  
####exposing port 8080 so we can later access the Spark master UI; to verify spark is running ...etc.
EXPOSE 8080
#####################################################################################

#####################################################################################
####installing supervisor
RUN apt-get install -y supervisor
 
####copy supervisor configuration files for master and slave nodes (described below)
COPY master.conf /opt/conf/master.conf
COPY slave.conf /opt/conf/slave.conf

####expose other ports
#EXPOSE 7077
#EXPOSE 4040
#EXPOSE 8081


##### from epahomov

#ADD spark_defaults.conf /spark_defaults.conf
#ADD start_spark_master.sh /start_spark_master.sh
#ADD start_spark_worker.sh /start_spark_worker.sh

#ENV SPARK_HOME /opt/spark

#ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
#ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

#ENV SPARK_MASTER_PORT 7077
#ENV SPARK_MASTER_WEBUI_PORT 8080
#ENV SPARK_WORKER_PORT 8888
#ENV SPARK_WORKER_WEBUI_PORT 8081

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006 
#####################################################################################

#default command: running an interactive spark shell in the local mode
CMD ["/opt/spark/bin/spark-shell", "--master", "local[*]"]
########################################EOF##########################################
