# Deployment Guide: Apache Iceberg

Apache Iceberg is an open table format for huge analytic datasets. It is not a service but a library that integrates with compute engines like Spark and Flink to manage table metadata.

## 1. Prerequisites

  * A running Hadoop and Spark cluster.

## 2. Integration with Spark

To use Iceberg, you need to add its runtime JAR to Spark and configure a catalog.

### Download the JAR

You can download the Iceberg Spark runtime JAR from Maven Central.

```bash
# Example for Iceberg 1.4.2 with Spark 3.3
wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.3_2.12/1.4.2/iceberg-spark-runtime-3.3_2.12-1.4.2.jar
```

### Configure Spark

The best way to use Iceberg is to configure Spark's SQL extensions and a catalog. You can do this by passing parameters to `spark-sql` or adding them to `/opt/spark/conf/spark-defaults.conf`.

```properties
# Add these lines to spark-defaults.conf
spark.sql.extensions                               org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions
spark.sql.catalog.hadoop_catalog                   org.apache.iceberg.spark.SparkCatalog
spark.sql.catalog.hadoop_catalog.type              hadoop
spark.sql.catalog.hadoop_catalog.warehouse         hdfs://your-master-node-hostname:9000/user/hive/warehouse
```

### Launch Spark with Iceberg

Now, when you launch Spark, it will have Iceberg capabilities. Make sure the JAR is available.

```bash
/opt/spark/bin/spark-sql --packages org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.4.2
```

(Using `--packages` is often easier than managing JARs manually).

No service needs to be started. Iceberg is now ready to be used to create and manage tables in Spark.
