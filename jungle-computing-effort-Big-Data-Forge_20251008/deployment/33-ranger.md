# Deployment Guide: Apache Ranger

Apache Ranger provides centralized security administration for the Hadoop ecosystem, including fine-grained authorization and auditing.

## 1. Prerequisites

  * A running Hadoop cluster.
  * A relational database for storing policies (e.g., MySQL, PostgreSQL).

## 2. Download and Unpack

Download the Ranger Admin server binary and unpack it on a dedicated node.

```bash
# Example for Ranger 2.4.0
wget https://dlcdn.apache.org/ranger/2.4.0/apache-ranger-2.4.0-admin.tar.gz
tar -xzf apache-ranger-2.4.0-admin.tar.gz
sudo mv apache-ranger-2.4.0-admin /opt/ranger-admin
```

You will also need to download the `ranger-2.4.0-usersync.tar.gz` and `ranger-2.4.0-<component>-plugin.tar.gz` packages for the services you wish to secure.

## 3. Configuration

1.  **Database Setup**: Create a database and a user for Ranger in your chosen RDBMS.
2.  **Configure `install.properties`**: Edit `/opt/ranger-admin/install.properties`. This file is crucial and configures everything for the setup script.
    ```properties
    # --- Database Properties ---
    db_root_user=root
    db_root_password=your_db_root_password
    db_host=your-db-host:3306
    db_name=ranger
    db_user=rangeradmin
    db_password=rangeradminpassword

    # --- Audit Store (Solr or HDFS) ---
    audit_store=solr

    # --- Policy Manager User ---
    policymgr_external_url=http://your-ranger-admin-host:6080
    ```
3.  **JDBC Driver**: Place the appropriate JDBC driver JAR for your database into `/opt/ranger-admin/ews/lib`.

## 4. Setup and Start

Run the setup script. This will configure the database and install the Ranger Admin service.

```bash
cd /opt/ranger-admin
sudo ./setup.sh
```

After the setup is complete, start the Ranger Admin service.

```bash
sudo ranger-admin start
```

You can now access the Ranger UI at `http://your-ranger-admin-host:6080`. The next steps involve installing the Ranger plugin on each Hadoop component (like HDFS, Hive, etc.) and configuring them to point to the Ranger Admin server.
