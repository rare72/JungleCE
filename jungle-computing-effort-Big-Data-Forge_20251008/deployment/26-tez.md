# Deployment Guide: Apache Tez

Apache Tez is an extensible framework for building high-performance batch and interactive data processing applications, which can be used as a faster alternative to Hadoop MapReduce. It runs on YARN.

## 1. Prerequisites

  * A running HDFS and YARN cluster.

## 2. Download and Unpack

Download the Tez binary and unpack it on a client node.

```bash
# Example for Tez 0.10.2
wget https://dlcdn.apache.org/tez/0.10.2/apache-tez-0.10.2-bin.tar.gz
tar -xzf apache-tez-0.10.2-bin.tar.gz
sudo mv apache-tez-0.10.2-bin /opt/tez
```

## 3. Upload Tez Libraries to HDFS

Tez requires its libraries to be available on HDFS for all nodes in the cluster to access.

```bash
hdfs dfs -mkdir -p /apps/tez
hdfs dfs -put /opt/tez/tez*.tar.gz /apps/tez/
```

## 4. Configure Tez

Create a `tez-site.xml` configuration file in `/opt/hadoop/etc/hadoop`.

```xml
<configuration>
  <property>
    <name>tez.lib.uris</name>
    <value>${fs.defaultFS}/apps/tez/apache-tez-0.10.2-bin.tar.gz</value>
  </property>
</configuration>
```

## 5. Configure Client

On the client machine, add the Tez configuration and libraries to the Hadoop classpath.

```bash
# Add to /opt/hadoop/etc/hadoop/hadoop-env.sh
export HADOOP_CLASSPATH=${HADOOP_CLASSPATH}:/opt/tez/conf:/opt/tez/*:/opt/tez/lib/*
```

Tez is now deployed. Tools like Hive and Pig can be configured to use Tez as their execution engine instead of MapReduce, which will dramatically improve their performance.
