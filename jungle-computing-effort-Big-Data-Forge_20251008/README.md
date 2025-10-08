# Jungle Computing Effort: The Anvil

**Forging stable, reproducible, and powerful Linux environments for Data Engineering.**

## Mission

This project automates the transformation of a bare Linux system (Debian-based or RHEL-based) into a production-ready data engineering workstation. It provides a suite of modular, single-purpose scripts that handle everything from system updates and security hardening to the installation of essential development tools, data platforms, and GUI applications.

The Anvil is built on the principles of idempotency and cross-platform compatibility, ensuring a consistent and reliable setup every time. An interactive master installer allows you to customize the setup by selecting or skipping specific tasks, giving you full control over your environment.

## Key Features

-   **Cross-Platform Support**: Works on both Debian-based (Ubuntu, Debian) and RHEL-based (RHEL, Fedora) distributions.
-   **Interactive Installer**: A master script orchestrates the setup, allowing you to skip tasks you don't need.
-   **Modular Scripts**: 34 single-purpose scripts handle specific tasks, making the system easy to understand, maintain, and extend.
-   **Comprehensive Tooling**: Installs a full suite of tools for data engineering, including Python, Java, PostgreSQL, MongoDB, VS Code, and more.
-   **Security Hardening**: Configures the system firewall and hardens the SSH server out of the box.
-   **Service Management**: Includes a dedicated script to easily enable or disable PostgreSQL and MongoDB services post-setup.

## Usage

### Running the Master Setup

To begin the setup process, clone this repository, navigate to the `orchestrator` directory, and run the master script with `sudo` privileges.

```bash
cd jungle-computing-effort/orchestrator
sudo bash ./run_master_setup.sh
```

#### Skipping Tasks

You can customize your installation by skipping specific tasks using the `--skip` flag, followed by the numbers of the tasks you wish to exclude.

For example, to skip the installation of GitHub Desktop (task 5) and Google Chrome (task 27):

```bash
sudo bash ./run_master_setup.sh --skip 5 27
```

### Managing Services

After the initial setup, you can easily manage the PostgreSQL and MongoDB services using the `manage_postgres_mongo_services.sh` script located in the `scripts` directory.

**Usage:**

```bash
cd jungle-computing-effort/scripts
sudo ./manage_postgres_mongo_services.sh [enable|disable] [postgres|mongo]
```

**Examples:**

```bash
# Enable the PostgreSQL service
sudo ./manage_postgres_mongo_services.sh enable postgres

# Disable the MongoDB service
sudo ./manage_postgres_mongo_services.sh disable mongo
```

## Script Manifest

The project is composed of 34 distinct scripts organized into 9 categories.

| #  | Category          | Script                               | Description                                                                 |
|----|-------------------|--------------------------------------|-----------------------------------------------------------------------------|
| 1  | System Prep       | `update_system.sh`                   | Updates all system packages to their latest versions.                       |
| 2  | System Prep       | `configure_timezone.sh`              | Sets the system timezone to `America/New_York`.                             |
| 3  | System Prep       | `setup_unattended_upgrades.sh`       | Configures automatic security updates (Debian-based).                       |
| 4  | System Prep       | `install_build_tools.sh`             | Installs essential build tools (`build-essential` or `Development Tools`).  |
| 5  | System Prep       | `install_github_tools.sh`            | Installs the GitHub CLI (`gh`) and GitHub Desktop.                          |
| 6  | Security          | `configure_firewall.sh`              | Sets up a firewall, allowing SSH and denying other incoming traffic.        |
| 7  | Security          | `harden_ssh_server.sh`               | Hardens SSH configuration by disallowing root and password login.           |
| 8  | Shell & Terminal  | `install_zsh.sh`                     | Installs the Z shell.                                                       |
| 9  | Shell & Terminal  | `install_oh_my_zsh.sh`               | Installs Oh My Zsh for the current user.                                    |
| 10 | Shell & Terminal  | `set_zsh_as_default_shell.sh`        | Changes the user's default shell to Zsh.                                    |
| 11 | Shell & Terminal  | `create_shell_profile.sh`            | Creates a `.zprofile` file and sets the default `$EDITOR`.                  |
| 12 | Shell & Terminal  | `setup_shell_aliases.sh`             | Adds common and useful shell aliases to `~/.zshrc`.                         |
| 13 | Shell & Terminal  | `install_terminator.sh`              | Installs the Terminator terminal emulator.                                  |
| 14 | Core Dev Tools    | `install_java_jdk.sh`                | Installs OpenJDK 11.                                                        |
| 15 | Core Dev Tools    | `install_python_dev_tools.sh`        | Installs Python development and linting tools (`black`, `flake8`, `isort`). |
| 16 | Core Dev Tools    | `install_cli_power_tools.sh`         | Installs `jq`, `htop`, `tree`, and `ncdu`.                                  |
| 17 | Core Dev Tools    | `install_vscode.sh`                  | Installs Visual Studio Code.                                                |
| 18 | Core Dev Tools    | `install_python3.sh`                 | Installs Python 3 and Pip.                                                  |
| 19 | Python Config     | `configure_pip.sh`                   | Creates a `pip.conf` file with a default request timeout.                   |
| 20 | Python Config     | `install_pip_packages.sh`            | Installs core Python data libraries (`pandas`, `pyspark`, etc.).            |
| 21 | Data Tools        | `install_postgresql_client.sh`       | Installs the `psql` command-line client.                                    |
| 22 | Data Tools        | `install_postgresql_server.sh`       | Installs and enables the PostgreSQL database server.                        |
| 23 | Data Tools        | `install_csvkit.sh`                  | Installs the `csvkit` command-line tool suite.                              |
| 24 | Data Tools        | `install_mongodb.sh`                 | Installs the MongoDB Community Server.                                      |
| 25 | Data Tools        | `install_quarto.sh`                  | Installs the Quarto technical publishing system.                            |
| 26 | Data Tools        | `install_dbeaver_ce.sh`              | Installs DBeaver Community Edition.                                         |
| 27 | Desktop & GUI     | `install_google_chrome.sh`           | Installs the Google Chrome web browser.                                     |
| 28 | Desktop & GUI     | `create_chrome_shortcut.sh`          | Creates a desktop shortcut for Google Chrome.                               |
| 29 | Desktop & GUI     | `create_terminator_shortcut.sh`      | Creates a desktop shortcut for Terminator.                                  |
| 30 | Desktop & GUI     | `create_vscode_shortcut.sh`          | Creates a desktop shortcut for Visual Studio Code.                          |
| 31 | Desktop & GUI     | `create_dbeaver_shortcut.sh`         | Creates a desktop shortcut for DBeaver.                                     |
| 32 | Finalization      | `final_cleanup.sh`                   | Removes unnecessary packages and cleans the package cache.                  |
| 33 | Management        | `prompt_for_reboot.sh`               | Informs the user that a reboot is recommended. (Manual Execution)           |
| 34 | Management        | `manage_postgres_mongo_services.sh`  | A utility to enable/disable PostgreSQL and MongoDB. (Manual Execution)      |