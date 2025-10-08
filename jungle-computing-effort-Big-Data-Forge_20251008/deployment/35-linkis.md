# Deployment Guide: Apache Linkis

Apache Linkis is a computation middleware that provides a unified API for submitting jobs to various backend engines like Spark, Hive, and Flink.

## 1. Prerequisites

  * A running Hadoop cluster (HDFS and YARN).
  * Java 8.
  * A MySQL database for the Linkis metastore.

## 2. Download and Unpack

Download the Linkis binary package and unpack it.

```bash
# Example for Linkis 1.4.0
wget https://dlcdn.apache.org/linkis/1.4.0/apache-linkis-1.4.0-bin.tar.gz
tar -xzf apache-linkis-1.4.0-bin.tar.gz
sudo mv apache-linkis-1.4.0-bin /opt/linkis
```

## 3. Configuration

1.  **Database Setup**: Initialize the Linkis database by running the `linkis-dist/package/db/linkis_ddl.sql` and `linkis_dml.sql` scripts in your MySQL instance.
2.  **Configure Database Connection**: Edit `conf/db.sh` to provide the connection details for your MySQL database.
    ```bash
    # In /opt/linkis/conf/db.sh
    MYSQL_HOST="your-mysql-host"
    MYSQL_PORT="3306"
    MYSQL_DB="linkis"
    MYSQL_USER="linkis"
    MYSQL_PASSWORD="your_password"
    ```
3.  **Configure Hadoop**: Edit `conf/linkis-env.sh` to point to your Hadoop and Hive installations.
    ```bash
    # In /opt/linkis/conf/linkis-env.sh
    HADOOP_HOME=/opt/hadoop
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
    HIVE_HOME=/opt/hive
    HIVE_CONF_DIR=/opt/hive/conf
    ```

## 4. Installation and Start

Run the installation script. This script will configure the services based on your environment settings.

```bash
cd /opt/linkis
# This script will prompt for versions of engines like Spark.
./bin/install.sh
```

After the installation script completes, start all Linkis microservices.

```bash
# Start all services (Gateway, Manager, Entrance, etc.)
./sbin/linkis-start-all.sh
```

Linkis is now running and ready to accept job submissions via its REST API, typically on port 9001.
