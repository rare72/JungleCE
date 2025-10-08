# Deployment Guide: Apache BookKeeper

This guide provides instructions for installing Apache BookKeeper. BookKeeper often relies on Apache ZooKeeper for coordination, so a running ZooKeeper ensemble is a prerequisite.

## 1. Prerequisites

  * A running Apache ZooKeeper cluster.
  * Java is installed on all nodes.

## 2. Download and Unpack

Download the BookKeeper binary and unpack it on each node that will run a "bookie" service.

```bash
# Example for BookKeeper 4.16.3
wget https://dlcdn.apache.org/bookkeeper/bookkeeper-4.16.3/bookkeeper-4.16.3-bin.tar.gz
tar -xzf bookkeeper-4.16.3-bin.tar.gz
sudo mv bookkeeper-4.16.3-bin /opt/bookkeeper
```

## 3. Distribute Hadoop Configuration

While BookKeeper does not always directly interact with HDFS, it's good practice to make the configuration available if any integrations might use it.

```bash
# Run this from your Hadoop master node
scp -r /opt/hadoop/etc/hadoop user@bookkeeper-node-hostname:/etc/hadoop/conf
```

## 4. Configure the Component

Edit the BookKeeper configuration file to point to your ZooKeeper ensemble and define storage locations.

  * **File**: `/opt/bookkeeper/conf/bk_server.conf`
  * **Modify these properties**:
    ```properties
    # Comma-separated list of ZooKeeper servers
    zkServers=zookeeper1:2181,zookeeper2:2181,zookeeper3:2181

    # Directories for the journal and data ("ledgers")
    journalDirectory=/data/bookkeeper/journal
    ledgerDirectories=/data/bookkeeper/ledgers
    ```

Ensure the data directories exist and are writable by the user running BookKeeper.

## 5. Set Environment and Start

Edit BookKeeper's environment script to set Java options and potentially the Hadoop configuration path.

  * **File**: `/opt/bookkeeper/conf/bkenv.sh`
  * **Add this line**:
    ```bash
    export HADOOP_CONF_DIR=/etc/hadoop/conf
    ```

Finally, initialize the cluster metadata (only once) and start the bookie service on each node.

```bash
# Run this once from any node to initialize the cluster in ZooKeeper
/opt/bookkeeper/bin/bookkeeper shell metaformat -n

# Run this on each BookKeeper node to start the service
/opt/bookkeeper/bin/bookkeeper bookie
```
