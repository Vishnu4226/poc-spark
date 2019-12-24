#Docker file for Pulling image and deploying the application
FROM vishnu4772/poc-bigdata:latest
MAINTAINER Vishnu Vardhan
COPY target/**scala-2.11**/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /root/spark/spark-1.6.1-bin-hadoop2.6/bin
RUN source ~/.bashrc
RUN ./root/spark/spark-1.6.1-bin-hadoop2.6/bin/spark-submit --class me.soulmachine.spark.WordCount /root/spark/spark-1.6.1-bin-hadoop2.6/bin/spark-example-project_2.11-1.0.0-SNAPSHOT.jar vishnu outputfile
CMD ["/root/hadoop/hadoop-2.10.0/sbin/start-dfs.sh", "run"]
CMD ["/root/hadoop/hadoop-2.10.0/sbin/start-yarn.sh", "run"]

