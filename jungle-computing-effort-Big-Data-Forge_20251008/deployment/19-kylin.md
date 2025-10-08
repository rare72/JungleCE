# Deployment Guide: Apache Kylin

Apache Kylin is an open-source, distributed Analytical Data Warehouse for Big Data. It provides an OLAP (Online Analytical Processing) engine that pre-calculates and stores data in "cubes" on HDFS.

## 1. Prerequisites

  * A running Hadoop cluster (HDFS, YARN, MapReduce/Spark).
  * A running Hive metastore.

## 2. Download and Unpack

Download the Kylin binary for your Hadoop version and unpack it.

```bash
# Example for Kylin 4.0.3 with Spark
wget https://dlcdn.apache.org/kylin/apache-kylin-4.0.3/apache-kylin-4.0.3-bin-spark3.tar.gz
tar -xzf apache-kylin-4.0.3-bin-spark3.tar.gz
sudo mv apache-kylin-4.0.3-bin-spark3 /opt/kylin
```

## 3. Distribute Hadoop Configuration

Kylin needs access to your Hadoop and Hive configurations to function.

```bash
# Copy hive-site.xml to the Kylin conf directory
scp user@hive-metastore-node:/path/to/hive/conf/hive-site.xml /opt/kylin/conf/

# Create a symlink to your hadoop config directory
ln -s /opt/hadoop/etc/hadoop /opt/kylin/hadoop
```

## 4. Configure Kylin

Run the `check-env.sh` script to verify dependencies. The main configuration is in `kylin.properties`.

  * **File**: `/opt/kylin/conf/kylin.properties`
  * **Key Properties**:
    ```properties
    # The Kylin server hostname
    kylin.server.host=your-kylin-node-hostname
    # Location for metadata in HDFS
    kylin.metadata.url=kylin_metadata@hdfs,path=hdfs://your-master-node-hostname:9000/kylin/kylin_metadata
    # The Spark engine configuration
    kylin.engine.spark-conf.spark.master=yarn
    kylin.engine.spark-conf.spark.submit.deployMode=cluster
    ```

## 5. Set Environment and Start

Kylin's scripts will pick up `HADOOP_CONF_DIR` automatically if the symlink in step 3 is not created.

```bash
# Start the Kylin service
/opt/kylin/bin/kylin.sh start
```

You can now access the Kylin web UI at `http://your-kylin-node-hostname:7070/kylin`.
