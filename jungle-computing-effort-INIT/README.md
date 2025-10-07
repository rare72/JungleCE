# Jungle Computing Effort: The Anvil

*Forging stable, reproducible, and powerful Linux environments for Data Engineering.*

---

## 1. Mission

The Anvil is a comprehensive automation suite designed to transform a bare Debian-based (Ubuntu, Debian) or RHEL-based (RHEL, Fedora) Linux system into a production-ready data engineering workstation. It leverages a collection of single-purpose, idempotent shell scripts orchestrated by an intelligent master installer.

This project ensures that every developer can start from a consistent, secure, and feature-rich baseline, eliminating configuration drift and dramatically speeding up environment setup.

## 2. Key Features

- **Cross-Platform Support:** Works seamlessly on both Debian and RHEL-based distributions.
- **Modular by Design:** Each of the 34 scripts handles a single, distinct task, making the system easy to understand, modify, and debug.
- **Interactive Installer:** The master script allows you to selectively skip tasks, giving you full control over the setup process.
- **Secure by Default:** Implements essential security measures, including firewall configuration and SSH server hardening.
- **Rich Tooling:** Installs a complete suite of tools for data engineering, including Python, Java, PostgreSQL, MongoDB, VS Code, and more.
- **Post-Setup Management:** Includes a dedicated script for easily managing (enabling/disabling) PostgreSQL and MongoDB services.

## 3. Usage

### 3.1. Running the Master Setup

The primary setup process is handled by the `run_master_setup.sh` script. It must be executed with `sudo` privileges.

**Basic Execution:**

```bash
cd jungle-computing-effort/orchestrator/
sudo ./run_master_setup.sh
```

**Skipping Specific Tasks:**

You can skip one or more tasks using the `--skip` flag, followed by the task numbers you wish to exclude.

```bash
# Skip the firewall configuration (6) and Zsh installation (8)
sudo ./run_master_setup.sh --skip 6 8
```

### 3.2. Managing Data Services

After setup, you can easily enable or disable the PostgreSQL and MongoDB services using the `manage_postgres_mongo_services.sh` script.

**Syntax:**

```bash
./scripts/34_manage_postgres_mongo_services.sh <enable|disable> <postgres|mongo>
```

**Examples:**

```bash
# Disable and stop the PostgreSQL service
./scripts/34_manage_postgres_mongo_services.sh disable postgres

# Enable and start the MongoDB service
./scripts/34_manage_postgres_mongo_services.sh enable mongo
```

## 4. Script Manifest

The project is composed of the following scripts, executed in order by the master orchestrator unless skipped.

| #  | Script Name                        | Category       | Description                                                                 |
|----|------------------------------------|----------------|-----------------------------------------------------------------------------|
| 1  | `update_system.sh`                 | System Prep    | Updates all system packages to their latest versions.                         |
| 2  | `configure_timezone.sh`            | System Prep    | Sets the system timezone to `America/New_York`.                               |
| 3  | `setup_unattended_upgrades.sh`     | System Prep    | Configures automatic security updates (Debian-based only).                    |
| 4  | `install_build_tools.sh`           | System Prep    | Installs essential build tools (`build-essential`, `Development Tools`).      |
| 5  | `install_github_tools.sh`          | System Prep    | Installs the GitHub CLI (`gh`) and GitHub Desktop.                            |
| 6  | `configure_firewall.sh`            | Security       | Configures `ufw` or `firewalld` to allow SSH and deny other incoming traffic. |
| 7  | `harden_ssh_server.sh`             | Security       | Disallows root login and password-based authentication for SSH.             |
| 8  | `install_zsh.sh`                   | Shell/Terminal | Installs the Z shell (`zsh`).                                               |
| 9  | `install_oh_my_zsh.sh`             | Shell/Terminal | Installs the Oh My Zsh framework for the user.                                |
| 10 | `set_zsh_as_default_shell.sh`      | Shell/Terminal | Changes the current user's default login shell to `zsh`.                      |
| 11 | `create_shell_profile.sh`          | Shell/Terminal | Creates a `.zprofile` and sets VS Code as the default `$EDITOR`.              |
| 12 | `setup_shell_aliases.sh`           | Shell/Terminal | Adds a set of useful command-line aliases to `~/.zshrc`.                      |
| 13 | `install_terminator.sh`            | Shell/Terminal | Installs the Terminator terminal emulator.                                  |
| 14 | `install_java_jdk.sh`              | Core Dev Tools | Installs OpenJDK 11.                                                        |
| 15 | `install_python_dev_tools.sh`      | Core Dev Tools | Installs `black`, `flake8`, and `isort` via `pip3`.                           |
| 16 | `install_cli_power_tools.sh`       | Core Dev Tools | Installs `jq`, `htop`, `tree`, and `ncdu`.                                    |
| 17 | `install_vscode.sh`                | Core Dev Tools | Installs Visual Studio Code.                                                |
| 18 | `install_python3.sh`               | Core Dev Tools | Installs Python 3 and its package manager, `pip`.                             |
| 19 | `configure_pip.sh`                 | Python Config  | Creates a default `pip.conf` with a connection timeout.                       |
| 20 | `install_pip_packages.sh`          | Python Config  | Installs `pandas`, `pyspark`, `logify`, and `duckdb`.                         |
| 21 | `install_postgresql_client.sh`     | Data Tools     | Installs the `psql` command-line client for PostgreSQL.                     |
| 22 | `install_postgresql_server.sh`     | Data Tools     | Installs and enables the PostgreSQL database server.                        |
| 23 | `install_csvkit.sh`                | Data Tools     | Installs the `csvkit` suite for working with CSV files.                       |
| 24 | `install_mongodb.sh`               | Data Tools     | Installs and enables the MongoDB Community Server.                          |
| 25 | `install_quarto.sh`                | Data Tools     | Installs the Quarto technical publishing system.                            |
| 26 | `install_dbeaver_ce.sh`            | Data Tools     | Installs the DBeaver Community Edition database tool.                       |
| 27 | `install_google_chrome.sh`         | Desktop/GUI    | Installs the Google Chrome web browser.                                     |
| 28 | `create_chrome_shortcut.sh`        | Desktop/GUI    | Creates a desktop shortcut for Google Chrome.                               |
| 29 | `create_terminator_shortcut.sh`    | Desktop/GUI    | Creates a desktop shortcut for Terminator.                                  |
| 30 | `create_vscode_shortcut.sh`        | Desktop/GUI    | Creates a desktop shortcut for Visual Studio Code.                          |
| 31 | `create_dbeaver_shortcut.sh`       | Desktop/GUI    | Creates a desktop shortcut for DBeaver.                                     |
| 32 | `final_cleanup.sh`                 | Finalization   | Removes unnecessary packages and cleans package manager caches.             |
| 33 | `prompt_for_reboot.sh`             | Management     | *Manual:* Informs the user that a reboot is recommended.                    |
| 34 | `manage_postgres_mongo_services.sh`| Management     | *Manual:* A utility to enable/disable PostgreSQL and MongoDB services.      |