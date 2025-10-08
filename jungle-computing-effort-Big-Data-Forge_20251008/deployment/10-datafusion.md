# Deployment Guide: Apache DataFusion

Apache DataFusion is a query engine library, not a standalone service. It is typically used within a Rust or Python application to perform high-performance queries on data.

## 1. Deployment for Python

### Install via pip

The easiest way to "deploy" DataFusion for Python is to install it using pip. It's recommended to do this within a Python virtual environment.

```bash
# Create and activate a virtual environment
python3 -m venv datafusion_env
source datafusion_env/bin/activate

# Install the library
pip install datafusion
```

### Using the Centralized JAR (for JVM contexts)

The `setup_libs.sh` script makes the Java implementation of DataFusion's core available. This would be used if you were calling DataFusion from a JVM-based language like Scala within a Spark job, though the Python and Rust APIs are more common.

## 2. Deployment for Rust

### Add as a Crate Dependency

To use DataFusion in a Rust project, you add it to your `Cargo.toml` file.

```toml
[dependencies]
datafusion = "34.0.0"
```

There are no services to configure or start. DataFusion is now ready to be used as a library in your application.
