# Deployment Guide: Apache DataSketches

Apache DataSketches is a library of stochastic streaming algorithms. It is deployed by including its JAR files in the classpath of your data processing application (e.g., Spark).

## 1. Prerequisites

  * A running Spark cluster.

## 2. Integration with Spark

The `setup_libs.sh` script and the corresponding `spark-defaults.conf` entry automatically make the DataSketches Spark library available to **all Spark jobs** on the cluster.

There are no further deployment steps required. You can immediately start using the DataSketches UDFs in your Spark SQL queries or DataFrame operations.

**Example import in Scala:**

```scala
import org.apache.datasketches.spark.functions._
```

## 3. Integration with other JVM Applications

For non-Spark applications, you would add DataSketches as a dependency in your `pom.xml` or `build.gradle` file.

**For Maven (`pom.xml`):**

```xml
<dependency>
    <groupId>org.apache.datasketches</groupId>
    <artifactId>datasketches-java</artifactId>
    <version>4.2.0</version>
</dependency>
```

There are no services to configure or start.
