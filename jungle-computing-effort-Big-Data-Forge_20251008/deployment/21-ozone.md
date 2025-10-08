# Deployment Guide: Apache Ozone

Apache Ozone is a scalable, redundant, and distributed object store for Hadoop. It provides a different storage layer than HDFS but integrates with the Hadoop ecosystem.

## 1. Prerequisites

  * A running Hadoop YARN cluster (for running applications).
  * HDFS can be running, but Ozone is a replacement/alternative.

## 2. Download and Unpack

Download the Ozone binary and unpack it on all nodes in the cluster.

```bash
# Example for Ozone 1.4.0
wget https://dlcdn.apache.org/ozone/1.4.0/apache-ozone-1.4.0.tar.gz
tar -xzf apache-ozone-1.4.0.tar.gz
sudo mv apache-ozone-1.4.0 /opt/ozone
```

## 3. Configuration

Configuration is done in `/opt/ozone/etc/hadoop`.

1.  **Create `ozone-site.xml`**: Copy the template and configure the Ozone Manager (OM) and Storage Container Manager (SCM) addresses.
    ```xml
    <property>
      <name>ozone.om.address</name>
      <value>your-om-node-hostname:9862</value>
    </property>
    <property>
      <name>ozone.scm.names</name>
      <value>your-scm-node-hostname</value>
    </property>
    ```
2.  **Initialize SCM**: Run this command once on the SCM node.
    ```bash
    /opt/ozone/bin/ozone scm --init
    ```
3.  **Initialize OM**: Run this command once on the OM node.
    ```bash
    /opt/ozone/bin/ozone om --init
    ```

## 4. Start the Services

Start the SCM, OM, and DataNode services.

```bash
# On the SCM node
/opt/ozone/sbin/ozone-daemon.sh start scm

# On the OM node
/opt/ozone/sbin/ozone-daemon.sh start om

# On each DataNode
/opt/ozone/sbin/ozone-daemon.sh start datanode
```
