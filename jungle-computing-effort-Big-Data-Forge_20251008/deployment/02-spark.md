# Deployment Guide: Apache Spark

This guide provides instructions for installing Apache Spark and integrating it with an existing Hadoop cluster.

## 1. Download and Unpack

On your master node, download a Spark binary that is pre-built for Hadoop.

```bash
# Example for Spark 3.5.0 with Hadoop 3
wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz
tar -xzf spark-3.5.0-bin-hadoop3.tgz
sudo mv spark-3.5.0-bin-hadoop3 /opt/spark
```

Copy the `/opt/spark` directory to all your worker nodes.

## 2. Distribute Hadoop Configuration

This step is implicit as Spark is often installed on the same nodes as Hadoop. If not, ensure the Hadoop config directory is available.

## 3. Configure Spark

The key is to tell Spark where to find the Hadoop configuration.

  * Create `conf/spark-env.sh` from the template:
    ```bash
    cp /opt/spark/conf/spark-env.sh.template /opt/spark/conf/spark-env.sh
    ```
  * Create `conf/workers` from the template and list your worker nodes:
    ```bash
    cp /opt/spark/conf/workers.template /opt/spark/conf/workers
    # Edit conf/workers to list worker hostnames
    ```

## 4. Set Environment and Start

Edit `/opt/spark/conf/spark-env.sh` to add the `HADOOP_CONF_DIR` variable.

```bash
# Add this line to the end of spark-env.sh
export HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
```

Finally, start the Spark cluster from your master node:

```bash
/opt/spark/sbin/start-all.sh
```
