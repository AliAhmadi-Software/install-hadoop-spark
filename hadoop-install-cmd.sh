##install hadoop on Ubuntu

#1. update
sudo apt update && sudo apt upgrade -y

#2. install java-8
sudo apt install openjdk-8-jdk ssh rsync -y
java -version

#3. Add JAVA_HOME && Execute
sudo nano /etc/environment

#add these line at the end of file
JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
#Save & Quit

source /etc/environment

echo $JAVA_HOME
## Output: /usr/lib/jvm/java-8-openjdk-amd64

#4. Download Hadoop
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz

#5. Extract Hadoop
tar -xvzf hadoop-3.4.1.tar.gz

#6. Move to Hadoop to /usr/local/hadoop
sudo mv hadoop-3.3.6 /usr/local/hadoop

#7. Config bashrc && Execute
nano ~/.bashrc

#add these line at the end of file
export HADOOP_HOME=/usr/local/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#Save & Quit

source ~/.bashrc

echo $HADOOP_HOME
#Output: /usr/local/hadoop
echo $JAVA_HOME
#Output: /usr/lib/jvm/java-8-openjdk-amd64

#8.Config hadoop-env.sh
nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh

#add these line at the end of file
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#Save & Quit

#9. Config core-site.xml
nano $HADOOP_CONF_DIR/core-site.xml

#add these line at the end of file
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
#Save & Quit

#10. Config hdfs-site.xml
nano $HADOOP_CONF_DIR/hdfs-site.xml

#add these line at the end of file
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/usr/local/hadoop/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/usr/local/hadoop/hdfs/datanode</value>
    </property>
</configuration>
#Save & Quit

#11. Config mapred-site.xml
nano $HADOOP_CONF_DIR/mapred-site.xml

#add these line at the end of file
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
#Save & Quit

#12. Config yarn-site.xml
nano $HADOOP_CONF_DIR/yarn-site.xml

#add these line at the end of file
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
#Save & Quit

#13. Config yarn-site.xml
nano $HADOOP_CONF_DIR/yarn-site.xml

#add these line at the end of file
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
#Save & Quit

#14. Config SSH
ssh-keygen -t rsa -P ""

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

chmod 0600 ~/.ssh/authorized_keys

ssh localhost
#You must Connect to localhost

#15. Format HDFS
hdfs namenode -format

#16. Start HDFS & YARN
start-dfs.sh

start-yarn.sh

#17. Check nodes
jps
#You must see NameNode - NodeManager - DataNode - ResourceManager
#if you dont see NameNode:
#first stop hdfs & yarn
start-dfs.sh

start-yarn.sh

cd /usr/local/hadoop

bin/hdfs namenode -format
##Now Start HDFS & YARN
start-dfs.sh

start-yarn.sh

jps
##Now You Must see NameNode
#HDFS: http://localhost:9870
#YARN: http://localhost:8088