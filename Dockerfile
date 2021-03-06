#Docker File for Installing spark
FROM vishnu4772/poc-hm:latest
LABEL maintainer="gonuguntavishnu@gmail.com"
COPY target/**scala-2.11**/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root
#RUN sh /root/spark/spark-2.2.0-bin-hadoop2.7/sbin/start-all.sh && sh /root/spark/spark-2.2.0-bin-hadoop2.7/sbin/start-history-server.sh
RUN cd /root/spark/spark-2.2.0-bin-hadoop2.7 && ./bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/vishnu outfile
RUN cd /root/spark/spark-2.2.0-bin-hadoop2.7 && ./bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/vishnu outfile1
RUN cd /root/spark/spark-2.2.0-bin-hadoop2.7 && ./bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/vishnu outfile2
RUN cd /root/spark/spark-2.2.0-bin-hadoop2.7 && ./bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/vishnu outfile3
