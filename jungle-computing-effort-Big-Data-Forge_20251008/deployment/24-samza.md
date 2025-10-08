# Deployment Guide: Apache Samza

Apache Samza is a distributed stream processing framework. It uses Apache Kafka for messaging, and Apache YARN for fault tolerance, processor isolation, security, and resource management.

## 1. Prerequisites

  * A running YARN cluster.
  * A running Kafka cluster.
  * A build tool like Maven or Gradle for your application.

## 2. Application Packaging

Samza is a library, and you "deploy" an application. You package your Samza job code and its dependencies into a `.tgz` archive.

A typical project structure includes:

  * `src/`: Your Java/Scala source code.
  * `config/`: Job configuration files.
  * `bin/`: Startup scripts (`run-app.sh`).

The `run-app.sh` script is responsible for telling Samza how to submit the job to YARN.

## 3. Configuration

The job configuration file (e.g., `my-job.properties`) defines how the job runs.

```properties
# YARN Job Properties
yarn.package.path=hdfs:///path/to/my-samza-app-1.0.0.tgz
yarn.container.memory.mb=1024

# Kafka System Properties
systems.kafka.samza.factory=org.apache.samza.system.kafka.KafkaSystemFactory
systems.kafka.consumer.zookeeper.connect=zookeeper1:2181/
systems.kafka.producer.bootstrap.servers=kafka1:9092

# Input and Output Streams
job.default.system=kafka
task.inputs=kafka.my-input-topic
task.outputs=kafka.my-output-topic
```

## 4. Execution

1.  **Build the job package**: `./bin/grid package`
2.  **Upload the package to HDFS**.
3.  **Run the job**: `./bin/run-job.sh --config-factory=... --config-path=...`

This will submit your application to the YARN ResourceManager, which will then schedule it to run on the cluster.
