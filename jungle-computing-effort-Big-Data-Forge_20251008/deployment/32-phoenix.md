# Deployment Guide: Apache Phoenix

Apache Phoenix provides a SQL layer over Apache HBase, enabling low-latency OLTP and operational analytics. It is deployed as a server-side library on the HBase cluster.

## 1. Prerequisites

  * A running Hadoop cluster (HDFS and YARN).
  * A running Apache HBase cluster.

## 2. Download and Unpack

Download the Phoenix binary that corresponds to your HBase version and unpack it on a client or edge node.

```bash
# Example for Phoenix 5.1.3 for HBase 2.4
wget https://dlcdn.apache.org/phoenix/phoenix-5.1.3/phoenix-hbase-2.4-5.1.3-bin.tar.gz
tar -xzf phoenix-hbase-2.4-5.1.3-bin.tar.gz
sudo mv phoenix-hbase-2.4-5.1.3-bin /opt/phoenix
```

## 3. Server-Side Deployment

Copy the `phoenix-server-hbase-*.jar` file from the unpacked directory to the `lib/` directory of every HBase RegionServer node.

```bash
# From the node where you unpacked Phoenix
scp /opt/phoenix/phoenix-server-hbase-*.jar user@hbase-regionserver-node:/opt/hbase/lib/
```

After copying the JAR, you must **restart the HBase cluster** for the changes to take effect.

## 4. Client-Side Configuration

To interact with Phoenix, you need the client JAR and the HBase configuration.

1.  **HBase Configuration**: Copy `hbase-site.xml` from your HBase cluster to the `/opt/phoenix/bin` directory.
2.  **Using `sqlline`**: Phoenix includes `sqlline`, a command-line SQL client.
    ```bash
    # Connect to your cluster
    /opt/phoenix/bin/sqlline.py your-zookeeper-quorum:2181
    ```

You can now create tables, upsert data, and run SQL queries against your HBase cluster using the `sqlline` client or any JDBC-compliant tool by including the `phoenix-client-hbase-*.jar` in its classpath.
