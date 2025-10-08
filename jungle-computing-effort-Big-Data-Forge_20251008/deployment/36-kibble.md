# Deployment Guide: Apache Kibble

Apache Kibble is a suite of tools for collecting and visualizing activity in software projects. It scans sources like Git repositories and mailing lists and stores the aggregated data in an Elasticsearch backend.

## 1. Prerequisites

  * Java 8 or higher.
  * Python 3.
  * An Elasticsearch instance (version 7.x is recommended).

## 2. Download

Download the Kibble scanner binary.

```bash
# Example for Kibble
wget https://dlcdn.apache.org/kibble/kibble-scanner/kibble-scanner.py
chmod +x kibble-scanner.py
sudo mv kibble-scanner.py /opt/kibble/
```

You will also need the Kibble web UI component if you wish to visualize the data.

## 3. Configuration

Kibble is configured via a YAML file, typically named `kibble.yml`.

1.  **Create `kibble.yml`**: This file defines the organization, the data sources to scan, and the connection to Elasticsearch.
    ```yaml
    kibble:
      name: "My Organization"
      organisation: "MyOrg"
      elasticsearch:
        host: "your-elasticsearch-host"
        port: 9200
      scanners:
        - git
        - mail

    sources:
      my-project-git:
        type: git
        sourceID: my-project-git
        location: "https://github.com/my-org/my-project.git"
      my-project-mail:
        type: ponymail # Or other mail types
        sourceID: my-project-mail
        location: "https://lists.my-org.org/archives/my-project-dev/"
    ```

## 4. Execution

Run the scanner to collect data. The scanner will connect to the sources defined in the configuration file and push the aggregated data into Elasticsearch.

```bash
cd /opt/kibble
./kibble-scanner.py scan --config /path/to/your/kibble.yml
```

After the scan is complete, you can start the Kibble web UI (if installed), which will read from the Elasticsearch index and display dashboards and statistics about your project's activity.
