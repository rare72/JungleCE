# Deployment Guide: Apache Pinot

Apache Pinot is a real-time, distributed OLAP datastore designed for low-latency analytics. A Pinot cluster consists of Controllers, Brokers, and Servers (both real-time and offline).

## 1. Prerequisites

  * A running Apache ZooKeeper cluster.
  * Java 11 or higher installed on all nodes.

## 2. Download and Unpack

Download the Pinot binary and unpack it on all nodes that will be part of the cluster.

```bash
# Example for Pinot 1.0.0
wget https://dlcdn.apache.org/pinot/apache-pinot-1.0.0/apache-pinot-1.0.0-bin.tar.gz
tar -xzf apache-pinot-1.0.0-bin.tar.gz
sudo mv apache-pinot-1.0.0-bin /opt/pinot
```

## 3. Configuration

Pinot can be launched with a single command for quickstarts, but a production cluster involves starting each component individually with its own configuration. The primary configuration is pointing each component to the ZooKeeper quorum.

## 4. Start the Services

Start the components in the following order.

1.  **Start ZooKeeper** (if not already running).
2.  **Start Pinot Controller**:
    ```bash
    /opt/pinot/bin/pinot-admin.sh StartController \
      -zkAddress your-zookeeper-quorum:2181 \
      -clusterName MyPinotCluster \
      -controllerPort 9000
    ```
3.  **Start Pinot Broker**:
    ```bash
    /opt/pinot/bin/pinot-admin.sh StartBroker \
      -zkAddress your-zookeeper-quorum:2181 \
      -clusterName MyPinotCluster
    ```
4.  **Start Pinot Server**:
    ```bash
    /opt/pinot/bin/pinot-admin.sh StartServer \
      -zkAddress your-zookeeper-quorum:2181 \
      -clusterName MyPinotCluster
    ```

The cluster is now running. The next steps involve creating a table by defining a schema and table configuration, and then setting up an ingestion job to load data from a source like Kafka or HDFS.
