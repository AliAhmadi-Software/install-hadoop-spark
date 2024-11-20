
# Hadoop and Spark Installation on Ubuntu

This guide provides step-by-step instructions to install and configure Hadoop and Spark on an Ubuntu system. The accompanying scripts (`hadoop-install-cmd.sh` and `spark-install-cmd.sh`) automate the process for ease of setup.

---

## Prerequisites
- A working Ubuntu system with sudo access.
- Basic knowledge of terminal commands.
- Internet connection for downloading required packages.

---

## 1. Hadoop Installation

### Steps Overview:
1. **Update and Upgrade System**  
   Ensure the system is updated:
   ```
   sudo apt update && sudo apt upgrade -y
   ```

2. **Install Java 8**  
   Hadoop requires Java 8. Install it with:
   ```
   sudo apt install openjdk-8-jdk ssh rsync -y
   ```

3. **Set JAVA_HOME Environment Variable**  
   Edit `/etc/environment` to include:
   ```
   JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
   ```
   Reload environment variables:
   ```
   source /etc/environment
   ```

4. **Download and Extract Hadoop**  
   Download the latest Hadoop version:
   ```
   wget https://dlcdn.apache.org/hadoop/common/hadoop-3.4.1/hadoop-3.4.1.tar.gz
   tar -xvzf hadoop-3.4.1.tar.gz
   sudo mv hadoop-3.4.1 /usr/local/hadoop
   ```

5. **Configure Hadoop Files**  
   - Update `.bashrc` to set environment variables.
   - Configure `core-site.xml`, `hdfs-site.xml`, `mapred-site.xml`, and `yarn-site.xml` as outlined in the script.

6. **Setup SSH for Hadoop**  
   Generate SSH keys and ensure passwordless login for `localhost`.

7. **Format and Start HDFS**  
   Format the HDFS filesystem and start Hadoop services:
   ```
   hdfs namenode -format
   start-dfs.sh
   start-yarn.sh
   ```

8. **Verify Installation**  
   Check services with:
   ```
   jps
   ```

   Access interfaces:  
   - HDFS: [http://localhost:9870](http://localhost:9870)  
   - YARN: [http://localhost:8088](http://localhost:8088)

---

## 2. Spark Installation

### Steps Overview:
1. **Install Dependencies**  
   - Ensure Java 8 and Hadoop are installed.  
   - Install Scala:
     ```
     sudo apt install scala -y
     ```

2. **Download and Extract Spark**  
   ```
   wget https://dlcdn.apache.org/spark/spark-3.5.3/spark-3.5.3-bin-hadoop3.tgz
   tar xvf spark-3.5.3-bin-hadoop3.tgz
   sudo mv spark-3.5.3-bin-hadoop3 /opt/spark
   ```

3. **Configure Spark**  
   - Update `.bashrc` with Spark environment variables.  
   - Configure `spark-env.sh` and `log4j2.properties` as outlined in the script.

4. **Start Spark Services**  
   Start Spark master and worker nodes:
   ```
   start-master.sh
   start-worker.sh spark://localhost:7077
   ```

   Access Spark interfaces:  
   - Spark Master: [http://localhost:8080](http://localhost:8080)  
   - Spark Worker: [http://localhost:8081](http://localhost:8081)

5. **Stop Spark Services**  
   To stop Spark:
   ```
   stop-master.sh
   stop-worker.sh
   ```

---

## Notes
- Ensure all paths in configuration files match your system's setup.
- Scripts must be run with appropriate permissions.

---

## License
This guide and accompanying scripts are provided under the MIT License. Use at your own risk.
