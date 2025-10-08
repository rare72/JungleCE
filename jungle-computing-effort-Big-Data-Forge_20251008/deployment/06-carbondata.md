# Deployment Guide: Apache CarbonData

Apache CarbonData is a storage format, not a standalone service. It is deployed as a plugin/library for a compute engine like Apache Spark. This guide shows how to configure Spark to use CarbonData.

## 1. Prerequisites

  * A running Hadoop and Spark cluster.

## 2. Download CarbonData

Download the appropriate CarbonData assembly JAR for your Spark version.

```bash
# Example for CarbonData 2.4.0 with Spark 3.3
wget https://repo1.maven.org/maven2/org/apache/carbondata/carbondata-spark-3.3_2.12/2.4.0/carbondata-spark-3.3_2.12-2.4.0-assembly.jar
```

## 3. Integrate with Spark

You can integrate CarbonData with Spark in two ways.

**Method 1: Place JAR in Spark's `jars` directory (Recommended for permanent setup)**

Copy the downloaded assembly JAR into the `jars` directory of your Spark installation on **every node**.

```bash
sudo cp carbondata-spark-3.3_2.12-2.4.0-assembly.jar /opt/spark/jars/
```

**Method 2: Use `--jars` for `spark-shell` or `spark-submit`**

Provide the path to the JAR when launching a Spark application.

```bash
/opt/spark/bin/spark-sql --jars /path/to/carbondata-spark-3.3_2.12-2.4.0-assembly.jar
```

## 4. Configure Spark Session

To use CarbonData, you must configure your Spark session to recognize it. Add these configurations to `/opt/spark/conf/spark-defaults.conf` for cluster-wide access.

```properties
spark.sql.extensions org.apache.spark.sql.CarbonExtensions
```

When creating a Spark session programmatically, add the configuration:

```scala
val spark = SparkSession.builder()
  .config("spark.sql.extensions", "org.apache.spark.sql.CarbonExtensions")
  .getOrCreate()
```

No service needs to be started. CarbonData is now ready to be used as a storage format in your Spark jobs.
