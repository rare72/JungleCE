# Deployment Guide: Apache DataFu

Apache DataFu is a collection of user-defined functions (UDFs) for data analysis. It is a library, not a service, and is deployed by including it in the classpath of a data processing job (e.g., Spark or MapReduce).

## 1. Prerequisites

  * A running Spark or Hadoop MapReduce cluster.

## 2. Integration with Spark

The `setup_libs.sh` script and the `spark-defaults.conf` entry automatically make the DataFu library available to **all Spark jobs** on the cluster.

There are no further deployment steps. You can start importing and using DataFu functions directly in your Spark application code.

**Example import in Scala:**

```scala
import datafu.spark.functions._
```

## 3. Integration with Hadoop MapReduce (Pig)

Historically, DataFu was popular with Apache Pig. To use it with Pig (which runs on MapReduce), you would register the JAR at the start of your Pig script.

```pig
-- Register the DataFu JAR
REGISTER /path/to/datafu-pig-1.4.0.jar;

-- Define UDFs
DEFINE Sessionize datafu.pig.sessions.Sessionize();

-- Use the UDF
sessions = FOREACH (GROUP data BY user) GENERATE FLATTEN(Sessionize(data));
```

There are no services to configure or start.
