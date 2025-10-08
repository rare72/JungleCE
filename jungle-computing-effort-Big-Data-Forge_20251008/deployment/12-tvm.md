# Deployment Guide: Apache TVM

Apache TVM is a deep learning compiler framework. It is typically deployed as a Python package and is used as a tool to optimize models, not as a long-running service.

## 1. Prerequisites

Installing TVM from source is recommended for performance. This requires several system dependencies.

  * **For Debian 12:**
    ```bash
    sudo apt update
    sudo apt install -y build-essential git python3-dev python3-venv libedit-dev libxml2-dev llvm-14
    ```
  * **For RHEL 9:**
    ```bash
    sudo dnf install -y python3-devel gcc-c++ make git llvm-devel
    ```

## 2. Download and Build

Clone the TVM repository and its submodules.

```bash
git clone --recursive https://github.com/apache/tvm.git
cd tvm
```

Create a build directory and configure the build.

```bash
mkdir build
cp cmake/config.cmake build
# In build/config.cmake, uncomment and set(USE_LLVM ON)
# (e.g., set(USE_LLVM /usr/bin/llvm-config-14))
cd build
cmake ..
make -j$(nproc)
```

## 3. Install the Python Package

Install the TVM package into a Python virtual environment.

```bash
# From the tvm root directory
python3 -m venv ../tvm_env
source ../tvm_env/bin/activate

# Install dependencies
pip install numpy decorator attrs
pip install --pre -f https://mlc.ai/wheels mlc-ai-nightly

# Install the TVM package
cd python
pip install -e .
```

TVM is now installed and ready to be used as a Python library for model compilation and optimization. There are no services to start.
