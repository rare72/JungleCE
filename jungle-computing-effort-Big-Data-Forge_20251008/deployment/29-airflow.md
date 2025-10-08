# Deployment Guide: Apache Airflow

Apache Airflow is a platform to programmatically author, schedule, and monitor workflows. This guide covers a basic setup using the LocalExecutor, which is suitable for a single-node installation.

## 1. Prerequisites

  * Python 3.8+ and `pip` are installed.
  * A metadata database is required. PostgreSQL or MySQL is recommended for production, but SQLite can be used for testing.

  * **For Debian 12:**
    ```bash
    sudo apt update
    sudo apt install -y python3-pip python3-venv
    ```
  * **For RHEL 9:**
    ```bash
    sudo dnf install -y python3-pip python3-virtualenv
    ```

## 2. Installation

It is highly recommended to install Airflow in a dedicated virtual environment.

```bash
# Set Airflow home and version
export AIRFLOW_HOME=~/airflow
export AIRFLOW_VERSION=2.8.1

# Create and activate virtual environment
python3 -m venv airflow_env
source airflow_env/bin/activate

# Install Airflow with community-recommended extras
pip install "apache-airflow[postgres,cncf.kubernetes]==${AIRFLOW_VERSION}" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-3.8.txt"
```

## 3. Configuration

1.  **Initialize the Database**: This command creates the necessary tables in the metadata database defined in `airflow.cfg`.
    ```bash
    airflow db init
    ```
2.  **Create a User**: Create an admin user to log in to the web UI.
    ```bash
    airflow users create \
        --username admin \
        --firstname Admin \
        --lastname User \
        --role Admin \
        --email admin@example.com
    ```
3.  **Configure `airflow.cfg`**: Edit `~/airflow/airflow.cfg`. Key settings include:
    *   `executor`: Change from `SequentialExecutor` to `LocalExecutor`.
    *   `sql_alchemy_conn`: Set the connection string to your PostgreSQL or MySQL database.
    *   `dags_folder`: Specify the directory where your DAG files are located.

## 4. Start the Services

Start the Airflow webserver and scheduler in separate terminals.

```bash
# Start the webserver (default port is 8080)
airflow webserver --port 8080

# Start the scheduler
airflow scheduler
```

You can now access the Airflow UI at `http://your-airflow-node:8080`.
