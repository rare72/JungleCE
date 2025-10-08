# Deployment Guide: Apache Calcite

Apache Calcite is a library, not a runnable service. It is "deployed" by including it as a dependency in your application (e.g., a Java/Scala project).

## 1. Prerequisites

  * A Java development environment with a build tool like Maven or Gradle.

## 2. Add as a Project Dependency

The standard way to use Calcite is to add it to your project's build configuration.

**For Maven (`pom.xml`):**

```xml
<dependency>
    <groupId>org.apache.calcite</groupId>
    <artifactId>calcite-core</artifactId>
    <version>1.36.0</version>
</dependency>
```

**For Gradle (`build.gradle`):**

```groovy
implementation 'org.apache.calcite:calcite-core:1.36.0'
```

## 3. Using the Centralized JAR

Alternatively, you can use the JAR file that was downloaded by the `setup_libs.sh` script. To do this, you would add the JAR to the classpath of your application when you compile and run it.

**Example for a Spark Job:**

The `setup_libs.sh` script and the corresponding `spark-defaults.conf` entry already make Calcite available to all Spark jobs automatically. You can start using it in your code without any further steps.

**Example for a standalone Java application:**

```bash
# Compile
javac -cp ".:/path/to/hdfs/jars/calcite-core-1.36.0.jar" MyCalciteApp.java

# Run
java -cp ".:/path/to/hdfs/jars/calcite-core-1.36.0.jar" MyCalciteApp
```

There are no services to configure or start. Calcite is now ready to be used programmatically within your application.
