# Deployment Guide: Apache Gobblin

Apache Gobblin is a universal data ingestion framework for extracting, transforming, and loading large amounts of data from a variety of sources. It can run in standalone mode or be distributed on YARN.

## 1. Prerequisites

  * Java 8, Git, Gradle.
  * A running HDFS and YARN cluster.

## 2. Download and Build

Gobblin is typically built from source.

```bash
git clone https://github.com/apache/gobblin.git
cd gobblin
./gradlew build
```

## 3. Configuration

Gobblin jobs are configured using `.pull` or `.properties` files. You define a source, converter, and writer.

  * **Example `wikipedia.pull` for standalone mode**:

    ```properties
    job.name=WikipediaIngestion
    source.class=org.apache.gobblin.source.extractor.extract.wikipedia.WikipediaSource
    writer.builder.class=org.apache.gobblin.writer.SimpleDataWriterBuilder
    writer.fs.uri=file:///tmp/gobblin-out
    ```

  * **Configuration for YARN**:
    To run on YARN, you need to configure the Gobblin YARN distribution, setting properties for the YARN application master, containers, and pointing to your HDFS cluster.

## 4. Execution

Gobblin provides scripts to launch jobs.

  * **Run in Standalone Mode**:
    ```bash
    bin/gobblin-standalone.sh start
    ```
  * **Run a one-time job**:
    ```bash
    bin/run-gobblin.sh --conf /path/to/wikipedia.pull
    ```
  * **Run on YARN**:
    After building the YARN distribution (`./gradlew :gobblin-distribution:buildDeb`), you would start the Gobblin Cluster ApplicationMaster on YARN.
