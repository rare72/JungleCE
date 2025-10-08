# Deployment Guide: Apache Daffodil

Apache Daffodil is a data parsing library and toolset. It can be used as a command-line tool or as a dependency in a JVM project.

## 1. Deployment as a Command-Line Tool

### Download and Unpack

Download the command-line interface binary and unpack it.

```bash
# Example for Daffodil 3.6.0
wget https://dlcdn.apache.org/daffodil/3.6.0/apache-daffodil-3.6.0-bin.tar.gz
tar -xzf apache-daffodil-3.6.0-bin.tar.gz
sudo mv daffodil-3.6.0 /opt/daffodil
```

### Add to PATH

For convenience, add the Daffodil `bin` directory to your system's PATH.

```bash
# Add to your .bashrc or .profile
export PATH=$PATH:/opt/daffodil/bin
```

The CLI is now ready to use.

## 2. Deployment as a Library

### Add as a Project Dependency

To use Daffodil programmatically, add it to your project's build configuration.

**For Maven (`pom.xml`):**

```xml
<dependency>
    <groupId>org.apache.daffodil</groupId>
    <artifactId>daffodil-japi_2.12</artifactId>
    <version>3.6.0</version>
</dependency>
```

### Using the Centralized JAR

The `setup_libs.sh` script and the `spark-defaults.conf` entry make the Daffodil runtime available to all Spark jobs. You can use its API within your Spark application to parse complex data from HDFS.

There are no services to configure or start.
