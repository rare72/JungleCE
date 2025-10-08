# Deployment Guide: Apache Pulsar

Apache Pulsar is a distributed, open-source pub-sub messaging and streaming platform. It uses Apache BookKeeper for storage and relies on Apache ZooKeeper for coordination.

## 1. Prerequisites

  * A running Apache ZooKeeper cluster.
  * Java is installed on all nodes.

## 2. Download and Unpack

Download the Pulsar binary and unpack it on all nodes that will run a broker or bookie.

```bash
# Example for Pulsar 3.1.2
wget https://dlcdn.apache.org/pulsar/pulsar-3.1.2/apache-pulsar-3.1.2-bin.tar.gz
tar -xzf apache-pulsar-3.1.2-bin.tar.gz
sudo mv apache-pulsar-3.1.2 /opt/pulsar
```

## 3. Configuration

For a production setup, you configure brokers, bookies, and ZooKeeper separately.

  * **Initialize Cluster Metadata** (run once):
    ```bash
    /opt/pulsar/bin/pulsar initialize-cluster-metadata \
      --cluster my-cluster \
      --zookeeper zookeeper1:2181 \
      --configuration-store zookeeper1:2181 \
      --web-service-url http://broker1:8080 \
      --broker-service-url pulsar://broker1:6650
    ```
  * **Bookie Configuration (`conf/bookkeeper.conf`):** Primarily involves setting `zkServers`.
  * **Broker Configuration (`conf/broker.conf`):** Set `zookeeperServers` and `configurationStoreServers`.

## 4. Start the Services

Start the bookies and brokers.

```bash
# On each BookKeeper node
/opt/pulsar/bin/pulsar-daemon start bookie

# On each Broker node
/opt/pulsar/bin/pulsar-daemon start broker
```

A standalone mode is also available for quick testing: `/opt/pulsar/bin/pulsar standalone`.
