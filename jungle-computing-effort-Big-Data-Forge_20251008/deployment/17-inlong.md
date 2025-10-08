# Deployment Guide: Apache InLong

Apache InLong is a one-stop, real-time data streaming platform. It's a complex system with multiple components (DataProxy, TubeMQ, Sort, Manager). This guide covers a simplified, standalone deployment.

## 1. Prerequisites

  * Java 8, MySQL 5.7+
  * A running Hadoop/HDFS cluster.

## 2. Download and Unpack

Download the binary package and unpack it.

```bash
# Example for InLong 1.9.0
wget https://dlcdn.apache.org/inlong/1.9.0/apache-inlong-1.9.0-bin.tar.gz
tar -xzf apache-inlong-1.9.0-bin.tar.gz
sudo mv apache-inlong-1.9.0 /opt/inlong
```

## 3. Configuration

InLong has many configuration files in `/opt/inlong/conf/`. The most critical for a standalone test is to configure the database connection.

1.  **Initialize the Database**: Run the SQL script `sql/apache_inlong_manager.sql` in your MySQL database.
2.  **Configure Manager**: Edit `inlong-manager/conf/application.properties` to point to your MySQL database.
3.  **Configure DataProxy**: Edit `dataproxy/conf/common.properties` to specify the address of the Manager.
4.  **Configure HDFS Sink**: When creating a data stream in the InLong Manager UI, you will configure a data sink. For HDFS, you will provide the NameNode URI (`hdfs://...`), file formats, and other HDFS client parameters.

## 4. Start the Services

InLong provides a simple command to start a standalone cluster.

```bash
# This starts all necessary components for a basic deployment
/opt/inlong/bin/inlong-standalone.sh start
```

For a production cluster, you would start each service (`manager`, `dataproxy`, `tubemq-master`, etc.) individually on their respective nodes.
