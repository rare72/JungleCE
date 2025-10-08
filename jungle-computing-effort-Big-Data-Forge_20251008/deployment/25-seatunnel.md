# Deployment Guide: Apache SeaTunnel

Apache SeaTunnel is a high-performance, distributed data integration tool. It runs on top of compute engines like Spark and Flink to synchronize data between various sources and sinks.

## 1. Prerequisites

  * A running Spark or Flink cluster with YARN.

## 2. Download and Unpack

Download the SeaTunnel package and unpack it on the node you will use to submit jobs.

```bash
# Example for SeaTunnel 2.3.5
wget https://dlcdn.apache.org/seatunnel/2.3.5/seatunnel-2.3.5-bin.tar.gz
tar -xzf seatunnel-2.3.5-bin.tar.gz
sudo mv seatunnel-2.3.5 /opt/seatunnel
```

## 3. Distribute Hadoop Configuration

SeaTunnel's Spark/Flink engine needs to know how to connect to HDFS and YARN.

```bash
# Run this from your Hadoop master node
scp -r /opt/hadoop/etc/hadoop user@seatunnel-node-hostname:/etc/hadoop/conf
```

## 4. Set Environment

Edit SeaTunnel's environment script to point to the Hadoop configuration and other dependencies.

  * **File**: `/opt/seatunnel/bin/seatunnel-env.sh`
  * **Set these variables**:
    ```bash
    # Point to your Spark home
    SPARK_HOME=${SPARK_HOME:-/opt/spark}
    # Point to your Hadoop config
    HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-/etc/hadoop/conf}
    ```

## 5. Configure and Run a Job

Create a configuration file that defines your data pipeline.

  * **Example `config.hocon`**:
    ```hocon
    env {
      execution.parallelism = 1
    }
    source {
      FakeSource {
        result_table_name = "fake"
        schema = {
          fields {
            name = "string"
            age = "int"
          }
        }
      }
    }
    sink {
      HdfsFile {
        path = "hdfs://your-master-node-hostname:9000/seatunnel/output"
        source_table_name = "fake"
      }
    }
    ```
  * **Run the job**:
    ```bash
    /opt/seatunnel/bin/seatunnel.sh --config ./config.hocon -e spark
    ```
