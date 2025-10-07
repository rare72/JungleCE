# Jungle Computing Effort (JungleCE)

Welcome to the Jungle Computing Effort (JungleCE) repository. This project is a curated collection of automation scripts and tools designed to streamline the setup and management of development and data engineering environments on Linux systems.

---

## Repository Overview

This repository is organized into several key directories, each serving a distinct purpose.

### 1. `jungle-computing-effort-INIT/`

This directory contains the system initialization component of the JungleCE project. It provides a comprehensive, end-to-end automation suite for transforming a bare Linux system (Debian/RHEL-based) into a foundational data engineering workstation.

- **Purpose:** Automate the initial setup of a developer's environment.
- **Features:** Includes 34 modular scripts for system prep, security hardening, shell customization, and the installation of essential data tools like PostgreSQL, MongoDB, Python, and VS Code.
- **Usage:** Navigate to `jungle-computing-effort-INIT/orchestrator/` and run the `run_master_setup.sh` script with `sudo`.
- **Details:** For a full list of features and usage instructions, please see the [project's README](./jungle-computing-effort-INIT/README.md).

### 2. `core-tech/`

This directory contains a collection of foundational scripts and resources for installing specific core technology runtimes. It serves as a library of installers, organized by operating system.

- **Purpose:** Provide standalone installers for essential runtimes.
- **Contents:** Includes setup scripts for various versions of Java (7, 8, 11) and Python (2, 3) for both Debian and RHEL-based systems.
- **Usage:** These scripts can be used individually to install a specific piece of technology without running a full environment setup.

### 3. `technology/`

This directory is intended to house setup scripts for larger, more specific technology platforms that are commonly used in data engineering.

- **Purpose:** Automate the installation of specific, complex data technologies.
- **Contents:** Currently contains scripts for setting up **Hadoop**.
- **Usage:** Scripts in this directory are designed to be run for their specific purpose, such as deploying a Hadoop cluster.

---

## Getting Started

To get started with a specific component, please refer to the `README.md` file located within its respective directory. For individual technology installers, explore the `core-tech/` and `technology/` directories.