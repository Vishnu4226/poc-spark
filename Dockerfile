#Docker file for Pulling image and deploying the application
FROM vishnu4772/test:poc
MAINTAINER Vishnu Vardhan
#RUN yum install wget -y
#RUN yum -y upgrade
RUN yum -y install openssh-server passwd supervisor || true
RUN yum clean all
RUN yum -y install wget
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar -xvf spark-1.6.1-bin-hadoop2.6.tgz
ENV SPARK_HOME /spark-1.6.1-bin-hadoop2.6
COPY **target**/spark-example-project_2.11-1.0.0-SNAPSHOT.jar /spark-1.6.1-bin-hadoop2.6/bin
RUN echo "This is the first docker file in happiest minds" >> vishnu
ENV JAVA_HOME /usr/java/default
RUN ./spark-1.6.1-bin-hadoop2.6/bin/spark-submit --class me.soulmachine.spark.WordCount /spark-1.6.1-bin-hadoop2.6/bin/spark-example-project_2.11-1.0.0-SNAPSHOT.jar vishnu outputfile
#CMD ["/root/hadoop/hadoop-2.10.0/sbin/start-dfs.sh", "run"]
#CMD ["/root/hadoop/hadoop-2.10.0/sbin/start-yarn.sh", "run"]
