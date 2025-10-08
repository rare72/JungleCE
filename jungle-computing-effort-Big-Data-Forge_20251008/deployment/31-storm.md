# Deployment Guide: Apache Storm

Apache Storm is a distributed, real-time computation system. A Storm cluster consists of a master node (running "Nimbus") and worker nodes (running "Supervisor"). It relies on Apache ZooKeeper for coordination.

## 1. Prerequisites

  * A running Apache ZooKeeper cluster.
  * Java is installed on all nodes.

## 2. Download and Unpack

Download the Storm binary and unpack it on all nodes (master and workers).

```bash
# Example for Storm 2.5.0
wget https://dlcdn.apache.org/storm/apache-storm-2.5.0/apache-storm-2.5.0.tar.gz
tar -xzf apache-storm-2.5.0.tar.gz
sudo mv apache-storm-2.5.0 /opt/storm
```

## 3. Configuration

Edit the `storm.yaml` file in `/opt/storm/conf/` on all nodes.

  * **Key Properties (`storm.yaml`):**
    ```yaml
    # List of ZooKeeper servers
    storm.zookeeper.servers:
      - "zookeeper1"
      - "zookeeper2"
      - "zookeeper3"

    # Hostname of the Nimbus master node
    nimbus.seeds: ["your-nimbus-hostname"]

    # Local directory for Storm data
    storm.local.dir: "/data/storm"
    ```

Ensure the `storm.local.dir` exists and is writable on all nodes.

## 4. Start the Services

Start the daemons on the appropriate nodes.

```bash
# On the master node, start Nimbus and the UI
/opt/storm/bin/storm nimbus &
/opt/storm/bin/storm ui &

# On each worker node, start the Supervisor
/opt/storm/bin/storm supervisor &
```

The cluster is now ready to accept "topologies" (Storm applications). You can submit a topology JAR file using the `storm jar` command from a client machine.
