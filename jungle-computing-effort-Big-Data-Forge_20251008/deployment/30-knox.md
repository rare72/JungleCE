# Deployment Guide: Apache Knox

Apache Knox is an application gateway for securing access to Hadoop clusters. It acts as a reverse proxy, centralizing authentication and hiding cluster details.

## 1. Prerequisites

  * A running Hadoop cluster.
  * Java is installed on the gateway node.

## 2. Download and Unpack

Download the Knox Gateway binary and unpack it on a dedicated edge node.

```bash
# Example for Knox 1.8.0
wget https://dlcdn.apache.org/knox/1.8.0/knox-1.8.0.tar.gz
tar -xzf knox-1.8.0.tar.gz
sudo mv knox-1.8.0 /opt/knox
```

## 3. Configuration

Knox is configured using XML files called "topologies" located in `/opt/knox/conf/topologies`.

1.  **Create a Topology File**: Create a file like `default.xml`. This file defines which backend services are exposed through the gateway.
    ```xml
    <topology>
        <gateway>
            <provider>
                <role>authentication</role>
                <name>ShiroProvider</name>
                <enabled>true</enabled>
                <param name="sessionTimeout" value="30"/>
                <!-- Add params for your identity provider, e.g., LDAP -->
            </provider>
            <provider>
                <role>identity-assertion</role>
                <name>Default</name>
                <enabled>true</enabled>
            </provider>
        </gateway>
        <service>
            <role>WEBHDFS</role>
            <url>http://your-namenode-hostname:9870/webhdfs</url>
        </service>
        <service>
            <role>RESOURCEMANAGER</role>
            <url>http://your-resourcemanager-hostname:8088/ws</url>
        </service>
    </topology>
    ```
2.  **Generate Master Secret**: Knox requires a master secret for securing credentials.
    ```bash
    /opt/knox/bin/knoxcli.sh create-master
    ```

## 4. Start the Service

Start the Knox Gateway.

```bash
/opt/knox/bin/gateway.sh start
```

You can now access Hadoop services through the Knox proxy, typically on port 8443. For example, to access WebHDFS, the URL would be `https://knox-node:8443/gateway/default/webhdfs/v1/`.
