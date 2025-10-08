# Deployment Guide: Apache Helix

Apache Helix is a generic cluster management framework used for the automatic management of partitioned, replicated, and distributed resources hosted on a cluster of nodes. It relies on Apache ZooKeeper.

## 1. Prerequisites

  * A running Apache ZooKeeper cluster.
  * Java is installed on all nodes.

## 2. Download and Unpack

Download the Helix component package and unpack it on a management node.

```bash
# Example for Helix 1.1.0
wget https://dlcdn.apache.org/helix/1.1.0/apache-helix-1.1.0-component.tar.gz
tar -xzf apache-helix-1.1.0-component.tar.gz
sudo mv apache-helix-1.1.0-component /opt/helix
```

## 3. Configuration

Helix is often used as a library, but you can run a standalone controller. Its main configuration is pointing to ZooKeeper.

## 4. Usage

Helix is typically used to manage a distributed application. You create a cluster, add nodes, define resources, and start controllers.

1.  **Start a ZooKeeper Server.**
2.  **Setup the Cluster**: Use the `helix-admin` tool to create a cluster in ZooKeeper.
    ```bash
    /opt/helix/bin/helix-admin.sh --zkSvr localhost:2181 --addCluster myCluster
    ```
3.  **Add Nodes**: Add instances that will participate in the cluster.
    ```bash
    /opt/helix/bin/helix-admin.sh --zkSvr localhost:2181 --addNode myCluster --node localhost:8001
    ```
4.  **Add a Resource**: Define a distributed resource (e.g., a database) with partitions and replicas.
    ```bash
    /opt/helix/bin/helix-admin.sh --zkSvr localhost:2181 --addResource myCluster --resource myDatabase --partitions 128 --stateModel MasterSlave
    ```
5.  **Start Controller and Participants**: Start the Helix controller process and the participant (application) processes on your nodes. This is typically done programmatically within your application code.
