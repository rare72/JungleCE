# Deployment Guide: Apache Arrow

Apache Arrow is a cross-language development platform for in-memory data. It is a library, not a service, so "deployment" means installing the necessary packages for your chosen programming language.

## 1. Prerequisites

  * A development environment for your chosen language (e.g., Python, Java).
  * For Python, `pip` and a virtual environment are recommended. For Java, a build tool like Maven or Gradle.

## 2. Installation for Python

Arrow is most commonly used in Python for big data analytics.

  * **For Debian 12:**
    ```bash
    sudo apt update
    sudo apt install -y python3-pip python3-venv
    ```
  * **For RHEL 9:**
    ```bash
    sudo dnf install -y python3-pip python3-virtualenv
    ```
  * **Install the Library:**
    ```bash
    # Create and activate a virtual environment
    python3 -m venv arrow_env
    source arrow_env/bin/activate

    # Install PyArrow with support for HDFS, Parquet, and other formats
    pip install pyarrow
    ```

## 3. Installation for Java/Scala

For JVM-based projects like Spark or Flink, you include Arrow as a dependency in your build tool.

  * **For Maven (`pom.xml`):**
    ```xml
    <dependency>
        <groupId>org.apache.arrow</groupId>
        <artifactId>arrow-vector</artifactId>
        <version>15.0.0</version>
    </dependency>
    <dependency>
        <groupId>org.apache.arrow</groupId>
        <artifactId>arrow-memory-netty</artifactId>
        <version>15.0.0</version>
    </dependency>
    ```

There are no services to configure or start. Arrow is now ready to be used as a library to enable high-performance data transport and in-memory analytics.
