# Deployment Guide: Apache Fluo

Apache Fluo is a distributed processing system that lets users make incremental updates to large data sets. It is built on top of Apache Accumulo.

## 1. Prerequisites

  * A running Apache Hadoop cluster (HDFS and YARN).
  * A running Apache ZooKeeper cluster.
  * A running Apache Accumulo cluster.
  * Java is installed on all nodes.

## 2. Download and Unpack

Download the Fluo binary distribution and unpack it on a client node.

```bash
# Example for Fluo 2.1.0
wget https://dlcdn.apache.org/fluo/2.1.0/fluo-2.1.0-bin.tar.gz
tar -xzf fluo-2.1.0-bin.tar.gz
sudo mv fluo-2.1.0 /opt/fluo
```

## 3. Configuration

Fluo applications are configured via a `fluo.properties` file. You need to point Fluo to your Accumulo and ZooKeeper instances.

1.  **Copy Configuration**: Copy the Accumulo and Hadoop configuration files into `/opt/fluo/conf`.
    ```bash
    scp user@accumulo-node:/opt/accumulo/conf/accumulo-client.properties /opt/fluo/conf/
    scp -r user@hadoop-master:/opt/hadoop/etc/hadoop /opt/fluo/conf/
    ```
2.  **Configure Fluo**: Edit `/opt/fluo/conf/fluo.properties` to set the application name and connection properties.
    ```properties
    # Accumulo connection properties
    fluo.connection.accumulo.instance=my-accumulo
    fluo.connection.accumulo.user=root
    fluo.connection.accumulo.password=secret

    # Zookeeper connection
    fluo.connection.zookeeper=zookeeper1:2181,zookeeper2:2181
    ```

## 4. Initialize and Run an Application

Unlike other services, you deploy a Fluo *application*.

1.  **Initialize the Application**: This command sets up the necessary tables in Accumulo.
    ```bash
    /opt/fluo/bin/fluo init my-fluo-app
    ```
2.  **Start Workers**: Start Fluo workers on the YARN cluster.
    ```bash
    /opt/fluo/bin/fluo-yarn start my-fluo-app
    ```

The Fluo application is now running and will observe changes in the configured Accumulo tables.
