# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-07

### Added
- **Initial Project Release:** The first version of the "Jungle Computing Effort: The Anvil."
- **34 Modular Scripts:** Created all scripts for system preparation, security, shell customization, development tools, data platforms, and GUI applications.
- **Master Orchestrator Script:** Implemented `run_master_setup.sh` with OS detection (Debian/RHEL), sudo checks, and a `--skip` feature for selective task execution.
- **Intelligent Execution Context:** The orchestrator now correctly runs scripts with `root` or standard user privileges as required.
- **Post-Setup Utilities:** Added `prompt_for_reboot.sh` and `manage_postgres_mongo_services.sh` for manual system management.
- **Project Documentation:** Generated a comprehensive `README.md` and this `CHANGELOG.md`.
- **Basic Project Structure:** Established the `orchestrator`, `scripts`, and `tests` directories.