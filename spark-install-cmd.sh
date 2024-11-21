###install Spark on Ubuntu

#1. Make Sure You have Hadoop & jdk-8
java -version

#2. Install Scala
sudo apt install scala -y

scala -version

#3. Make Sure You have python in your system (By Default you have it in your Ubuntu)
python3 --version

#4.Download Spark 
wget https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz

#5. Extract Spark
tar xvf spark-3.5.3-bin-hadoop3.tgz

#6.Move spark to /opt/spark
sudo mv spark-3.5.3-bin-hadoop3 /opt/spark

#7. Config bashrc & Execute
nano ~/.bashrc

#add these line at the end of file
export SPARK_HOME=/opt/spark
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#Save & Quit

source ~/.bashrc

#8. Config Spark
cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh

nano $SPARK_HOME/conf/spark-env.sh

#add these line at the end of file
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export SPARK_MASTER_HOST='localhost'
export HADOOP_CONF_DIR=/etc/hadoop
export YARN_CONF_DIR=/etc/hadoop
#Save & Quit

cp $SPARK_HOME/conf/log4j2.properties.template $SPARK_HOME/conf/log4j2.properties

#9. Start Spark
start-master.sh

start-worker.sh spark://localhost:7077

#Visit: http://localhost:8080
#Visit: http://localhost:8081

#10. Run Spark Shell
spark-shell

#12. Test pyspark
pyspark
#Output: >>> (your command line is Ready)

data = [1, 2, 3, 4, 5]
rdd = sc.parallelize(data)
print(rdd.collect())
#Output: [1, 2, 3, 4, 5]

#13. Stop Spark
stop-master.sh

stop-worker.sh