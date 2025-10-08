# Deployment Guide: Apache Kudu

Apache Kudu is a columnar storage engine for fast analytics on fast data. It is a standalone service with master and tablet servers.

## 1. Prerequisites

  * NTP configured on all nodes for clock synchronization.
  * Increased `ulimit` settings for open files and processes.

## 2. Download and Install

Kudu provides its own repositories for easy installation.

  * **For RHEL 9 (and compatible):**
    ```bash
    sudo wget https://apache.bintray.com/kudu/el/kudu.repo -O /etc/yum.repos.d/kudu.repo
    sudo dnf install -y kudu kudu-master kudu-tserver
    ```
  * **For Debian 12 (and compatible):**
    ```bash
    sudo apt-get install -y apt-transport-https
    sudo wget https://apache.bintray.com/kudu/ubuntu-bionic/kudu.list -O /etc/apt/sources.list.d/kudu.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1434642642A24A61
    sudo apt-get update
    sudo apt-get install -y kudu kudu-master kudu-tserver
    ```

## 3. Configuration

Configuration is done in `/etc/kudu/conf`.

  * **Master Configuration (`master.gflagfile`):**
    ```
    --fs_wal_dir=/data/kudu/master
    --fs_data_dirs=/data/kudu/master
    --rpc_bind_addresses=0.0.0.0
    ```
  * **Tablet Server Configuration (`tserver.gflagfile`):**
    ```
    --fs_wal_dir=/data/kudu/tserver
    --fs_data_dirs=/data/kudu/tserver
    --tserver_master_addrs=your-kudu-master-hostname:7051
    ```

## 4. Start the Services

Start the master and tablet server daemons.

```bash
# On the master node
sudo systemctl start kudu-master

# On each tablet server node
sudo systemctl start kudu-tserver
```
