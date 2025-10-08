#!/bin/bash

# A script to download common JARs and place them in HDFS for Spark & Hadoop

# --- Configuration ---
# You can update versions here as needed
CALCITE_VERSION="1.36.0"
DATAFU_VERSION="1.4.0"
DATASKETCHES_VERSION="4.2.0"
DAFFODIL_VERSION="3.6.0"
DATAFUSION_VERSION="34.0.0"

HDFS_JAR_DIR="/apps/jars"
LOCAL_TEMP_DIR="/tmp/jar_downloads"

# --- Script Logic ---
echo "--- Starting JAR Library Setup ---"

# 1. Create local temp directory
mkdir -p "$LOCAL_TEMP_DIR"
cd "$LOCAL_TEMP_DIR"
echo "Created temporary local directory at $LOCAL_TEMP_DIR"

# 2. Download JARs using wget
echo "Downloading libraries..."
wget -q "https://repo1.maven.org/maven2/org/apache/calcite/calcite-core/${CALCITE_VERSION}/calcite-core-${CALCITE_VERSION}.jar"
wget -q "https://repo1.maven.org/maven2/org/apache/datafu/datafu-spark_${DATAFU_VERSION:0:3}/${DATAFU_VERSION}/datafu-spark_${DATAFU_VERSION:0:3}-${DATAFU_VERSION}.jar" -O "datafu-spark-${DATAFU_VERSION}.jar"
wget -q "https://repo1.maven.org/maven2/org/apache/datasketches/datasketches-spark/${DATASKETCHES_VERSION}/datasketches-spark-${DATASKETCHES_VERSION}.jar"
wget -q "https://repo1.maven.org/maven2/org/apache/daffodil/daffodil-runtime1_2.12/${DAFFODIL_VERSION}/daffodil-runtime1_2.12-${DAFFODIL_VERSION}.jar"
wget -q "https://repo1.maven.org/maven2/org/apache/arrow/arrow-datafusion-core/${DATAFUSION_VERSION}/arrow-datafusion-core-${DATAFUSION_VERSION}.jar"

echo "Downloads complete."

# 3. Create HDFS directory
echo "Creating HDFS directory at $HDFS_JAR_DIR..."
hdfs dfs -mkdir -p "$HDFS_JAR_DIR"

# 4. Upload JARs to HDFS
echo "Uploading JARs to HDFS..."
hdfs dfs -put -f ./*.jar "$HDFS_JAR_DIR/"

# 5. Clean up local files
echo "Cleaning up local directory..."
rm -rf "$LOCAL_TEMP_DIR"

echo "--- JAR Library Setup Complete! ---"
echo "Libraries are now available in HDFS at: $HDFS_JAR_DIR"
echo "See this project's README.md for configuration instructions."
