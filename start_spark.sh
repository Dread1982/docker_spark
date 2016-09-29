docker run -d --net spark_network --name master -p 8080:8080 -p 7077:7077 -p 4040:4040 -p 7001:7001 -p 7002:7002 -p 7003:7003 -p 7004:7004 -p 7005:7005 -p 7006:7006 -p 7007:7007 -v /c/Users/Manuel/docker_spark/:/host/ dread1982/super_spark:v4 /usr/bin/supervisord --configuration=/opt/conf/master.conf

#/start_spark_master.sh "$@"
#/usr/bin/supervisord --configuration=/opt/conf/master.conf
docker run -d --net spark_network --name slave -p 8081:8081 -p 8888:8888 -v /c/Users/Manuel/docker_spark/:/host/ dread1982/super_spark:v4 /usr/bin/supervisord --configuration=/opt/conf/slave.conf

#/start_spark_worker.sh "$@"
#/usr/bin/supervisord --configuration=/opt/conf/slave.conf

docker run --name cassandra_3 --net spark_network -v cas_data:/var/lib/cassandra -d cassandra:3.0
#docker run --name cassandra_3 --net spark_network -v /c/Users/Manuel/docker_spark/cassandra_datadir:/var/lib/cassandra -d cassandra:3.0
#docker run --name cassandra_3 --net spark_network -v /var/lib/cassandra -d cassandra:3.0


docker run --name zeppelin -d --net spark_network -p 9999:9999 -v /c/Users/Manuel/docker_spark/:/host/ dread1982/zeppelin:v8 /usr/bin/supervisord --configuration=/opt/conf/zeppelin.conf