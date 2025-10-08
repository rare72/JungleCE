# Deployment Guide: Apache Beam

Apache Beam is a programming model. There is no service to deploy. This guide explains how to set up a project to run Beam pipelines using the Spark Runner on your existing cluster.

## 1. Development Prerequisites

You will need a build tool like Maven or Gradle.

  * **For Debian 12:**
    ```bash
    sudo apt install -y maven
    ```
  * **For RHEL 9:**
    ```bash
    sudo dnf install -y maven
    ```

## 2. Project Setup (pom.xml)

When creating your Beam application, include the necessary dependencies in your `pom.xml` for the Spark Runner.

```xml
<dependencies>
  <dependency>
    <groupId>org.apache.beam</groupId>
    <artifactId>beam-sdks-java-core</artifactId>
    <version>2.51.0</version>
  </dependency>
  <dependency>
    <groupId>org.apache.beam</groupId>
    <artifactId>beam-runners-spark-3</artifactId>
    <version>2.51.0</version>
  </dependency>
  <dependency>
    <groupId>org.apache.spark</groupId>
    <artifactId>spark-core_2.12</artifactId>
    <version>3.5.0</version>
  </dependency>
</dependencies>
```

## 3. Configure the Pipeline

In your Java or Python code, specify `SparkRunner` in the pipeline options. The runner will automatically use the Hadoop configuration found by Spark.

```java
PipelineOptions options = PipelineOptionsFactory.create();
options.setRunner(SparkRunner.class);
Pipeline p = Pipeline.create(options);
// ... your pipeline logic ...
p.run().waitUntilFinish();
```

## 4. Submit the Job

Package your application into a JAR file and submit it to your Spark cluster. The Spark job will execute the Beam pipeline.

```bash
/opt/spark/bin/spark-submit \
  --class com.mycompany.MyBeamPipeline \
  --master yarn \
  --deploy-mode cluster \
  my-beam-app-fat.jar
```

No separate environment variables are needed as long as your Spark cluster is correctly configured to access HDFS.
