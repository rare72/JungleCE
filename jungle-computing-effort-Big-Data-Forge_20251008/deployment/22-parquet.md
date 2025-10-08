# Deployment Guide: Apache Parquet

Apache Parquet is a columnar storage format available to any project in the Hadoop ecosystem. Like ORC, it is a library, not a service. Its "deployment" is included by default in modern data processing frameworks like Spark.

## 1. Prerequisites

  * A running Hadoop or Spark cluster.

## 2. Verification

Spark uses Parquet as its default storage format, so no installation or configuration is required.

To use Parquet in Spark, you can simply save a DataFrame.

```scala
// In Scala Spark
// Writing is Parquet by default
df.write.save("hdfs:///path/to/output.parquet")

// Reading Parquet
val df = spark.read.parquet("hdfs:///path/to/data.parquet")
```

## 3. Using with other Tools

For other tools, you need to ensure the Parquet library JARs are on the classpath. The core libraries are provided by the `parquet-format-java` project.

When writing a MapReduce job that reads/writes Parquet, you would need to include the `parquet-hadoop` library and its dependencies.

There are no services to configure or start.
