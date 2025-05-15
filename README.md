[【中文】](./README-cn.md)

# Instructions

pyenv is a convenient tool for managing Python versions.

This repository stores the environment packages loaded by pyenv on the UNIHIKER. You can directly download the files and extract them into the pyenv environment to avoid lengthy downloads.

# Usage

## 1. Install pyenv on UNIHIKER

- Connect UNIHIKER to the internet.

- Install the environment:

  ```
  # Update package index
  sudo apt update
  # Install dependencies
  sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev
  
  # Install pyenv
  curl https://pyenv.run | bash
  
  # Add pyenv to system configuration
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc
  
  # Apply configuration
  source ~/.bashrc
  
  # Check pyenv version. If a version number appears, installation is successful.
  pyenv --version
  ```



## 2. Downloa & Install 

```
# Navigate to the directory
cd /root/.pyenv/versions/
# Download the Python package file using the tar.gz link from the releases page.
wget https://github.com/liliang9693/unihiker-pyenv-python/releases/download/3.8.5%263.11.4%263.12.7/python-3.11.4.tar.gz
# Extract the file to the current folder
tar -xzf python-3.11.4.tar.gz
# List directory contents. The output should include the 3.11.4 folder.
ls
# Refresh pyenv's Python list (no output expected)
pyenv rehash
# List detected versions. The output should show system and 3.11.4.
pyenv versions
# Set 3.11.4 as the global default Python
pyenv global 3.11.4
# List versions. The selected version (3.11.4) will be marked with a *.
pyenv versions
# Check Python version. The output should be Python 3.11.4, indicating successful version switch.
python --version
# List pip packages. Only pip and setuptools should appear, indicating a fresh Python environment ready for custom package installations.
pip list
```

## Notes

- Step 1 only needs to be performed once. Repeat steps 3 to install additional Python versions.
- After installing a new Python environment, if you need to use Mind+ graphical features, manually install the required libraries.

- To switch back to the system's default Python 3.7:

```
pyenv global system
```

