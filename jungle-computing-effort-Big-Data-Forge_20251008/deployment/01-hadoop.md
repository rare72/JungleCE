# Deployment Guide: Apache Hadoop

This guide provides instructions for installing and configuring a foundational Hadoop cluster (HDFS and YARN) on a bare-metal server.

## 1. Prerequisites

Ensure Java and SSH are installed, and passwordless SSH is configured from the master node to all worker nodes.

  * **For Debian 12:**
    ```bash
    sudo apt update
    sudo apt install -y openjdk-11-jdk ssh
    ```
  * **For RHEL 9:**
    ```bash
    sudo dnf install -y java-11-openjdk-devel openssh-server
    ```

## 2. Download and Unpack

On your master node, download the latest stable binary and unpack it.

```bash
# Example for Hadoop 3.3.6
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
tar -xzf hadoop-3.3.6.tar.gz
sudo mv hadoop-3.3.6 /opt/hadoop
```

Copy the `/opt/hadoop` directory to all your worker nodes.

## 3. Configuration

Edit the following files in `/opt/hadoop/etc/hadoop`.

  * `hadoop-env.sh`: Set `JAVA_HOME`.
    ```sh
    # For Debian
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    # For RHEL
    # export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
    ```
  * `core-site.xml`: Define the HDFS NameNode location.
    ```xml
    <configuration>
        <property>
            <name>fs.defaultFS</name>
            <value>hdfs://your-master-node-hostname:9000</value>
        </property>
    </configuration>
    ```
  * `hdfs-site.xml`: Configure HDFS settings.
    ```xml
    <configuration>
        <property>
            <name>dfs.replication</name>
            <value>3</value> </property>
    </configuration>
    ```
  * `yarn-site.xml`: Configure YARN settings.
    ```xml
    <configuration>
        <property>
            <name>yarn.nodemanager.aux-services</name>
            <value>mapreduce_shuffle</value>
        </property>
    </configuration>
    ```
  * `workers`: List the hostnames of all your worker nodes.
    ```
    worker-node-1
    worker-node-2
    worker-node-3
    ```

## 4. Format and Start

From your master node:

```bash
# Format the HDFS filesystem (RUN ONLY THE FIRST TIME!)
/opt/hadoop/bin/hdfs namenode -format

# Start HDFS and YARN services
/opt/hadoop/sbin/start-dfs.sh
/opt/hadoop/sbin/start-yarn.sh
```
