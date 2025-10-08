# Deployment Guide: Apache ORC

Apache ORC is a self-describing, type-aware columnar file format designed for Hadoop workloads. It is not a service, but a library. Its "deployment" is typically included by default in modern Hadoop and Spark distributions.

## 1. Prerequisites

  * A running Hadoop or Spark cluster.

## 2. Verification

Modern Spark distributions include the ORC library by default. You can verify its presence. No installation is usually required.

To use ORC in Spark, you simply specify it as the format.

```scala
// In Scala Spark
val df = spark.read.orc("hdfs:///path/to/data.orc")
df.write.format("orc").save("hdfs:///path/to/output.orc")
```

## 3. Using with Native MapReduce or Hive

For older systems or direct use, you may need to ensure the ORC JARs are on the classpath. These JARs are typically found within the Hive library directories.

  * `orc-core.jar`
  * `orc-mapreduce.jar`
  * `hive-storage-api.jar`

When running a MapReduce job, you would add these to the job's classpath, often using the `-libjars` option.

There are no services to configure or start.
