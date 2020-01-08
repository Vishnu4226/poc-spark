#Docker File for Installing spark
FROM 981774949705.dkr.ecr.us-east-1.amazonaws.com/poc-hm:latest
LABEL maintainer="gonuguntavishnu@gmail.com"
COPY target/**scala-2.11**/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root
RUN sh /root/spark/spark-2.2.0-bin-hadoop2.7/sbin/start-all.sh && sh /root/spark/spark-2.2.0-bin-hadoop2.7/sbin/start-history-server.sh
RUN cd /root/spark/spark-2.2.0-bin-hadoop2.7 && ./bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/vishnu outfile
