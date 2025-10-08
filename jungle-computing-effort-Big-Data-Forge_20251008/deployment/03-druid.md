# Deployment Guide: Apache Druid

This guide provides instructions for installing Apache Druid and configuring it to use HDFS for deep storage.

## 1. Download and Unpack

Download the Druid binary and unpack it.

```bash
# Example for Druid 28.0.0
wget https://dlcdn.apache.org/druid/28.0.0/apache-druid-28.0.0-bin.tar.gz
tar -xzf apache-druid-28.0.0-bin.tar.gz
sudo mv apache-druid-28.0.0 /opt/druid
```

## 2. Distribute Hadoop Configuration

Copy the Hadoop configuration directory to the node where Druid will run.

```bash
# Run this from your Hadoop master node
scp -r /opt/hadoop/etc/hadoop user@druid-node-hostname:/etc/hadoop/conf
```

## 3. Configure Druid

Edit Druid's common properties file to specify HDFS as the deep storage location.

  * **File**: `/opt/druid/conf/druid/_common/common.runtime.properties`
  * **Add/Modify these properties**:
    ```properties
    druid.storage.type=hdfs
    druid.storage.storageDirectory=hdfs://your-master-node-hostname:9000/druid/segments

    # Add hadoop-client dependencies to the classpath
    druid.extensions.loadList=["druid-hdfs-storage", "druid-kafka-indexing-service"]
    druid.dependencies.uris=["https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-runtime/3.3.6/hadoop-client-runtime-3.3.6.jar", "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-client-api/3.3.6/hadoop-client-api-3.3.6.jar"]
    ```

## 4. Set Environment and Start

Edit Druid's environment script to point to the Hadoop configuration.

  * **File**: `/opt/druid/conf/druid/_common/druid-env.sh`
  * **Add this line**:
    ```bash
    export HADOOP_CONF_DIR=/etc/hadoop/conf
    ```

Finally, start the Druid services:

```bash
# For a quick start on a single machine
/opt/druid/bin/start-micro-quickstart
```

(Note: A production deployment involves starting individual services on multiple nodes.)
