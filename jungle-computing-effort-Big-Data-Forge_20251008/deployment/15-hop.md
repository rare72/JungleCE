# Deployment Guide: Apache Hop

Apache Hop is a data orchestration and data engineering platform. It is a standalone client-server application that can connect to and orchestrate jobs on your Hadoop cluster.

## 1. Prerequisites

  * Java 11 or higher.

## 2. Download and Unpack

Download the Hop client and unpack it on your workstation or an edge node.

```bash
# Example for Hop 2.7.0
wget https://dlcdn.apache.org/hop/2.7.0/apache-hop-client-2.7.0.zip
unzip apache-hop-client-2.7.0.zip
sudo mv hop /opt/hop
```

## 3. Distribute Hadoop Configuration

To allow Hop to connect to your cluster, it needs the Hadoop configuration files.

```bash
# Run this from your Hadoop master node
scp -r /opt/hadoop/etc/hadoop user@hop-node-hostname:/opt/hop/config/hadoop-config
```

## 4. Configure Hop to find Hadoop

You need to tell Hop's projects where the Hadoop configuration is located.

1.  Launch Hop: `/opt/hop/hop-gui.sh`
2.  In your Hop project, you can set a variable `HADOOP_CONF_DIR` to point to `/opt/hop/config/hadoop-config`.
3.  Alternatively, when creating Hadoop file connections within the Hop GUI, you can specify the paths to your `core-site.xml` and `hdfs-site.xml` files.

## 5. Start and Use

Launch the GUI or run workflows from the command line.

```bash
# Launch the GUI
/opt/hop/hop-gui.sh

# Run a workflow from the command line
/opt/hop/hop-run.sh -r local -f /path/to/my-workflow.hwf
```
